# Descargador de pensums UASD

Herramienta opcional del proyecto UASD Académica. Automatiza un navegador Chromium para abrir las páginas imprimibles de planes de grado y guardarlas como PDF. **No modifica SQLite ni los archivos del backend/frontend.**

## Requisitos

- Windows 11 y Python 3.10 o posterior instalado y accesible desde PowerShell.
- Conexión a Internet.
- Acceso normal al portal oficial de la UASD.

## Instalación

Desde PowerShell, dentro de esta carpeta:

```powershell
py -m pip install -r requirements.txt
py -m playwright install chromium
```

## Primera prueba (solo dos pensums)

Prueba más controlable, con enlaces verificados en los documentos oficiales aportados:

```powershell
py descargar_pensums.py --enlaces enlaces_ejemplo.csv --limite 2
```

Comprueba los PDF en `pensums_descargados/Facultad_de_Ciencias_Juridicas_y_Politicas/`.

## Detección automática desde el índice

Primero genera el inventario sin descargar:

```powershell
py descargar_pensums.py --solo-indice
```

Abre `pensums_descargados/indice_detectado.csv` y comprueba nombres y agrupación. Después prueba Artes con solo dos planes:

```powershell
py descargar_pensums.py --facultad Artes --limite 2
```

Si esos archivos son correctos, amplía a toda Artes:

```powershell
py descargar_pensums.py --facultad Artes --limite 0
```

Para todas las facultades:

```powershell
py descargar_pensums.py --todos --limite 0
```

La descarga es pausada; los PDF existentes se omiten. Los fallos quedan documentados en `resultado_descargas.csv`.

## Problemas habituales

- **No se detectan programas**: el índice puede haber cambiado o usar un árbol dinámico que no pueda expandirse. Ejecuta con `--mostrar-navegador`; usa como alternativa un CSV propio con columnas `facultad,escuela,programa,codigo_programa,url`.
- **Pendiente de revisión**: un programa no se abrió directamente con el parámetro `plan`. No se intenta adivinar esa versión; revisa el enlace y añádelo al CSV.
- **HTTP 403 / CAPTCHA / acceso denegado**: detén la descarga. No intentes evadir restricciones. Comprueba el acceso manual o consulta con el sitio.
- **PDF incompleto**: comprueba que contenga la tabla de asignaturas y los créditos; el reporte indica qué documentos fallaron.
- **No uses `--todos` antes de probar una muestra**, ni ejecutes descargas paralelas o demasiado rápidas.

## Limitaciones

Este programa fue validado sintácticamente, pero no se ha probado contra el portal en tiempo real desde el entorno donde se creó. El HTML y los comportamientos de sus enlaces pueden cambiar. Las entradas de los planes pueden abrir ventanas intermedias o permitir escoger varias versiones; se registrarán como pendientes en vez de inventar URLs. Algunos programas tienen varias versiones: confirma el plan que deseas incorporar a SQLite.
