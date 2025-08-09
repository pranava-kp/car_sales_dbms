<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customers and Car Models</title>
<style>
    /* Background and Base Styles */
    body, html {
        font-family: Arial, sans-serif; /* Uses Arial font */
        margin: 0; /* No margin around edges */
        padding: 0; /* No padding */
        color: white; /* White text color */
        height: 100%; /* Full height */
        overflow: auto; /* Allows scrolling if needed */
    }
    
    /* Video Background */
    .video-background {
        position: fixed; /* Stays in place when scrolling */
        top: 0;
        left: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        object-fit: cover; /* Covers entire space */
        z-index: -1; /* Behind other content */
    }
    
    /* Toolbar Styling */
    .toolbar {
        position: fixed; /* Stays at top */
        top: 10px;
        right: 20px;
        background-color: #333; /* Dark gray */
        color: white;
        padding: 10px;
        border-radius: 5px; /* Rounded corners */
    }
    
    /* Dropdown Menu */
    .dropdown {
        position: relative; /* For absolute positioning inside */
        display: inline-block;
    }
    
    .dropdown-content {
        display: none; /* Hidden by default */
        position: absolute;
        background-color: #f9f9f9; /* Light gray */
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); /* Shadow effect */
        z-index: 1; /* Above other content */
        right: 0; /* Aligns to right */
    }
    
    .dropdown-content a {
        color: black; /* Black text for links */
        padding: 12px 16px;
        text-decoration: none; /* No underline */
        display: block; /* Each link on its own line */
    }
    
    .dropdown-content a:hover {
        background-color: #f1f1f1; /* Light gray on hover */
    }
    
    .dropdown:hover .dropdown-content {
        display: block; /* Shows menu on hover */
    }
    
    /* Main Content Area */
    .content-container {
        background: rgba(0, 0, 0, 0.7); /* Semi-transparent black */
        padding: 20px;
        border-radius: 10px; /* Rounded corners */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        text-align: center;
        width: 80%; /* 80% of page width */
        margin: 100px auto; /* Centered with top margin */
        z-index: 1; /* Above background */
    }
    
    /* Table Styling */
    .content-container table {
        width: 100%; /* Full width */
        margin-top: 20px;
        color: white;
        border-collapse: collapse; /* No space between borders */
    }
    
    .content-container table th, 
    .content-container table td {
        padding: 10px;
        border: 1px solid white; /* White borders */
    }
    
    /* Logout Button */
    .logout-container {
        margin-top: 20px;
        text-align: right; /* Aligns button to right */
    }
    
    .logout-container button {
        background: #4CAF50; /* Green button */
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer; /* Hand cursor on hover */
        transition: background 0.3s ease; /* Smooth color change */
    }
    
    .logout-container button:hover {
        background: #45a049; /* Darker green on hover */
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
            <a href="company_main.jsp" onclick="executeQuery('option3')">Home</a>
            <!-- <a href="company1.jsp" onclick="executeQuery('registeredCars')">Registered Cars (Join Operation)</a> -->
            <a href="company2.jsp" onclick="executeQuery('option2')">Dealership (Select Operation)</a>
        </div>
    </div>
</div>

<div class="content-container">
<h2>Customers and Car Model</h2>
<%
    String user_id = (String) session.getAttribute("user_id");
    if (user_id == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // out.println("<p class='debug-message'>DEBUG: user_id = " + user_id + "</p>");
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

        String sql = "SELECT M.Model_Name, C.Name " +
                     "FROM MODEL M " +
                     "JOIN manufacturer_login ml ON M.Manufacturer_Name = ml.username " +
                     "JOIN CAR CA ON M.ID = CA.Model_ID " +
                     "JOIN CUSTOMER C ON CA.Invoice_Number = C.Invoice_no " +
                     "WHERE ml.username = ? OR ml.manufacturer_id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, user_id);
        pstmt.setString(2, user_id);

        // out.println("<p class='debug-message'>DEBUG: SQL = " + sql + "</p>");
        
        rs = pstmt.executeQuery();

        out.println("<table>");
        out.println("<tr><th>Model Name</th><th>Customer Name</th></tr>");

        boolean hasResults = false;
        while (rs.next()) {
            hasResults = true;
            out.println("<tr>");
            out.println("<td>" + rs.getString("Model_Name") + "</td>");
            out.println("<td>" + rs.getString("Name") + "</td>");
            out.println("</tr>");
        }
        
        if (!hasResults) {
            out.println("<tr><td colspan='2'>No matching records found</td></tr>");
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