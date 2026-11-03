
# UASD Académica
## Plan de desarrollo y aprendizaje

**Proyecto:** UASD Académica  
**Tipo:** Sistema de consulta académica  
**Universidad:** Universidad Autónoma de Santo Domingo (UASD)  
**Fecha de inicio:** 2 de noviembre de 2026  
**Fecha de entrega:** 26 de noviembre de 2026  
**Estado:** En desarrollo  

---

# 1. Descripción del proyecto

UASD Académica será una aplicación web local desarrollada con Java y Spring Boot en el backend, React y TypeScript en el frontend y SQLite como base de datos.

El sistema permitirá consultar información académica de la Universidad Autónoma de Santo Domingo.

Inicialmente, permitirá seleccionar una escuela y visualizar las carreras que ofrece.

Posteriormente, podrá incorporar planes de estudio, asignaturas, créditos y prerrequisitos.

El proyecto estará organizado para permitir futuras ampliaciones.

---

# 2. Objetivo general

Desarrollar un sistema de información académica que permita consultar las carreras ofertadas por la Universidad Autónoma de Santo Domingo mediante una interfaz gráfica conectada a una base de datos local.

## 2.1. Objetivos específicos

- Diseñar una base de datos relacional.
- Registrar facultades, escuelas y carreras.
- Desarrollar una API REST utilizando Java y Spring Boot.
- Implementar consultas SQL desde Java.
- Crear una interfaz gráfica moderna utilizando React.
- Conectar el frontend con el backend.
- Permitir consultar carreras según la escuela seleccionada.
- Implementar búsquedas y filtros.
- Documentar y probar el funcionamiento del sistema.
- Publicar el código fuente en GitHub.

---

# 3. Tecnologías

| Tecnología | Utilización |
|---|---|
| Java | Lenguaje del backend |
| Spring Boot | Desarrollo de API REST |
| Maven | Gestión de dependencias |
| SQLite | Base de datos local |
| JDBC | Comunicación con la base de datos |
| React | Interfaz de usuario |
| TypeScript | Lógica del frontend |
| CSS | Diseño visual |
| Git | Control de versiones |
| GitHub | Repositorio del proyecto |
| VS Code | Entorno de desarrollo |

## 3.1. Arquitectura

El sistema estará dividido en tres componentes:

### Frontend

Responsable de mostrar la información y permitir la interacción con el usuario.

Tecnologías:

- React
- TypeScript
- CSS

### Backend

Responsable de recibir solicitudes, procesar información y consultar la base de datos.

Tecnologías:

- Java
- Spring Boot
- JDBC

### Base de datos

Responsable de almacenar la información académica.

Tecnología:

- SQLite

Comunicación:

Frontend → API REST → Backend → SQLite

---

# 4. Requisitos funcionales

## 4.1. Funcionalidades obligatorias

- [ ] RF01: Consultar facultades.
- [ ] RF02: Consultar escuelas pertenecientes a una facultad.
- [ ] RF03: Consultar carreras pertenecientes a una escuela.
- [ ] RF04: Seleccionar una escuela desde la interfaz gráfica.
- [ ] RF05: Mostrar las carreras mediante un botón.
- [ ] RF06: Obtener la información desde SQLite.
- [ ] RF07: Buscar carreras por nombre.
- [ ] RF08: Mostrar información básica de cada carrera.
- [ ] RF09: Ejecutar el sistema localmente.
- [ ] RF10: Entregar el código fuente mediante GitHub.

## 4.2. Funcionalidades opcionales

Estas funcionalidades se implementarán solamente si las obligatorias están terminadas.

- [ ] Consultar asignaturas de una carrera.
- [ ] Mostrar el pénsum por semestre.
- [ ] Mostrar créditos académicos.
- [ ] Consultar prerrequisitos.
- [ ] Visualizar relaciones entre asignaturas.
- [ ] Implementar planificación académica.
- [ ] Exportar información a PDF.
- [ ] Incorporar modo oscuro.
- [ ] Desarrollar un panel administrativo.

---

# 5. Modelo de datos inicial

## 5.1. Facultad

Atributos:

- id
- nombre
- descripción

## 5.2. Escuela

Atributos:

- id
- nombre
- facultad_id

## 5.3. Carrera

Atributos:

- id
- código
- nombre
- escuela_id
- descripción

## 5.4. Plan de estudio

