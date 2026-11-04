-- UASD ACADEMICA | Pensum faltante: Ingenieria Geomatica, P-IGEO, plan 200910.
-- Fuente: PDF UASD provisto por el usuario, 3 paginas, 5 semestres, 23 asignaturas, 76 creditos.
-- URL en PDF: https://app.uasd.edu.do/PensumGrado/?periodoV=999999&programa=P-IGEO&plan=200910&nivel=GR
-- Requiere importar previamente los 113 pensums (hasta Educacion).
-- Carrera YA EXISTENTE: PLAN-P-IGEO, Escuela de Agrimensura, Facultad de Ingenieria y Arquitectura.
-- No agrega carreras ni modifica nombres/creditos de materias existentes.
-- Si falla CHECK, detener: ROLLBACK TO SAVEPOINT importar_geomatica; RELEASE SAVEPOINT importar_geomatica;
PRAGMA foreign_keys = ON;
SAVEPOINT importar_geomatica;

CREATE TABLE IF NOT EXISTS fuentes_pensum (
 codigo_plan TEXT PRIMARY KEY, codigo_carrera_db TEXT NOT NULL,
 plan TEXT NOT NULL, pdf_fuente TEXT NOT NULL,
 total_materias INTEGER NOT NULL, total_creditos INTEGER NOT NULL
);

DROP TABLE IF EXISTS temp._geo_plan;
CREATE TEMP TABLE _geo_plan (
 codigo_plan TEXT PRIMARY KEY, codigo_db TEXT NOT NULL,
 version TEXT NOT NULL, escuela TEXT NOT NULL, facultad TEXT NOT NULL,
 total_materias INTEGER NOT NULL, total_creditos INTEGER NOT NULL
);
INSERT INTO _geo_plan VALUES
('P-IGEO','PLAN-P-IGEO','200910','Escuela de Agrimensura','Facultad de Ingeniería y Arquitectura',23,76);

DROP TABLE IF EXISTS temp._geo_materias;
CREATE TEMP TABLE _geo_materias (
 codigo TEXT PRIMARY KEY, nombre TEXT NOT NULL,
 creditos INTEGER NOT NULL CHECK (creditos >= 0),
 periodo INTEGER NOT NULL CHECK (periodo BETWEEN 1 AND 5)
);
INSERT INTO _geo_materias (codigo,nombre,creditos,periodo) VALUES
('AGM-5000','Introducción a la Geomática',2,1),
('AGM-5010','Tecnología Computacional I',2,1),
('EST-1110','Estadística General',4,1),
('FIS-5050','Física General II-A',3,1),
('MAT-2580','Cálculo y Analítica II',5,1),
('AGM-5020','Errores y Ajustes',3,2),
('AGM-5030','Tecnología Computacional II',2,2),
('AGM-5040','Normatización Catastral',2,2),
('IDI-0130','Inglés Técnico',4,2),
('MAT-3600','Ecuaciones Diferenciales',5,2),
('AGM-5050','Geodesia I',4,3),
('AGM-5060','Aplics Computacionales en Top',3,3),
('AGM-5070','Sistema de Inf Geográfica I',3,3),
('AGM-5080','Fotogamet y Fotointer Aplic',3,3),
('ECN-1100','Nociones de Economía',3,3),
('AGM-5090','Sistema de Inf Geográfica II',3,4),
('AGM-5100','Análisis de Imag y Teledet',3,4),
('AGM-5110','Topografía Vial',4,4),
('AGM-5120','Geodesia II',4,4),
('AGM-5130','Ingeniería Ambiental',2,5),
('AGM-5140','Análisis de Costo y Presupuest',2,5),
('AGM-5150','Administ de Proyecto Geomático',2,5),
('AGM-7000','Tesis de Grado',8,5);

