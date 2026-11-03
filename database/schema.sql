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

PRAGMA foreign_keys = ON;