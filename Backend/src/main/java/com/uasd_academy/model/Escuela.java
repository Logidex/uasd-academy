
package com.uasd_academy.model;

public class Escuela {

    private int id;
    private String nombre;
    private int idFacultad;

    public Escuela(int id, String nombre, int idFacultad) {
        this.id = id;
        this.nombre = nombre;
        this.idFacultad = idFacultad;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public int getIdFacultad() {
        return idFacultad;
    }
}