Atributos:

- id
- carrera_id
- versión
- fecha de vigencia

## 5.5. Asignatura

Atributos:

- id
- código
- nombre
- créditos

## 5.6. PlanAsignatura

Relaciona las asignaturas con los planes de estudio.

Atributos:

- plan_id
- asignatura_id
- semestre

Las tablas definitivas se diseñarán antes de implementar SQLite.

---

# 6. Metodología de desarrollo

Cada funcionalidad seguirá cinco etapas:

1. Definir qué problema resolverá.
2. Estudiar los conceptos necesarios.
3. Diseñar las clases, datos y responsabilidades.
4. Implementar la funcionalidad mediante ejercicios.
5. Probar, documentar y subir los cambios a GitHub.

No se implementarán funcionalidades sin comprender primero sus conceptos principales.

---

# 7. Módulos de aprendizaje

## Módulo 1: Fundamentos de Java

### Conceptos

- [ ] Sintaxis básica.
- [ ] Variables y tipos de datos.
- [ ] Operadores.
- [ ] Condicionales.
- [ ] Bucles.
- [ ] Métodos y parámetros.
- [ ] Clases y objetos.
- [ ] Constructores.
- [ ] Encapsulamiento.
- [ ] Getters y setters.
- [ ] Listas y colecciones.
- [ ] Manejo básico de excepciones.

### Práctica

Crear objetos que representen facultades, escuelas y carreras.

### Criterio de finalización

Poder crear, almacenar y recorrer una lista de objetos sin copiar una solución completa.

---

## Módulo 2: Fundamentos de Spring Boot

### Conceptos

- [ ] Cliente y servidor.
- [ ] HTTP.
- [ ] Métodos GET y POST.
- [ ] API REST.
- [ ] JSON.
- [ ] Controladores.
- [ ] Servicios.
- [ ] Inyección de dependencias.
- [ ] Respuestas y códigos HTTP.

### Práctica

Crear API para consultar facultades y carreras utilizando datos temporales.

### Criterio de finalización

Poder desarrollar un endpoint GET que devuelva una lista de objetos en JSON.

---

## Módulo 3: Bases de datos

### Conceptos

- [ ] Bases de datos relacionales.
- [ ] Tablas y registros.
- [ ] Claves primarias.
- [ ] Claves foráneas.
- [ ] Relaciones uno a muchos.
- [ ] SELECT.
- [ ] INSERT.
- [ ] UPDATE.
- [ ] DELETE.
- [ ] JOIN.
- [ ] JDBC.
- [ ] Consultas parametrizadas.

### Práctica

Crear las tablas académicas y conectarlas con Java.

### Criterio de finalización

Consultar carreras desde SQLite utilizando Java.

---

## Módulo 4: Catálogo académico

### Funcionalidades

- [ ] Consultar facultades.
- [ ] Consultar escuelas.
- [ ] Consultar carreras.
- [ ] Filtrar carreras por escuela.
- [ ] Buscar carreras.
- [ ] Importar datos académicos verificados.

### Criterio de finalización

Tener una API conectada a SQLite que devuelva información académica real.

---

## Módulo 5: Frontend

### Conceptos

- [ ] Componentes React.
- [ ] Props.
- [ ] Estado.
- [ ] Eventos.
- [ ] useEffect.
- [ ] Fetch API.
- [ ] TypeScript aplicado a React.
- [ ] CSS Grid.
- [ ] Flexbox.
- [ ] Diseño adaptable.

### Funcionalidades

- [ ] Crear página principal.
- [ ] Crear navegación.
- [ ] Mostrar facultades.
- [ ] Mostrar escuelas.
- [ ] Mostrar carreras.
- [ ] Agregar botones.
- [ ] Agregar búsqueda.
- [ ] Diseñar tarjetas académicas.

### Criterio de finalización

Poder navegar y consultar información desde una interfaz gráfica.

---

## Módulo 6: Integración

### Funcionalidades

- [ ] Conectar React con Spring Boot.
- [ ] Consumir respuestas JSON.
- [ ] Implementar consulta mediante botones.
- [ ] Mostrar mensajes de error.
- [ ] Mostrar estados de carga.
- [ ] Manejar resultados vacíos.

### Criterio de finalización

Seleccionar una escuela y visualizar sus carreras obtenidas desde SQLite.

---

## Módulo 7: Pruebas y mejoras

