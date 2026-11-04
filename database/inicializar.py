#!/usr/bin/env python3
"""Reconstituye la base de datos de los 114 planes sin sobrescribir la original
hasta haber terminado y verificado todo. Requiere solo Python 3.10+ (stdlib).
"""
from __future__ import annotations
import argparse
from datetime import datetime
from pathlib import Path
import os
import shutil
import sqlite3
import sys

ROOT = Path(__file__).resolve().parent
DEST = ROOT / 'uasd.db'
TEMP = ROOT / 'uasd_nueva_temporal.db'
SCRIPT_ORDER = [
    'schema.sql',
    'seed.sql',
    'ampliacion_masiva_uasd.sql',
    'normalizar_catalogo.sql',
    'pensum_informatica_200820.sql',
    'pensums/artes/pensums_artes_19.sql',
    'pensums/ciencias/pensums_ciencias_9.sql',
    'pensums/economicas/pensums_economicas_11.sql',
    'pensums/juridicas/pensums_juridicas_2.sql',
    'pensums/agronomicas/pensums_agronomicas_7.sql',
    'pensums/salud/pensums_salud_10.sql',
    'pensums/humanidades/pensums_humanidades_14_CORREGIDO.sql',
    'pensums/ingenieria/pensums_ingenieria_13.sql',
    'pensums/educacion/pensums_educacion_27.sql',
    'pensums/ingenieria/pensum_geomatica_200910.sql',
    'pensums/ajustes/01_colegio_geografia.sql',
]
EXPECTED = {'facultades':9, 'escuelas':50, 'carreras':115,
            'materias':2864, 'carrera_materias':6210}


def check(conn, strict=False):
    bad_fk = conn.execute('PRAGMA foreign_key_check').fetchall()
    if bad_fk:
        raise RuntimeError(f'Claves foraneas invalidas: {bad_fk[:5]}')
    integrity = conn.execute('PRAGMA integrity_check').fetchone()[0]
    if integrity != 'ok':
        raise RuntimeError(f'PRAGMA integrity_check: {integrity}')
    actual = {}
    for table, expected in EXPECTED.items():
        actual[table] = conn.execute('SELECT COUNT(*) FROM ' + table).fetchone()[0]
        if strict and actual[table] != expected:
            raise RuntimeError(f'{table}: se esperaban {expected} y hay {actual[table]}')
    geom = conn.execute("""
      SELECT COUNT(*), COALESCE(SUM(m.creditos), 0)
      FROM carreras c JOIN carrera_materias cm ON cm.id_carrera=c.id_carrera
      JOIN materias m ON m.id_materia=cm.id_materia
      WHERE c.codigo='PLAN-P-IGEO'
    """).fetchone()
    if strict and tuple(geom) != (23, 76):
        raise RuntimeError(f'Geomática: se esperaba (23 materias, 76 creditos), obtenido {tuple(geom)}')
    geog = conn.execute("""
      SELECT COUNT(*), COALESCE(SUM(m.creditos), 0)
      FROM carreras c JOIN carrera_materias cm ON cm.id_carrera=c.id_carrera
      JOIN materias m ON m.id_materia=cm.id_materia
      WHERE c.codigo='PLAN-P-GEOG'
    """).fetchone()
    if strict and tuple(geog) != (41, 175):
        raise RuntimeError(f'Geografia: se esperaba (41 componentes, 175 creditos), obtenido {tuple(geog)}')
    print(f'Geografia: {geog[0]} componentes, {geog[1]} creditos')
    print('Conteos:', ', '.join(f'{k}={v}' for k,v in actual.items()))
    print(f'Geomatica: {geom[0]} materias, {geom[1]} creditos; integridad OK')
    return actual


def main():
    parser = argparse.ArgumentParser(description='Inicializar UASD Academica con 114 pensums')
    parser.add_argument('--recrear', action='store_true', help='Crear nueva base y respaldar la anterior')
    parser.add_argument('--verificar', action='store_true', help='Comprobar la base sin modificarla')
    args=parser.parse_args()
    if args.verificar:
        if not DEST.is_file():
            parser.error('No existe database/uasd.db')
        with sqlite3.connect(str(DEST)) as conn:
            conn.execute('PRAGMA foreign_keys=ON')
            check(conn, strict=False)
        return 0
    if DEST.exists() and not args.recrear:
        parser.error('uasd.db ya existe. No se cambio. Usa --verificar o --recrear si deseas reemplazarla con respaldo.')
    if TEMP.exists():
        parser.error('Existe uasd_nueva_temporal.db. Revisala y retirala antes de reconstruir.')
    print('Creando base temporal... No se modificara la actual hasta validar todo.')
    try:
        with sqlite3.connect(str(TEMP)) as conn:
            conn.execute('PRAGMA foreign_keys=ON')
            for n, rel in enumerate(SCRIPT_ORDER,1):
                path = ROOT/rel
                if not path.is_file():
                    raise FileNotFoundError(f'Falta {path}')
                print(f'[{n:02}/{len(SCRIPT_ORDER)}] {rel}')
                try:
                    conn.executescript(path.read_text(encoding='utf-8-sig'))
                    conn.commit()
                except Exception as err:
                    conn.rollback()
                    raise RuntimeError(f'Fallo el archivo {rel}: {err}') from err
                fk=conn.execute('PRAGMA foreign_key_check').fetchall()
                if fk:
                    raise RuntimeError(f'Error de claves foraneas tras {rel}: {fk[:3]}')
            check(conn,strict=True)
        if DEST.exists():
            # Detener backend y cerrar DBeaver antes de reconstruir. Hacer respaldo real.
            stamp = datetime.now().strftime('%Y%m%d_%H%M%S_%f')
            backup = ROOT / f'uasd_respaldo_{stamp}.db'
            shutil.copy2(DEST,backup)
            print('Respaldo:',backup)
        os.replace(TEMP, DEST)
        print('Base lista:', DEST)
        return 0
    except Exception as err:
        print('ERROR:',err,file=sys.stderr)
        print('La base original no fue sobrescrita. Revisa la base temporal:', TEMP, file=sys.stderr)
        return 1

if __name__=='__main__':
    raise SystemExit(main())
