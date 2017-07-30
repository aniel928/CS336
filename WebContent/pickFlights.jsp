<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Flight Options</title>
<body>
<h1>Flight Options</h1>

<% Connection con = dbConnect();

String tripType = request.getParameter("tripType");
//roundtrip
if(tripType.equals("round")){
	if((request.getParameter("startDate").isEmpty()) || (request.getParameter("returnDate").isEmpty()) || (request.getParameter("departTime").isEmpty()) || (request.getParameter("returnTime").isEmpty()) || (request.getParameter("numPass").isEmpty())){
		response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=round&domintl="+request.getParameter("domintl"));
		return;
	}
	out.println("roundtrip");
	out.println(request.getParameter("startAirport"));
	out.println(request.getParameter("destAirport"));
	out.println(request.getParameter("startDate"));
	out.println(request.getParameter("returnDate"));
	out.println(request.getParameter("departTime"));
	out.println(request.getParameter("returnTime"));
	out.println(request.getParameter("numPass"));
}
//oneway
else if(tripType.equals("oneway")){
	if((request.getParameter("startAirport").isEmpty()) || (request.getParameter("destAirport").isEmpty()) || (request.getParameter("startDate").isEmpty()) || (request.getParameter("departTime").isEmpty()) || (request.getParameter("numPass").isEmpty())){		
		response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=oneway&domintl="+request.getParameter("domintl"));
			return;
	}
	out.println("oneway");
	out.println(request.getParameter("startAirport"));
	out.println(request.getParameter("destAirport"));
	out.println(request.getParameter("startDate"));
	out.println(request.getParameter("departTime"));
	out.println(request.getParameter("numPass"));

}
//multicity
else if(tripType.equals("multi")){
	out.println("multi<br>");
	int cities = 0;
	
	try{cities = Integer.parseInt(request.getParameter("numcity"));}catch(Exception e){out.println("Oops");}
	out.println(cities+" cities (+ starting airport)<br>");
	
	int i=1;
	
	//store airports, dates, and times in array.
	String[] airports = new String[cities+1];
	String[] dates = new String[cities+1];
	String[] times = new String[cities +1];
	
	//starting info
	airports[0] =  request.getParameter("startAirport");
	dates[0] = request.getParameter("startDepart");
	times[0] = request.getParameter("startTime");
	
	//Loop for city info
	while(i < cities){
		String city = "airport" + i;
		String date = "dept" + i;
		String time = "time" + i;
		airports[i] = request.getParameter(city);
		dates[i] = request.getParameter(date);
		times[i] = request.getParameter(time);
		i++;
	}
	
	//final info
	airports[cities] = request.getParameter("finalAirport");
	dates[cities] = request.getParameter("finalDepart");
	times[cities] = request.getParameter("finalTime");
	
	//print them all to screen.
	for(int j=0; j<=cities;j++){
		if(airports[j].equals("") || dates[j].equals("") || times[j].equals("") || request.getParameter("numPass").isEmpty()){
			response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=multi&domintl="+request.getParameter("domintl")+"&number="+cities);
			return;
		}
		out.println(airports[j]);
		out.println(dates[j]);
		out.println(times[j]);
		out.println("<br>");
	}
}
else{
	out.println("uh oh");
}%>