DROP TABLE IF EXISTS temp._geo_guard;
CREATE TEMP TABLE _geo_guard(ok INTEGER NOT NULL CHECK(ok=1));
-- Los 23 registros suman los 76 creditos PDF.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(*)=23 AND SUM(creditos)=76 THEN 1 ELSE 0 END FROM _geo_materias;
-- Verificacion por semestre: 16,16,16,14,14.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(*)=0 THEN 1 ELSE 0 END FROM (
 SELECT periodo,SUM(creditos) AS total FROM _geo_materias GROUP BY periodo
 HAVING (periodo=1 AND total<>16) OR (periodo=2 AND total<>16)
 OR (periodo=3 AND total<>16) OR (periodo=4 AND total<>14) OR (periodo=5 AND total<>14)
);
-- Comprobar que la carrera ya existe exactamente una vez y en la escuela/facultad correcta.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(*)=1 THEN 1 ELSE 0 END FROM _geo_plan p
 JOIN carreras c ON c.codigo=p.codigo_db
 JOIN escuelas e ON e.id_escuela=c.id_escuela AND e.nombre=p.escuela
 JOIN facultades f ON f.id_facultad=e.id_facultad AND f.nombre=p.facultad;
-- No reemplazar creditos de materias existentes con valores distintos.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(*)=0 THEN 1 ELSE 0 END FROM _geo_materias r
 JOIN materias m ON m.codigo=r.codigo WHERE m.creditos<>r.creditos;
-- Si ya estaba vinculada, el periodo debe ser identico.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(*)=0 THEN 1 ELSE 0 END FROM _geo_materias r
 JOIN materias m ON m.codigo=r.codigo
 JOIN carrera_materias cm ON cm.id_materia=m.id_materia
 JOIN carreras c ON c.id_carrera=cm.id_carrera AND c.codigo='PLAN-P-IGEO'
 WHERE cm.periodo<>r.periodo;
-- Si la fuente ya existe, sus metadatos deben ser consistentes.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(*)=0 THEN 1 ELSE 0 END FROM fuentes_pensum s
 WHERE s.codigo_plan='P-IGEO' AND (s.codigo_carrera_db<>'PLAN-P-IGEO'
 OR s.plan<>'200910' OR s.total_materias<>23 OR s.total_creditos<>76);

INSERT OR IGNORE INTO materias (codigo,nombre,creditos)
SELECT codigo,nombre,creditos FROM _geo_materias;
INSERT OR IGNORE INTO carrera_materias (id_carrera,id_materia,periodo)
SELECT c.id_carrera,m.id_materia,r.periodo FROM _geo_materias r
 JOIN materias m ON m.codigo=r.codigo
 JOIN carreras c ON c.codigo='PLAN-P-IGEO';
INSERT OR IGNORE INTO fuentes_pensum
(codigo_plan,codigo_carrera_db,plan,pdf_fuente,total_materias,total_creditos)
VALUES ('P-IGEO','PLAN-P-IGEO','200910',
 'Ingenieria_Geomatica_P_IGEO_200910_CORRECTO.pdf',23,76);

-- Comprobar que el registro final tiene 23 materias y 76 creditos.
INSERT INTO _geo_guard SELECT CASE WHEN COUNT(cm.id_materia)=23 AND SUM(m.creditos)=76
 THEN 1 ELSE 0 END
FROM carreras c JOIN carrera_materias cm ON cm.id_carrera=c.id_carrera
JOIN materias m ON m.id_materia=cm.id_materia
WHERE c.codigo='PLAN-P-IGEO';

RELEASE SAVEPOINT importar_geomatica;

-- Reporte final. En una BD con 113 pensums previos: 2864 materias y 6209 relaciones.
SELECT c.nombre AS carrera,COUNT(m.id_materia) AS materias,
 SUM(m.creditos) AS creditos,MIN(cm.periodo) AS primer_semestre,
 MAX(cm.periodo) AS ultimo_semestre
FROM carreras c JOIN carrera_materias cm ON cm.id_carrera=c.id_carrera
JOIN materias m ON m.id_materia=cm.id_materia
WHERE c.codigo='PLAN-P-IGEO' GROUP BY c.id_carrera;
SELECT (SELECT COUNT(*) FROM materias) AS materias_unicas,
 (SELECT COUNT(*) FROM carrera_materias) AS relaciones;
PRAGMA foreign_key_check;
