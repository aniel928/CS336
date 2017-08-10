<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
<!-- Author: Catherine Yeager-->
<title>View Revenue</title>
<body>


<div class="trans">
<h1>View Revenue</h1>
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

	String sortMon = request.getParameter("months").toString();
		String sortYear = request.getParameter("years").toString();
		str = "SELECT * FROM airline.reservations where MONTH(ResDate)= " + sortMon + " AND YEAR(ResDate)= " + sortYear + ";";
		result = stmt.executeQuery(str);
		
		out.println("<table class= 'datatable'>");

		
		//manager page
		
		//Top labels
		out.println("<tr>");
		out.println("<th>");
			out.println("Reservation Nunber");
		out.println("</th>");
		
		out.println("<th>");
			out.println("Date");  
		out.println("</th>");
			
		out.println("<th>");
			out.println("Fare");
		out.println("</th>");
	
		while(result.next()) {
			
			Double cost = result.getDouble("ResTotalFare") + result.getInt("ResBookingFee");
			out.println("<tr>");
			
			out.println("<td>");
			out.print(result.getString("ResNumber"));
			out.println("</td>");
			
			out.println("<td>");
			out.print(result.getString("ResDate"));
			out.println("</td>");
			
			out.println("<td>");
			out.print(""+cost);
			out.println("</td>");
			
			out.println("</tr>");
	
		}
		con.close();
} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</div>
</body>
</html>