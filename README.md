# UASD Académica

Aplicación académica para consultar el catálogo de **facultades → escuelas → carreras → materias** de la Universidad Autónoma de Santo Domingo (UASD).

El usuario selecciona una facultad y una escuela, pulsa **Consultar carreras** y puede abrir el plan de estudios de una carrera para ver las asignaturas agrupadas por período y sus créditos.

> **Proyecto académico no oficial.** Los planes se recopilaron de documentos de la UASD y pueden corresponder a versiones históricas. La aplicación no confirma qué planes están vigentes ni sustituye la información institucional.

## Estado del proyecto

Se han procesado **114 documentos de pensum**, distribuidos entre **9 facultades**. La reconstrucción automatizada incluida en este repositorio produce:

| Dato | Total |
|---|---:|
| Facultades | 9 |
| Escuelas | 50 |
| Registros de carreras y programas | 115 |
| Materias únicas | 2,864 |
| Relaciones carrera–materia | 6,209 |

Los **115 registros de programas no equivalen necesariamente a 115 carreras distintas o vigentes**: incluyen menciones, programas técnicos y versiones de planes. Los 114 documentos procesados tampoco significan que todos los planes sean actuales.

**Caso especial pendiente de integrar al instalador:** el plan `000011` de **Licenciatura en Geografía** contiene el bloque previo «Colegio Universitario» (`AAA-0000`, 36 créditos), sin semestre convencional. En la instalación automática publicada, ese bloque no se enlaza a la carrera: Geografía muestra 139 créditos en lugar de los 175 indicados en el PDF. Una migración separada permite añadirlo como período `0`, elevando las relaciones totales a **6,210** sin crear materias nuevas. Dicha migración todavía no forma parte de `inicializar.py` ni de `schema.sql` en la versión revisada del repositorio. Si ya la aplicaste manualmente a tu base local, **no la reconstruyas** solo para seguir estos pasos.

## Tecnologías

- **Backend:** Java 27, Spring Boot, Maven Wrapper y JDBC.
- **Frontend:** React, TypeScript y Vite.
- **Base de datos:** SQLite.
- **Inicialización:** Python 3.10 o posterior (biblioteca estándar `sqlite3`, sin paquetes adicionales).

> La interfaz es web, pero la lógica del servidor y las consultas a la base de datos están implementadas en Java. Para la entrega académica, confirma con el docente que se acepta una interfaz web en lugar de una interfaz de escritorio Java.

## Estructura principal

```text
uasd-academy/
├── Backend/                           # API con Spring Boot
│   └── mvnw.cmd
├── Frontend/                          # Aplicación React + TypeScript
│   └── package.json
├── database/
│   ├── schema.sql                     # Estructura inicial de SQLite
│   ├── seed.sql                       # Datos iniciales
│   ├── ampliacion_masiva_uasd.sql     # Catálogo ampliado
│   ├── normalizar_catalogo.sql        # Ajustes de códigos de programas
│   ├── pensum_informatica_200820.sql  # Plan de Informática
│   ├── pensums/                       # SQL de las demás facultades
│   │   ├── artes/
│   │   ├── ciencias/
│   │   ├── economicas/
│   │   ├── juridicas/
│   │   ├── agronomicas/
│   │   ├── salud/
│   │   ├── humanidades/
│   │   ├── ingenieria/
│   │   └── educacion/
│   ├── inicializar.py                 # Reconstrucción completa y validación
│   └── inicializar.ps1                # Acceso rápido desde PowerShell
└── README.md
```

La base `database/uasd.db` se crea localmente y **no debe subirse al repositorio**. Tampoco deben subirse archivos `.db` de respaldo, `Frontend/node_modules/`, `Frontend/dist/` ni `Backend/target/`.

## Requisitos previos

