
package com.uasd_academy.repository;

import com.uasd_academy.model.Carrera;
import java.util.List;

public interface CarreraRepository {

    List<Carrera> obtenerTodas();

    List<Carrera> obtenerPorEscuela(int idEscuela);

}
