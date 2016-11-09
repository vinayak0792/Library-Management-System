<%-- 
    Document   : checkin
    Created on : Oct 14, 2016, 3:10:27 PM
    Author     : vinayaka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      
        <table>            
            <%
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password");

String details = request.getParameter("details");

String ssQuery = "select bl.isbn, bl.card_id , bl.date_out , bl.due_date, bl.loan_id from books as b , book_loans as bl , borrower as br where (b.isbn = bl.isbn and br.card_id = bl.card_id ) and date_in is null and(b.title like ? or b.isbn like ? or br.card_id like ? or br.ssn like ? or br.fname like ? or br.lname like ? or br.address like ?  or br.phone like ? )";

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
    
    
    
   while(rs1.next())
   { %>
        
    <tr>
        <td><a href="fines.jsp?isbn=<%= rs1.getString("isbn") %>&card_id=<%= rs1.getString("card_id") %>&loan_id=<%=rs1.getString("loan_id")%>"> <%=rs1.getString("isbn")%> </a> </td>
        <td>> <%= rs1.getString("card_id") %> </td>
                  
           <td><%= rs1.getDate("date_out") %> </td>
           <td><%= rs1.getDate("due_date") %> </td>
       </tr> 
      
      
   
           <%  }
        

%>
</table>
    </body>
</html>
