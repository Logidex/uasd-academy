package com.uasd_academy.repository;

import com.uasd_academy.model.Facultad;
import java.util.List;

public class FacultadRepositoryLocal implements FacultadRepository {

    @Override
    public List<Facultad> obtenerTodas() {

        return List.of(
                new Facultad(1, "Facultad de Ciencias", "Área académica de ciencias"),
                new Facultad(2, "Facultad de Artes", "Área académica de artes"),
                new Facultad(3, "Facultad de Humanidades", "Área académica de humanidades")
        );
    }
}