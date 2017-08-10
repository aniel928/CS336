<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
<!-- Author: Catherine Yeager -->
<title>Mail List</title>
<body>
<div class="trans">
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
	
	
	out.println("<table class = 'datatable'>");

	//manager page
	
	//Top labels
	out.println("<tr>");
	out.println("<th>");
		out.println("UserName");
	out.println("</th");
	
	out.println("<th>");
		out.println("Name");  
	out.println("</th>");
		
	out.println("<th>");
		out.println("Address");
	out.println("</th>");
	
	out.println("<th>");
		out.println("Email");
	out.println("</th>");
	
	out.println("<th>");
		out.println("Phone");
	out.println("</th>");
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

out.println("<br><br><a href='dashboard.jsp'>Back to Dashboard</a>");
con.close();


} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</div>
</body>
</html>
</body>
</html>