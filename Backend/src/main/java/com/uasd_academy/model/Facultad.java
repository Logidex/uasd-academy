
package com.uasd_academy.model;

public class Facultad {

    private int id;
    private String nombre;
    private int fundacion;

    public Facultad(int id, String nombre, int fundacion) {
        this.id = id;
        this.nombre = nombre;
        this.fundacion = fundacion;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public int getFundacion() {
        return fundacion;
    }

}