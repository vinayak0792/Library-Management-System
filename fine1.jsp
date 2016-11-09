
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>


        
        <%  
            Class.forName("com.mysql.jdbc.Driver"); 
            java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password");
            String id = request.getParameter("card_id");
            String isbn = request.getParameter("isbn");
            String button = request.getParameter("button");
            Integer card_id = Integer.parseInt(id);
            String fineQuery = " select * from fines as f, borrower as br where br.loan_id = f.loan_id and card_id = ? "; 
            String odQuery = "Select bl.isbn, b.title , count(loan_id) as total from book_loans as bl, books as b where card_id= ? and bl.isbn = b.isbn and date_in is null and (SELECT DATEDIFF((Select due_date from book_loans where loan_id= bl.loan_id),(Select CURDATE())) < 0)" ;
            int days =0;
            if(button.equals("1"))
            {
            PreparedStatement stmt = conn.prepareStatement(fineQuery);
            stmt.setInt(1,card_id);
            ResultSet rs = stmt.executeQuery();
            while(rs.next())
            {
                out.println(rs.getInt("loan_id"));
                out.println(rs.getInt("fine"));
                if (rs.getInt("paid") == 1 )
                {
                  out.println("Fine not paid \n");
                }
                else
                {
                    out.println("Fines are paid \n");
                }
                  
            }
            }
            if(button.equals("2"))
            {
            
            PreparedStatement stmt1 = conn.prepareStatement(odQuery);
            stmt1.setInt(1,card_id);
            ResultSet rs1 = stmt1.executeQuery();
            ResultSet rs2 = rs1;
            while(rs1.next())
            {
                out.println(rs1.getString("isbn"));
                out.println(rs1.getString("title"));
               
            }
            
            if(rs2.next())
            {
                days = rs2.getInt("total");
            }
            
            
            }
            
            if(button.equals("cal"))
            {
                out.println("calc");
            }
            
            
        %>
