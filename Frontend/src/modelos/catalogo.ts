export type Facultad = { id: number; nombre: string; descripcion?: string };
export type Escuela = { id: number; nombre: string; idFacultad: number };
export type Carrera = { idCarrera: number; nombre: string; idEscuela: number };
export type Materia = { id: number; codigo: string; nombre: string; creditos: number; periodo: number };
