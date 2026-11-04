
type CarreraCardProps = {
    nombre: string;
    facultad: string;
}

function CarreraCard({nombre, facultad}: CarreraCardProps) {
  return (
    <div>
      <h2>{nombre}</h2>
      <p>{facultad}</p>
    </div>
  );
}

export default CarreraCard;
