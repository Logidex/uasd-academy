# UASD Académica — Plan de desarrollo y bitácora

**Proyecto:** UASD Académica  
**Inicio:** 2 de noviembre de 2026  
**Entrega objetivo:** 26 de noviembre de 2026  
**Estado:** En desarrollo — primera API funcional  
**Repositorio:** `uasd-academy` (GitHub; completar URL)  
**Entorno:** Windows, Visual Studio Code  

> **Cómo usar este documento:** actualiza las casillas y el registro de avances al terminar cada sesión. No marques funciones como terminadas hasta que las hayas probado. Sube el archivo junto con tu código mediante Git.

## 1. Propósito

Desarrollar un sistema de consulta académica de la Universidad Autónoma de Santo Domingo que permita consultar carreras por escuela desde una base de datos. Se construirá una versión web local: backend Java con API REST y frontend web. Se procurará un diseño claro y moderno, con espacio para ampliar el catálogo a asignaturas y planes de estudio.

### Requisito mínimo de la asignación
- [ ] Consultar carreras por escuela seleccionada.
- [ ] Disponer de un botón que realice la consulta.
- [ ] Recuperar los registros de una base de datos, no de una lista fija en el código.
- [ ] Demostrar una aplicación funcionando con Java.
- [ ] Confirmar que el profesor acepta una interfaz web local con backend Java, en lugar de una ventana de escritorio Java.

### Alcance ampliado (sujeto al tiempo y a fuentes verificadas)
- [ ] Consultar facultades, escuelas y carreras.
- [ ] Buscar carreras por nombre.
- [ ] Consultar detalles de una carrera.
- [ ] Mostrar asignaturas y planes de estudio que se hayan podido verificar.
- [ ] Mostrar créditos, semestres y prerrequisitos cuando existan datos confiables.

### Fuera del alcance obligatorio para esta entrega
- Cargar **todos** los pénsums y materias si no se obtienen fuentes confiables a tiempo.
- Sistema de inscripción o autenticación institucional.
- Sincronización con sistemas privados de la UASD.
- Aplicación móvil y publicación en servidores públicos.

## 2. Tecnologías y arquitectura

| Componente | Elección | Estado |
|---|---|---|
| Editor | Visual Studio Code | En uso |
| Lenguaje backend | Java (el entorno actual ejecuta Java 27) | En uso |
| Framework backend | Spring Boot 4.1.2 | En uso |
| Gestor de proyecto | Maven / Maven Wrapper | En uso |
| API | HTTP REST con JSON | Primer endpoint listo |
| Base de datos | SQLite | Pendiente |
| Acceso a datos | JDBC o repositorios según diseño | Pendiente |
| Frontend | React + TypeScript + CSS | Pendiente |
| Versionado | Git + GitHub | Repositorio publicado |

### Flujo previsto

`Navegador (React) → HTTP/JSON → Java (Spring Boot) → consultas SQL → SQLite`

En desarrollo, frontend y backend pueden ejecutarse en puertos distintos. Para la entrega, se evaluará servir la compilación de React desde Spring Boot y mantener una instalación local sencilla.

## 3. Estructura actual del proyecto

```text
uasd-academy/
├── Backend/
│   ├── src/main/java/com/uasd_academy/
│   │   ├── UasdAcademyApplication.java
│   │   ├── controller/
│   │   │   ├── HolaController.java
│   │   │   └── FacultadController.java
│   │   └── model/
│   │       └── Facultad.java
│   ├── src/main/resources/application.properties
│   ├── pom.xml
│   └── mvnw.cmd
├── PLAN_DESARROLLO.md
└── README.md  (si existe en la raíz)
```

**Nota:** la clase `Facultad.java` se trabajó durante las lecciones; confirmar en VS Code que esté guardada con constructor y getters. En `FacultadController.java`, el paquete debe ser `com.uasd_academy.controller`.

## 4. Estado de implementación

### Completado y confirmado
- [x] Crear proyecto Maven / Spring Boot.
- [x] Configurar la ejecución desde VS Code.
- [x] Iniciar Tomcat en `localhost:8080`.
- [x] Crear y probar el endpoint `GET /api/hola`.
- [x] Corregir el nombre del paquete del controlador Hola.
- [x] Publicar el proyecto en GitHub.

### En progreso / por verificar
- [ ] Confirmar que `Facultad.java` tiene atributos, constructor y getters.
- [ ] Compilar y probar `GET /api/facultad`.
- [ ] Comprobar que devuelve JSON con `id`, `nombre` y `fundacion`.

