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

type Materia = {
  id: number;
  codigo: string;
  nombre: string;
  creditos: number;
  periodo: number;
};

async function consultarAPI<T>(url: string): Promise<T> {
  const respuesta = await fetch(url);

  if (!respuesta.ok) {
    throw new Error(`Error HTTP: ${respuesta.status}`);
  }

  return respuesta.json() as Promise<T>;
}

function App() {
  const [facultades, setFacultades] = useState<Facultad[]>([]);
  const [escuelas, setEscuelas] = useState<Escuela[]>([]);
  const [carreras, setCarreras] = useState<Carrera[]>([]);
  const [materias, setMaterias] = useState<Materia[]>([]);

  const [idFacultad, setIdFacultad] = useState<number | null>(null);
  const [idEscuela, setIdEscuela] = useState<number | null>(null);
  const [idCarrera, setIdCarrera] = useState<number | null>(null);

  const [facultadesCargadas, setFacultadesCargadas] = useState(false);
  const [carrerasConsultadas, setCarrerasConsultadas] = useState(false);
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState("");

  async function cargarFacultades() {
    setCargando(true);
    setError("");

    try {
      const datos = await consultarAPI<Facultad[]>("/api/facultades");
      setFacultades(datos);
      setFacultadesCargadas(true);
    } catch (e) {
      console.error(e);
      setError("No se pudieron cargar las facultades.");
    } finally {
      setCargando(false);
    }
  }

  async function seleccionarFacultad(id: number) {
    setIdFacultad(id);
    setIdEscuela(null);
    setIdCarrera(null);

    setEscuelas([]);
    setCarreras([]);
    setMaterias([]);
    setCarrerasConsultadas(false);

    setCargando(true);
    setError("");

    try {
      const datos = await consultarAPI<Escuela[]>(
        `/api/escuelas/facultad/${id}`,
      );

      setEscuelas(datos);
    } catch (e) {
      console.error(e);
      setError("No se pudieron cargar las escuelas.");
    } finally {
      setCargando(false);
    }
  }

  function seleccionarEscuela(id: number) {
    setIdEscuela(id);
    setIdCarrera(null);

    setCarreras([]);
    setMaterias([]);
    setCarrerasConsultadas(false);
    setError("");
  }

  async function consultarCarreras() {
    if (idEscuela === null) return;

    setCargando(true);
    setError("");
    setCarreras([]);
    setMaterias([]);
    setIdCarrera(null);
    setCarrerasConsultadas(false);

    try {
      const datos = await consultarAPI<Carrera[]>(
        `/api/carreras/escuela/${idEscuela}`,
      );

      setCarreras(datos);
      setCarrerasConsultadas(true);
    } catch (e) {
      console.error(e);
      setError("No se pudieron consultar las carreras.");
    } finally {
      setCargando(false);
    }
  }

  async function seleccionarCarrera(id: number) {
    setIdCarrera(id);
    setMaterias([]);
    setCargando(true);
    setError("");

    try {
      const datos = await consultarAPI<Materia[]>(
        `/api/materias/carrera/${id}`,
      );

      setMaterias(datos);
    } catch (e) {
      console.error(e);
      setError("No se pudieron consultar las materias.");
    } finally {
      setCargando(false);
    }
  }

  const carreraActual = carreras.find((c) => c.idCarrera === idCarrera);

  const periodos = [...new Set(materias.map((m) => m.periodo))].sort(
    (a, b) => a - b,
  );

  const totalCreditos = materias.reduce(
    (total, materia) => total + materia.creditos,
    0,
  );

  return (
    <main className="contenedor">
      <header className="encabezado">
        <div className="marca">UASD Académica</div>
        <h1>Catálogo académico</h1>
        <p>
          Consulta las facultades, escuelas, carreras y planes de estudio de la
          UASD.
        </p>
      </header>

      <section className="seccion">
        <h2>1. Selecciona una facultad</h2>

        <button
          className="boton-principal"
          onClick={() => void cargarFacultades()}
          disabled={cargando}
        >
          {facultadesCargadas ? "Actualizar facultades" : "Cargar facultades"}
        </button>

        <div className="lista-botones">
          {facultades.map((facultad) => (
            <button
              key={facultad.id}
              className={idFacultad === facultad.id ? "seleccionado" : ""}
              disabled={cargando}
              onClick={() => void seleccionarFacultad(facultad.id)}
            >
              {facultad.nombre}
            </button>
          ))}
        </div>
      </section>

      <section className="seccion">
        <h2>2. Selecciona una escuela</h2>

        {idFacultad === null ? (
          <p className="texto-secundario">Primero selecciona una facultad.</p>
        ) : (
          <div className="lista-botones">
            {escuelas.map((escuela) => (
              <button
                key={escuela.id}
                className={idEscuela === escuela.id ? "seleccionado" : ""}
                disabled={cargando}
                onClick={() => seleccionarEscuela(escuela.id)}
              >
                {escuela.nombre}
              </button>
            ))}

            {!cargando && escuelas.length === 0 && !error && (
              <p>No hay escuelas registradas.</p>
            )}
          </div>
        )}
      </section>

      <section className="seccion">
        <h2>3. Consultar carreras</h2>

        <button
          className="boton-principal"
          onClick={() => void consultarCarreras()}
          disabled={idEscuela === null || cargando}
        >
          Consultar carreras
        </button>

        {carrerasConsultadas && carreras.length === 0 && (
          <p>No hay carreras registradas para esta escuela.</p>
        )}

        <div className="lista-carreras">
          {carreras.map((carrera) => (
            <button
              key={carrera.idCarrera}
              className={
                "tarjeta-carrera " +
                (idCarrera === carrera.idCarrera ? "tarjeta-activa" : "")
              }
              disabled={cargando}
              onClick={() => void seleccionarCarrera(carrera.idCarrera)}
            >
              <span className="tarjeta-etiqueta">Carrera universitaria</span>
              <strong>{carrera.nombre}</strong>
              <span>Ver materias →</span>
            </button>
          ))}
        </div>
      </section>

      {idCarrera !== null && !cargando && (
        <section className="seccion">
          <h2>4. Plan de estudios</h2>

          <h3>{carreraActual?.nombre}</h3>

          {materias.length === 0 ? (
            <p className="texto-secundario">
              Esta carrera todavía no tiene materias registradas en nuestra base
              de datos.
            </p>
          ) : (
            <>
              <div className="resumen">
                <span>{materias.length} componentes del plan</span>
                <span>{totalCreditos} créditos</span>
                <span>{periodos.length} bloques del plan</span>
              </div>

              {periodos.map((periodo) => (
                <div key={periodo} className="bloque-periodo">
                  <h3>
                    {periodo === 0
                      ? "Colegio Universitario (bloque previo)"
                      : `Período ${periodo}`}
                  </h3>

                  <div className="tabla-scroll">
                    <table>
                      <thead>
                        <tr>
                          <th>Código</th>
                          <th>Materia</th>
                          <th>Créditos</th>
                        </tr>
                      </thead>

                      <tbody>
                        {materias
                          .filter((m) => m.periodo === periodo)
                          .map((materia) => (
                            <tr key={materia.id}>
                              <td>{materia.codigo}</td>
                              <td>{materia.nombre}</td>
                              <td>{materia.creditos}</td>
                            </tr>
                          ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              ))}
            </>
          )}
        </section>
      )}

      {cargando && <p className="mensaje">Cargando información...</p>}

      {error && (
        <p className="mensaje-error" role="alert">
          {error}
        </p>
      )}

      <footer>UASD Académica · Proyecto académico</footer>
    </main>
  );
}

export default App;
