-- UASD Académica: pensum Licenciatura en Informática (plan 200820)
-- Referencia: https://mipensum.do/uasd/licenciatura-en-informatica
-- Contraste: https://4ved.rcp.services/carreras/licenciatura-en-informatica-fc/print
-- 51 asignaturas, 186 créditos, 10 períodos. Las tres optativas son espacios del plan.
-- Nombres desarrollados para lectura; validar vigencia institucional antes de presentar como pensum actual.
-- Requiere las tablas materias, carrera_materias y la carrera 'Licenciatura en Informática'.
PRAGMA foreign_keys = ON;

-- 1. Catálogo de materias (sin duplicar códigos)
INSERT OR IGNORE INTO materias (codigo, nombre, creditos)
VALUES
    ('BIO-0140', 'Biología Básica', 3),
    ('DOP-1000', 'Orientación Institucional', 1),
    ('HIS-0110', 'Fund de Historia Social Dominicana', 3),
    ('INF-2060', 'Computación Esencial', 4),
    ('INF-2070', 'Laboratorio de Computación Esencial', 1),
    ('LET-0110', 'Lengua Española Básica I', 3),
    ('SOC-0100', 'Introducción a las Ciencias Sociales', 3),
    ('EFS-0120', 'Educación Física', 2),
    ('IDI-0280', 'Inglés Elemental', 5),
    ('INF-5100', 'Introducción a la Programación', 4),
    ('INF-5110', 'Laboratorio de Introducción a la Programación', 1),
    ('LET-0120', 'Lengua Española Básica II', 3),
    ('MAT-0140', 'Matemática Básica', 4),
    ('FIL-0110', 'Introducción a la Filosofía', 3),
    ('FIS-0140', 'Física Básica', 4),
    ('IDI-0130', 'Inglés Técnico', 4),
    ('INF-5120', 'Lenguaje de Programación I', 4),
    ('INF-5130', 'Laboratorio de Lenguaje de Programación I', 1),
    ('MAT-2330', 'Análisis Lineal y Matricial', 5),
    ('QUI-0140', 'Química Básica', 3),
    ('FIS-1150', 'Física para Informática', 3),
    ('FIS-1160', 'Laboratorio de Física para Informática', 1),
    ('INF-5140', 'Lenguaje de Programación II', 4),
    ('INF-5150', 'Laboratorio de Lenguaje de Programación II', 1),
    ('INF-5260', 'Estructura de Datos', 3),
    ('MAT-3560', 'Cálculo I', 5),
    ('EST-2110', 'Estadística Básica', 5),
    ('INF-2080', 'Organización y Arquitectura del Computador', 4),
    ('INF-5160', 'Lenguaje de Programación III', 4),
    ('INF-5170', 'Laboratorio de Lenguaje de Programación III', 1),
    ('MAT-3570', 'Cálculo II', 5),
    ('CON-1190', 'Contabilidad General I', 5),
    ('INF-3220', 'Algoritmos Computacionales', 5),
    ('INF-3240', 'Sistemas Operativos', 4),
    ('INF-4200', 'Base de Datos I', 5),
    ('BIO-2400', 'Bioética', 2),
    ('INF-3290', 'Análisis y Diseño de Sistemas', 5),
    ('INF-5200', 'Base de Datos II', 5),
    ('INF-ZZA0', 'Asignatura optativa (7.º período)', 3),
    ('MAT-1430', 'Matemática Financiera', 5),
    ('MAT-3920', 'Matemática Discreta para Computación', 4),
    ('INF-4250', 'Teleproceso', 4),
    ('INF-4260', 'Redes de Procesamiento de Datos', 4),
    ('INF-5220', 'Ingeniería de Software I', 4),
    ('INF-ZZB0', 'Asignatura optativa (8.º período)', 5),
    ('MAT-3940', 'Investigación de Operaciones', 5),
    ('INF-5230', 'Auditoría de Sistemas Informáticos', 4),
    ('INF-5240', 'Administración de Centros de Cómputos', 4),
    ('INF-5250', 'Ingeniería de Software II', 4),
    ('INF-ZZC0', 'Asignatura optativa (9.º período)', 4),
    ('INF-7010', 'Tesis de Grado o Curso Equivalente', 8);

-- 2. Vincular el pensum a la carrera por nombre y escuela, sin usar IDs fijos
-- Cada materia se vincula a un solo período para este plan de ejemplo.
INSERT OR IGNORE INTO carrera_materias (id_carrera, id_materia, periodo)
SELECT c.id_carrera, m.id_materia, plan.periodo
FROM (
    SELECT column1 AS codigo, column2 AS periodo
    FROM (VALUES
        ('BIO-0140', 1),
        ('DOP-1000', 1),
        ('HIS-0110', 1),
        ('INF-2060', 1),
        ('INF-2070', 1),
        ('LET-0110', 1),
        ('SOC-0100', 1),
        ('EFS-0120', 2),
        ('IDI-0280', 2),
        ('INF-5100', 2),
        ('INF-5110', 2),
        ('LET-0120', 2),
        ('MAT-0140', 2),
        ('FIL-0110', 3),
        ('FIS-0140', 3),
        ('IDI-0130', 3),
        ('INF-5120', 3),
        ('INF-5130', 3),
        ('MAT-2330', 3),
        ('QUI-0140', 3),
        ('FIS-1150', 4),
        ('FIS-1160', 4),
        ('INF-5140', 4),
        ('INF-5150', 4),
        ('INF-5260', 4),
        ('MAT-3560', 4),
        ('EST-2110', 5),
        ('INF-2080', 5),
        ('INF-5160', 5),
        ('INF-5170', 5),
        ('MAT-3570', 5),
        ('CON-1190', 6),
        ('INF-3220', 6),
        ('INF-3240', 6),
        ('INF-4200', 6),
        ('BIO-2400', 7),
        ('INF-3290', 7),
        ('INF-5200', 7),
        ('INF-ZZA0', 7),
        ('MAT-1430', 7),
        ('MAT-3920', 7),
        ('INF-4250', 8),
        ('INF-4260', 8),
        ('INF-5220', 8),
        ('INF-ZZB0', 8),
        ('MAT-3940', 8),
        ('INF-5230', 9),
        ('INF-5240', 9),
        ('INF-5250', 9),
        ('INF-ZZC0', 9),
        ('INF-7010', 10)
    )
) AS plan
JOIN materias m ON m.codigo = plan.codigo
CROSS JOIN carreras c
JOIN escuelas e ON e.id_escuela = c.id_escuela
WHERE c.nombre = 'Licenciatura en Informática'
  AND e.nombre = 'Escuela de Informática';

-- 3. Comprobación por período
SELECT cm.periodo, COUNT(*) AS materias, SUM(m.creditos) AS creditos
FROM carrera_materias cm
JOIN materias m ON m.id_materia = cm.id_materia
JOIN carreras c ON c.id_carrera = cm.id_carrera
JOIN escuelas e ON e.id_escuela = c.id_escuela
WHERE c.nombre = 'Licenciatura en Informática' AND e.nombre = 'Escuela de Informática'
GROUP BY cm.periodo ORDER BY cm.periodo;

-- 4. Verificación de claves foráneas
PRAGMA foreign_key_check;
