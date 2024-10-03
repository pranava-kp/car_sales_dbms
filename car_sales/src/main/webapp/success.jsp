<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Successful</title>
</head>

<body>
<h2>Login Successful</h2>
<p>Welcome, <%= request.getParameter("user_id") %>!</p>

<%
    // Initialize database connection variables
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String JDBC = "jdbc:mysql://localhost:3306/users";
    String dbUser = "root";
    String dbPassword = "241195";

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(JDBC, dbUser, dbPassword);

        // Prepare the SQL query
        String sql = "select Name, Phone ,Reg_no from rto r, car c where r.RTO_ID= c.RTO_ID";
        pstmt = conn.prepareStatement(sql);

        // Execute the query
        rs = pstmt.executeQuery();

        // Display the data in a table format
        out.println("<table border='1'>");
        out.println("<tr><th>Name</th><th>Phone</th><th>Reg_no</th></tr>");

        // Process the result set
        while (rs.next()) {
            String column1 = rs.getString("Name");
            String column2 = rs.getString("Phone");
            String column3 = rs.getString("Reg_no");

            // Display the data
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
        // Close the resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!-- Add a logout button -->
<form action="logout.jsp" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>
