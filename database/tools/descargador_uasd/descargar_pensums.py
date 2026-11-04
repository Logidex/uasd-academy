#!/usr/bin/env python3
"""Descargar planes de grado de la UASD como PDF con Playwright.

El portal es una web interactiva, no una colección simple de PDFs.
El modo automático descubre planes y prueba abrir cada entrada del índice.
Si una entrada requiere pasos no automatizados, se registra como pendiente.
"""
from __future__ import annotations

import argparse
import csv
import re
import sys
import time
import unicodedata
from pathlib import Path
from urllib.parse import urlparse, parse_qs

INDEX_URL = "https://app.uasd.edu.do/planesgrado/"
PLAN_DOMAIN = "app.uasd.edu.do"
FIELDS = ["facultad", "escuela", "programa", "codigo_programa", "url", "estado", "archivo", "detalle"]
CODE_PATTERN = re.compile(r"\bP-[A-Z0-9]{2,12}\b", re.IGNORECASE)
ROW_PATTERN = re.compile(r"^\s*(.*?)\s*[-–]\s*\(\s*(.*?)\s*[-–]\s*(P-[A-Z0-9]+)\s*\)\s*$", re.I)


def slug(text: str, max_chars: int = 105) -> str:
    t = unicodedata.normalize("NFKD", text)
    t = "".join(c for c in t if not unicodedata.combining(c))
    t = re.sub(r"[^A-Za-z0-9]+", "_", t).strip("_")
    return (t[:max_chars].strip("_") or "Sin_nombre")


def matches(name: str, search: str | None) -> bool:
    if not search:
        return True
    return slug(search).lower() in slug(name).lower()


def safe_plan_url(url: str) -> bool:
    p = urlparse(url)
    return p.scheme == "https" and p.hostname == PLAN_DOMAIN and "/pensumgrado" in p.path.lower() and bool(parse_qs(p.query).get("plan"))


def extract_catalog(text: str) -> list[dict[str, str]]:
    """Procesa el texto visible del índice; no inventa datos del plan."""
    faculty = ""
    school = ""
    rows: list[dict[str, str]] = []
    seen: set[tuple[str, str, str]] = set()
    for raw in text.splitlines():
        line = re.sub(r"\s+", " ", raw).strip("| \t")
        if not line:
            continue
        if line.lower().startswith("facultad de ") or line.lower().startswith("facultad de cs."):
            faculty, school = line, ""
            continue
        if line.lower().startswith("escuela de "):
            school = line
            continue
        hit = ROW_PATTERN.match(line)
        if hit:
            title, catalogue_code, program_code = hit.groups()
            key = (faculty, school, program_code.upper())
            if key not in seen:
                seen.add(key)
                rows.append({"facultad": faculty, "escuela": school,
                             "programa": title.strip(), "codigo_programa": program_code.upper(),
                             "codigo_catalogo": catalogue_code.strip()})
    return rows