1. **Git**, para clonar el repositorio.
2. **Java 27**: `java -version`.
3. **Node.js y npm**, en versiones compatibles con el Vite usado por el frontend: `node -v` y `npm -v`.
4. **Python 3.10+**: `python --version`.
5. **Windows y PowerShell**, si deseas utilizar `inicializar.ps1`. El comando directo de Python también permite ejecutar el inicializador sin el archivo PowerShell.

No es necesario instalar Maven globalmente: el proyecto incluye Maven Wrapper. **Tampoco es necesario instalar `sqlite3.exe`** para la inicialización automática, porque Python utiliza su propio módulo `sqlite3`.

## 1. Descargar el código

Desde PowerShell:

```powershell
git clone https://github.com/Logidex/uasd-academy.git
cd uasd-academy
```

Si ya tienes el repositorio, abre la carpeta raíz del proyecto en VS Code.

## 2. Crear la base de datos completa

### Opción recomendada: instalador Python

Desde la **raíz del repositorio**:

```powershell
cd database
python inicializar.py
cd ..
```

El inicializador ejecuta **15 scripts SQL**, empezando por la estructura y terminando con Ingeniería Geomática. Incluye la normalización de códigos que evita duplicar las carreras de Periodismo y Psicología Clínica. Antes de reemplazar un archivo existente, comprueba claves foráneas, integridad y los conteos esperados.

**Si `database/uasd.db` ya existe, el programa no la sobrescribe.** Para comprobar la base existente sin modificarla:

```powershell
cd database
python inicializar.py --verificar
cd ..
```

Para reconstruirla deliberadamente, **detén primero el backend y cierra las conexiones de DBeaver**. Asegúrate de conservar cualquier cambio manual que no esté integrado en los scripts:

```powershell
cd database
python inicializar.py --recrear
cd ..
```

El inicializador genera una base temporal, la valida y crea una copia de respaldo con fecha antes de reemplazar `uasd.db`. Aun así, es conveniente guardar un respaldo propio antes de usar `--recrear`.

### Alternativa: PowerShell

En Windows puedes utilizar el mismo instalador mediante su envoltura:

```powershell
cd database
.\inicializar.ps1
.\inicializar.ps1 -Verificar
# Solo si deseas reconstruir la base actual, tras guardar respaldo:
# .\inicializar.ps1 -Recrear
cd ..
```

### Alternativa manual: DBeaver

Puedes ejecutar los SQL sobre una **base vacía**, respetando estrictamente el orden de la lista `SCRIPT_ORDER` dentro de `database/inicializar.py`. Ya no son solamente los cuatro scripts iniciales. En DBeaver, **Alt + X** suele ejecutar todo el script; **Ctrl + Enter** ejecuta normalmente la instrucción actual. Confirma la transacción si tienes desactivado el autocommit.

**No ejecutes `seed.sql` sobre una base poblada** ni combines una reconstrucción con importaciones manuales incompletas.

### Comprobar el resultado

En DBeaver:

```sql
SELECT
  (SELECT COUNT(*) FROM facultades) AS facultades,
  (SELECT COUNT(*) FROM escuelas) AS escuelas,
  (SELECT COUNT(*) FROM carreras) AS programas,
  (SELECT COUNT(*) FROM materias) AS materias_unicas,
  (SELECT COUNT(*) FROM carrera_materias) AS relaciones;

PRAGMA foreign_key_check;
PRAGMA integrity_check;
```

Con la reconstrucción automática publicada, los conteos esperados son **9, 50, 115, 2,864 y 6,209**, respectivamente. `foreign_key_check` debe devolver **cero filas** y `integrity_check` debe devolver `ok`.

Si aplicaste a tu base local el ajuste especial de Geografía, el último conteo será **6,210**. Ese valor diferente no indica un error en sí mismo.

## 3. Ejecutar el backend Java

Abre una terminal desde la raíz del repositorio:

```powershell
cd Backend
.\mvnw.cmd spring-boot:run
```

El proyecto utiliza la base `../database/uasd.db` con la carpeta `Backend` como directorio de trabajo. Normalmente la API estará disponible en `http://localhost:8080`.

