// Keep your existing package declaration above these imports.
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = getEnvOrDefault(
            "COLLEGE_DB_URL",
            "jdbc:mysql://localhost:3306/collegeJava");

    private static final String USER = getEnvOrDefault(
            "COLLEGE_DB_USER", "root");

    private static final String PASSWORD =
            System.getenv("COLLEGE_DB_PASSWORD");

    private static String getEnvOrDefault(
            String key, String defaultValue) {
        String value = System.getenv(key);
        return (value == null || value.isBlank())
                ? defaultValue : value;
    }

    public static Connection getConnection() throws Exception {
        if (PASSWORD == null) {
            throw new SQLException(
                    "COLLEGE_DB_PASSWORD environment variable is not set.");
        }

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}