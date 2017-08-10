<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Dashboard</title>
<body>
<div class="trans">
<h1>View Reservation</h1>
<%
	String filter = "all";
	if(request.getParameter("filter") != null){
		filter = request.getParameter("filter");
			
	}
	%>
	
	<form method='post' action='ViewReservation.jsp'>
	<select name = 'filter'>
		<option value = 'all'<% if(filter.equals("all")){out.println(" selected ");} %> />All Reservations
		<option value = 'acct'<% if(filter.equals("acct")){out.println(" selected ");} %> />Reservations by Account Number
		<option value = 'flight'<% if(filter.equals("flight")){out.println(" selected ");} %> />Reservations by Flight Number
	</select>
	<input type = 'submit'/>
	</form>
	<br><br>

<% 

	if(filter.equals("all")){
		out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Reservation Made</th><th>account Number</th><th>Number Of Passengers</th><th>Date Of Flight</th><th> Flight Number</th><th>Customer Itinerary</th></tr>");
		String str = "SELECT reservations.ResNumber, ResDate, account_no, count(PassName), DateOfFlight, FLNumber FROM reservations, has, makes, passenger where reservations.ResNumber = has.ResNumber AND reservations.ResNumber = makes.ResNumber AND reservations.ResNumber = passenger.ResNumber group by reservations.ResNumber, FLNumber, DateOFFlight order by ResNumber, DateOfFlight";
		ResultSet rs = selectRequest(str);
		String resno = "";
		String color = "#80c1ca";
		while(rs.next()){
			if(resno.equals(rs.getString(1))){
				out.println("<tr style='background-color:"+color+"'><td></td><td></td><td></td><td></td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td></td></tr>");
			}
			else{
				if(color.equals("#80c1ca")){
					color = "#ddf5f8";
				}else{
					color = "#80c1ca";
				}
				out.println("<tr style='background-color:"+color+"'><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td>");
				out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td></tr>");
			}		
			resno = rs.getString(1);
			
		}
	}
	else if (filter.equals("acct")){
		%>
		Account Number 
		<form method='post' action='ViewReservation.jsp?filter=acct'><input type='text' name='acctnum' <% if(request.getParameter("acctnum")!=null){out.println(" value='"+request.getParameter("acctnum")+"'");} %>/><input type='submit' value='filter'/></form> 
		<br><br><%
		if(request.getParameter("acctnum") != null){
			
			out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Reservation Made</th><th>account Number</th><th>Number Of Passengers</th><th>Date Of Flight</th><th> Flight Number</th><th>Customer Itinerary</th></tr>");
			String str = "SELECT reservations.ResNumber, ResDate, account_no, count(PassName), DateOfFlight, FLNumber FROM reservations, has, makes, passenger where reservations.ResNumber = has.ResNumber AND reservations.ResNumber = makes.ResNumber AND reservations.ResNumber = passenger.ResNumber and account_no='"+request.getParameter("acctnum")+"' group by reservations.ResNumber, FLNumber, DateOFFlight order by ResNumber, DateOfFlight";
			ResultSet rs = selectRequest(str);
			String resno = "";
			String color = "#80c1ca";
			while(rs.next()){
				if(resno.equals(rs.getString(1))){
					out.println("<tr style='background-color:"+color+"'><td></td><td></td><td></td><td></td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td></td></tr>");
				}
				else{
					if(color.equals("#80c1ca")){
						color = "#ddf5f8";
					}else{
						color = "#80c1ca";
					}
					out.println("<tr style='background-color:"+color+"'><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td>");
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td></tr>");
					}		
				resno = rs.getString(1);
				
			}
			
		}
	}
	else if (filter.equals("flight")){
		%>
		Flight Number 
		<form method='post' action='ViewReservation.jsp?filter=flight'><input type='text' name='flight' <% if(request.getParameter("flight")!=null){out.println(" value='"+request.getParameter("flight")+"'");} %>/><input type='submit' value='filter'/></form> 
		<br><br><%
		if(request.getParameter("flight") != null){
			
			out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Reservation Made</th><th>account Number</th><th>Number Of Passengers</th><th>Date Of Flight</th><th> Flight Number</th><th>Customer Itinerary</th></tr>");
			String str = "SELECT reservations.ResNumber, ResDate, account_no, count(PassName), DateOfFlight, FLNumber FROM reservations, has, makes, passenger where reservations.ResNumber = has.ResNumber AND reservations.ResNumber = makes.ResNumber AND reservations.ResNumber = passenger.ResNumber AND FLNumber="+request.getParameter("flight")+" group by reservations.ResNumber, FLNumber, DateOFFlight order by ResNumber, DateOfFlight";
			ResultSet rs = selectRequest(str);
			String resno = "";
			String color = "#80c1ca";
			while(rs.next()){
				if(resno.equals(rs.getString(1))){
					out.println("<tr style='background-color:"+color+"'><td></td><td></td><td></td><td></td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td></td></tr>");
				}
				else{
					if(color.equals("#80c1ca")){
						color = "#ddf5f8";
					}else{
						color = "#80c1ca";
					}
					out.println("<tr style='background-color:"+color+"'><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td>");
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td></tr>");
				}		
				resno = rs.getString(1);
				
			}
			
		}	
	}


%>
</div>
</body>
<button type='button' name='back' onclick='history.back()''>Go Back</button>

<br><br><button type='button' name='back'><a href='dashboard.jsp'>Back to Dashboard</a></button>

</html>