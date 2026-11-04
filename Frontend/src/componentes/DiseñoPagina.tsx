import type { ReactNode } from "react";
import { Link } from "react-router-dom";

export function DiseñoPagina({ children }: { children: ReactNode }) {
  return (
    <main className="contenedor">
      <header className="encabezado">
        <Link className="marca" to="/"><span className="marca-icono">U</span> UASD Académica <span className="marca-separador">/</span> CATÁLOGO</Link>
        <span className="encabezado-etiqueta">TU GUÍA UNIVERSITARIA</span>
        <h1>Tu futuro comienza <em>aquí.</em></h1>
        <p>Explora las facultades, descubre tu carrera y conoce el plan de estudios que te espera.</p>
        <div className="encabezado-pasos"><span>01 Facultad</span><span>02 Escuela</span><span>03 Carrera</span></div>
      </header>
      {children}
      <footer>UASD Académica · Proyecto académico</footer>
    </main>
  );
}
