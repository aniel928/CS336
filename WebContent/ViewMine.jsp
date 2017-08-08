<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	<title>View My Reservations</title>
	</head>
	<body>
	<h1> My Reservations</h1>
	<% 
	java.util.Date today = new java.util.Date(); 
	String filter = "all";
	if(request.getParameter("filter") != null){
		filter = request.getParameter("filter");
			
	}
	%>
	<form method='post' action='ViewMine.jsp'>
	<select name = 'filter'>
		<option value = 'all'<% if(filter.equals("all")){out.println(" selected ");} %> />All Reservations
		<option value = 'future'<% if(filter.equals("future")){out.println(" selected ");} %> />Future Reservations
		<option value = 'past'<% if(filter.equals("past")){out.println(" selected ");} %> />Past Reservations
	</select>
	<input type = 'submit'/>
	</form>
	<br><br>
	
	<%
	if(session.getAttribute("type").equals("customer")){
		String str = "SELECT makes.ResNumber, ResDate, min(DateOfFlight) from makes, has, reservations where account_no ='"+session.getAttribute("account_no")+"' and reservations.ResNumber = makes.ResNumber and reservations.ResNumber = has.ResNumber and makes.ResNumber = has.ResNumber group by makes.ResNumber order by dateOfFlight";
		ResultSet rs = selectRequest(str);
		
		out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Date Reservation Made</th><th>First Date of Travel</th><th>Itinerary</th><th>Cancel</th</tr>");
		
		while(rs.next()){
			if (filter.equals("all")){
				out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td>");
				out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
				if(getDate(rs.getString(3)).after(today)){
					out.println("<td><a href='cancelRes.jsp?res="+rs.getString(1)+"'>Cancel Reservation</a></td></tr>");
				}
				else{
					out.println("<td></td></tr>");
				}
			}
			else if(filter.equals("past")){
				if(getDate(rs.getString(3)).before(today)){
					out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td>");
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
					out.println("<td></td></tr>");					
				}
			}
			else if(filter.equals("future")){
				if(getDate(rs.getString(3)).after(today)){
					out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td>");
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
					out.println("<td><a href='cancelRes.jsp?res="+rs.getString(1)+"'>Cancel Reservation</a></td></tr>");			
				}
			}
		}
		out.println("</table>");	
	}	
	else{
		String str = "SELECT makes.ResNumber, account_no, ResDate, min(DateOfFlight) from makes, has, reservations where CSR ='"+session.getAttribute("ssn")+"' and reservations.ResNumber = makes.ResNumber and reservations.ResNumber = has.ResNumber and makes.ResNumber = has.ResNumber group by makes.ResNumber order by dateOfFlight"; 
	
		ResultSet rs = selectRequest(str);
		
		out.println("<table class='datatable'><tr><th>Reservation Number</th><th>Account Number</th><th>Date Reservation Made</th><th>First Date of Travel</th><th>Customer Itinerary</th><th>Cancel</th></tr>");
		
		while(rs.next()){
			if(filter.equals("all")){
				out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td>");
				if(getDate(rs.getString(4)).after(today)){
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
							out.println("<td><a href='cancelRes.jsp?res="+rs.getString(1)+"'>Cancel Reservation</a></td></tr>");
					}
				else{
					out.println("<td></td></tr>");
				}
			}
			else if(filter.equals("past")){
				if(getDate(rs.getString(4)).before(today)){
					out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td>");
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
					out.println("<td></td></tr>");
				}
			}
			else if(filter.equals("future")){
				if(getDate(rs.getString(4)).after(today)){
					out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td>");
					out.println("<td><a href='itinerary.jsp?num="+rs.getString(1)+"'>View Itinerary</a></td>");
					out.println("<td><a href='cancelRes.jsp?res="+rs.getString(1)+"'>Cancel Reservation</a></td></tr>");
				}
			}
		}
		out.println("</table>");	
	
	}
	
	%>
	 
	 <button type='button' name='back' onclick='history.back()''>Go Back</button>
	
	<br><br><button type='button' name='back'><a href='dashboard.jsp'>Back to Dashboard</a></button>
	 