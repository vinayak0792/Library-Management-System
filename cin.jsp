<%-- 
    Document   : cin
    Created on : Oct 14, 2016, 6:15:00 PM
    Author     : Meghana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
 <%       
        Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password");

String details = request.getParameter("details");

String ssQuery = "select bl.isbn, bl.card_id , bl.date_out , bl.due_date from books as b , book_loans as bl , borrower as br where (b.isbn = bl.isbn and br.card_id = bl.card_id ) and (b.title like ? or b.isbn like ? or br.card_id like ? or br.ssn like ? or br.fname like ? or br.lname like ? or br.address like ?  or br.phone like ? )";

   PreparedStatement stmt = conn.prepareStatement(ssQuery);
    stmt.setString(1,"%"+details+"%");
    stmt.setString(2,"%"+details+"%");
    stmt.setString(3,"%"+details+"%");
    stmt.setString(4,"%"+details+"%");
    stmt.setString(5,"%"+details+"%");
    stmt.setString(6,"%"+details+"%");
    stmt.setString(7,"%"+details+"%");
    stmt.setString(8,"%"+details+"%");
   
    ResultSet rs1 = stmt.executeQuery();
    if(rs1.next())
    {
        out.println(rs.getInt("card_id"));
    }
    
    
 %>   
    </body>
</html>