| Endpoint | Función |
|---|---|
| `GET /api/facultades` | Listar facultades |
| `GET /api/escuelas/facultad/{idFacultad}` | Listar escuelas por facultad |
| `GET /api/carreras/escuela/{idEscuela}` | Listar carreras por escuela |
| `GET /api/materias/carrera/{idCarrera}` | Consultar las asignaturas de un pensum |

Los identificadores entre llaves deben sustituirse por los IDs reales que devuelve la API; no son códigos oficiales de programas.

## 4. Ejecutar el frontend React

**Sin detener Java**, abre otra terminal desde la raíz:

```powershell
cd Frontend
npm install
npm run dev
```

Abre la dirección local que indique Vite, habitualmente `http://localhost:5173`.

El frontend realiza solicitudes a `/api`; el proxy de `Frontend/vite.config.ts` debe redirigirlas a `http://localhost:8080`. Si React no carga datos, comprueba que el backend esté funcionando y que el proxy apunte al puerto correcto.

## 5. Probar la aplicación

1. Pulsa **Cargar facultades**.
2. Elige una facultad y luego una escuela.
3. Pulsa **Consultar carreras**.
4. Selecciona una carrera para ver las materias por período y la suma de créditos.

Casos útiles de verificación:

| Programa | Resultado esperado |
|---|---|
| Licenciatura en Informática, plan `200820` | 51 materias, 186 créditos |
| Ingeniería Geomática, plan `200910` | 23 asignaturas, 76 créditos |
| Licenciatura en Geografía, plan `000011` | 139 créditos en instalación base; 175 si se aplicó la migración del bloque previo |

**Presentación pendiente:** el frontend publicado muestra encabezados numéricos como `Período 0`. Se recomienda mostrar `Colegio Universitario (bloque previo)` cuando corresponda y distinguir tesis e internados de los períodos académicos ordinarios. La consulta de Java no depende de ese cambio visual.

## 6. Pruebas del proyecto

Backend, dentro de `Backend/`:

```powershell
.\mvnw.cmd test
```

Frontend, dentro de `Frontend/`:

```powershell
npm run build
npm run lint
```

Base de datos, dentro de `database/`:

```powershell
python inicializar.py --verificar
```

El chequeo `--verificar` comprueba la integridad y muestra los conteos reales; **no garantiza que coincidan con los de una reconstrucción nueva**. La comprobación estricta de totales se realiza al crear la base desde cero.

## Notas sobre los datos y el modelo

- Los planes fueron extraídos de documentos de la UASD. Un programa puede tener varias versiones y el catálogo no confirma vigencia académica.
- Algunos códigos `PLAN-P-*` o `UASD-LOC-*` son identificadores internos de la aplicación, no códigos oficiales.
- La tabla `fuentes_pensum` permite registrar referencias y versiones de los documentos procesados.
- Las tablas con nombres como `_edu_*`, `_huma_*` o `_ing_*` son **auxiliares temporales** usadas durante importaciones; no son necesarias para las consultas normales de React y Java.
- Las tablas permanentes principales son `facultades`, `escuelas`, `carreras`, `materias`, `carrera_materias` y `fuentes_pensum`.
- El esquema de la versión revisada utiliza `CHECK (periodo > 0)`. Para incorporar el bloque previo de Geografía como `periodo = 0` en **futuras reconstrucciones**, aún falta actualizar `schema.sql` e integrar su migración al inicializador. **No basta con editar `schema.sql` para alterar una base ya creada.**

Fuentes de consulta institucional: [Planes de grado UASD](https://app.uasd.edu.do/planesgrado/) y [Oferta académica UASD](https://uasd.edu.do/oferta-academica/).

## Autoría y alcance

Proyecto académico de consulta del catálogo universitario. No representa a la Universidad Autónoma de Santo Domingo ni sustituye sus servicios oficiales.
