<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Profile</title>
<style>
table, th, td {
   border: 1px solid black;
}
</style>
<body>
<h1>View User Profile</h1>

<%
try {
	//connect to database
	Connection con = dbConnect();
	
	Statement stmt = con.createStatement();

	//build sql query
	String str = "SELECT * FROM users WHERE username= '"+ session.getAttribute("username") + "'";
	
	//run query
	ResultSet result = stmt.executeQuery(str);
	

	out.println("<table style='width:250px'>");

		out.println("<tr>");
			out.println("<td>");
				out.println("UserName");
			out.println("</td>");
			
			out.println("<td>");
				out.println("password");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Account Number");
			out.println("</td>");
		out.println("</tr>");
		
		out.println("<tr>");
			out.println("<td>");
				out.println("test");
			out.println("</td>");
		out.println("</tr>");
	
	out.println("</table>");


} catch (Exception e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</body>
</html>