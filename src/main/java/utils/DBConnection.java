package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=HotelDB;encrypt=false";
    private static final String USER = "sa";
    private static final String PASS = "sa";

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("DB connected: " + conn);
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
            return null;
        } catch (SQLException e) {
            System.err.println("SQL Exception when getting connection: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
