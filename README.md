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
| Relaciones carrera–materia | 6,210 |

Los **115 registros de programas no equivalen necesariamente a 115 carreras distintas o vigentes**: incluyen menciones, programas técnicos y versiones de planes. Los 114 documentos procesados tampoco significan que todos los planes sean actuales.

**Bloque especial de Geografía integrado:** el plan `000011` de **Licenciatura en Geografía** incluye «Colegio Universitario» (`AAA-0000`, 36 créditos) como un bloque previo, sin semestre convencional. El sistema lo representa como `periodo = 0`. Por tanto, el plan muestra **41 componentes y 175 créditos**, y la instalación completa genera **6,210 relaciones**. No se crea una materia adicional: se utiliza el código `AAA-0000` ya registrado.

El instalador incorpora esta corrección **si se utilizan juntos** `database/schema.sql`, `database/inicializar.py` y `database/pensums/ajustes/01_colegio_geografia.sql` de la versión actualizada. Estos cambios están pensados para instalaciones nuevas; modificar `schema.sql` no migra automáticamente una base ya creada.

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
│   │   ├── educacion/
│   │   └── ajustes/                  # Bloque previo de Geografía (período 0)
│   │       └── 01_colegio_geografia.sql
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

El inicializador ejecuta **16 scripts SQL**, empezando por la estructura y terminando con el ajuste de Colegio Universitario para Geografía. Incluye la normalización de códigos que evita duplicar las carreras de Periodismo y Psicología Clínica. Antes de reemplazar un archivo existente, comprueba claves foráneas, integridad y los conteos esperados.

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

Con el instalador actualizado, los conteos esperados son **9 facultades, 50 escuelas, 115 registros de programas, 2,864 materias y 6,210 relaciones**. `foreign_key_check` debe devolver **cero filas** e `integrity_check` debe devolver `ok`.

Como comprobación adicional del caso especial:

```sql
SELECT c.nombre AS carrera,
       COUNT(*) AS componentes,
       SUM(m.creditos) AS total_creditos
FROM carreras c
JOIN carrera_materias cm ON cm.id_carrera = c.id_carrera
JOIN materias m ON m.id_materia = cm.id_materia
WHERE c.codigo = 'PLAN-P-GEOG'
GROUP BY c.id_carrera, c.nombre;
```

El resultado esperado es **41 componentes y 175 créditos**. Si una instalación anterior muestra 139 créditos, no basta con modificar `schema.sql`: hay que utilizar la migración específica para esa base existente.

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
| Licenciatura en Geografía, plan `000011` | 41 componentes, 175 créditos, incluyendo bloque previo (período 0) |

**Presentación de períodos especiales:** el período `0` representa «Colegio Universitario (bloque previo)» en Geografía; tesis e internados pueden aparecer como bloques adicionales del plan. El backend Java devuelve el número de período y la interfaz debe mostrar etiquetas comprensibles.

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
- El esquema actualizado utiliza `CHECK (periodo >= 0)` para admitir bloques previos como Colegio Universitario. El script `pensums/ajustes/01_colegio_geografia.sql` se ejecuta en último lugar en `inicializar.py`. **No basta con editar `schema.sql` para alterar una base ya creada.**

Fuentes de consulta institucional: [Planes de grado UASD](https://app.uasd.edu.do/planesgrado/) y [Oferta académica UASD](https://uasd.edu.do/oferta-academica/).

## Autoría y alcance

Proyecto académico de consulta del catálogo universitario. No representa a la Universidad Autónoma de Santo Domingo ni sustituye sus servicios oficiales.