### Próximas funciones
- [ ] Devolver una lista de objetos Facultad.
- [ ] Aprender colecciones `List`, parámetros y respuestas HTTP.
- [ ] Crear tablas relacionales en SQLite.
- [ ] Consultar desde Java las facultades, escuelas y carreras almacenadas.
- [ ] Crear una pantalla web para seleccionar escuela y consultar carreras.
- [ ] Integrar React con la API.
- [ ] Probar y empaquetar la entrega.

## 5. Cronograma de referencia

| Fechas | Meta | Entregable verificable |
|---|---|---|
| 2–5 nov. | Entorno, Git y primera API | `GET /api/hola` responde |
| 6–11 nov. | Modelos, base de datos y consultas Java | API de carreras basada en SQLite |
| 12–17 nov. | Interfaz React y conexión con backend | Seleccionar escuela y ver carreras |
| 18–21 nov. | Detalles y datos académicos adicionales | Consultas ampliadas y búsqueda |
| 22–25 nov. | Pruebas, correcciones, documentación | Versión instalable/ejecutable y demostrable |
| 26 nov. | Entrega | Repositorio y proyecto funcionando |

**Regla de prioridad:** si existe retraso, terminar primero el flujo mínimo *escuela → botón → API Java → SQLite → lista de carreras*. Congelar funciones nuevas a partir del 21 de noviembre.

## 6. Registro de avances (bitácora)

| Fecha | Actividad | Resultado | Próximo paso |
|---|---|---|---|
| 02/11/2026 | Creación de proyecto Spring Boot | Servidor arranca en puerto 8080 | Primera ruta REST |
| 02/11/2026 | Corrección del paquete de `HolaController` | `/api/hola` funciona | Publicar repositorio |
| 02/11/2026 | Subida inicial a GitHub | Repositorio publicado | Crear modelo Facultad |
| 02/11/2026 | Introducción a clases, constructor y getters | Ejercicios realizados; controlador de facultad escrito | Probar `/api/facultad` |

### Plantilla para cada sesión

```text
Fecha:
Objetivo:
Qué aprendí:
Archivos modificados:
Pruebas realizadas:
Errores encontrados y solución:
Commit de Git:
Siguiente tarea:
```

## 7. Validación y pruebas

- [x] `GET http://localhost:8080/api/hola` responde correctamente.
- [ ] `GET http://localhost:8080/api/facultad` responde JSON correcto.
- [ ] La API devuelve listas de carreras desde SQLite.
- [ ] Un filtro por escuela devuelve solamente sus carreras.
- [ ] Los datos vacíos muestran un mensaje comprensible.
- [ ] La aplicación puede ejecutarse en una computadora distinta.
- [ ] El README contiene instrucciones reproducibles.
- [ ] El repositorio no incluye contraseñas ni archivos de compilación.

## 8. Fuentes y calidad de datos

Fuentes institucionales a revisar:
- https://app.uasd.edu.do/planesgrado/
- https://uasd.edu.do/vicerrectoria-docente/ofertas-academicas/

**Regla:** no presentar años de fundación, códigos, créditos o materias inventados como información oficial. Los datos de ejemplo utilizados para aprender se sustituirán por registros verificados antes de la entrega. Guardar nombre, URL y fecha de consulta de cada fuente utilizada.

## 9. Riesgos y decisiones pendientes

| Riesgo o decisión | Medida propuesta |
|---|---|
| Demasiadas funcionalidades en 24 días | Priorizar requisito mínimo y pruebas |
| Datos oficiales incompletos | Identificar cobertura; usar solo datos verificados |
| Profesor podría exigir escritorio | Confirmar aceptación de app web local cuanto antes |
| Java 27 en el entorno actual | Comprobar compatibilidad y documentar requisitos de ejecución |
| Dificultades con React / integración | Mantener API independiente y funcional |
| Problemas al instalar en otro equipo | Preparar instrucciones y prueba de instalación limpia |

## 10. Próximo paso inmediato

1. Guardar `Facultad.java` con constructor y getters.
2. Ejecutar el backend.
3. Abrir `http://localhost:8080/api/facultad` y verificar la respuesta JSON.
4. Corregir errores antes de introducir más conceptos.
5. Registrar la prueba y crear un commit.

**Convención de commits sugerida:** `feat:`, `fix:`, `docs:`, `test:`.
