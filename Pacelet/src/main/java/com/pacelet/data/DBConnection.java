package com.pacelet.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = getEnvOrDefault(
            "PACELET_DB_URL",
            "jdbc:mysql://localhost:3306/pacelet");

    private static final String USER = getEnvOrDefault(
            "PACELET_DB_USER", "root");

    private static final String PASSWORD =
            System.getenv("PACELET_DB_PASSWORD");

    private static String getEnvOrDefault(
            String key, String defaultValue) {
        String value = System.getenv(key);
        return (value == null || value.isBlank())
                ? defaultValue : value;
    }

    public static Connection getConnection()
            throws SQLException {

        if (PASSWORD == null) {
            throw new SQLException(
                    "PACELET_DB_PASSWORD environment variable is not set.");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC Driver not found.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}