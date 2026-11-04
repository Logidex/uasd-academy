PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS facultades (
    id_facultad INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS escuelas (
    id_escuela INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    id_facultad INTEGER NOT NULL,

    FOREIGN KEY (id_facultad)
        REFERENCES facultades(id_facultad)
);

CREATE TABLE IF NOT EXISTS carreras (
    id_carrera INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE,
    nombre TEXT NOT NULL,
    id_escuela INTEGER NOT NULL,
    descripcion TEXT,

    FOREIGN KEY (id_escuela)
        REFERENCES escuelas(id_escuela)
);

-- Catálogo general de asignaturas
CREATE TABLE IF NOT EXISTS materias (
    id_materia INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE,
    nombre TEXT NOT NULL,
    creditos INTEGER NOT NULL CHECK (creditos >= 0)
);

-- Materias que pertenecen a cada carrera
CREATE TABLE IF NOT EXISTS carrera_materias (
    id_carrera INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    periodo INTEGER NOT NULL CHECK (periodo >= 0),

    PRIMARY KEY (id_carrera, id_materia),

    FOREIGN KEY (id_carrera)
        REFERENCES carreras(id_carrera),

    FOREIGN KEY (id_materia)
        REFERENCES materias(id_materia)
);
