
package com.uasd_academy.repository;

import com.uasd_academy.model.Facultad;
import org.springframework.stereotype.Repository;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class FacultadRepositorySQLite implements FacultadRepository {

    @Override
    public List<Facultad> obtenerTodas() {

        List<Facultad> facultades = new ArrayList<>();

        Path ruta = Path.of("../database/uasd.db")
                .toAbsolutePath()
                .normalize();

        if (!Files.isRegularFile(ruta)) {
            throw new IllegalStateException(
                    "No existe la base de datos: " + ruta
            );
        }

        String url = "jdbc:sqlite:" + ruta;

        String sql = """
                SELECT id_facultad, nombre, descripcion
                FROM facultades
                ORDER BY nombre
                """;

        try (Connection conexion = DriverManager.getConnection(url);
             PreparedStatement consulta = conexion.prepareStatement(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {

                int id = resultado.getInt("id_facultad");
                String nombre = resultado.getString("nombre");
                String descripcion = resultado.getString("descripcion");

                Facultad facultad = new Facultad(
                        id,
                        nombre,
                        descripcion
                );

                facultades.add(facultad);
            }

        } catch (SQLException e) {
            throw new IllegalStateException(
                    "Error al consultar las facultades en SQLite", e
            );
        }

        return facultades;
    }
}
