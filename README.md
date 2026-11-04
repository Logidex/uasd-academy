# UASD Académica

Aplicación académica para consultar **facultades → escuelas → carreras** de la Universidad Autónoma de Santo Domingo (UASD). Permite seleccionar una escuela y pulsar **Consultar carreras**; al elegir una carrera con pensum registrado, muestra las materias organizadas por período.

## Tecnologías

- **Backend:** Java 27, Spring Boot, Maven Wrapper y JDBC.
- **Base de datos:** SQLite.
- **Frontend:** React, TypeScript y Vite.

> **Requisito de la asignación:** es una aplicación con backend en Java e interfaz web en React. Verificar con el docente si acepta una interfaz web en lugar de una aplicación de escritorio Java.

## Estructura del repositorio

```text
uasd-academy/
├── Backend/                         # API Java + Spring Boot
│   └── mvnw.cmd
├── Frontend/                        # React + TypeScript
│   └── package.json
├── database/
│   ├── schema.sql                   # 1. Crear las 5 tablas
│   ├── seed.sql                     # 2. Datos mínimos iniciales
│   ├── ampliacion_masiva_uasd.sql   # 3. Ampliar catálogo de escuelas y carreras
│   ├── pensum_informatica_200820.sql # 4. Materias de Informática
│   └── inicializar.ps1              # Automatiza el orden en Windows
└── README.md
```

`database/uasd.db` se **genera localmente** y no tiene que subirse a Git. Tampoco deben subirse `Frontend/node_modules/`, `Frontend/dist/` ni `Backend/target/`.

## Requisitos previos

1. **Java 27** (la versión utilizada para desarrollar este proyecto); comprobar con `java -version`.
2. **Node.js compatible con Vite 8** y npm; comprobar con `node -v` y `npm -v`. Se recomienda una versión LTS reciente.
3. **SQLite CLI (`sqlite3`)** para la instalación automatizada, o **DBeaver** como alternativa visual.
4. **PowerShell** en Windows. El backend incluye Maven Wrapper (`mvnw.cmd`), por lo que no hace falta instalar Maven globalmente.

## Paso 1: descargar el repositorio

Desde PowerShell:

```powershell
git clone https://github.com/Logidex/uasd-academy.git
cd uasd-academy
```

Si ya tienes el repositorio descargado, abre su carpeta raíz en VS Code.

## Paso 2: crear la base de datos

### Opción A — Automática, recomendada (Windows + SQLite CLI)

Comprueba primero que `sqlite3` funciona:

```powershell
sqlite3 -version
```

Después, desde la raíz del proyecto:

```powershell
cd database
.\inicializar.ps1
cd ..
```

El script crea `database/uasd.db` en este orden:

| Orden | Archivo | Función |
|---|---|---|
| 1 | `schema.sql` | Crea `facultades`, `escuelas`, `carreras`, `materias`, `carrera_materias` |
| 2 | `seed.sql` | Inserta facultades, escuelas y carreras iniciales |
| 3 | `ampliacion_masiva_uasd.sql` | Amplía el catálogo de facultades, escuelas y programas |
| 4 | `pensum_informatica_200820.sql` | Inserta materias y períodos del plan de Informática |

**Si ya existe `uasd.db`, no se sobrescribe.** Para reconstruirla intencionalmente, detén primero el backend y ejecuta desde `database/`:

```powershell
.\inicializar.ps1 -Recrear
```

La opción `-Recrear` genera una base nueva y respalda la base anterior con fecha antes de sustituirla. Guarda tus propios cambios SQL antes de usarla: una reconstrucción restaura **solo los datos de estos scripts**.

Si PowerShell no permite ejecutar el archivo por su política local, puedes utilizar la opción manual de DBeaver. No hace falta desactivar permanentemente ninguna protección.

### Opción B — DBeaver (sin SQLite CLI)

1. Crea un archivo vacío llamado `database/uasd.db` y abre una conexión **SQLite** de DBeaver apuntando a ese archivo.
2. Ejecuta los cuatro scripts de la tabla anterior **en ese orden**. Para ejecutar un archivo completo en DBeaver usa la acción *Ejecutar script SQL* (normalmente `Alt + X`); `Ctrl + Enter` puede ejecutar solo la sentencia actual.
3. Si el autocommit está desactivado, confirma con **Commit** antes de abrir el backend.
4. No vuelvas a ejecutar `seed.sql` sobre una base ya poblada: sus IDs iniciales son fijos. Para reconstruir desde cero, utiliza una base vacía.

