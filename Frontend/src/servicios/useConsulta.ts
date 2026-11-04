import { useEffect, useState } from "react";
import { consultar } from "./catalogo";

type Resultado<T> = { ruta: string; datos: T | null; error: boolean };

export function useConsulta<T>(ruta: string | null) {
  const [resultado, setResultado] = useState<Resultado<T> | null>(null);
  useEffect(() => {
    if (!ruta) return;
    const controlador = new AbortController();
    consultar<T>(ruta, controlador.signal)
      .then((datos) => setResultado({ ruta, datos, error: false }))
      .catch(() => {
        if (!controlador.signal.aborted) setResultado({ ruta, datos: null, error: true });
      });
    return () => controlador.abort();
  }, [ruta]);
  const actual = resultado?.ruta === ruta ? resultado : null;
  return { datos: actual?.datos ?? null, error: actual?.error ?? false, cargando: !!ruta && !actual };
}
