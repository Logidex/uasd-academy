package com.uasd_academy.repository;

import com.uasd_academy.model.Facultad;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class FacultadRepositoryLocal implements FacultadRepository {

    @Override
    public List<Facultad> obtenerTodas() {

        return List.of(
            new Facultad(1, "Facultad de Ciencias", 1950),
            new Facultad(2, "Facultad de Artes", 1960),
            new Facultad(3, "Facultad de Humanidades", 1945)
        );
    }
}