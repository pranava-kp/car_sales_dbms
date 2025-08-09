<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dealership Information</title>
<style>
    /* Background and Base Styles */
    body, html {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        color: white;
        height: 100%;
        overflow: auto;
    }
    
    /* Video Background */
    .video-background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: -1;
    }
    
    /* Toolbar Styling */
    .toolbar {
        position: fixed;
        top: 10px;
        right: 20px;
        background-color: #333;
        color: white;
        padding: 10px;
        border-radius: 5px;
    }
    
    /* Dropdown Menu */
    .dropdown {
        position: relative;
        display: inline-block;
    }
    
    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        right: 0;
    }
    
    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }
    
    .dropdown-content a:hover {
        background-color: #f1f1f1;
    }
    
    .dropdown:hover .dropdown-content {
        display: block;
    }
    
    /* Main Content Area */
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
    
    /* Table Styling */
    .content-container table {
        width: 100%;
        margin-top: 20px;
        color: white;
        border-collapse: collapse;
    }
    
    .content-container table th, 
    .content-container table td {
        padding: 10px;
        border: 1px solid white;
    }
    
    /* Logout Button */
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
    
    /* Logo Styling */
    .logo {
        position: fixed;
        top: 25px;
        left: 25px;
        width: 100px;
        height: 100px;
    }
    
    /* Debug Message Styling */
    .debug-message {
        color: yellow;
        font-weight: bold;
    }
</style>
</head>
<body>
<img src="design.jpeg" alt="Background" class="video-background">
<img src="geenie.jpg" alt="Logo" class="logo">

<div class="toolbar">
    <div class="dropdown">
        <button class="dropbtn">Options</button>
        <div class="dropdown-content">
            <a href="company1.jsp" onclick="executeQuery('registeredCars')">Registered Cars (Join Operation)</a>
            <!-- <a href="company2.jsp" onclick="executeQuery('option2')">Dealership (Select Operation)</a> -->
            <a href="company_main.jsp" onclick="executeQuery('option3')">Home</a>
        </div>
    </div>
</div>

<div class="content-container">
<h2>Dealership</h2>
<%
    String user_id = (String) session.getAttribute("user_id");
    if (user_id == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    //out.println("<p class='debug-message'>DEBUG: user_id = " + user_id + "</p>");
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

        String sql = "SELECT DISTINCT ml.username AS Manufacturer_Name, bf.DealerID AS Dealer_ID " +
                     "FROM manufacturer_login ml " +
                     "JOIN BUY_FROM bf ON ml.manufacturer_id = bf.ID " +
                     "WHERE ml.username = ? OR ml.manufacturer_id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, user_id);
        pstmt.setString(2, user_id);

        //out.println("<p class='debug-message'>DEBUG: SQL = " + sql + "</p>");
        
        rs = pstmt.executeQuery();

        out.println("<table>");
        out.println("<tr><th>Manufacturer</th><th>Dealer Name</th></tr>");

        boolean hasResults = false;
        while (rs.next()) {
            hasResults = true;
            out.println("<tr>");
            out.println("<td>" + rs.getString("Manufacturer_Name") + "</td>");
            out.println("<td>" + rs.getString("Dealer_ID") + "</td>");
            out.println("</tr>");
        }
        
        if (!hasResults) {
            out.println("<tr><td colspan='2'>No dealership records found</td></tr>");
        }
        
        out.println("</table>");

    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
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