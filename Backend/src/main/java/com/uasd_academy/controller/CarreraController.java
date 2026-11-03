
package com.uasd_academy.controller;

import com.uasd_academy.model.Carrera;
import com.uasd_academy.service.CarreraService;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@RestController
public class CarreraController {

    private final CarreraService service;

    public CarreraController(CarreraService service) {
        this.service = service;
    }

    @GetMapping("/api/carreras")
    public List<Carrera> obtenerCarreras() {
        return service.listarCarreras();
    }

    @GetMapping("/api/carreras/escuela/{idEscuela}")
    public List<Carrera> obtenerPorEscuela(
            @PathVariable("idEscuela") int idEscuela) {

        return service.listarCarrerasPorEscuela(idEscuela);
    }
}

