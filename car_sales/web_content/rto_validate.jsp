<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DatabaseConfig" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Validation</title>
</head>
<body>

<%
String user_id = request.getParameter("user_id");
String password = request.getParameter("password");

String JDBC = DatabaseConfig.JDBC_URL;
String dbUser = DatabaseConfig.DB_USER;
String dbPassword = DatabaseConfig.DB_PASSWORD;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    try (Connection con = DriverManager.getConnection(JDBC, dbUser, dbPassword);
         PreparedStatement st = con.prepareStatement("SELECT * FROM rto_login WHERE user_id=? AND password=?")) {
        st.setString(1, user_id);
        st.setString(2, password);
        try (ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                // Store user_id in session
                session.setAttribute("user_id", user_id);
                response.sendRedirect("rto_main.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        }
    }
} catch (ClassNotFoundException e) {
    out.println("JDBC Driver not found. Please add the JDBC library to your project.");
    e.printStackTrace();
} catch (SQLException e) {
    out.println("Error connecting to the database: " + e.getMessage());
    e.printStackTrace();
}
%>
</body>
</html>
