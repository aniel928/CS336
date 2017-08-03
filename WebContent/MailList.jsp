<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Mail List</title>
<body>
<h1>Customer Mail List</h1>
<style>
table, th, td {
	border: 1px solid black;
}
td {
	width:10%;
}
</style>

<%
//declare variables
Connection con;
Statement stmt;
String type;
String str;
ResultSet result;
int i=1;
int x=0;

try {
	//connect to database
	con = dbConnect();
	
	stmt = con.createStatement();

	//build sql query
	str = "SELECT username, first_name, last_name, street_address, city, state, zipcode, email, phone FROM airline.users where users.usertype = 'customer';";
	
	//run query
	result = stmt.executeQuery(str);
	
	
	//get user type from getAttribute
	type=session.getAttribute("type").toString();
	
	
	out.println("<table style='width:1000'>");

	//manager page
	
	//Top labels
	out.println("<tr>");
	out.println("<td>");
		out.println("UserName");
	out.println("</td>");
	
	out.println("<td>");
		out.println("Name");  
	out.println("</td>");
		
	out.println("<td>");
		out.println("Address");
	out.println("</td>");
	
	out.println("<td>");
		out.println("Email");
	out.println("</td>");
	
	out.println("<td>");
		out.println("Phone");
	out.println("</td>");
out.println("</tr>");

while(result.next()) {
	
	out.println("<tr>");
	
	out.println("<td>");
	out.print(result.getString("username"));
	out.println("</td>");
	
	out.println("<td>");
	out.print(result.getString("first_name"));
	out.print(" ");
	out.print(result.getString("last_name"));
	out.println("</td>");
	
	out.println("<td>");
	out.print(result.getString("street_address"));
	out.print(", ");
	out.print(result.getString("city"));
	out.print(", ");
	out.print(result.getString("state"));
	out.print(", ");
	out.print(result.getString("zipcode"));
	out.println("</td>");
	
	out.println("<td>");
	out.print(result.getString("email"));
	out.println("</td>");
	
	out.println("<td>");
	out.print(result.getString("phone"));
	out.println("</td>");
	
	out.println("</tr>");

}

out.println("</table>");
con.close();


} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</body>
</html>
</body>
</html>