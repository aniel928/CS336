<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Flight Options</title>
<body>
<h1>Flight Options</h1>

<% Connection con = dbConnect();

String tripType = request.getParameter("tripType");
//roundtrip
if(tripType.equals("round")){
	out.println("acocunt" +request.getParameter("account"));
	
	
	if((request.getParameter("startDate").isEmpty()) || (request.getParameter("returnDate").isEmpty()) || (request.getParameter("departTime").isEmpty()) || (request.getParameter("returnTime").isEmpty()) || (request.getParameter("numPass").isEmpty())){
		response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=round&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	}
	
	//pull in as Dates.
	java.util.Date startdate = new java.util.Date();
	startdate = getDate(request.getParameter("startDate"));
	java.util.Date retdate = new java.util.Date();
	retdate = getDate(request.getParameter("returnDate"));
	
	//is it ok that you can't fly in and out on same day?  Very difficult to code otherwise.
	//if startdate after ret date, return error.
	if((startdate.compareTo(retdate)>0)){
		response.sendRedirect("MakeReservation.jsp?error=dates&tripType=round&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));;
		con.close();
		return;
	}
	//if startdate equals retdate, trip too short
	if(startdate.compareTo(retdate)==0){
		response.sendRedirect("MakeReservation.jsp?error=short&tripType=round&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	}
	
	//get difference in days
	int diffInDays = -1;
	diffInDays = daysBet(startdate, retdate);
	
	//if diff in days is more than 30, trip too long
	if(diffInDays>30){
		response.sendRedirect("MakeReservation.jsp?error=long&tripType=round&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	}
	//doesn't allow today either... ok?  - put this back when Pete fixes database
	//if startdate is before today, throw error.
/*	if(startdate.compareTo(new java.util.Date())<0){
		response.sendRedirect("MakeReservation.jsp?error=prior&tripType=round&domintl="+request.getParameter("domintl"));
		return;
	}*/

	//Pull outgoing flights from DB and create table
	String str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(startdate)+"' AND APIDDeparts = '"+request.getParameter("startAirport")+"' AND APIDArrives = '"+request.getParameter("destAirport")+"' AND traverses.FLNumber = flights.FLNumber;";

	ResultSet rs = selectRequest(str);%>
	
	<br> <h3>Choose your origin flight:</h3><br>
	<table class='datatable'>
		<tr>
			<th>Select Flight</th>
			<th>Flight Number</th>
			<th>Start Airport</th>
			<th>Destination Airport</th>
			<th>Depart Date</th>
			<th>Depart Time</th>
			<th>Arrive Date</th>
			<th>Arrive Time</th>
			<th>Fare</th>
			<th>Advance Discount</th>
		</tr>
		<form method="post" action="book.jsp">
<%
	int i = 0;
	while(rs.next()){
		String time1 = rs.getString(5);
		String time2 = rs.getString(7);
		if(time1.length()!=2){
			time1 = "0"+time1;
		}
		if(time2.length()!=2){
			time2 = "0"+time2;
		}
			
		out.println("<tr><td><input type='radio' name = 'start' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>"+rs.getString(8)+"</td>");
		if(daysBet(new java.util.Date(),startdate)>30){
			out.println("<td> Eligible for Discount </td></tr>");					
		}
		else{
			out.println("<td></td></tr>");
		}
	}
	
	str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(retdate)+"' AND APIDDeparts = '"+request.getParameter("destAirport")+"' AND APIDArrives = '"+request.getParameter("startAirport")+"' AND traverses.FLNumber = flights.FLNumber;";
	
	rs = selectRequest(str);%>
	
	</table>
	<br><br><h3>Choose your return flight:</h3><br>
	<table class='datatable'>
		<tr>
			<th>Select Flight</th>
			<th>Flight Number</th>
			<th>Start Airport</th>
			<th>Destination Airport</th>
			<th>Depart Date</th>
			<th>Depart Time</th>
			<th>Arrive Date</th>
			<th>Arrive Time</th>
			<th>Fare</th>
			<th>Advance Discount</th>
		</tr>
	<%

		while(rs.next()){
			String time1 = rs.getString(5);
			String time2 = rs.getString(7);
			if(time1.length()!=2){
				time1 = "0"+time1;
			}
			if(time2.length()!=2){
				time2 = "0"+time2;
			}
			out.println("<tr><td><input type='radio' name = 'return' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>"+rs.getString(8)+"</td>");
			if(daysBet(new java.util.Date(),startdate)>30){
				out.println("<td> Eligible for Discount </td></tr>");					
			}
			else{
				out.println("<td></td></tr>");
			}
		}
		rs.close();
	%>
		</table>
		<input type='hidden' id='tripType' name = 'tripType' value='round'></input>
		<input type='hidden' id='numPass' name = 'numPass' value= '<%out.println(request.getParameter("numPass"));%>'/>
		<input type='hidden' id='account' name = 'account' value= '<%out.println(request.getParameter("account"));%>'/>
		<br><br>
		<input type="submit" class = "sub" value="Continue to Passenger Information"/>
	
	</form>
	<%
//	String str = "(Select * from SELECT FLNumber from flieson WHERE FDDays = '"+startDateString+"';"
	
}

//oneway
else if(tripType.equals("oneway")){
	if((request.getParameter("startAirport").isEmpty()) || (request.getParameter("destAirport").isEmpty()) || (request.getParameter("startDate").isEmpty()) || (request.getParameter("departTime").isEmpty()) || (request.getParameter("numPass").isEmpty())){		
		response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=oneway&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	}
	
	java.util.Date startdate = new java.util.Date();
	startdate = getDate(request.getParameter("startDate"));

	//doesn't allow today either... ok?  - put this back when Pete fixes database
	//if startdate is before today, throw error.
	/*if(startdate.compareTo(new java.util.Date())<0){
		response.sendRedirect("MakeReservation.jsp?error=prior&tripType=round&domintl="+request.getParameter("domintl"));
		return;
	}*/
	
	//Pull outgoing flights from DB and create table
	String str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(startdate)+"' AND APIDDeparts = '"+request.getParameter("startAirport")+"' AND APIDArrives = '"+request.getParameter("destAirport")+"' AND traverses.FLNumber = flights.FLNumber;";

	ResultSet rs = selectRequest(str);%>
	
	<br> <h3>Choose your origin flight:</h3><br>
	<table class='datatable'>
		<tr>
			<th>Select Flight</th>
			<th>Flight Number</th>
			<th>Start Airport</th>
			<th>Destination Airport</th>
			<th>Depart Date</th>
			<th>Depart Time</th>
			<th>Arrive Date</th>
			<th>Arrive Time</th>
			<th>Fare</th>
			<th>Advance Discount</th>
		</tr>
		<form method="post" action="book.jsp">
<%
	int i = 0;
	while(rs.next()){
		String time1 = rs.getString(5);
		String time2 = rs.getString(7);
		if(time1.length()!=2){
			time1 = "0"+time1;
		}
		if(time2.length()!=2){
			time2 = "0"+time2;
		}
			
		out.println("<tr><td><input type='radio' name = 'start' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>"+rs.getString(8)+"</td>");
		if(daysBet(new java.util.Date(),startdate)>30){
			out.println("<td> Eligible for Discount </td></tr>");					
		}
		else{
			out.println("<td></td></tr>");
		}
	}
	rs.close();
	%>
		</table>
		<input type='hidden' id='tripType' name = 'tripType' value='oneway'/>
		<input type='hidden' id='numPass' name = 'numPass' value= '<%out.println(request.getParameter("numPass"));%>'/>
		<input type='hidden' id='account' name = 'account' value= '<%out.println(request.getParameter("account"));%>'/>
		<br><br>
		<input type="submit" class = "sub" value="Continue to Passenger Information"/>
	
	</form>
	
	

	<%
}









































//multicity
else if(tripType.equals("multi")){
	out.println("multi<br>");
	out.println("account: "+request.getParameter("account"));
	int cities = 0;
	out.println("city: "+ request.getParameter("numcity")+".");
	try{cities = Integer.parseInt(request.getParameter("numcity").trim());}catch(Exception e){out.println("Oops");}
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
	
	//print them all to screen.
	for(int j=0; j<cities;j++){
		if(airports[j].equals("") || dates[j].equals("") || times[j].equals("") || request.getParameter("numPass").isEmpty()){
			response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=multi&domintl="+request.getParameter("domintl")+"&number="+cities+"&account="+request.getParameter("account"));;
			con.close();
			return;
		}
	}
	
/* 	if(airports[cities].equals("") || times[cities].equals("")){
		response.sendRedirect("MakeReservation.jsp?error=allreq&tripType=multi&domintl="+request.getParameter("domintl")+"&number="+cities+"&account="+request.getParameter("account"));;
		con.close();
		return;
	}
 */	for(int j=0; j<=cities;j++){
		out.println(airports[j]);
		if(j!=cities){
			out.println(dates[j]);
			out.println(times[j]);
		}
		out.println("<br>");
	}

	
	for (int j=0; (j<dates.length-1);j++){
		java.util.Date date = getDate(dates[j]);
		//Pull outgoing flights from DB and create table
		String str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(date)+"' AND APIDDeparts = '"+airports[j]+"' AND APIDArrives = '"+airports[j+1]+"' AND traverses.FLNumber = flights.FLNumber;";

		ResultSet rs = selectRequest(str);%>
		
		<br> <h3>Choose your flight:</h3><br>
		<table class='datatable'>
			<tr>
				<th>Select Flight</th>
				<th>Flight Number</th>
				<th>Start Airport</th>
				<th>Destination Airport</th>
				<th>Depart Date</th>
				<th>Depart Time</th>
				<th>Arrive Date</th>
				<th>Arrive Time</th>
				<th>Fare</th>
				<th>Advance Discount</th>
			</tr>
			<form method="post" action="book.jsp">
	<%
		while(rs.next()){
			String time1 = rs.getString(5);
			String time2 = rs.getString(7);
			if(time1.length()!=2){
				time1 = "0"+time1;
			}
			if(time2.length()!=2){
				time2 = "0"+time2;
			}
				
			out.println("<tr><td><input type='radio' name = 'mid"+(j)+"' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>"+rs.getString(8)+"</td>");
			if(daysBet(new java.util.Date(),getDate(dates[j]))>30){
				out.println("<td> Eligible for Discount </td></tr>");					
			}
			else{
				out.println("<td></td></tr>");
			}
		}
		rs.close();


		%>
			</table>
			<input type='hidden' id='tripType' name = 'tripType' value='multi'/>
			<input type='hidden' id='numPass' name = 'numPass' value= '<%out.println(request.getParameter("numPass"));%>'/>
			<input type='hidden' id='account' name = 'account' value= '<%out.println(request.getParameter("account"));%>'/>
			<input type='hidden' id='numcity' name = 'numcity' value= '<%out.println(request.getParameter("numcity"));%>'/>
			<br><br>
		
	<% 	
	}
	%><input type="submit" class = "sub" value="Continue to Passenger Information"/>
	
	</form><%
}

else{
	out.println("uh oh");
}

con.close();
%>


</body>