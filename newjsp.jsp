<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<html>
    <head><title></title></head>
    <body>
<%
String search=request.getParameter("details"); 
//session.putValue("userid",userid); 
//String pwd=request.getParameter("pwd"); 
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password"); 
PreparedStatement stmt= null;

String query = "select b.isbn, b.title, a.name , b.avaliability from books as b,authors as a,book_authors as ba where b.ISBN = ba.isbn and ba.author_id = a.author_id and (b.ISBN LIKE ? or b.title like ? or a.name like ? )" ;
//String query = "select b.isbn, b.title, a.name , b.avaliability from books as b,authors as a,book_authors as ba" ;

stmt = conn.prepareStatement(query);
stmt.setString(1,"%"+search+"%");
stmt.setString(2,"%"+search+"%");
stmt.setString(3,"%"+search+"%");

ResultSet rs=stmt.executeQuery();

//out.println(rs.getDouble("isbn")+""+rs.getString("ttile"));
String title;
String isbn;
ResultSet rs1 = rs;

while(rs.next())
{
    //out.println(rs.getString("isbn"));
    isbn = rs.getString("isbn");
    %> 
    <table border="1">
       <tr>
           <td><%= rs.getString("isbn") %> </td>
           <td><%= rs.getString("title") %> </td>        
           <td><%= rs1.getString("name") %> </td>

    
       </tr>
    <% }
%>    
     
</table>
</body>
</html>