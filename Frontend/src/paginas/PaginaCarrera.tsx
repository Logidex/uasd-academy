import { useParams } from "react-router-dom";
import { EstadoConsulta } from "../componentes/EstadoConsulta";
import { NavegacionPagina } from "../componentes/NavegacionPagina";
import { PlanEstudios } from "../componentes/PlanEstudios";
import { TituloSeccion } from "../componentes/TituloSeccion";
import type { Carrera, Escuela, Facultad, Materia } from "../modelos/catalogo";
import { useConsulta } from "../servicios/useConsulta";

export function PaginaCarrera() {
  const { idFacultad = "", idEscuela = "", idCarrera = "" } = useParams();
  const facultades = useConsulta<Facultad[]>("/api/facultades");
  const escuelas = useConsulta<Escuela[]>(`/api/escuelas/facultad/${idFacultad}`);
  const carreras = useConsulta<Carrera[]>(`/api/carreras/escuela/${idEscuela}`);
  const materias = useConsulta<Materia[]>(`/api/materias/carrera/${idCarrera}`);
  const facultad = facultades.datos?.find((item) => String(item.id) === idFacultad);
  const escuela = escuelas.datos?.find((item) => String(item.id) === idEscuela);
  const carrera = carreras.datos?.find((item) => String(item.idCarrera) === idCarrera);
  const cargando = facultades.cargando || escuelas.cargando || carreras.cargando || materias.cargando;
  const error = facultades.error || escuelas.error || carreras.error || materias.error;

  return <>
    <NavegacionPagina volver={`/facultades/${idFacultad}?escuela=${idEscuela}`} />
    <section className="seccion">
      <TituloSeccion paso="04" etiqueta="PLAN DE ESTUDIOS" titulo={carrera?.nombre ?? "Detalle de la carrera"} descripcion={facultad && escuela ? `${facultad.nombre} · ${escuela.nombre}` : undefined} />
      <EstadoConsulta cargando={cargando} error={error} />
      {!cargando && !error && (!facultad || !escuela || !carrera) && <p>No encontramos esta carrera en la escuela seleccionada.</p>}
      {!cargando && !error && facultad && escuela && carrera && materias.datos && <PlanEstudios materias={materias.datos} />}
    </section>
  </>;
}
