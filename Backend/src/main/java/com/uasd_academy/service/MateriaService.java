
package com.uasd_academy.service;

import com.uasd_academy.model.Materia;
import com.uasd_academy.repository.MateriaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MateriaService {

    private final MateriaRepository materiaRepository;

    public MateriaService(MateriaRepository materiaRepository) {
        this.materiaRepository = materiaRepository;
    }

    public List<Materia> listarMateriasPorCarrera(int idCarrera) {
        return materiaRepository.obtenerPorCarrera(idCarrera);
    }
}
