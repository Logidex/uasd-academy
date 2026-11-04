import { Link } from "react-router-dom";

export function NavegacionPagina({ volver }: { volver?: string }) {
  return (
    <nav className="navegacion-pagina" aria-label="Navegación del catálogo">
      {volver && <Link to={volver}>← Volver atrás</Link>}
      <Link to="/">⌂ Inicio</Link>
    </nav>
  );
}
