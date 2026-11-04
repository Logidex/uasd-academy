-- UASD Académica | Facultad de Ciencias Jurídicas y Políticas | planes 000012
-- Fuente: dos PDF originales de la UASD aportados por el usuario.
-- Derecho: 73 materias/espacios curriculares, 226 créditos (10 semestres + tesis).
-- Ciencias Políticas: 61 materias/espacios curriculares, 197 créditos (8 semestres + tesis).
-- La tesis se coloca en periodo 11 para Derecho y periodo 9 para Ciencias Políticas.
-- Requiere schema.sql y ampliacion_masiva_uasd.sql; no sobrescribe materias existentes.
-- Los datos de prerrequisitos y equivalencias están preservados en materias_juridicas_2_pensums.csv;
-- las tablas actuales no tienen columnas para almacenarlos.
PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS fuentes_pensum (codigo_plan TEXT PRIMARY KEY, codigo_carrera_db TEXT NOT NULL, plan TEXT NOT NULL, pdf_fuente TEXT NOT NULL, total_materias INTEGER NOT NULL, total_creditos INTEGER NOT NULL);
DROP TABLE IF EXISTS temp._juridicas_planes;
CREATE TEMP TABLE _juridicas_planes(codigo_plan TEXT PRIMARY KEY, nombre TEXT NOT NULL, escuela TEXT NOT NULL, version TEXT NOT NULL, pdf TEXT NOT NULL, total_materias INTEGER NOT NULL, total_creditos INTEGER NOT NULL);
INSERT INTO _juridicas_planes VALUES
('P-DERE','Licenciatura en Derecho','Escuela de Derecho','000012','Licenciatura en Derecho.pdf',73,226),
('P-CSPO','Licenciatura en Ciencias Políticas','Escuela de Ciencias Políticas','000012','Licenciatura en Ciencias Políticas.pdf',61,197);
DROP TABLE IF EXISTS temp._juridicas_materias;
CREATE TEMP TABLE _juridicas_materias (plan TEXT NOT NULL, codigo TEXT NOT NULL, nombre TEXT NOT NULL, creditos INTEGER NOT NULL, periodo INTEGER NOT NULL);
INSERT INTO _juridicas_materias VALUES
('P-DERE','DER-1150','Introd Al Estudio Del Derecho',3,1),
('P-DERE','DOP-1000','Orientación Institucional',1,1),
('P-DERE','ECN-2110','Introducción A La Economía',4,1),
('P-DERE','FIL-0110','Int a la Filosofía',3,1),
('P-DERE','FIS-0140','Física Básica',4,1),
('P-DERE','HIS-0110','Fund de Hist Social Dominicana',3,1),
('P-DERE','LET-0110','Lengua Española Básica I',3,1),
('P-DERE','SOC-0110','Int A Las Ciencias Sociales',2,1),
('P-DERE','BIO-0140','Biología Básica',3,2),
('P-DERE','DER-1180','Introd Al Est Del Derecho Priv',3,2),
('P-DERE','EFS-0110','Educación Física',1,2),
('P-DERE','IDI-0510','Francés Elemental I',5,2),
('P-DERE','LET-0120','Lengua Española Básica II',3,2),
('P-DERE','MAT-0140','Matemática Básica',4,2),
('P-DERE','QUI-0140','Química Básica',3,2),
('P-DERE','DER-1220','Lógica Jurídica',3,3),
('P-DERE','DER-1370','Derecho Penal General I',3,3),
('P-DERE','DER-2200','Historia Del Derecho',3,3),
('P-DERE','DER-2250','Derecho Romano I',3,3),
('P-DERE','IDI-0520','Francés Elemental II',5,3),
('P-DERE','PSI-1050','Int A La Psicología',3,3),
('P-DERE','DER-1380','Derecho Penal General II',3,4),
('P-DERE','DER-2260','Derecho Romano II',3,4),
('P-DERE','DER-2400','Métodos Y Tec De Invest Jurid',3,4),
('P-DERE','DER-2550','Derecho De Familia I',3,4),
('P-DERE','EST-1100','Fundamento De Estadística',3,4),
('P-DERE','IDI-1530','Traducción Jurídica I',3,4),
('P-DERE','POL-1370','Derecho Constitucional I',3,4),
('P-DERE','POL-3280','Hist De Las Ideas Políticas I',3,4),
('P-DERE','DER-2450','Servicios Jurídicos I',3,5),
('P-DERE','DER-2560','Derecho De Familia II',3,5),
('P-DERE','DER-2570','Derecho De Los Bienes',3,5),
('P-DERE','INF-1040','Int A La Informática Jurídica',3,5),
('P-DERE','POL-1380','Derecho Constitucional II',3,5),
('P-DERE','POL-3290','Hist De Las Ideas Políticas II',3,5),
('P-DERE','SOC-1310','Sociología Jurídica',3,5),
('P-DERE','DER-1580','Derecho De Obligaciones I',3,6),
('P-DERE','DER-2460','Servicios Jurídicos II',3,6),
('P-DERE','DER-2580','Derecho De Contratos',3,6),
('P-DERE','DER-3330','Derecho Penal Especial I',3,6),
('P-DERE','DER-3560','Derecho Procesal Civil I',3,6),
('P-DERE','DER-3610','Derecho Comercial I',3,6),
('P-DERE','POL-2350','Derecho Administrativo',3,6),
('P-DERE','POL-2410','Der Internacional Público I',3,6),
('P-DERE','DER-1590','Derecho De Obligaciones II',3,7),
('P-DERE','DER-2290','Derecho Comparado',3,7),
('P-DERE','DER-2470','Servicios Jurídicos III',3,7),
('P-DERE','DER-3340','Derecho Penal Especial II',3,7),
('P-DERE','DER-3580','Derecho Procesal Civil II',3,7),
('P-DERE','DER-3620','Derecho Comercial II',3,7),
('P-DERE','DER-3630','Derecho Laboral I',3,7),
('P-DERE','POL-2420','Der Internacional Público II',3,7),
('P-DERE','DER-2480','Servicios Jurídicos IV',3,8),
('P-DERE','DER-2500','Derecho De Las Garantías',3,8),
('P-DERE','DER-2670','Derecho Agrario',3,8),
('P-DERE','DER-3350','Derecho Procesal Penal I',3,8),
('P-DERE','DER-3590','Derecho Procesal Civil III',3,8),
('P-DERE','DER-3640','Derecho Laboral II',3,8),
('P-DERE','DER-3670','Derecho Inmobiliario',3,8),
('P-DERE','POL-2440','Der Internacional Americano',3,8),
('P-DERE','DER-2270','Filosofía Del Derecho',3,9),
('P-DERE','DER-3250','Ética Jurídica',3,9),
('P-DERE','DER-3360','Derecho Procesal Penal II',3,9),
('P-DERE','DER-3370','Criminología',3,9),
('P-DERE','DER-3490','Derecho Notarial',3,9),
('P-DERE','DER-3650','Derecho Internacional Priv I',3,9),
('P-DERE','DER-4500','Derecho Procesal Civil IV',3,9),
('P-DERE','DER-4510','Responsabilidad Civil I',3,9),
('P-DERE','DER-3380','Derecho Penitenciario',3,10),
('P-DERE','DER-3660','Derecho Internacional Priv II',3,10),
('P-DERE','DER-4520','Responsabilidad Civil II',3,10),
('P-DERE','DER-4550','Derecho De Las Sucs Y Donac',3,10),
('P-DERE','DER-7000','Tesis De Grado O Curso Equival',8,11),
('P-CSPO','DOP-1000','Orientación Institucional',1,1),
('P-CSPO','EFS-0110','Educación Física',1,1),
('P-CSPO','FIL-0110','Int a la Filosofía',3,1),
('P-CSPO','HIS-0110','Fund de Hist Social Dominicana',3,1),
('P-CSPO','LET-0110','Lengua Española Básica I',3,1),
('P-CSPO','MAT-0140','Matemática Básica',4,1),
('P-CSPO','POL-1140','Geopolítica',3,1),
('P-CSPO','POL-1150','Int A La Ciencia Política',3,1),
('P-CSPO','QUI-0140','Química Básica',3,1),
('P-CSPO','BIO-0140','Biología Básica',3,2),
('P-CSPO','DER-1150','Introd Al Estudio Del Derecho',3,2),
('P-CSPO','ECN-2110','Introducción A La Economía',4,2),
('P-CSPO','EST-1100','Fundamento De Estadística',3,2),
('P-CSPO','FIL-1230','Int A La Log Formal Y Dialect',4,2),
('P-CSPO','LET-0120','Lengua Española Básica II',3,2),
('P-CSPO','POL-2170','Historia Política Dominicana',4,2),
('P-CSPO','SOC-0110','Int A Las Ciencias Sociales',2,2),
('P-CSPO','ECN-3130','Economía Política I',3,3),
('P-CSPO','FIS-0140','Física Básica',4,3),
('P-CSPO','INF-1010','Int Al Procesamiento De Datos',4,3),
('P-CSPO','POL-2180','Historia Política I',4,3),
('P-CSPO','POL-3210','His De Las Ideas Políticas I',4,3),
('P-CSPO','SOC-1110','Fundamentos De Sociología',3,3),
('P-CSPO','SOC-1220','Fund De Investigación Social',3,3),
('P-CSPO','ECN-1130','Historia Económica',3,4),
('P-CSPO','ECN-3140','Economía Política II',3,4),
('P-CSPO','GEO-2410','Geografía Humana',3,4),
('P-CSPO','POL-1370','Derecho Constitucional I',3,4),
('P-CSPO','POL-2190','Historia Política II',3,4),
('P-CSPO','POL-2380','Teoría Del Estado',3,4),
('P-CSPO','POL-3220','His De Las Ideas Políticas II',4,4),
('P-CSPO','SOC-1240','Diseño De Inv Empírica',3,4),
('P-CSPO','ECN-1370','Economía Dominicana I',3,5),
('P-CSPO','ECN-2210','Fund Desarrollo Económico',4,5),
('P-CSPO','POL-1380','Derecho Constitucional II',3,5),
('P-CSPO','POL-2200','Teoría Política Contemporánea',3,5),
('P-CSPO','POL-2340','Partidos Políticos',3,5),
('P-CSPO','POL-2410','Der Internacional Público I',3,5),
('P-CSPO','POL-3140','Política Mundial Contemporánea',4,5),
('P-CSPO','POL-3230','His Del Pensamiento Pol Dom',3,5),
('P-CSPO','ECN-1380','Economía Dominicana II',3,6),
('P-CSPO','POL-2220','Investigación Política',3,6),
('P-CSPO','POL-2390','Sistema Electoral Dominicano',3,6),
('P-CSPO','POL-2420','Der Internacional Público II',3,6),
('P-CSPO','POL-2460','Organizaciones Internacionales',3,6),
('P-CSPO','POL-3160','Desarrollo Político',3,6),
('P-CSPO','POL-3300','Instituc Políticas Y Admvas',3,6),
('P-CSPO','POL-4200','Pensamiento Político Latinoam',3,6),
('P-CSPO','ECN-2310','Economía Internacional',4,7),
('P-CSPO','POL-2250','Opinión Pública Y Propag Polit',4,7),
('P-CSPO','POL-2260','Mov Soc Y Grup De Pres En Rd',3,7),
('P-CSPO','POL-2360','Derecho Administrativo',3,7),
('P-CSPO','POL-2440','Der Internacional Americano',3,7),
('P-CSPO','POL-3150','Política Dominicana',3,7),
('P-CSPO','POL-3370','Sistemas Políticos',3,7),
('P-CSPO','ECN-3280','Política Económica',4,8),
('P-CSPO','POL-3390','Políticas Públicas',3,8),
('P-CSPO','POL-3400','Der Diplomático Y Consular',3,8),
('P-CSPO','POL-3430','Relaciones Internacionales',3,8),
('P-CSPO','POL-4110','Deontología Política',3,8),
('P-CSPO','POL-7000','Tesis De Grado O Curso Equival',8,9);
-- Falla de forma explícita si faltan carreras/escuelas esperadas.
DROP TABLE IF EXISTS temp._juridicas_validacion;
CREATE TEMP TABLE _juridicas_validacion (ok INTEGER NOT NULL CHECK (ok = 1));
INSERT INTO _juridicas_validacion SELECT CASE WHEN COUNT(*) = 2 THEN 1 ELSE 0 END FROM _juridicas_planes p JOIN carreras c ON c.codigo = 'PLAN-' || p.codigo_plan JOIN escuelas e ON e.id_escuela=c.id_escuela AND e.nombre=p.escuela;
-- Solo crear asignaturas ausentes: no sobreescribir créditos ni nombres existentes.
INSERT OR IGNORE INTO materias(codigo,nombre,creditos) SELECT codigo,MIN(nombre),MIN(creditos) FROM _juridicas_materias GROUP BY codigo;
INSERT OR IGNORE INTO carrera_materias(id_carrera,id_materia,periodo) SELECT c.id_carrera,m.id_materia,r.periodo FROM _juridicas_materias r JOIN _juridicas_planes p ON p.codigo_plan=r.plan JOIN carreras c ON c.codigo='PLAN-'||p.codigo_plan JOIN materias m ON m.codigo=r.codigo;
INSERT OR IGNORE INTO fuentes_pensum(codigo_plan,codigo_carrera_db,plan,pdf_fuente,total_materias,total_creditos) SELECT p.codigo_plan,c.codigo,p.version,p.pdf,p.total_materias,p.total_creditos FROM _juridicas_planes p JOIN carreras c ON c.codigo='PLAN-'||p.codigo_plan;
COMMIT;
-- Comprobación por carrera. El crédito del catálogo maestro puede diferir del PDF si hay colisiones históricas.
SELECT p.codigo_plan,p.nombre,p.total_materias AS materias_pdf,p.total_creditos AS creditos_pdf, COUNT(cm.id_materia) AS materias_db,COALESCE(SUM(m.creditos),0) AS creditos_db FROM _juridicas_planes p LEFT JOIN carreras c ON c.codigo='PLAN-'||p.codigo_plan LEFT JOIN carrera_materias cm ON cm.id_carrera=c.id_carrera LEFT JOIN materias m ON m.id_materia=cm.id_materia GROUP BY p.codigo_plan ORDER BY p.codigo_plan;
-- Reporte de códigos con crédito distinto al ya existente; revisar diferencias antes de afirmar equivalencia.
SELECT r.plan,r.codigo,MIN(r.nombre) AS nombre_pdf,MIN(r.creditos) AS creditos_pdf,m.nombre AS nombre_catalogo,m.creditos AS creditos_catalogo FROM _juridicas_materias r JOIN materias m ON m.codigo=r.codigo WHERE r.creditos<>m.creditos GROUP BY r.plan,r.codigo ORDER BY r.plan,r.codigo;
PRAGMA foreign_key_check;
