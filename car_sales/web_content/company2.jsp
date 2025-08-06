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
        right: 10px; 
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
                <a href="company1.jsp" onclick="executeQuery('registeredCars')">Registered Cars (Join Operation)</a>
                <a href="company2.jsp" onclick="executeQuery('option2')">Dealership (Select Operation)</a>
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
    %>


    <%
        // Initialize database connection variables
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String JDBC = "jdbc:mysql://localhost:3306/rto";
        String dbUser = "root";
        String dbPassword = "1711011";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            conn = DriverManager.getConnection(JDBC, dbUser, dbPassword);

            // Prepare the SQL query
            String sql = "SELECT DISTINCT m.Name AS Manufacturer_Name, bf.DealerID AS Dealer_ID FROM MANUFACTURER m JOIN BUY_FROM bf ON m.ID = bf.ID WHERE m.Name = ?;";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);

            // Execute the query
            rs = pstmt.executeQuery();

            // Display the data in a table format
            out.println("<table>");
            out.println("<tr><th>Manufacturer</th><th>Dealer Name</th></tr>");

            while (rs.next()) {
                String column1 = rs.getString("Manufacturer_Name");
                String column2 = rs.getString("Dealer_ID");

                // Display the data
                out.println("<tr>");
                out.println("<td>" + column1 + "</td>");
                out.println("<td>" + column2 + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <!-- Add a logout button -->
    <div class="logout-container">
        <form action="logout.jsp" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
</div>

</body>
</html>