**Comprobación en DBeaver:**

```sql
SELECT
  (SELECT COUNT(*) FROM facultades) AS facultades,
  (SELECT COUNT(*) FROM escuelas) AS escuelas,
  (SELECT COUNT(*) FROM carreras) AS carreras,
  (SELECT COUNT(*) FROM materias) AS materias,
  (SELECT COUNT(*) FROM carrera_materias) AS relaciones_materias;

PRAGMA foreign_key_check;
```

En una instalación nueva con **los cuatro archivos suministrados**, esperamos **9 facultades, 50 escuelas, 106 carreras/programas, 51 materias y 51 relaciones carrera–materia**; `foreign_key_check` debe devolver **cero filas**. El total de 106 incluye una carrera del `seed.sql` que no aparece en el catálogo masivo; una base preexistente puede mostrar otros totales. Son datos de referencia del proyecto, **no un censo certificado de carreras vigentes**.

## Paso 3: ejecutar el backend Java

Abre una terminal en la raíz del proyecto:

```powershell
cd Backend
.\mvnw.cmd spring-boot:run
```

Spring Boot usa `../database/uasd.db` **relativo a la carpeta `Backend`**, por lo que es importante iniciar Maven desde ahí. El servidor estará disponible normalmente en `http://localhost:8080`.

Verifica estos endpoints en el navegador:

| Ruta | Qué devuelve |
|---|---|
| `http://localhost:8080/api/facultades` | Facultades |
| `http://localhost:8080/api/escuelas/facultad/1` | Escuelas de una facultad (ejemplo ID 1) |
| `http://localhost:8080/api/carreras/escuela/1` | Carreras de una escuela (ejemplo ID 1) |
| `http://localhost:8080/api/materias/carrera/1` | Materias de una carrera (ejemplo ID 1) |

Los IDs se usan como ejemplos; consulta primero la API o la base de datos para saber cuáles corresponden a cada registro.

## Paso 4: ejecutar React

**Sin detener el backend**, abre una segunda terminal desde la raíz:

```powershell
cd Frontend
npm install
npm run dev
```

Abre la URL que muestre Vite, normalmente `http://localhost:5173`.

El servidor de desarrollo Vite debe tener un proxy que envíe `/api` a `http://localhost:8080`, por ejemplo en `Frontend/vite.config.ts`:

```ts
server: {
  proxy: {
    "/api": {
      target: "http://localhost:8080",
      changeOrigin: true
    }
  }
}
```

Si la API responde en el navegador pero React falla, comprueba que **ambos servidores están ejecutándose** y que el proxy coincide con el puerto del backend.

## Paso 5: probar la aplicación

1. Pulsa **Cargar facultades**.
2. Selecciona **Facultad de Ciencias**.
3. Selecciona **Escuela de Informática**.
4. Pulsa **Consultar carreras**.
5. Selecciona **Licenciatura en Informática** para ver el pensum registrado: **51 materias, 186 créditos y 10 períodos**.

Las demás carreras pueden mostrar que su pensum todavía no está registrado. Eso no impide consultar el catálogo de carreras.

## Comprobaciones para la entrega

En la carpeta `Backend`:

```powershell
.\mvnw.cmd test
```

En la carpeta `Frontend`:

```powershell
npm run build
npm run lint
```

También verifica que el archivo `database/uasd.db` pueda reconstruirse desde los SQL del repositorio.

## Notas sobre los datos

- El catálogo incluye licenciaturas, ingenierías, menciones y programas técnicos. Los **106 registros** no representan necesariamente 106 carreras únicas activas.
- Algunos códigos (`INF001`, `UASD-LOC-*`, `PLAN-P-*`) son **identificadores internos o referencias de planes**, no códigos oficiales de carrera de la UASD.
- El pensum de Informática está identificado como **plan 200820**. No se afirma que sea el pensum vigente.
- Fuentes de referencia declaradas en los scripts: [Planes de grado UASD](https://app.uasd.edu.do/planesgrado/) y [Oferta académica UASD](https://uasd.edu.do/oferta-academica/). El script del pensum también consigna otras referencias; la validez y vigencia de cada dato deben verificarse con la institución.

## Autoría y finalidad

Proyecto académico de consulta del catálogo de carreras de la UASD. Se utiliza una base SQLite local y una API Java; no es un portal oficial de la universidad.
