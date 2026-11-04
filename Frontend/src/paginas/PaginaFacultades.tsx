import { EstadoConsulta } from "../componentes/EstadoConsulta";
import { TarjetaFacultad } from "../componentes/TarjetaFacultad";
import { TituloSeccion } from "../componentes/TituloSeccion";
import type { Facultad } from "../modelos/catalogo";
import { useConsulta } from "../servicios/useConsulta";

export function PaginaFacultades() {
  const { datos, cargando, error } = useConsulta<Facultad[]>("/api/facultades");
  return <section className="seccion">
    <TituloSeccion paso="01" etiqueta="EMPECEMOS POR EL PRINCIPIO" titulo="Explora las facultades" descripcion="Selecciona el área que te interesa conocer." />
    <EstadoConsulta cargando={cargando} error={error} />
    {datos && (datos.length ? <div className="lista-facultades">{datos.map((facultad) => <TarjetaFacultad key={facultad.id} facultad={facultad} />)}</div> : <p>No hay facultades registradas.</p>)}
  </section>;
}
