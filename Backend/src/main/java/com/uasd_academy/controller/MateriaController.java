
package com.uasd_academy.controller;

import com.uasd_academy.model.Materia;
import com.uasd_academy.service.MateriaService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/materias")
public class MateriaController {

    private final MateriaService materiaService;

    public MateriaController(MateriaService materiaService) {
        this.materiaService = materiaService;
    }

    @GetMapping("/carrera/{idCarrera}")
    public List<Materia> listarPorCarrera(
            @PathVariable("idCarrera") int idCarrera) {

        return materiaService.listarMateriasPorCarrera(idCarrera);
    }
}
