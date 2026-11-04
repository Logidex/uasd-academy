
package com.uasd_academy.repository.sqlite;

import com.uasd_academy.model.Materia;
import com.uasd_academy.repository.MateriaRepository;
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
public class MateriaRepositorySQLite implements MateriaRepository {

    @Override
    public List<Materia> obtenerPorCarrera(int idCarrera) {

        List<Materia> materias = new ArrayList<>();

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
                SELECT
                    m.id_materia,
                    m.codigo,
                    m.nombre,
                    m.creditos,
                    cm.periodo
                FROM carrera_materias cm
                INNER JOIN materias m
                    ON m.id_materia = cm.id_materia
                WHERE cm.id_carrera = ?
                ORDER BY cm.periodo, m.codigo
                """;

        try (Connection conexion = DriverManager.getConnection(url);
             PreparedStatement consulta =
                     conexion.prepareStatement(sql)) {

            consulta.setInt(1, idCarrera);

            try (ResultSet resultado = consulta.executeQuery()) {

                while (resultado.next()) {

                    Materia materia = new Materia(
                            resultado.getInt("id_materia"),
                            resultado.getString("codigo"),
                            resultado.getString("nombre"),
                            resultado.getInt("creditos"),
                            resultado.getInt("periodo")
                    );

                    materias.add(materia);
                }
            }

        } catch (SQLException e) {
            throw new IllegalStateException(
                    "Error al consultar las materias en SQLite", e
            );
        }

        return materias;
    }
}
