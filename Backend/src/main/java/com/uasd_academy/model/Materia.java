
package com.uasd_academy.model;

public class Materia {

    private final int id;
    private final String codigo;
    private final String nombre;
    private final int creditos;
    private final int periodo;

    public Materia(int id, String codigo, String nombre,
                   int creditos, int periodo) {
        this.id = id;
        this.codigo = codigo;
        this.nombre = nombre;
        this.creditos = creditos;
        this.periodo = periodo;
    }

    public int getId() {
        return id;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public int getCreditos() {
        return creditos;
    }

    public int getPeriodo() {
        return periodo;
    }
}
