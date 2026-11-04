export function TituloSeccion({ paso, etiqueta, titulo, descripcion }: {
  paso: string; etiqueta: string; titulo: string; descripcion?: string;
}) {
  return <div className="seccion-titulo"><span className="paso">{paso}</span><div>
    <span className="sobre-titulo">{etiqueta}</span><h2>{titulo}</h2>
    {descripcion && <p>{descripcion}</p>}
  </div></div>;
}
