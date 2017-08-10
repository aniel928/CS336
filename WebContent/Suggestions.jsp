<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Suggestions</title>
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
<h1> View Customer Suggestions</h1>
<% 
if(request.getParameter("acc") == null) {
	out.print("<form>");
	  out.print("Enter Account Number: <input type='text' name='acc' required>");
	  out.print("<br> <br>");
	  out.print("<input type='submit'>");
	out.print("</form>");
}
else {
	Connection con = dbConnect();
		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String str ="select flightinfo.*, count(FLNumber) count from flightinfo, has  where FInumber in (select FLNumber from has where ResNumber in (select ResNumber from makes where account_no = '" + request.getParameter("acc") + "')) and has.FLNumber = flightinfo.FINumber group by FLNumber order by count desc";
	
	ResultSet result = stmt.executeQuery(str);
	
	
	//build header
	out.println("<table class=datatable>");
	out.println("<tr>");
				out.println("<td style='font-weight:bold'>");
					out.println("Flight Number");
				out.println("</td>");
				
				out.println("<td style='font-weight:bold'>");
					out.println("Flight Fare");
				out.println("</td>");
				
				out.println("<td style='font-weight:bold'>");
					out.println("Departs");  
				out.println("</td>");
					
				out.println("<td style='font-weight:bold'>");
					out.println("Arrives");
				out.println("</td>");
				
				out.println("<td style='font-weight:bold'>");
					out.println("Time Departs");
				out.println("</td>");
	
				out.println("<td style='font-weight:bold'>");
					out.println("Time Arrives");
				out.println("</td>");
				
				out.println("<td style='font-weight:bold'>");
					out.println("Operates");
				out.println("</td>"); 
				
				out.println("<td style='font-weight:bold'>");
					out.println("Aircraft Number");
				out.println("</td>");
				
				out.println("<td style='font-weight:bold'>");
					out.println("Count");
				out.println("</td>");
	
	//loop through result set
	while(result.next()) {
		
				
		out.println("<tr>");
			//flight number
			out.print("<td>");
				out.println(result.getString(1));
			out.print("</td>");
			
			//fare
			out.print("<td>");
				out.println(result.getString(2));
			out.print("</td>");
			
			//departs
			out.print("<td>");
				out.println(result.getString(3));
			out.print("</td>");
			
			//arives
			out.print("<td>");
				out.println(result.getString(4));
			out.print("</td>");
			
			//depart time
			out.print("<td>");
				out.println(result.getString(5));
			out.print("</td>");
			
			//arrives time
			out.print("<td>");
				out.println(result.getString(6));
			out.print("</td>");
			
			//operates
			out.print("<td>");
				out.println(result.getString(7));
			out.print("</td>");
			
			//aircraft
			out.print("<td>");
				out.println(result.getString(8));
			out.print("</td>");
			
			//count
			out.print("<td>");
				out.println(result.getString(9));
			out.print("</td>");
		
		out.println("</tr>");
		
	}
	out.print("</table>");
}


%>
</div>
<br> <br>
<button type='button' name='back'><a href='dashboard.jsp'>Back to Dashboard</a></button>
</body>
</html>