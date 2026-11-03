
package com.uasd_academy.model;

public class Carrera {

    private int idCarrera;
    private String nombre;
    private int idEscuela;

    public Carrera(int idCarrera, String nombre, int idEscuela) {
        this.idCarrera = idCarrera;
        this.nombre = nombre;
        this.idEscuela = idEscuela;
    }

    public int getIdCarrera() {
        return idCarrera;
    }

    public String getNombre() {
        return nombre;
    }

    public int getIdEscuela() {
        return idEscuela;
    }

}
