<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	<title>Itinerary</title>
	</head>
	<body>
	
	<% 
	String res_no = request.getParameter("num");
	
	String str = "select FLNumber, DateOfFlight, FIDeparts, FIDptTime, FIArrives, FIArrTime, ResTotalFare, ResFareRestrictions from flightinfo, reservations, makes, has where account_no='"+session.getAttribute("account_no")+"' AND reservations.ResNumber='"+res_no+"' AND reservations.ResNumber = makes.ResNumber AND makes.ResNumber = has.ResNumber AND has.ResNumber = reservations.ResNumber AND has.FLNumber = flightinfo.FInumber order by DateOfFlight;";

	DecimalFormat decim = new DecimalFormat("0.00");
	
	ResultSet rs = selectRequest(str);
	
	rs.next();
	out.println("<h3>Reservation Number: "+res_no+"</h3>");
	out.println("<h4>Total Fare: $"+Double.parseDouble(decim.format(rs.getDouble(7)))+"</h4>");
	out.println("<h4>Restrictions Applied: "+rs.getString(8)+"</h4>");
	
	out.println("<table class = 'datatable'><tr><th>Flight Number</th><th>Date of Flight</th><th>Depart Airport</th><th>Departure Time</th><th>Arrival Airport</th><th>Arrival Time</th></tr>");
	
	rs.beforeFirst();
	while(rs.next()){
		//Name of first airport
		String str2 = "SELECT APName FROM airports WHERE APID='"+rs.getString(3)+"';";
		ResultSet r = selectRequest(str2);
		r.next();
		
		//Name of second airport
		String air1 = r.getString(1);
		str2 = "SELECT APName FROM airports WHERE APID='"+rs.getString(5)+"';";
		r = selectRequest(str2);
		r.next();
		String air2 = r.getString(1);
		
		String time1 = rs.getString(4);
		String time2 = rs.getString(6);
		if(time1.length()!=2){
			time1 = "0"+time1;
		}
		if(time2.length()!=2){
			time2 = "0"+time2;
		}
		
		out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+air1+"</td><td>"+time1+":00:00"+"</td><td>"+air2+"</td><td>"+time2+":00:00"+"</td></tr>");		
	}
	out.println("</table><br><br>");
	
str = "select PassName, PassSeat, PassMeal from passenger where ResNumber='"+res_no+"';";
	
	//go thorugh and print passengers
	
	ResultSet s = selectRequest(str);
	out.println("<br><div style='border-style:solid;width:500px;padding:20px;background-color: #80c1ca;'><b>Passengers on this flight:</b><br>");
	while(s.next()){
		out.println("<br><div style='padding:10px;border-style:solid;background-color: #ddf5f8;'>Passenger Name: "+s.getString(1)+"<br>Preferred Seat: "+s.getString(2)+"<br>Preferred Meal: "+s.getString(3)+"<br></div>");	
	}
	out.println("</div><br><br>");
	
	
	
	
	
	
	
	%>
	</body>
	</html>