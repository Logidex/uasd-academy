import { BrowserRouter, Route, Routes } from "react-router-dom";
import { DiseñoPagina } from "./componentes/DiseñoPagina";
import { PaginaFacultades } from "./paginas/PaginaFacultades";
import { PaginaFacultad } from "./paginas/PaginaFacultad";
import { PaginaCarrera } from "./paginas/PaginaCarrera";
import "./App.css";

function App() {
  return (
    <BrowserRouter>
      <DiseñoPagina>
        <Routes>
          <Route path="/" element={<PaginaFacultades />} />
          <Route path="/facultades/:idFacultad" element={<PaginaFacultad />} />
          <Route path="/facultades/:idFacultad/escuelas/:idEscuela/carreras/:idCarrera" element={<PaginaCarrera />} />
          <Route path="*" element={<p className="seccion">No encontramos esta página.</p>} />
        </Routes>
      </DiseñoPagina>
    </BrowserRouter>
  );
}

export default App;
