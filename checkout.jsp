<%-- 
    Document   : checkout
    Created on : Oct 14, 2016, 2:33:53 PM
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
      <%
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password");

String isbn = request.getParameter("isbn");
String id = request.getParameter("card_id");

int ava = 0;
int od = 0;
int ac = 0; 
int paid = 0;
int loan_id = 0;
Integer card_id = Integer.parseInt(id);

String avaQuery = "select avaliability from books where isbn = ?";
String odQuery = "Select count(loan_id) as total from book_loans as bl where card_id= ? and date_in is null and (SELECT DATEDIFF((Select due_date from book_loans where loan_id= bl.loan_id),(Select CURDATE())) < 0)" ;
String acQuery = "Select count(*) as total from book_loans as bl where card_id= ? and date_in is null and (SELECT DATEDIFF((Select due_date from book_loans where loan_id= bl.loan_id),(Select CURDATE())) > 0);";
String fineQuery = "select paid from book_loans as bl, fines as f where bl.card_id = ? and bl.loan_id = f.loan_id  ";
String loanQuery = "select loan_id from book_loans ORDER BY loan_id DESC limit 1 ";



PreparedStatement stmt1 = conn.prepareStatement(avaQuery);
stmt1.setString(1,isbn);
ResultSet rs = stmt1.executeQuery();
if(rs.next())
{
    ava = rs.getInt("avaliability");    
}

if (ava == 0)
{
    out.println("the book is not avaliable");    
}
else
{
    
    PreparedStatement stmt2 = conn.prepareStatement(odQuery);
    stmt2.setInt(1, card_id);
    ResultSet rs1 = stmt2.executeQuery();
    if(rs1.next())
    {
        od = rs1.getInt("total");
    }
        
    
    PreparedStatement stmt3 = conn.prepareStatement(acQuery);
    stmt3.setInt(1, card_id);
    ResultSet rs2 = stmt3.executeQuery();
    if(rs2.next())
    {
       ac = rs2.getInt("total"); 
      // out.println(rs2.getInt("total"));
    }

        
    
      PreparedStatement stmt4 = conn.prepareStatement(fineQuery);
    stmt4.setInt(1, card_id);
    ResultSet rs3 = stmt4.executeQuery();
    if(rs2.next())
    {
     paid = rs2.getInt("paid");   
    }
        
    
    //out.println("cannot lend book overdue"+od+"active"+ac+"paid"+paid);
    
    if (od >=1 || ac >3 || paid == 1)
    {
        out.println("cannot lend book");
    }
    else
    {
        Statement stmt10 = conn.createStatement();
        
        ResultSet rs10 = stmt10.executeQuery(loanQuery);
        if(rs10.next())
        {
            loan_id = rs10.getInt("loan_id") + 1 ;    
}
        String upQuery = "update books set avaliability = 0 where isbn = ?" ;
        PreparedStatement stmt8 = conn.prepareStatement(upQuery);
        
        stmt8.setString(1,isbn);
        
        int kj = stmt8.executeUpdate();
             
        
        Statement stmt5 = conn.createStatement();
        
        Statement stmt6 = conn.createStatement();
        ResultSet rs8 = stmt5.executeQuery("Select CURDATE()as do");
        ResultSet rs9 = stmt6.executeQuery("SELECT DATE_ADD((Select CURDATE()as date_out), INTERVAL 14 DAY) as dd;");
        if(rs8.next() && rs9.next())
        {
            Statement st= conn.createStatement(); 
            
            int i = st.executeUpdate("insert into book_loans(loan_id,isbn,card_id,date_out,due_date) values ('"+loan_id+"','"+isbn+"','"+card_id+"','"+rs8.getDate("do")+"','"+rs9.getDate("dd")+"')"); 
            
            if(i>0 && kj>0)
                {
                   
                    out.println("Book checkout successful");
                    
                }
                else
                {
                   
                    out.println("Book checkout failed");
                    
                }
            }
    }
    
    

}



%>
    </body>
</html>
