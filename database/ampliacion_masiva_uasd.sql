-- UASD Academica | Ampliacion masiva del catalogo
-- Fuentes: https://app.uasd.edu.do/planesgrado/ y https://uasd.edu.do/oferta-academica/
-- Generado 2026-11-04; los codigos P-* son identificadores del catalogo de planes, no codigos internos de carrera oficiales.
-- Ejecutar despues de schema.sql; funciona sobre la base existente o una nueva.
-- No destruye registros existentes. Las filas preexistentes con nombres/codigos distintos se conservan.
-- NOTA: SQLite activa foreign_keys por conexion; esta instruccion debe ejecutarse fuera de una transaccion.
PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- FACULTADES
INSERT INTO facultades (nombre, descripcion)
SELECT v.nombre, v.descripcion FROM (
SELECT 'Facultad de Artes' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ciencias' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ciencias Económicas y Sociales' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ciencias Jurídicas y Políticas' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ciencias de la Educación' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ciencias de la Salud' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ciencias Agronómicas y Veterinarias' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Humanidades' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
UNION ALL
SELECT 'Facultad de Ingeniería y Arquitectura' AS nombre, 'Facultad de la Universidad Autónoma de Santo Domingo' AS descripcion
) v WHERE NOT EXISTS (SELECT 1 FROM facultades f WHERE f.nombre = v.nombre);

-- ESCUELAS: relacione por nombre de facultad, no por ID arbitrario.
WITH catalogo(facultad, escuela) AS (
    VALUES
        ('Facultad de Artes', 'Escuela de Artes Plásticas'),
        ('Facultad de Artes', 'Escuela de Cine, TV y Fotografía'),
        ('Facultad de Artes', 'Escuela de Crítica e Historia del Arte'),
        ('Facultad de Artes', 'Escuela de Diseño Industrial y Modas'),
        ('Facultad de Artes', 'Escuela de Música'),
        ('Facultad de Artes', 'Escuela de Publicidad'),
        ('Facultad de Artes', 'Escuela de Teatro'),
        ('Facultad de Ciencias', 'Escuela de Biología'),
        ('Facultad de Ciencias', 'Escuela de Ciencias Geográficas'),
        ('Facultad de Ciencias', 'Escuela de Física'),
        ('Facultad de Ciencias', 'Escuela de Informática'),
        ('Facultad de Ciencias', 'Escuela de Matemáticas'),
        ('Facultad de Ciencias', 'Escuela de Microbiología y Parasitología'),
        ('Facultad de Ciencias', 'Escuela de Química'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Administración'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Contabilidad'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Economía'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Estadística'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Mercadotecnia'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Sociología'),
        ('Facultad de Ciencias Económicas y Sociales', 'Escuela de Turismo y Hotelería'),
        ('Facultad de Ciencias Jurídicas y Políticas', 'Escuela de Ciencias Políticas'),
        ('Facultad de Ciencias Jurídicas y Políticas', 'Escuela de Derecho'),
        ('Facultad de Ciencias de la Educación', 'Escuela de Bibliotecología, Tecnología e Innovación'),
        ('Facultad de Ciencias de la Educación', 'Escuela de Educación Física y Ciencias del Deporte'),
        ('Facultad de Ciencias de la Educación', 'Escuela de Educación Infantil y Básica'),
        ('Facultad de Ciencias de la Educación', 'Escuela de Educación Media'),
        ('Facultad de Ciencias de la Educación', 'Escuela de Orientación Educativa y Psicopedagogía'),
        ('Facultad de Ciencias de la Educación', 'Escuela de Teoría y Gestión Educativa'),
        ('Facultad de Ciencias de la Salud', 'Escuela de Bioanálisis'),
        ('Facultad de Ciencias de la Salud', 'Escuela de Enfermería'),
        ('Facultad de Ciencias de la Salud', 'Escuela de Farmacia'),
        ('Facultad de Ciencias de la Salud', 'Escuela de Medicina'),
        ('Facultad de Ciencias de la Salud', 'Escuela de Odontología'),
        ('Facultad de Ciencias de la Salud', 'Escuela de Salud Pública'),
        ('Facultad de Ciencias Agronómicas y Veterinarias', 'Escuela de Agronomía'),
        ('Facultad de Ciencias Agronómicas y Veterinarias', 'Escuela de Veterinaria'),
        ('Facultad de Ciencias Agronómicas y Veterinarias', 'Escuela de Zootecnia'),
        ('Facultad de Humanidades', 'Escuela de Comunicación Social'),
        ('Facultad de Humanidades', 'Escuela de Filosofía'),
        ('Facultad de Humanidades', 'Escuela de Historia y Antropología'),
        ('Facultad de Humanidades', 'Escuela de Idiomas'),
        ('Facultad de Humanidades', 'Escuela de Letras'),
        ('Facultad de Humanidades', 'Escuela de Psicología'),
        ('Facultad de Ingeniería y Arquitectura', 'Escuela de Agrimensura'),
        ('Facultad de Ingeniería y Arquitectura', 'Escuela de Arquitectura'),
        ('Facultad de Ingeniería y Arquitectura', 'Escuela de Electromecánica'),
        ('Facultad de Ingeniería y Arquitectura', 'Escuela de Ingeniería Civil'),
        ('Facultad de Ingeniería y Arquitectura', 'Escuela de Ingeniería Industrial'),
        ('Facultad de Ingeniería y Arquitectura', 'Escuela de Ingeniería Química')
)
INSERT INTO escuelas (nombre, id_facultad)
SELECT c.escuela, f.id_facultad
FROM catalogo c JOIN facultades f ON f.nombre = c.facultad
WHERE NOT EXISTS (
    SELECT 1 FROM escuelas e
    WHERE e.nombre = c.escuela AND e.id_facultad = f.id_facultad
);

