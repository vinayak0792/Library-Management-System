<%-- 
    Document   : newsuer
    Created on : Oct 14, 2016, 2:12:32 PM
    Author     : vinayaka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library2","root","password");
//String isbn = request.getParameter("isbn");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String ssn = request.getParameter("ssn");
String address = request.getParameter("add");
String phone = request.getParameter("phn");
int card_id = 0;
int i = 0 ;
String cardQuery = "select card_id from borrower ORDER BY card_id DESC limit 1";
String insertQuery = "insert into borrower values(?,?,?,?,?,?)" ;
String ssnQuery = "select ssn from borrower where ssn = ?";

PreparedStatement stmt2 = conn.prepareStatement(ssnQuery);
stmt2.setString(1,ssn);

ResultSet rs2 = stmt2.executeQuery();

if(rs2.next() && ssn.equals(rs2.getString("ssn")))
{
    out.println("SSN already exists, please check your card_id");
    
}
else
{
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(cardQuery);

if(rs.next())
{
    card_id  = rs.getInt("card_id") + 100;
    
}

PreparedStatement stmt1 = conn.prepareStatement(insertQuery);
stmt1.setInt(1,card_id);
stmt1.setString(2,ssn); 
stmt1.setString(3,fname);
stmt1.setString(4,lname);
stmt1.setString(5,address);
stmt1.setString(6,phone);

i = stmt1.executeUpdate();
if(i==1)
{
    out.println("User Added");
}

}















%>