### Actividades

- [ ] Probar los endpoints.
- [ ] Verificar las consultas SQL.
- [ ] Probar la navegación.
- [ ] Manejar errores.
- [ ] Corregir problemas visuales.
- [ ] Validar datos académicos.
- [ ] Revisar rendimiento básico.

---

## Módulo 8: Entrega

### Actividades

- [ ] Actualizar README.
- [ ] Documentar instalación.
- [ ] Documentar ejecución.
- [ ] Crear scripts de base de datos.
- [ ] Probar el proyecto desde cero.
- [ ] Verificar el repositorio de GitHub.
- [ ] Preparar demostración.
- [ ] Entregar proyecto.

---

# 8. Cronograma

## 2 al 5 de noviembre

Análisis, planificación y configuración.

## 6 al 11 de noviembre

Fundamentos necesarios de Java y desarrollo inicial del backend.

## 12 al 17 de noviembre

Base de datos, consultas y primera interfaz funcional.

## 18 al 21 de noviembre

Integración, diseño visual y funcionalidades complementarias.

## 22 al 25 de noviembre

Pruebas, documentación y correcciones.

## 26 de noviembre

Entrega del proyecto.

Este cronograma podrá ajustarse según los avances.

---

# 9. Estado actual

## Completado

- [x] Proyecto Spring Boot creado.
- [x] Java configurado.
- [x] Maven funcionando.
- [x] Servidor local iniciado correctamente.
- [x] API Hola Mundo funcionando.
- [x] Repositorio creado en GitHub.
- [x] Primer código publicado.

## En desarrollo

- [ ] Comprender completamente clases y objetos.
- [ ] Comprender constructores.
- [ ] Practicar encapsulamiento.
- [ ] Comprender getters y setters.
- [ ] Probar API de facultades.

## Pendiente

- [ ] Completar los fundamentos necesarios.
- [ ] Crear una API de listas de facultades.
- [ ] Diseñar SQLite.
- [ ] Implementar consultas reales.
- [ ] Crear frontend.
- [ ] Integrar backend y frontend.
- [ ] Preparar entrega.

---

# 10. Registro de avances

## 2 de noviembre de 2026

### Actividades

- Configuración de Spring Boot.
- Creación del proyecto.
- Primera ejecución del servidor.
- Implementación de HolaController.
- Corrección de paquetes de Java.
- Prueba del endpoint /api/hola.
- Publicación del proyecto en GitHub.
- Introducción a clases y constructores.
- Creación inicial de Facultad y FacultadController.

### Problemas encontrados

El endpoint /api/hola devolvía error 404 porque el paquete del controlador no coincidía con el paquete principal.

### Solución

Se corrigió la declaración package del controlador y se reinició Spring Boot.

### Resultado

Primera API REST funcionando correctamente.

---

# 11. Reglas de desarrollo

1. Comprender antes de programar.
2. No incorporar tecnologías innecesarias.
3. Mantener el código organizado.
4. Utilizar nombres claros.
5. Separar responsabilidades.
6. Probar cada funcionalidad.
7. No subir contraseñas ni información privada.
8. Crear commits descriptivos.
9. Actualizar este documento.
10. Priorizar una entrega funcional.

---

# 12. Definición de terminado

Una funcionalidad se considerará terminada solamente cuando:

- El código compile correctamente.
- El funcionamiento haya sido probado.
- No tenga errores conocidos que impidan su uso.
- Se comprenda su lógica principal.
- Se haya actualizado la documentación.
- Los cambios estén registrados en Git.

---

# 13. Próxima actividad

Retomar el Módulo 1: Fundamentos de Java.

Revisar y practicar:

1. Clases y objetos.
2. Constructores.
3. Métodos.
4. Encapsulamiento.
5. Getters y setters.
6. Listas de objetos.

Después utilizaremos esos conocimientos para completar FacultadController y devolver información en JSON.

---

# 14. Objetivo final

Entregar el 26 de noviembre de 2026 un sistema funcional desarrollado con Java, Spring Boot, React, TypeScript y SQLite, capaz de consultar carreras de la UASD mediante una interfaz gráfica.

El proyecto deberá ejecutarse localmente, contar con documentación y estar disponible en GitHub.

Las funcionalidades avanzadas podrán incorporarse posteriormente como parte de una versión ampliada de UASD Académica.

