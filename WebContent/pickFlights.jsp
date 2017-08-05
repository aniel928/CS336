<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Flight Options</title>
<body>
<h1>Flight Options</h1>

<% Connection con = dbConnect();

String tripType = request.getParameter("tripType");
//roundtrip
if(tripType.equals("round")){
	
	//pull in as Dates.
	java.util.Date startdate = new java.util.Date();
	startdate = getDate(request.getParameter("startDate"));
	java.util.Date retdate = new java.util.Date();
	retdate = getDate(request.getParameter("returnDate"));
	
	String startTime = timeOfDay(request.getParameter("departTime"));
	String returnTime = timeOfDay(request.getParameter("returnTime"));
	
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
	String str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(startdate)+"' AND APIDDeparts = '"+request.getParameter("startAirport")+"' AND APIDArrives = '"+request.getParameter("destAirport")+"' AND traverses.FLNumber = flights.FLNumber"+startTime+";";
	
	ResultSet rs = selectRequest(str);
	if(!rs.next()){
		response.sendRedirect("MakeReservation.jsp?error=noneStart&tripType=round&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	} 
	
	boolean early = false;
	boolean extended = false;
	//discount eligible
	if(daysBet(new java.util.Date(),startdate)>30 || diffInDays>=5){
		out.println("Congratulations! Your flight is elible for discounts!<br>");
		if(daysBet(new java.util.Date(),startdate)>30){
			out.println("&emsp; This flight is eligible for a 20% Early Bird Discount.<br>");
			early = true;	
		}
		if(diffInDays>=5){
			out.println("&emsp; This flight is eligible for a 10% Extended Stay Discount.<br>");
			extended = true;
		}
	}
	%>
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
			<% if(early || extended){ %>
				<th> Your Discounted Fare </th>
			<% } %>
		</tr>
		<form method="post" action="book.jsp">
<%
	int i = 0;
	rs.beforeFirst();
	while(rs.next()){
		String time1 = rs.getString(5);
		String time2 = rs.getString(7);
		if(time1.length()!=2){
			time1 = "0"+time1;
		}
		if(time2.length()!=2){
			time2 = "0"+time2;
		}

		
	    DecimalFormat decim = new DecimalFormat("0.00");
	    Double fare = Double.parseDouble(decim.format(rs.getDouble(8)));
			
		out.println("<tr><td><input type='radio' name = 'start' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>$"+fare+"</td>");
		
		if(early){
			fare = Double.parseDouble(decim.format(fare *= .8));
		}
		if(extended){
			fare = Double.parseDouble(decim.format(fare *= .9));
		}
		out.println("<th>$"+fare+"</th></tr>");
		
	}
	
	str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(retdate)+"' AND APIDDeparts = '"+request.getParameter("destAirport")+"' AND APIDArrives = '"+request.getParameter("startAirport")+"' AND traverses.FLNumber = flights.FLNumber"+returnTime+";";
	
	rs = selectRequest(str);
	if(!rs.next()){
		response.sendRedirect("MakeReservation.jsp?error=noneReturn&tripType=round&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	} %>
	
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
			<% if(early || extended){ %>
				<th> Your Discounted Fare </th>
			<% } %>
		</tr>
	<%
		rs.beforeFirst();
		while(rs.next()){
			String time1 = rs.getString(5);
			String time2 = rs.getString(7);
			if(time1.length()!=2){
				time1 = "0"+time1;
			}
			if(time2.length()!=2){
				time2 = "0"+time2;
			}
		    DecimalFormat decim = new DecimalFormat("0.00");
		    Double fare = Double.parseDouble(decim.format(rs.getDouble(8)));
				
			out.println("<tr><td><input type='radio' name = 'return' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>$"+fare+"</td>");
			
			if(early){
				fare = Double.parseDouble(decim.format(fare *= .8));
			}
			if(extended){
				fare = Double.parseDouble(decim.format(fare *= .9));
			}
			out.println("<th>$"+fare+"</th></tr>");
			
		}
		rs.close();
	%>
		</table>
		<input type='hidden' id='tripType' name = 'tripType' value='round'></input>
		<input type='hidden' id='numPass' name = 'numPass' value= '<%out.println(request.getParameter("numPass"));%>'/>
		<input type='hidden' id='account' name = 'account' value= '<%out.println(request.getParameter("account"));%>'/>
		<input type='hidden' id='diffInDays' name = 'diffInDays' value= '<%out.println(request.getParameter("diffInDays"));%>'/>
		<br><br>
		<input type="submit" class = "sub" value="Continue to Passenger Information"/>
	
	</form>
	<%
//	String str = "(Select * from SELECT FLNumber from flieson WHERE FDDays = '"+startDateString+"';"
	
}

//oneway
else if(tripType.equals("oneway")){
	
	String departTime = timeOfDay(request.getParameter("departTime"));
	
	java.util.Date startdate = new java.util.Date();
	startdate = getDate(request.getParameter("startDate"));

	//doesn't allow today either... ok?  - put this back when Pete fixes database
	//if startdate is before today, throw error.
	/*if(startdate.compareTo(new java.util.Date())<0){
		response.sendRedirect("MakeReservation.jsp?error=prior&tripType=round&domintl="+request.getParameter("domintl"));
		return;
	}*/
	
	//Pull outgoing flights from DB and create table
	String str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(startdate)+"' AND APIDDeparts = '"+request.getParameter("startAirport")+"' AND APIDArrives = '"+request.getParameter("destAirport")+"' AND traverses.FLNumber = flights.FLNumber"+ departTime +";";
	ResultSet rs = selectRequest(str);
	if(!rs.next()){
		response.sendRedirect("MakeReservation.jsp?error=none&tripType=oneway&domintl="+request.getParameter("domintl")+"&account="+request.getParameter("account"));
		con.close();
		return;
	}
	boolean early = false;
	//discount eligible
	if(daysBet(new java.util.Date(),startdate)>30){
		out.println("Congratulations! Your flight is elible for discounts!<br>");
		out.println("&emsp; This flight is eligible for a 20% Early Bird Discount.<br>");
	}
	
		
	%>
	
	
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
			<% if(early){ %>
				<th> Your Discounted Fare </th>
			<% } %>
	</tr>
		<form method="post" action="book.jsp">
<%
	int i = 0;
	rs.beforeFirst();
	while(rs.next()){
		String time1 = rs.getString(5);
		String time2 = rs.getString(7);
		if(time1.length()!=2){
			time1 = "0"+time1;
		}
		if(time2.length()!=2){
			time2 = "0"+time2;
		}
			
		DecimalFormat decim = new DecimalFormat("0.00");
		Double fare = Double.parseDouble(decim.format(rs.getDouble(8)));
				
		out.println("<tr><td><input type='radio' name = 'start' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>$"+fare+"</td>");
			
		if(early){
			fare = Double.parseDouble(decim.format(fare *= .8));
		}
		out.println("<th>$"+fare+"</th></tr>");
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
	int cities = 0;
	try{cities = Integer.parseInt(request.getParameter("numcity").trim());}catch(Exception e){out.println("Oops");}
	
	int i=1;
	
	//store airports, dates, and times in array.
	String[] airports = new String[cities+1];
	String[] dates = new String[cities+1];
	String[] times = new String[cities +1];
	
	//starting info
	airports[0] =  request.getParameter("startAirport");
	dates[0] = request.getParameter("startDepart");
	times[0] = timeOfDay(request.getParameter("startTime"));
	
	//Loop for city info
	while(i < cities){
		String city = "airport" + i;
		String date = "dept" + i;
		String time = "time" + i;
		airports[i] = request.getParameter(city);
		dates[i] = request.getParameter(date);
		times[i] = timeOfDay(request.getParameter(time));
		i++;
	}
	boolean early = false;
	if(daysBet(new java.util.Date(),getDate(dates[0]))>30){
		out.println("Congratulations! Your flight is elible for discounts!<br>");
		out.println("&emsp; This flight is eligible for a 20% Early Bird Discount.<br>");
		early = true;
	}
	
	//final info
	airports[cities] = request.getParameter("finalAirport");
		
	for (int j=0; (j<dates.length-1);j++){
		java.util.Date date = getDate(dates[j]);
		//Pull outgoing flights from DB and create table
		String str = "SELECT traverses.FLNumber, APIDDeparts, APIDArrives, TraDptDate, TraDptTime, TraArrDate, TraArrTime, FLFare from traverses, flights WHERE TraDptDate='"+ formatDate(date)+"' AND APIDDeparts = '"+airports[j]+"' AND APIDArrives = '"+airports[j+1]+"' AND traverses.FLNumber = flights.FLNumber"+times[j]+";";
		ResultSet rs = selectRequest(str);
		
		
	//discount eligible
%>
		
		<br> <h3>Choose flight<% out.println(" "+(j+1)+":");%></h3><br>
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
				<% if(early){ %>
					<th> Your Discounted Fare </th>
				<% } %>
			</tr>
			<form method="post" action="book.jsp">
	<%
		if(!rs.next()){
			response.sendRedirect("MakeReservation.jsp?error="+j+"&tripType=multi&domintl="+request.getParameter("domintl")+"&number="+cities+"&account="+request.getParameter("account"));;
			con.close();
			return;	
		}
	
		rs.beforeFirst();

		while(rs.next()){
			String time1 = rs.getString(5);
			String time2 = rs.getString(7);
			if(time1.length()!=2){
				time1 = "0"+time1;
			}
			if(time2.length()!=2){
				time2 = "0"+time2;
			}
				
			DecimalFormat decim = new DecimalFormat("0.00");
			Double fare = Double.parseDouble(decim.format(rs.getDouble(8)));
					
			out.println("<tr><td><input type='radio' name = 'mid"+j+"' value='"+rs.getString(1)+"_"+rs.getString(2)+"_"+rs.getString(4)+"'/></td><td>"+rs.getString(1) + "</td><td>"+rs.getString(2)+"</td><td>" + rs.getString(3)+"</td><td>" + rs.getString(4)+"</td><td>" + time1+":00:00 Local</td><td>" + rs.getString(6)+"</td><td>" + time2+":00:00 Local</td><td>$"+fare+"</td>");
				
			if(early){
				fare = Double.parseDouble(decim.format(fare *= .8));
			}
			out.println("<th>$"+fare+"</th></tr>");
		}
		rs.close();


		%>
			</table>
			<input type='hidden' id='tripType' name = 'tripType' value='multi'/>
			<input type='hidden' id='numPass' name = 'numPass' value= '<%out.println(request.getParameter("numPass"));%>'/>
			<input type='hidden' id='account' name = 'account' value= '<%out.println(request.getParameter("account"));%>'/>
			<input type='hidden' id='numcity' name = 'numcity' value= '<%out.println(request.getParameter("numcity"));%>'/>
			<input type='hidden' id='startDate' name = 'startDate' value= '<%out.println(dates[0]);%>'/>
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