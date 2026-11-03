
package com.uasd_academy.controller;

import com.uasd_academy.model.Escuela;
import com.uasd_academy.service.EscuelaService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@RestController
public class EscuelaController {

    private final EscuelaService service;

    public EscuelaController(EscuelaService service) {
        this.service = service;
    }

    @GetMapping("/api/escuelas")
    public List<Escuela> obtenerEscuelas() {
        return service.listarEscuelas();
    }

    @GetMapping("/api/escuelas/facultad/{idFacultad}")
    public List<Escuela> obtenerPorFacultad(
            @PathVariable("idFacultad") int idFacultad) {

        return service.listarEscuelasPorFacultad(idFacultad);
    }
}
