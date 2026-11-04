-- Complemento para INSTALACIONES NUEVAS de UASD Academica.
-- El schema.sql nuevo admite periodo=0. Este script NO es una migracion
-- para bases antiguas con CHECK(periodo>0): utilizar la migracion anterior
-- si se necesita corregir una base ya creada.
-- Se registra el bloque de Colegio Universitario como periodo 0,
-- conservando sus 36 creditos oficiales dentro de Geografia (plan 000011).

INSERT OR IGNORE INTO carrera_materias (id_carrera, id_materia, periodo)
SELECT c.id_carrera, m.id_materia, 0
FROM carreras AS c
CROSS JOIN materias AS m
WHERE c.codigo = 'PLAN-P-GEOG'
  AND m.codigo = 'AAA-0000'
  AND m.creditos = 36;
