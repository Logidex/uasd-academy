
package com.uasd_academy.service;

import com.uasd_academy.model.Escuela;
import com.uasd_academy.repository.EscuelaRepository;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EscuelaService {

    private final EscuelaRepository repository;

    public EscuelaService(EscuelaRepository repository) {
        this.repository = repository;
    }

    public List<Escuela> listarEscuelas() {
        return repository.obtenerTodas();
    }
}
