<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Successful</title>
<style>
    body, html {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        color: white;
        height: 100%;
        overflow: auto;
    }
    .video-background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: -1;
    }
    .toolbar {
        position: fixed;
        top: 10px;
        right: 50px; 
        background-color: #333;
        color: white;
        padding: 10px;
        border-radius: 5px;
    }
    .toolbar .dropdown {
        position: relative;
        display: inline-block;
    }
    .toolbar .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        right: 0;
    }
    .toolbar .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }
    .toolbar .dropdown-content a:hover {
        background-color: #f1f1f1;
    }
    .toolbar .dropdown:hover .dropdown-content {
        display: block;
    }
    .content-container {
        background: rgba(0, 0, 0, 0.7);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 80%;
        margin: 100px auto; 
        z-index: 1;
    }
    .content-container h2 {
        margin-top: 0;
    }
    .content-container table {
        width: 100%;
        margin-top: 20px;
        color: white;
        border-collapse: collapse; 
    }
    .content-container table th, .content-container table td {
        padding: 10px;
        border: 1px solid white;
    }
    .logout-container {
        margin-top: 20px;
        text-align: right;
    }
    .logout-container button {
        background: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s ease;
    }
    .logout-container button:hover {
        background: #45a049;
    }
    .logo {
        position: fixed;
        top: 15px;
        left: 15px;
        width: 100px;
        height: 100px;
    }
</style>
</head>
<body>

<img src="design.jpeg" alt="JAL-GAAR" class="video-background">
<img src="geenie.jpg" alt="JAL-GAAR" class="logo">

<div class="toolbar">
    <div class="dropdown">
        <button class="dropbtn">Options</button>
        <div class="dropdown-content">
            <a href="user1.jsp">Current Car Models</a>
            <a href="user2.jsp">Mileage (Corelated Query)</a>
            <a href="user3.jsp">My Cars</a>
            <a href="user4.jsp">Update Details</a>
            <a href="user_main.jsp">Home</a>
        </div>
    </div>
</div>

<div class="content-container">
    <h2>Current Car Models</h2>
    <%
        String user_id = (String) session.getAttribute("user_id");
        if (user_id == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String JDBC = "jdbc:mysql://localhost:3306/rto";
        String dbUser = "root";
        String dbPassword = "1711011";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC, dbUser, dbPassword);

            String sql = "SELECT Model_Name, Base_price, Year_of_prod FROM Model order BY base_price;";

            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();

            out.println("<table>");
            out.println("<tr><th>Model Name</th><th>Base Price</th><th>Year Of Production</th></tr>");

            while (rs.next()) {
                String column1 = rs.getString("Model_Name");
                String column2 = rs.getString("Base_price");
                String column3 = rs.getString("Year_of_prod");

                out.println("<tr>");
                out.println("<td>" + column1 + "</td>");
                out.println("<td>" + column2 + "</td>");
                out.println("<td>" + column3 + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <div class="logout-container">
        <form action="logout.jsp" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
</div>
</body>
</html>
