export async function consultar<T>(ruta: string, signal: AbortSignal): Promise<T> {
  const respuesta = await fetch(ruta, { signal });
  if (!respuesta.ok) throw new Error(`Error HTTP: ${respuesta.status}`);
  return respuesta.json() as Promise<T>;
}
