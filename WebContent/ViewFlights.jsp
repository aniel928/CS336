<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Flights</title>
<body>
<h1>View Current Flights</h1>


<%if(session.getAttribute("type").equals("customer")){
	
	out.println("Best Selling flights goes here later");
	
} else{%>

	<select>
		<option value="all">All Flights</option>
		<option value="active">Most Active Flights.</option>
		<option value="cust">Customer List by Flight Number</option>
		<option value="airport">Flight by Airport</option>
		<option value="ontime">On-Time Flights</option>
		<option value="delayed">Delayed Flights></option>
	</select>
<% } %>
</body>
</html>