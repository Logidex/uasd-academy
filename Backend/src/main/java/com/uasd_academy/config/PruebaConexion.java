package com.uasd_academy.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.nio.file.Files;
import java.nio.file.Path;

public class PruebaConexion {
    public static void probar() {

        Path ruta = Path.of("../database/uasd.db")
                        .toAbsolutePath()
                        .normalize();
        System.out.println("Base de datos: " + ruta);

        if (!Files.isRegularFile(ruta)) {
            System.out.println("El archivo no existe: " + ruta);
            return;
        }

        String url = "jdbc:sqlite:" + ruta;

        String sql = "SELECT COUNT(*) FROM facultades";

        try (Connection conexion = DriverManager.getConnection(url)) {

            try (PreparedStatement consulta =
                         conexion.prepareStatement("PRAGMA foreign_keys = ON")) {
                consulta.execute();
            }

            try (PreparedStatement consulta = conexion.prepareStatement(sql);
                 ResultSet resultado = consulta.executeQuery()) {

                if (resultado.next()) {
                    System.out.println(
                            "Facultades registradas: " + resultado.getInt(1)
                    );
                }
            }

        } catch (SQLException e) {
            System.out.println("Error JDBC: " + e.getMessage());
        }
    }
}