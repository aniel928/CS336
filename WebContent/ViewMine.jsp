<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	<title>View My Reservations</title>
	</head>
	<body>
	<h1> My Reservations</h1>
	<% 
	
	if(session.getAttribute("type").equals("customer")){
		String str = "SELECT makes.ResNumber, ResDate, min(DateOfFlight) from makes, has, reservations where account_no ='"+session.getAttribute("account_no")+"' and reservations.ResNumber = makes.ResNumber and reservations.ResNumber = has.ResNumber and makes.ResNumber = has.ResNumber group by makes.ResNumber";
		
		ResultSet rs = selectRequest(str);
		
		out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Date Reservation Made</th><th>First Date of Travel</th><th>Itinerary</th><th>Cancel</th</tr>");
		
		while(rs.next()){
			out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td>");
			out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
			out.println("<td><a href='cancelRes.jsp?res="+rs.getString(1)+"'>Cancel Reservation</a></td></tr>");
		}
		out.println("</table>");	
	}	
	else{
		String str = "SELECT makes.ResNumber, account_no, ResDate, min(DateOfFlight) from makes, has, reservations where CSR ='"+session.getAttribute("ssn")+"' and reservations.ResNumber = makes.ResNumber and reservations.ResNumber = has.ResNumber and makes.ResNumber = has.ResNumber group by makes.ResNumber"; 
	
		ResultSet rs = selectRequest(str);
		
		out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Account Number</th><th>Date Reservation Made</th><th>First Date of Travel</th></tr>");
		
		while(rs.next()){
			out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td>");
	//		out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
	//		out.println("<td><a href='cancelRes.jsp?res="+rs.getString(1)+"'>Cancel Reservation</a></td></tr>");
		}
		out.println("</table>");	
	
	}
	
	%>
	
	</body>
	</html>