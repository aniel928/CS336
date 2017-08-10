<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title> Flight Customers</title>
<body>
<style>
table, th, td {
	border: 1px solid black;
}
td {
	width:10%;
}</style>
<% try{
	//declare variables
	Connection con;
	Statement stmt;
	String type;
	String str;
	ResultSet result;
	
	con = dbConnect();
	
	stmt = con.createStatement();
		
	//build sql query
	out.println("<div class='trans'");
			String showby = request.getParameter("num").toString();
			out.println("<h1> Customers Reserved for Flight " + showby + "</h1>");
					 str="SELECT * FROM airline.has h, airline.makes m, airline.users u WHERE h.ResNumber=m.ResNumber AND m.account_no=u.account_no;";
		
			 		result = stmt.executeQuery(str);
		
					out.println("<table style='width:1000'>");
			 		out.println("<tr>");
					out.println("<td>");
						out.println("Account Number");
					out.println("</td>");
					
					out.println("<td>");
						out.println("Username");  
					out.println("</td>");
					
					out.println("<td>");
					out.println("Name");  
					out.println("</td>");
					
					
					out.println("<td>");
					out.println("Reservation Number");  
					out.println("</td>");
				
					
					out.println("</tr>");
					while(result.next()) {
						
						
						out.println("<td>");
						out.print(result.getString(5));
						out.println("</td>");
						
						out.println("<td>");
						out.print(result.getString(7));
						out.println("</td>");
						
						out.println("<td>");
						out.print(result.getString(11));
						out.println(" ");
						out.println(result.getString(12));
						out.println("</td>");
						
						out.println("<td>");
						out.print(result.getString(1));
						out.println("</td>");
						
						
						out.println("</tr>");
					}
					 out.println("</table>");
			 con.close();
			 out.println("</div>");
		
		
} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</body>
</html>