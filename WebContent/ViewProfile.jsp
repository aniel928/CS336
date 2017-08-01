<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Profile</title>
<style>
table, th, td {
	border: 1px solid black;
}
td {
	width:10%;
}
</style>
<body>
<h1>View User Profile</h1>

<%
//declare variables
final int USER_COL=19;
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
	str = "SELECT * FROM users";
	
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
				out.println("Account Number or SSN");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Name");  //sperate into First name and last name???
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
			
			out.println("<td>");
				out.println("Seat Prefrence");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Meal Prefrence");
			out.println("</td>");
				
			out.println("<td>");
				out.println("Hourly Rate");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Start Date");
			out.println("</td>");
		out.println("</tr>");
		
		while(result.next()) {
			out.println("<tr>");
			while(i <= USER_COL) {
				if(i ==1) {
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i==3) {
					out.println("<td>");
						if(result.getString(i) != null)
							out.print(result.getString(i));
				}
				if(i==4){
					if(result.getString(i) != null)
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i == 5) {
					out.println("<td>");
						out.print(result.getString(i) + " ");
				}
				if(i == 6){
						out.print(result.getString(i));
						out.println("</td>");
				}
				if(i == 7){
					out.println("<td>");
					out.print(result.getString(i) + " ");
				}
				if(i == 8){
					out.print(result.getString(i) + " ");
				}
				if(i == 9){
					out.print(result.getString(i) + " ");
				}
				if(i == 10){
					out.print(result.getString(i));
					out.println("</td>");
				}
				if(i == 11){
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i== 12){
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i == 15) {
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i == 16){
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i == 17) {
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				if(i == 19) {
					out.println("<td>");
						out.print(result.getString(i));
					out.println("</td>");
				}
				
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