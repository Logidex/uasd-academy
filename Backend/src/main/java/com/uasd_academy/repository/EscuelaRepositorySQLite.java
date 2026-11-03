
package com.uasd_academy.repository;

import com.uasd_academy.model.Escuela;
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
public class EscuelaRepositorySQLite implements EscuelaRepository {

    @Override
    public List<Escuela> obtenerTodas() {

        List<Escuela> escuelas = new ArrayList<>();

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
                SELECT id_escuela, nombre, id_facultad
                FROM escuelas
                ORDER BY nombre
                """;

        try (
                Connection conexion = DriverManager.getConnection(url);
                PreparedStatement consulta = conexion.prepareStatement(sql);
                ResultSet resultado = consulta.executeQuery()
        ) {

            while (resultado.next()) {

                int id = resultado.getInt("id_escuela");
                String nombre = resultado.getString("nombre");
                int idFacultad = resultado.getInt("id_facultad");

                Escuela escuela = new Escuela(
                        id,
                        nombre,
                        idFacultad
                );

                escuelas.add(escuela);
            }

        } catch (SQLException e) {

            throw new IllegalStateException(
                    "Error al consultar las escuelas en SQLite",
                    e
            );
        }

        return escuelas;
    }
}

