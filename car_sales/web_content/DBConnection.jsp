<%@ page import="java.sql.*" %>
<% 
    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/car_sales", 
            "your_username", 
            "your_password");
    } catch(Exception e) {
        out.println("DB Error: " + e.getMessage());
    }
%>