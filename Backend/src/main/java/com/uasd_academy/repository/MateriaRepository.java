
package com.uasd_academy.repository;

import com.uasd_academy.model.Materia;
import java.util.List;

public interface MateriaRepository {

    List<Materia> obtenerPorCarrera(int idCarrera);
}
