<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Revenue</title>
<body>
<h1>View Revenue</h1>
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
String sortType = request.getParameter("showby").toString();

stmt = con.createStatement();

//build sql query

switch (sortType){
	case ("month"):
		String sortMon = request.getParameter("months").toString();
		String sortYear = request.getParameter("years").toString();
		str = "SELECT * FROM airline.reservations where MONTH(ResDate)= " + sortMon + " AND YEAR(ResDate)= " + sortYear + ";";
		result = stmt.executeQuery(str);
		
		out.println("<table style='width:1000'>");

		//manager page
		
		//Top labels
		out.println("<tr>");
		out.println("<td>");
			out.println("Reservation Nunber");
		out.println("</td>");
		
		out.println("<td>");
			out.println("Date");  
		out.println("</td>");
			
		out.println("<td>");
			out.println("Fare");
		out.println("</td>");
	
		while(result.next()) {
			
			out.println("<tr>");
			
			out.println("<td>");
			out.print(result.getString("ResNumber"));
			out.println("</td>");
			
			out.println("<td>");
			out.print(result.getString("ResDate"));
			out.println("</td>");
			
			out.println("<td>");
			out.print(result.getString("ResTotalFare"));
			out.println("</td>");
			
			out.println("</tr>");
	
		}

						break;
		case ("flight"):
						break;
		case ("airport"):
						break;
		case ("customer"):
						break;
		case ("all"):
		default:
						break;
	}
	con.close();


} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</body>
</html>