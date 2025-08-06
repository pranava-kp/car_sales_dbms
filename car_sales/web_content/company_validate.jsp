<%@ page import="java.sql.*" %>
<%
String username = request.getParameter("user_id");
String password = request.getParameter("password");

String JDBC = "jdbc:mysql://localhost:3306/rto";
String dbUser = "root";
String dbPassword = "1711011";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(JDBC, dbUser, dbPassword);
    
    String sql = "SELECT m.* FROM manufacturer_login ml " +
                 "JOIN manufacturer m ON ml.manufacturer_id = m.ID " +
                 "WHERE ml.username = ? AND ml.password = ?";
    
    PreparedStatement st = con.prepareStatement(sql);
    st.setString(1, username);
    st.setString(2, password);
    
    ResultSet rs = st.executeQuery();
    
    if (rs.next()) {
        // Store manufacturer info in session
        session.setAttribute("user_id", rs.getString("ID"));
        session.setAttribute("company_name", rs.getString("Name"));
        response.sendRedirect("company_main.jsp");
    } else {
        response.sendRedirect("error.jsp?message=Invalid+credentials");
    }
    
    rs.close();
    st.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
    e.printStackTrace();
}
%>