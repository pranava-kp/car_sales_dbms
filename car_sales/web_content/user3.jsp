<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DatabaseConfig" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cars</title>
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
    .toolbar .dropdown-content a.active {
        background-color: #007bff;
        color: white;
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
<% String currentPage = "user3"; %>
<img src="design.jpeg" alt="Background" class="video-background">
<img src="geenie.jpg" alt="JAL-GAAR" class="logo">

<div class="toolbar">
    <div class="dropdown">
        <button class="dropbtn">Options</button>
        <div class="dropdown-content">
            <a href="user_main.jsp" class="<%= "home".equals(currentPage) ? "active" : "" %>">Home</a>
           <a href="user1.jsp" class="<%= "user1".equals(currentPage) ? "active" : "" %>">Current Models</a>
            <a href="user2.jsp" class="<%= "user2".equals(currentPage) ? "active" : "" %>">Mileage (Corelated Query)</a>
            <a href="user3.jsp" class="<%= "user3".equals(currentPage) ? "active" : "" %>">My Cars</a>
            <a href="user4.jsp" class="<%= "user4".equals(currentPage) ? "active" : "" %>">Update Details</a>
        </div>
    </div>
</div>

<div class="content-container">
    <h2>My Cars</h2>
    <%
        String user_id = (String) session.getAttribute("user_id");
        if (user_id == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String JDBC = DatabaseConfig.JDBC_URL;
        String dbUser = DatabaseConfig.DB_USER;
        String dbPassword = DatabaseConfig.DB_PASSWORD;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC, dbUser, dbPassword);

            String sql = "SELECT CA.Reg_no, CA.Date_of_Registration, CA.Chassis_No, CM.Model_Name " +
                         "FROM CAR CA " +
                         "JOIN MODEL CM ON CA.Model_ID = CM.ID " +
                         "JOIN CUSTOMER C ON CA.Invoice_Number = C.Invoice_no " +
                         "WHERE C.Name = ?";

            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            pstmt.setString(1, user_id);

            rs = pstmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p>No data found for user: " + user_id + "</p>");
            } else {
                out.println("<table>");
                out.println("<tr><th>Registration Number</th><th>Date of Registration</th><th>Chassis No.</th><th>Model</th></tr>");

                while (rs.next()) {
                    String regNo = rs.getString("Reg_no");
                    Date registrationDate = rs.getDate("Date_of_Registration");
                    String chassisNo = rs.getString("Chassis_No");
                    String modelName = rs.getString("Model_Name");

                    out.println("<tr>");
                    out.println("<td>" + regNo + "</td>");
                    out.println("<td>" + registrationDate + "</td>");
                    out.println("<td>" + chassisNo + "</td>");
                    out.println("<td>" + modelName + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
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
