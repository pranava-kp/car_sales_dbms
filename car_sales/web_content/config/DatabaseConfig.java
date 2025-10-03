package config; 

public class DatabaseConfig {
    public static final String JDBC_URL = "jdbc:mysql://localhost:3306/rto?allowMultiQueries=true";
    public static final String DB_USER = "root";
    public static final String DB_PASSWORD = "1711011";

    private DatabaseConfig() {} // Utility class
}