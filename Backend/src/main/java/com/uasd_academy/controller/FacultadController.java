
package com.uasd_academy.controller;

import com.uasd_academy.model.Facultad;
import com.uasd_academy.service.FacultadService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class FacultadController {

    private final FacultadService service;

    public FacultadController(FacultadService service) {
        this.service = service;
    }

    @GetMapping("/api/facultades")
    public List<Facultad> obtenerFacultades() {
        return service.listarFacultades();
    }
}
