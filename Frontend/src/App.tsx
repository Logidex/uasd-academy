
import { useState } from "react";
import "./App.css";

type Facultad = {
  id: number;
  nombre: string;
  descripcion?: string;
};

type Escuela = {
  id: number;
  nombre: string;
  idFacultad: number;
};

type Carrera = {
  idCarrera: number;
  nombre: string;
  idEscuela: number;
};

function App() {
  const [facultades, setFacultades] = useState<Facultad[]>([]);
  const [escuelas, setEscuelas] = useState<Escuela[]>([]);
  const [carreras, setCarreras] = useState<Carrera[]>([]);

  const [facultadSeleccionada, setFacultadSeleccionada] =
    useState<number | null>(null);

  const [escuelaSeleccionada, setEscuelaSeleccionada] =
    useState<number | null>(null);

  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState("");

  async function obtenerFacultades() {
    setCargando(true);
    setError("");

    try {
      const respuesta = await fetch("/api/facultades");

      if (!respuesta.ok) {
        throw new Error(`Error HTTP: ${respuesta.status}`);
      }

      const datos: Facultad[] = await respuesta.json();
      setFacultades(datos);
    } catch (error) {
      console.error(error);
      setError("No se pudieron cargar las facultades.");
    } finally {
      setCargando(false);
    }
  }

  async function seleccionarFacultad(idFacultad: number) {
    setFacultadSeleccionada(idFacultad);
    setEscuelaSeleccionada(null);

    setEscuelas([]);
    setCarreras([]);
    setError("");
    setCargando(true);

    try {
      const respuesta = await fetch(
        `/api/escuelas/facultad/${idFacultad}`
      );

      if (!respuesta.ok) {
        throw new Error(`Error HTTP: ${respuesta.status}`);
      }

      const datos: Escuela[] = await respuesta.json();
      setEscuelas(datos);
    } catch (error) {
      console.error(error);
      setError("No se pudieron cargar las escuelas.");
    } finally {
      setCargando(false);
    }
  }

  async function seleccionarEscuela(idEscuela: number) {
    setEscuelaSeleccionada(idEscuela);
    setCarreras([]);
    setError("");
    setCargando(true);

    try {
      const respuesta = await fetch(
        `/api/carreras/escuela/${idEscuela}`
      );

      if (!respuesta.ok) {
        throw new Error(`Error HTTP: ${respuesta.status}`);
      }

      const datos: Carrera[] = await respuesta.json();
      setCarreras(datos);
    } catch (error) {
      console.error(error);
      setError("No se pudieron cargar las carreras.");
    } finally {
      setCargando(false);
    }
  }

  return (
    <main className="contenedor">
      <header>
        <h1>UASD Académica</h1>
        <p>Sistema de consulta de carreras universitarias</p>
      </header>

      <section className="seccion">
        <h2>1. Facultades</h2>

        <button
          onClick={obtenerFacultades}
          disabled={cargando}
        >
          Consultar facultades
        </button>

        <div className="lista">
          {facultades.map((facultad) => (
            <button
              key={facultad.id}
              className={
                facultadSeleccionada === facultad.id
                  ? "seleccionado"
                  : ""
              }
              onClick={() =>
                void seleccionarFacultad(facultad.id)
              }
              disabled={cargando}
            >
              {facultad.nombre}
            </button>
          ))}
        </div>
      </section>

      <section className="seccion">
        <h2>2. Escuelas</h2>

        {facultadSeleccionada === null ? (
          <p>Primero selecciona una facultad.</p>
        ) : (
          <div className="lista">
            {escuelas.map((escuela) => (
              <button
                key={escuela.id}
                className={
                  escuelaSeleccionada === escuela.id
                    ? "seleccionado"
                    : ""
                }
                onClick={() =>
                  void seleccionarEscuela(escuela.id)
                }
                disabled={cargando}
              >
                {escuela.nombre}
              </button>
            ))}
          </div>
        )}
      </section>

      <section className="seccion">
        <h2>3. Carreras</h2>

        {escuelaSeleccionada === null ? (
          <p>Primero selecciona una escuela.</p>
        ) : carreras.length === 0 && !cargando ? (
          <p>No hay carreras registradas para esta escuela.</p>
        ) : (
          <div className="lista-carreras">
            {carreras.map((carrera) => (
              <article
                key={carrera.idCarrera}
                className="tarjeta"
              >
                <h3>{carrera.nombre}</h3>
              </article>
            ))}
          </div>
        )}
      </section>

      {cargando && <p className="mensaje">Cargando datos...</p>}

      {error && <p className="error">{error}</p>}
    </main>
  );
}

export default App;




