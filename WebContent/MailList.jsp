<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Mail List</title>
<body>
<h1>Create Mail List</h1>
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
final int USER_COL=2;
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
	str = "SELECT username email FROM airline.users where users.usertype = 'customer'";
	
	//run query
	result = stmt.executeQuery(str);
	
	//move to first line of user table
	//result.next();
	
	//get user type from getAttribute
	type=session.getAttribute("type").toString();
	
	
	out.println("<table style='width:1000'>");

	//manager page
			out.println("<tr>");
			out.println("<td>");
				out.println("UserName");
			out.println("</td>");
			
			//insert password???
					
			out.println("<td>");
				out.println("Email");
			out.println("</td>");
			
			
			
			while(result.next()) {
				out.println("<tr>");
				while(i <= USER_COL) {
					
					out.println("<td>");
					out.print(result.getString(i));
					out.println("</td>");
					
					i++;
				}
				i=1;
				out.println("</tr>");
				x++;
			}
	
	out.println("</table>");


} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</body>
</html>
</body>
</html>