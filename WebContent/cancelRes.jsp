<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	<title>View My Reservations</title>
	</head>
	<body>
	
	<% 
	
	Connection con = dbConnect();
	Statement stmt = con.createStatement(); 

	try{
	//delete from makes table
	String str = "DELETE FROM makes WHERE ResNumber = '"+ request.getParameter("res")+"';";
	stmt.executeUpdate(str);
	stmt.close();
	
	//delete from has table
	str = "DELETE FROM has WHERE ResNumber = '"+ request.getParameter("res")+"';";
	stmt.executeUpdate(str);
	stmt.close();
	
	//delete from passengers table
	str = "DELETE FROM passenger WHERE ResNumber = '"+ request.getParameter("res")+"';";
	stmt.executeUpdate(str);
	stmt.close();
	
	//delete from reservations table
	str = "DELETE FROM reservations WHERE ResNumber = '"+ request.getParameter("res")+"';";
	stmt.executeUpdate(str);
	stmt.close();
	con.close();
	
	out.println("<h3>Reservation has been cancelled.</h3>");
	out.println("<a href='ViewMine.jsp'>Back to My Reservations</a>");
	out.println("<br><br><a href='dashboard.jsp'>Back to Dashboard</a>");
	}
	catch(SQLException e){
		out.println(e.getMessage());
	}
	
	
	
	%>
	</body>
	</html>