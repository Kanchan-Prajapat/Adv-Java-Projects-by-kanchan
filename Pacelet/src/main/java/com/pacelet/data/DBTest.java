
package com.pacelet.data;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try (Connection connection =
                     DBConnection.getConnection()) {

            System.out.println(
                    "Pacelet MySQL connection successful!"
            );

        } catch (Exception e) {

            System.out.println(
                    "Database connection failed!"
            );

            e.printStackTrace();
        }
    }
}
