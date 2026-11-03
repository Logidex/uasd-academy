
package com.uasd_academy.service;

import com.uasd_academy.model.Facultad;
import com.uasd_academy.repository.FacultadRepository;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FacultadService {

    private final FacultadRepository repository;

    public FacultadService(FacultadRepository repository) {
        this.repository = repository;
    }

    public List<Facultad> listarFacultades() {
        return repository.obtenerTodas();
    }
}