-- CARRERAS: un programa por codigo de plan; no inserta si ya existe misma denominacion en la escuela.
-- Las carreras preexistentes INF001, MAT001, etc. se conservan sin renombrarlas.
WITH catalogo(escuela, codigo_plan, carrera) AS (
    VALUES
        ('Escuela de Artes Plásticas', 'P-APLA', 'Licenciatura en Artes Plásticas'),
        ('Escuela de Artes Plásticas', 'P-ARPE', 'Licenciatura en Artes Plásticas Mención Escultura'),
        ('Escuela de Artes Plásticas', 'P-ARPP', 'Licenciatura en Artes Plásticas Mención Pintura'),
        ('Escuela de Cine, TV y Fotografía', 'P-CINC', 'Licenciatura en Cinematografía y Audiovisuales Mención Cine'),
        ('Escuela de Cine, TV y Fotografía', 'P-CINT', 'Licenciatura en Cinematografía y Audiovisuales Mención Televisión'),
        ('Escuela de Cine, TV y Fotografía', 'P-FOTA', 'Técnico en Fotografía y Medios Audiovisuales'),
        ('Escuela de Crítica e Historia del Arte', 'P-HISA', 'Licenciatura en Historia y Crítica del Arte'),
        ('Escuela de Diseño Industrial y Modas', 'P-AIDA', 'Licenciatura en Artes Industriales Mención Diseño Artesanal'),
        ('Escuela de Diseño Industrial y Modas', 'P-AIDI', 'Licenciatura en Artes Industriales Mención Diseño Industrial'),
        ('Escuela de Diseño Industrial y Modas', 'P-AIDM', 'Licenciatura en Artes Industriales Mención Diseño de Modas'),
        ('Escuela de Música', 'P-MUS', 'Licenciatura en Música'),
        ('Escuela de Música', 'P-MUST', 'Licenciatura en Música Mención Teoría y Educación Musical'),
        ('Escuela de Publicidad', 'P-ARPD', 'Licenciatura en Publicidad Mención Diseño'),
        ('Escuela de Publicidad', 'P-ARPI', 'Licenciatura en Publicidad Mención Ilustración'),
        ('Escuela de Publicidad', 'P-PUBC', 'Licenciatura en Publicidad Mención Creatividad y Gerencia'),
        ('Escuela de Teatro', 'P-TEA', 'Licenciatura en Teatro'),
        ('Escuela de Teatro', 'P-TEAA', 'Licenciatura en Teatro Mención Actuación'),
        ('Escuela de Teatro', 'P-TEAI', 'Licenciatura en Teatro Mención Dirección'),
        ('Escuela de Teatro', 'P-TEDR', 'Licenciatura en Teatro Mención Dramaturgia'),
        ('Escuela de Biología', 'P-BIOL', 'Licenciatura en Biología'),
        ('Escuela de Ciencias Geográficas', 'P-ECOT', 'Licenciatura en Geografía Mención Recursos Naturales y Ecoturismo'),
        ('Escuela de Ciencias Geográficas', 'P-GEOG', 'Licenciatura en Geografía'),
        ('Escuela de Ciencias Geográficas', 'P-GEOR', 'Licenciatura en Geografía Mención Representación Espacial'),
        ('Escuela de Física', 'P-FISI', 'Licenciatura en Física'),
        ('Escuela de Informática', 'P-INFO', 'Licenciatura en Informática'),
        ('Escuela de Matemáticas', 'P-MATE', 'Licenciatura en Matemáticas'),
        ('Escuela de Microbiología y Parasitología', 'P-MICR', 'Licenciatura en Microbiología'),
        ('Escuela de Química', 'P-QUIM', 'Licenciatura en Química'),
        ('Escuela de Química', 'P-TSAL', 'Tecnólogo Superior en Alimentos'),
        ('Escuela de Administración', 'P-ADME', 'Licenciatura en Administración de Empresas'),
        ('Escuela de Administración', 'P-ADMP', 'Licenciatura en Administración Pública'),
        ('Escuela de Contabilidad', 'P-CONT', 'Licenciatura en Contabilidad'),
        ('Escuela de Economía', 'P-ADCE', 'Licenciatura en Aduana y Comercio Exterior'),
        ('Escuela de Economía', 'P-ECON', 'Licenciatura en Economía'),
        ('Escuela de Estadística', 'P-ESTI', 'Licenciatura en Estadística Mención Informática'),
        ('Escuela de Estadística', 'P-ESTS', 'Licenciatura en Estadística Mención Socioeconómica'),
        ('Escuela de Mercadotecnia', 'P-MERC', 'Licenciatura en Mercadotecnia'),
        ('Escuela de Sociología', 'P-SOCI', 'Licenciatura en Sociología'),
        ('Escuela de Sociología', 'P-TRAS', 'Licenciatura en Trabajo Social'),
        ('Escuela de Turismo y Hotelería', 'P-TURH', 'Licenciatura en Turismo y Hotelería'),
        ('Escuela de Ciencias Políticas', 'P-CSPO', 'Licenciatura en Ciencias Políticas'),
        ('Escuela de Derecho', 'P-DERE', 'Licenciatura en Derecho'),
        ('Escuela de Bibliotecología, Tecnología e Innovación', 'P-BCIN', 'Licenciatura en Bibliotecología y Ciencias de la Información'),
        ('Escuela de Bibliotecología, Tecnología e Innovación', 'P-EDBI', 'Licenciatura en Educación Mención Bibliotecología'),
        ('Escuela de Bibliotecología, Tecnología e Innovación', 'P-EMIE', 'Licenciatura en Educación Mención Informática Educativa'),
        ('Escuela de Educación Física y Ciencias del Deporte', 'P-EDFD', 'Licenciatura en Educación Física y Deporte'),
        ('Escuela de Educación Física y Ciencias del Deporte', 'P-EDFI', 'Licenciatura en Educación Física'),
        ('Escuela de Educación Infantil y Básica', 'P-EDBA', 'Licenciatura en Educación Básica'),
        ('Escuela de Educación Infantil y Básica', 'P-EDIN', 'Licenciatura en Educación Infantil'),
        ('Escuela de Educación Infantil y Básica', 'P-EDUI', 'Licenciatura en Educación Inicial'),
        ('Escuela de Educación Infantil y Básica', 'P-EMAE', 'Licenciatura en Educación Mención Arte Escolar'),
        ('Escuela de Educación Media', 'P-EDFF', 'Licenciatura en Educación Mención Filosofía y Letras'),
        ('Escuela de Educación Media', 'P-EMBQ', 'Licenciatura en Educación Media Mención Biología y Química'),
        ('Escuela de Educación Media', 'P-EMCS', 'Licenciatura en Educación Media Mención Ciencias Sociales'),
        ('Escuela de Educación Media', 'P-EMFM', 'Licenciatura en Educación Media Mención Física y Matemáticas'),
        ('Escuela de Educación Media', 'P-EMMF', 'Licenciatura en Educación Media Mención Francés'),
        ('Escuela de Educación Media', 'P-EMMI', 'Licenciatura en Educación Media Mención Inglés'),
        ('Escuela de Educación Media', 'P-EMML', 'Licenciatura en Educación Media Mención Letras'),
        ('Escuela de Orientación Educativa y Psicopedagogía', 'P-EDES', 'Licenciatura en Educación Especial'),
        ('Escuela de Orientación Educativa y Psicopedagogía', 'P-EDOA', 'Licenciatura en Educación Mención Orientación Académica'),
        ('Escuela de Orientación Educativa y Psicopedagogía', 'P-EDOC', 'Licenciatura en Educación Mención Orientación Socio-Comunitaria'),
        ('Escuela de Orientación Educativa y Psicopedagogía', 'P-EDOR', 'Licenciatura en Educación Mención Orientación para Desarrollo de Recursos Humanos'),
        ('Escuela de Orientación Educativa y Psicopedagogía', 'P-EMOP', 'Licenciatura en Educación Mención Orientación Psicopedagógica'),
        ('Escuela de Teoría y Gestión Educativa', 'P-EMGE', 'Licenciatura en Educación Mención Gestión Educativa'),
        ('Escuela de Teoría y Gestión Educativa', 'P-EPJA', 'Licenciatura en Educación para Personas Jóvenes y Adultas'),
        ('Escuela de Bioanálisis', 'P-BIOA', 'Licenciatura en Bioanálisis'),
        ('Escuela de Bioanálisis', 'P-IMAG', 'Licenciatura en Imagenología'),
        ('Escuela de Bioanálisis', 'P-TRAD', 'Técnico Radiólogo'),
        ('Escuela de Enfermería', 'P-ENFE', 'Licenciatura en Enfermería'),
        ('Escuela de Farmacia', 'P-FARM', 'Licenciatura en Farmacia'),
        ('Escuela de Medicina', 'P-DMED', 'Doctor en Medicina'),
        ('Escuela de Odontología', 'P-CODO', 'Doctor en Odontología'),
        ('Escuela de Salud Pública', 'P-TSAP', 'Técnico Superior en Atención Prehospitalaria'),
        ('Escuela de Agronomía', 'P-IADA', 'Ingeniería Agronómica Mención Desarrollo Agrícola'),
        ('Escuela de Agronomía', 'P-IAPC', 'Ingeniería Agronómica Mención Producción de Cultivos'),
        ('Escuela de Agronomía', 'P-IASR', 'Ingeniería Agronómica Mención Suelo y Riego'),
        ('Escuela de Veterinaria', 'P-MEDV', 'Licenciatura en Medicina Veterinaria'),
        ('Escuela de Zootecnia', 'P-ILAL', 'Ingeniería Lácteo Alimentaria'),
        ('Escuela de Zootecnia', 'P-IZOO', 'Ingeniería en Zootecnia'),
        ('Escuela de Zootecnia', 'P-TPLA', 'Tecnología en Procesos Lácteo Alimentarios'),
        ('Escuela de Comunicación Social', 'P-CSCG', 'Licenciatura en Comunicación Social Mención Comunicación Gráfica'),
        ('Escuela de Comunicación Social', 'P-CSPE', 'Licenciatura en Comunicación Social Mención Periodismo'),
        ('Escuela de Comunicación Social', 'P-CSRP', 'Licenciatura en Comunicación Social Mención Relaciones Públicas'),
        ('Escuela de Filosofía', 'P-FILO', 'Licenciatura en Filosofía'),
        ('Escuela de Historia y Antropología', 'P-ANTR', 'Licenciatura en Antropología'),
        ('Escuela de Historia y Antropología', 'P-HIST', 'Licenciatura en Historia'),
        ('Escuela de Idiomas', 'P-LEMF', 'Licenciatura en Lenguas Modernas Mención Francés'),
        ('Escuela de Idiomas', 'P-LEMI', 'Licenciatura en Lenguas Modernas Mención Inglés'),
        ('Escuela de Letras', 'P-LET', 'Licenciatura en Letras'),
        ('Escuela de Psicología', 'P-HUMA', 'Licenciatura en Psicología Mención Psicología del Desarrollo Humano'),
        ('Escuela de Psicología', 'P-PSIC', 'Licenciatura en Psicología Mención Psicología Clínica'),
        ('Escuela de Psicología', 'P-PSIE', 'Licenciatura en Psicología Mención Psicología Escolar'),
        ('Escuela de Psicología', 'P-PSII', 'Licenciatura en Psicología Mención Psicología Industrial'),
        ('Escuela de Psicología', 'P-PSIS', 'Licenciatura en Psicología Mención Psicología Social'),
        ('Escuela de Agrimensura', 'P-IGEO', 'Ingeniería Geomática'),
        ('Escuela de Agrimensura', 'P-LAGE', 'Licenciatura en Agrimensura'),
        ('Escuela de Agrimensura', 'P-TAGM', 'Técnico Superior en Agrimensura'),
        ('Escuela de Arquitectura', 'P-ARQ', 'Arquitectura'),
        ('Escuela de Electromecánica', 'P-IEME', 'Ingeniería Electromecánica Mención Eléctrica'),
        ('Escuela de Electromecánica', 'P-IEMM', 'Ingeniería Electromecánica Mención Mecánica'),
        ('Escuela de Electromecánica', 'P-IEMT', 'Ingeniería Electromecánica Mención Electrónica'),
        ('Escuela de Electromecánica', 'P-IMCT', 'Ingeniería en Mecatrónica'),
        ('Escuela de Ingeniería Civil', 'P-ICIV', 'Ingeniería Civil'),
        ('Escuela de Ingeniería Industrial', 'P-IIND', 'Ingeniería Industrial'),
        ('Escuela de Ingeniería Química', 'P-IQUI', 'Ingeniería Química')
)
INSERT INTO carreras (codigo, nombre, id_escuela, descripcion)
SELECT 'PLAN-' || c.codigo_plan, c.carrera, e.id_escuela, 'Referencia: catalogo UASD de planes de grado (' || c.codigo_plan || ')'
FROM catalogo c JOIN escuelas e ON e.nombre = c.escuela
WHERE NOT EXISTS (
    SELECT 1 FROM carreras x WHERE x.codigo = 'PLAN-' || c.codigo_plan
       OR (x.id_escuela = e.id_escuela AND lower(x.nombre) = lower(c.carrera))
);

COMMIT;

-- COMPROBACION
SELECT (SELECT COUNT(*) FROM facultades) AS facultades,
       (SELECT COUNT(*) FROM escuelas) AS escuelas,
       (SELECT COUNT(*) FROM carreras) AS carreras;

-- Diagnostico: escuelas aun sin carreras
SELECT e.nombre AS escuela, f.nombre AS facultad
FROM escuelas e JOIN facultades f ON f.id_facultad = e.id_facultad
LEFT JOIN carreras c ON c.id_escuela = e.id_escuela
GROUP BY e.id_escuela HAVING COUNT(c.id_carrera) = 0;

