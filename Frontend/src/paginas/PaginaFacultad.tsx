import { Link, useParams, useSearchParams } from "react-router-dom";
import { EstadoConsulta } from "../componentes/EstadoConsulta";
import { NavegacionPagina } from "../componentes/NavegacionPagina";
import { TituloSeccion } from "../componentes/TituloSeccion";
import type { Carrera, Escuela, Facultad } from "../modelos/catalogo";
import { useConsulta } from "../servicios/useConsulta";

export function PaginaFacultad() {
  const { idFacultad = "" } = useParams();
  const [parametros, setParametros] = useSearchParams();
  const idEscuela = parametros.get("escuela");
  const facultades = useConsulta<Facultad[]>("/api/facultades");
  const escuelas = useConsulta<Escuela[]>(`/api/escuelas/facultad/${idFacultad}`);
  const facultad = facultades.datos?.find((item) => String(item.id) === idFacultad);
  const escuela = escuelas.datos?.find((item) => String(item.id) === idEscuela);
  const carreras = useConsulta<Carrera[]>(escuela ? `/api/carreras/escuela/${escuela.id}` : null);

  return <>
    <NavegacionPagina volver="/" />
    <section className="seccion">
      <TituloSeccion paso="02" etiqueta="ENCUENTRA TU ÁREA" titulo={facultad?.nombre ?? "Escuelas de la facultad"} descripcion="Selecciona una escuela para conocer sus carreras." />
      <EstadoConsulta cargando={facultades.cargando || escuelas.cargando} error={facultades.error || escuelas.error} />
      {facultades.datos && !facultad && <p>No encontramos esta facultad.</p>}
      {facultad && escuelas.datos && <div className="lista-botones">
        {escuelas.datos.length ? escuelas.datos.map((item) => <button key={item.id} className={escuela?.id === item.id ? "seleccionado" : ""} aria-pressed={escuela?.id === item.id} onClick={() => setParametros({ escuela: String(item.id) })}>{item.nombre}</button>) : <p>No hay escuelas registradas para esta facultad.</p>}
      </div>}
    </section>
    {escuelas.datos && idEscuela && !escuela && <p className="mensaje-error" role="alert">No encontramos esta escuela en la facultad seleccionada.</p>}
    {facultad && escuela && <section className="seccion">
      <TituloSeccion paso="03" etiqueta="DESCUBRE TU CAMINO" titulo="Carreras disponibles" descripcion={escuela.nombre} />
      <EstadoConsulta cargando={carreras.cargando} error={carreras.error} />
      {carreras.datos && (carreras.datos.length ? <div className="lista-carreras">{carreras.datos.map((carrera) => <Link className="tarjeta-carrera" key={carrera.idCarrera} to={`/facultades/${idFacultad}/escuelas/${escuela.id}/carreras/${carrera.idCarrera}`}><span className="tarjeta-etiqueta">Carrera universitaria</span><strong>{carrera.nombre}</strong><span>Ver plan de estudios →</span></Link>)}</div> : <p>No hay carreras registradas para esta escuela.</p>)}
    </section>}
  </>;
}
