package lk.hasara.advanceprogrammingassingmentmy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String jdbcURL = "jdbc:mysql://localhost:3306/pahana_edu";
    private static final String jdbcUsername = "root";
    private static final String jdbcPassword = "1234";

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Fails if jar is not added
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
}
