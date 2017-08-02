<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Dashboard</title>
<body>
<h1>View Reservation</h1>
<%
Connection con = dbConnect();
if(session.getAttribute("type").equals("customer")){
	//connect to database
	
	//String str = "SELECT * from reservations where ResNum in (SELECT ResNumber FROM has WHERE account_no='"+ session.getAttribute("account_no") +"');";

	out.println("Customer view.  Waiting on reservations table in DB");
	//Run the query against the database.
	//ResultSet result = stmt.executeQuery(str);
	
//	while(result.next()){
		//print out the table of reservations.
//	}
	
}
else{
	out.println("Employee and Manager view<br><br>");
	out.println("Filter By:")	;
	out.println("<form method='post' action='ViewReservations.jsp'><select><option value='cust_name'>Customer Name</option><option value='flight_num'>Flight Number</option><input type='submit' </form>");
	
}
	con.close(); %>
</body>
</html>