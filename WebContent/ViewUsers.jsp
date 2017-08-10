<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Users</title>
<style>
table, th, td {
	border: 1px solid black;
}
td {
	width:10%;
}
</style>
<body>
<div class="trans">
<h1>View User Profile</h1>

<%
//declare variables
final int USER_COL=19;
Connection con;
Statement stmt;
String str;
ResultSet result;
int i=1;
int x=0;

//used to store the values of certian attributes so they can be correctly sent to ViewEditUsers.jsp
String type=null;
String ssn=null;
String acc=null;

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
	
	
	out.println("<table class=datatable>");

	//manager page
		out.println("<tr>");
			out.println("<td style='font-weight:bold'>");
				out.println("UserName");
			out.println("</td>");
			
			//insert password???
					
			out.println("<td style='font-weight:bold'>");
				out.println("Account Number or SSN");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Name");  //sperate into First name and last name???
			out.println("</td>");
				
			out.println("<td style='font-weight:bold'>");
				out.println("Address");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Email");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Phone");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Seat Prefrence");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Meal Prefrence");
			out.println("</td>");
		
			 if(session.getAttribute("type").equals("manager")) {
				 out.println("<td style='font-weight:bold'>");
					out.println("Hourly Rate");
				out.println("</td>");
			  }
			
			out.println("<td style='font-weight:bold'>");
				out.println("Type");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Start Date");
			out.println("</td>");
			
			out.println("<td style='font-weight:bold'>");
				out.println("Link");
			out.println("</td>");
		out.println("</tr>");
		
		while(result.next()) {
			out.println("<tr>");
			
			//get values for variables right off the bat
			type=result.getString(18);
			acc=result.getString(3); 
			ssn=result.getString(4);
			
	
			out.print("<td>" + result.getString(1) +  "</td>");
			if(type.equals("customer")){
				out.print("<td> "+ acc + "</td>");
			}
			else{
				out.print("<td> "+ ssn + "</td>");
			}
			out.print("<td>" + result.getString(5) + " " +  result.getString(6) +  "</td>");
			
			out.print("<td>" + result.getString(7) + " " +  result.getString(8) + ", " + result.getString(9) + " " +  result.getString(10) + "</td>");
			
			out.print("<td>" + result.getString(11) +  "</td>");
			out.print("<td>" + result.getString(12) +  "</td>");
			if(type.equals("customer")){
				out.print("<td>" + result.getString(15) +  "</td>");
				out.print("<td>" + result.getString(16) +  "</td>");
			}
			else{
				out.print("<td></td><td></td>");
			}
			
			
			//if manager display hourly rate
			if(session.getAttribute("type").equals("manager")) {
				if(type.equals("customer")){
					out.println("<td></td>");
				}
				else{
					out.print("<td>" + result.getString(17) +  "</td>");
				}
			}	
			out.print("<td>" + type +  "</td>");
			if(type.equals("customer")){
				out.print("<td></td>");
			}
			else{
				out.print("<td>" + result.getString(19) +  "</td>");
			}		
			if(type == null){
				type="employee";
			}
			if(type.equals("customer")) {
				out.print("<td>" + 
							"<form method='get' action='ViewEditUsersUserList.jsp'>" +
								"<button name='acc' value=" + acc + ">View or Edit</button>" +	
							"</form>" +
				        "</td>");
			}
			else{
				out.print("<td>" + 
						  	"<form method='get' action='ViewEditUsersUserList.jsp'>" +
								"<button name='ssn' value=" + ssn + ">View or Edit</button>" +	
							"</form>" +
			              "</td>");
			}
			
			out.print("</tr>");
		}
		out.print("</table>");
} 
catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
catch(NullPointerException e) {
	out.print("tst" + e.getMessage());
}

%>
</div>
</body>
</html>