def csv_write(path: Path, items: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8-sig") as out:
        w = csv.DictWriter(out, fieldnames=FIELDS, extrasaction="ignore")
        w.writeheader()
        w.writerows(items)


def auto_expand(page) -> None:
    """Intenta expandir nodos del árbol; evita hacer clic en enlaces de carreras."""
    for _ in range(8):
        changed = page.evaluate("""() => {
          let count = 0;
          for (const elem of document.querySelectorAll('[aria-expanded="false"], [title*="Expand"], [alt*="Expand"], .dxWeb_tvExpand')) {
            if (count > 150) break;
            const text = (elem.textContent || '').trim();
            // Nunca activar una entrada de carrera por accidente.
            if (/P-[A-Z0-9]{2,}/i.test(text)) continue;
            const target = elem.matches('img') ? elem.parentElement : elem;
            if (target && !target.dataset.uasdExpanded) {
              target.dataset.uasdExpanded = '1'; target.click(); count++;
            }
          }
          return count;
        }""")
        if not changed:
            break
        page.wait_for_timeout(300)


def pick_program_locator(page, row):
    code = row["codigo_programa"]
    # En muchos árboles el texto de una carrera es un enlace; preferirlo al padre.
    loc = page.locator("a").filter(has_text=code)
    if loc.count():
        return loc.first
    loc = page.get_by_text(re.compile(re.escape(code), re.I))
    if loc.count():
        return loc.last
    return None


def capture_link(page, context, row, pause: float) -> tuple[str, str]:
    loc = pick_program_locator(page, row)
    if loc is None:
        return "", "No se encontró el enlace del programa en el índice"
    href = loc.get_attribute("href") or ""
    if href.startswith("https://") and safe_plan_url(href):
        return href, ""
    known = {id(p) for p in context.pages}
    popup_urls = []
    def on_popup(p):
        popup_urls.append(p)
    page.on("popup", on_popup)
    original_url = page.url
    try:
        loc.click(timeout=10000, force=True)
        page.wait_for_timeout(max(500, int(pause * 1000)))
        for popup in popup_urls + [p for p in context.pages if id(p) not in known]:
            try:
                popup.wait_for_load_state("domcontentloaded", timeout=12000)
                if safe_plan_url(popup.url):
                    return popup.url, ""
                # A veces la vista de selección contiene un link al plan.
                sub = popup.locator('a[href*="PensumGrado"]')
                for i in range(min(sub.count(), 15)):
                    u = sub.nth(i).get_attribute("href") or ""
                    if safe_plan_url(u):
                        return u, ""
            except Exception:
                pass
            finally:
                try:
                    popup.close()
                except Exception:
                    pass
        if safe_plan_url(page.url):
            return page.url, ""
        if page.url != original_url:
            return "", "El enlace abrió una página intermedia sin URL directa del pensum"
        return "", "No se pudo determinar una URL de pensum con versión del plan"
    except Exception as exc:
        return "", f"No se pudo abrir desde el índice: {str(exc)[:160]}"
    finally:
        page.remove_listener("popup", on_popup)
        if page.url != original_url:
            page.goto(INDEX_URL, wait_until="domcontentloaded", timeout=30000)
            auto_expand(page)


def save_pdf(context, url: str, filename: Path, timeout_ms: int) -> tuple[bool, str]:
    if not safe_plan_url(url):
        return False, "URL no aceptada: debe apuntar a un plan UASD con parámetro 'plan'"
    page = context.new_page()
    try:
        resp = page.goto(url, wait_until="domcontentloaded", timeout=timeout_ms)
        if resp is not None and resp.status >= 400:
            return False, f"HTTP {resp.status}"
        page.wait_for_timeout(700)
        body = page.locator("body").inner_text(timeout=10000)
        if not ("Clave" in body and ("Asignatura" in body or "Asignaturas" in body)):
            return False, "El contenido no parece ser la tabla de un pensum (posible bloqueo o inicio de sesión)"
        filename.parent.mkdir(parents=True, exist_ok=True)
        page.emulate_media(media="print")
        page.pdf(path=str(filename), format="A4", print_background=True,
                 margin={"top": "8mm", "right": "7mm", "bottom": "8mm", "left": "7mm"})
        if filename.stat().st_size < 2000:
            filename.unlink(missing_ok=True)
            return False, "PDF demasiado pequeño; posible respuesta incompleta"
        return True, ""
    except Exception as exc:
        filename.unlink(missing_ok=True)
        return False, f"{type(exc).__name__}: {str(exc)[:200]}"
    finally:
        page.close()


def read_links(path: Path) -> list[dict[str, str]]:
    with path.open(encoding="utf-8-sig", newline="") as f:
        records = list(csv.DictReader(f))
    if not records or not {"facultad", "programa", "url"}.issubset(records[0]):
        raise ValueError("El CSV requiere columnas: facultad, programa, url")
    return [{"facultad": r.get("facultad", "Sin_facultad"),
             "escuela": r.get("escuela", ""), "programa": r["programa"],
             "codigo_programa": r.get("codigo_programa", ""), "url": r["url"]} for r in records]


def main() -> int:
    ap = argparse.ArgumentParser(description="Descarga planes de grado de la UASD como PDF (navegador Chromium).")
    ap.add_argument("--facultad", help="Parte del nombre, p. ej. 'Artes' o 'Ingenieria'")
    ap.add_argument("--todos", action="store_true", help="Descargar todas las facultades")
    ap.add_argument("--limite", type=int, default=2, help="Máximo por ejecución (defecto: 2; 0 = sin límite)")
    ap.add_argument("--salida", type=Path, default=Path("pensums_descargados"))
    ap.add_argument("--enlaces", type=Path, help="CSV alternativo con facultad,escuela,programa,url")
    ap.add_argument("--solo-indice", action="store_true", help="Descubrir el catálogo sin descargar")
    ap.add_argument("--pausa", type=float, default=1.5, help="Segundos mínimos entre solicitudes")
    ap.add_argument("--mostrar-navegador", action="store_true")
    args = ap.parse_args()
    if not (args.todos or args.facultad or args.enlaces or args.solo_indice):
        ap.error("Indica --facultad Artes, --todos, --solo-indice o --enlaces enlaces.csv")
    if args.limite < 0 or args.pausa < 0:
        ap.error("--limite y --pausa no pueden ser negativos")
    try:
        from playwright.sync_api import sync_playwright
    except ImportError:
        print("Falta Playwright. Instala con: pip install playwright", file=sys.stderr)
        return 2
    output = args.salida.resolve()
    output.mkdir(parents=True, exist_ok=True)
    results: list[dict[str, str]] = []
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=not args.mostrar_navegador)
        context = browser.new_context(locale="es-DO", accept_downloads=True)
        try:
            index_page = None
            if args.enlaces:
                entries = read_links(args.enlaces)
            else:
                index_page = context.new_page()
                print(f"Abriendo el índice oficial: {INDEX_URL}")
                index_page.goto(INDEX_URL, wait_until="domcontentloaded", timeout=45000)
                auto_expand(index_page)
                body = index_page.locator("body").inner_text(timeout=12000)
                entries = extract_catalog(body)
                if not entries:
                    # Algunos árboles mantienen entradas ocultas pero presentes en DOM.
                    entries = extract_catalog(index_page.locator("body").text_content() or "")
                print(f"Entradas detectadas: {len(entries)}")
            index_records = [dict(e, estado="pendiente", archivo="", detalle="") for e in entries]
            csv_write(output / "indice_detectado.csv", index_records)
            if args.solo_indice:
                print(f"Índice: {output / 'indice_detectado.csv'}")
                return 0
            filtered = [r for r in entries if matches(r["facultad"], args.facultad)]
            if not filtered:
                print("No se encontraron programas para la facultad seleccionada. Revisa indice_detectado.csv.", file=sys.stderr)
                return 1
            maximum = args.limite or len(filtered)
            print(f"Candidatos: {len(filtered)}; procesaremos hasta {min(maximum, len(filtered))}.")
            for i, row in enumerate(filtered[:maximum], 1):
                item = dict(row)
                item.setdefault("url", "")
                item.update(estado="pendiente", archivo="", detalle="")
                name = f"{slug(item['programa'], 75)}_{slug(item.get('codigo_programa', ''), 18)}"
                # Los nombres pueden repetirse en planes distintos; añadir el plan una vez conocida la URL.
                print(f"[{i}] {item['facultad']} / {item['programa']}")
                if not item["url"] and index_page is not None:
                    item["url"], item["detalle"] = capture_link(index_page, context, item, args.pausa)
                if not safe_plan_url(item["url"]):
                    item["estado"] = "pendiente_revision"
                    if not item["detalle"]:
                        item["detalle"] = "No se obtuvo URL directa del pensum"
                else:
                    plan = parse_qs(urlparse(item["url"]).query).get("plan", [""])[0]
                    destination = output / slug(item["facultad"]) / f"{name}_{slug(plan, 20)}.pdf"
                    if destination.exists() and destination.stat().st_size >= 2000:
                        item["estado"], item["archivo"] = "ya_existe", str(destination.relative_to(output))
                    else:
                        ok, reason = save_pdf(context, item["url"], destination, 45000)
                        item["estado"] = "descargado" if ok else "error"
                        item["archivo"] = str(destination.relative_to(output)) if ok else ""
                        item["detalle"] = reason
                results.append(item)
                csv_write(output / "resultado_descargas.csv", results)
                print(f"    -> {item['estado']} {item['detalle']}")
                if i < min(maximum, len(filtered)):
                    time.sleep(args.pausa)
            print(f"\nReporte: {output / 'resultado_descargas.csv'}")
            print(f"PDF disponibles: {sum(r['estado'] in ('descargado', 'ya_existe') for r in results)} / {len(results)}")
            return 0 if all(r["estado"] in ("descargado", "ya_existe") for r in results) else 1
        finally:
            context.close()
            browser.close()


if __name__ == "__main__":
    raise SystemExit(main())
