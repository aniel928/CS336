<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Flights</title>
<body>
<h1>View Current Flights</h1>

	<%if(request.getParameter("view")==null){

		if(session.getAttribute("type").equals("customer")){
			
			out.println("Best Selling flights goes here later");
			
		} else{%>
			<form method="post" action="ViewFlights.jsp">
				<select name="view">
					<option value="all">All Flights</option>
					<option value="active">Most Active Flights.</option>
					<option value="cust">Customer List by Flight Number</option>
					<option value="airport">Flight by Airport</option>
					<option value="ontime">On-Time Flights</option>
					<option value="delayed">Delayed Flights></option>
					<option value="bestsell">Best Selling</option>
				</select>
				<input type="submit"/>
			</form>
		<%} 
		}

	else{
		String view = request.getParameter("view");
		
		if(view.equals("all")){
			out.println("All selected.");
		}
		else if(view.equals("active")){
			out.println("Active selected.");
		}
		else if(view.equals("cust")){
			out.println("Customer selected.");
		}
		else if(view.equals("airport")){
			out.println("Airport selected.");
		}
		else if(view.equals("ontime")){
			out.println("On Time selected.");
		}
		else if(view.equals("delayed")){
			out.println("Delayed selected.");
		}
		else if(view.equals("bestsell")){
			out.println("Best Selling selected.");
		}
		else{
			out.println("Error.");			
		}
	
	}

%>



</body>
</html>