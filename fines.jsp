<%-- 
    Document   : fines
    Created on : Oct 14, 2016, 6:00:50 PM
    Author     : Meghana
--%>


<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>

        <%  
            Class.forName("com.mysql.jdbc.Driver"); 
            java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password");
            String id = request.getParameter("card_id");
            String isbn = request.getParameter("isbn");
            String loan_id = request.getParameter("loan_id");
            //Integer card_id = Integer.parseInt(id);
            //String fineQuery = " select * from fines as f, borrower as br where br.loan_id = f.loan_id and card_id = ?"; 
            String loanidQuery = "select loan_id from book_loans where card_id=? "; 
            String odQuery = "select DATEDIFF((Select CURDATE()),(select due_date from book_loans where loan_id ='"+loan_id+"')) as total" ;
            int days =0;
            
//            PreparedStatement stmt = conn.prepareStatement(loanidQuery);
//            stmt.setString(1,id);
//            ResultSet rs = stmt.executeQuery();
//            if(rs.next())
//            {
//               
//            }
            
            PreparedStatement stmt1 = conn.prepareStatement(odQuery);
            ResultSet rs1 = stmt1.executeQuery();
            if(rs1.next())
            {
                days = rs1.getInt("total");
            }
            double fine =0;
           // out.println("days"+days);
            if(days>0){
            fine = (-days)* 0.25 ;
            }
            //out.println(" / "+fine);
            
        Statement stmt5 = conn.createStatement();
        ResultSet rs8 = stmt5.executeQuery("Select CURDATE()as do");
           //String query = "update fine set fine_amt = ?,paid = 1 where loan_id= ? "; 
           Statement stmt2 = conn.createStatement();
           Statement stmt3 = conn.createStatement();
           
           //out.println("days"+days+""+fine);
           
           
          if(rs8.next() )
          {
               String upQuery = "update books set avaliability = 1 where isbn = ?" ;
        PreparedStatement stmt8 = conn.prepareStatement(upQuery);
        stmt8.setString(1,isbn);
        int kj = stmt8.executeUpdate();
        //out.println(loan_id);
        int j = stmt3.executeUpdate("update book_loans set date_in='"+rs8.getDate("do")+"' where loan_id='"+loan_id+"' ");
        if(fine>0)
            {
            int k = stmt2.executeUpdate("insert into fines values('"+loan_id+"','"+fine+"',0)");
            
            if ( k>0 && j>0)
            {
                out.println("amount paid" + fine + "book checked in");
            }
            
           
          }
        else
        {
            out.println("No fines due");
        }
            
            
            
            }
     
            
        %>
