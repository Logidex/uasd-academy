
-- Datos iniciales de facultades

INSERT INTO facultades (
    id_facultad,
    nombre,
    descripcion
)
VALUES
    (
        1,
        'Facultad de Ciencias',
        'Área académica de ciencias'
    ),
    (
        2,
        'Facultad de Artes',
        'Área académica de artes'
    ),
    (
        3,
        'Facultad de Humanidades',
        'Área académica de humanidades'
    );

-- Datos iniciales de escuelas


-- Escuelas de ejemplo

INSERT INTO escuelas (
    id_escuela,
    nombre,
    id_facultad
)
VALUES
    (
        1,
        'Escuela de Informática',
        1
    ),
    (
        2,
        'Escuela de Matemáticas',
        1
    ),
    (
        3,
        'Escuela de Artes Plásticas',
        2
    );


-- Carreras de ejemplo
-- Los códigos son ficticios

INSERT INTO carreras (
    codigo,
    nombre,
    id_escuela,
    descripcion
)
VALUES
    (
        'INF001',
        'Licenciatura en Informática',
        1,
        'Carrera del área de informática'
    ),
    (
        'MAT001',
        'Licenciatura en Matemáticas',
        2,
        'Carrera del área de matemáticas'
    ),
    (
        'ART001',
        'Licenciatura en Artes Plásticas',
        3,
        'Carrera del área de artes'
    );
