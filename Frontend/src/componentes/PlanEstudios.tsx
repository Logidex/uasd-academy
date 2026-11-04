import type { Materia } from "../modelos/catalogo";

export function PlanEstudios({ materias }: { materias: Materia[] }) {
  if (!materias.length) return <p className="texto-secundario">Esta carrera todavía no tiene materias registradas en nuestra base de datos.</p>;
  const periodos = [...new Set(materias.map((materia) => materia.periodo))].sort((a, b) => a - b);
  const creditos = materias.reduce((total, materia) => total + materia.creditos, 0);
  return <>
    <div className="resumen"><span>{materias.length} componentes del plan</span><span>{creditos} créditos</span><span>{periodos.length} bloques del plan</span></div>
    {periodos.map((periodo) => <div key={periodo} className="bloque-periodo">
      <h3>{periodo === 0 ? "Colegio Universitario (bloque previo)" : `Período ${periodo}`}</h3>
      <div className="tabla-scroll"><table><thead><tr><th>Código</th><th>Materia</th><th>Créditos</th></tr></thead>
        <tbody>{materias.filter((materia) => materia.periodo === periodo).map((materia) => <tr key={materia.id}><td>{materia.codigo}</td><td>{materia.nombre}</td><td>{materia.creditos}</td></tr>)}</tbody>
      </table></div>
    </div>)}
  </>;
}
