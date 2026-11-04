-- Comprobaciones despues de importar los 114 planes.
SELECT
 (SELECT COUNT(*) FROM facultades) AS facultades,
 (SELECT COUNT(*) FROM escuelas) AS escuelas,
 (SELECT COUNT(*) FROM carreras) AS carreras,
 (SELECT COUNT(*) FROM materias) AS materias_unicas,
 (SELECT COUNT(*) FROM carrera_materias) AS relaciones,
 (SELECT COUNT(*) FROM fuentes_pensum) AS fuentes_explicitas;

SELECT c.nombre AS carrera,COUNT(*) AS materias,SUM(m.creditos) AS creditos,
 MIN(cm.periodo) AS primer_semestre,MAX(cm.periodo) AS ultimo_semestre
FROM carreras c
JOIN carrera_materias cm ON c.id_carrera=cm.id_carrera
JOIN materias m ON m.id_materia=cm.id_materia
WHERE c.codigo='PLAN-P-IGEO'
GROUP BY c.id_carrera;

PRAGMA foreign_key_check;
PRAGMA integrity_check;
