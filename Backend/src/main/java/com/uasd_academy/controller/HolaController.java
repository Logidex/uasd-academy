
package com.uasd_academy.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolaController {

    @GetMapping("/api/hola")
    public String saludar() {
        return "Hola Mundo desde UASD Académica";
    }
}
