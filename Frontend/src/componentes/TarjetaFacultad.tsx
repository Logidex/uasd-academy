import { Link } from "react-router-dom";
import type { Facultad } from "../modelos/catalogo";

// Emblemas publicados en https://uasd.edu.do/facultades/.
const emblemas: Record<string, string> = {
  "Facultad de Humanidades": "HUMANIDADES",
  "Facultad de Ciencias": "CIENCIAS",
  "Facultad de Ciencias Económicas y Sociales": "ECONOMIA",
  "Facultad de Ciencias Jurídicas y Políticas": "JURIDICA",
  "Facultad de Ingeniería y Arquitectura": "INGENIERIA",
  "Facultad de Ciencias de la Salud": "SALUD",
  "Facultad de Ciencias Agronómicas y Veterinarias": "VETERINARIA",
  "Facultad de Artes": "ARTES",
  "Facultad de Ciencias de la Educación": "EDUCACION",
};

export function TarjetaFacultad({ facultad }: { facultad: Facultad }) {
  const emblema = emblemas[facultad.nombre];
  return <Link className="tarjeta-facultad" to={`/facultades/${facultad.id}`}>
    <span className="facultad-emblema">{emblema && <img src={`https://uasd.edu.do/wp-content/uploads/2022/11/LOGO-${emblema}.svg`} alt="" loading="lazy" />}</span>
    <span className="facultad-texto"><small>FACULTAD</small><strong>{facultad.nombre.replace(/^Facultad de /, "")}</strong><span>Explorar <span aria-hidden="true">↗</span></span></span>
  </Link>;
}
