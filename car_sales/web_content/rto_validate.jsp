<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DatabaseConfig" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RTO Login Validation</title>
</head>
<body>

<%
// Input collection
String user_id = request.getParameter("user_id");
String password = request.getParameter("password");
boolean passwordMatch = false;

// Database configuration
String JDBC = DatabaseConfig.JDBC_URL;
String dbUser = DatabaseConfig.DB_USER;
String dbPassword = DatabaseConfig.DB_PASSWORD;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    // Use Try-With-Resources to guarantee closing of connection and statement
    try (Connection con = DriverManager.getConnection(JDBC, dbUser, dbPassword);
         // SQL Injection safe: Only fetch the stored hash based on user_id
         PreparedStatement st = con.prepareStatement("SELECT password FROM rto_login WHERE user_id=?")) {
        
        st.setString(1, user_id);
        
        try (ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                String storedHash = rs.getString("password");
                
                // Securely compare submitted plaintext password against the stored hash
                if (storedHash != null) {
                    passwordMatch = BCrypt.checkpw(password, storedHash); 
                }
            }
        }
    }

    // Handle the login result
    if (passwordMatch) {
        // Login Success
        session.setAttribute("user_id", user_id);
        response.sendRedirect("rto_main.jsp");
    } else {
        response.sendRedirect("error.jsp");
    }

} catch (ClassNotFoundException e) {
    out.println("<p style='color: red;'>Configuration Error: JDBC Driver not found.</p>");
    e.printStackTrace();
} catch (SQLException e) {
    out.println("<p style='color: red;'>Database Error: Failed to connect or query the database.</p>");
    e.printStackTrace();
}
%>
</body>
</html>
