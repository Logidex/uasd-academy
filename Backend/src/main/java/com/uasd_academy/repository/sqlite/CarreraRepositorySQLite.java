
package com.uasd_academy.repository.sqlite;

import com.uasd_academy.model.Carrera;
import com.uasd_academy.repository.CarreraRepository;

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
public class CarreraRepositorySQLite implements CarreraRepository {

    @Override
    public List<Carrera> obtenerTodas() {

        List<Carrera> carreras = new ArrayList<>();

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
                SELECT id_carrera, nombre, id_escuela
                FROM carreras
                ORDER BY nombre
                """;

        try (
                Connection conexion = DriverManager.getConnection(url);
                PreparedStatement consulta = conexion.prepareStatement(sql);
                ResultSet resultado = consulta.executeQuery()
        ) {

            while (resultado.next()) {

                int idCarrera = resultado.getInt("id_carrera");
                String nombre = resultado.getString("nombre");
                int idEscuela = resultado.getInt("id_escuela");

                Carrera carrera = new Carrera(
                        idCarrera,
                        nombre,
                        idEscuela
                );

                carreras.add(carrera);
            }

        } catch (SQLException e) {

            throw new IllegalStateException(
                    "Error al consultar las carreras en SQLite",
                    e
            );
        }

        return carreras;
    }


    @Override
    public List<Carrera> obtenerPorEscuela(int idEscuela) {

        List<Carrera> carreras = new ArrayList<>();

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
            SELECT id_carrera, nombre, id_escuela
            FROM carreras
            WHERE id_escuela = ?
            ORDER BY nombre
            """;

        try (
                Connection conexion = DriverManager.getConnection(url);
                PreparedStatement consulta = conexion.prepareStatement(sql)
        ) {

            consulta.setInt(1, idEscuela);

            try (ResultSet resultado = consulta.executeQuery()) {

                while (resultado.next()) {

                    int idCarrera = resultado.getInt("id_carrera");
                    String nombre = resultado.getString("nombre");
                    int idEscuelaCarrera = resultado.getInt("id_escuela");

                    Carrera carrera = new Carrera(
                            idCarrera,
                            nombre,
                            idEscuelaCarrera
                    );

                    carreras.add(carrera);
                }
            }

        } catch (SQLException e) {
            throw new IllegalStateException(
                    "Error al consultar las carreras por escuela",
                    e
            );
        }

        return carreras;
    }

}

