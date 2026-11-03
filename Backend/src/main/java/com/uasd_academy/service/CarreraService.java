
package com.uasd_academy.service;

import com.uasd_academy.model.Carrera;
import com.uasd_academy.repository.CarreraRepository;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CarreraService {

    private final CarreraRepository repository;

    public CarreraService(CarreraRepository repository) {
        this.repository = repository;
    }

    public List<Carrera> listarCarreras() {
        return repository.obtenerTodas();
    }

    public List<Carrera> listarCarrerasPorEscuela(int idEscuela) {
        return repository.obtenerPorEscuela(idEscuela);
    }
}

