export function EstadoConsulta({ cargando, error }: { cargando: boolean; error: boolean }) {
  if (cargando) return <p className="mensaje" role="status">Cargando información...</p>;
  if (error) return <p className="mensaje-error" role="alert">No se pudo cargar la información. Comprueba la conexión con el servidor e inténtalo de nuevo.</p>;
  return null;
}
