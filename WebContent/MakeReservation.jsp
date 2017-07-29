<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Make Reservation</title>
<body>
<h1>Make Reservation</h1>
	
	<%
	try{
		if(request.getParameter("tripType")==null){%>
	
		<form method="get" action="MakeReservation.jsp" enctype=text/plain>
	    
	  		<input type="radio" name="tripType" value="round"/> Round-trip
	  		<br><br>
	  		<input type="radio" name="tripType" value="oneway"/> One-way
	  		<br><br>
	  		<input type="radio" name="tripType" value="multi"/> Multi-city
	  		<br><br>
	  		<input type="submit" value="submit" />
		</form>
		
		<%} 
		else if(request.getParameter("tripType").equals("round")){%>
			Starting Airport
			<select>
			<% Connection con = dbConnect();
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM airports";
			
			
			//Replace below with this one database is setup.  assume airport ID is first column and second is airport name.
			
//			ResultSet result = stmt.executeQuery(str);
			
//			while(result.next()){
//				out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+"</option>");
//			}
				
				
				%>
				<option value ="airport1">Airport 1</option>
				<option value ="airport2">Airport 2</option>
				<option value ="airport3">Airport 3</option>
				<option value ="airport4">Airport 4</option>
				<option value ="airport5">Airport 5</option>
			</select>
			&emsp; &emsp;&emsp;
			Destination Airport
			<select>
				<option value ="airport1">Airport 1</option>
				<option value ="airport2">Airport 2</option>
				<option value ="airport3">Airport 3</option>
				<option value ="airport4">Airport 4</option>
				<option value ="airport5">Airport 5</option>
			</select>
			<br><br>
			Depart Date
			<input type="date" name="startDate"/>
			&emsp;
			Return Date
			<input type="date" name="returnDate"/>
			<br><br>
			Preferred Depart Time
			<select>
				<option value="anytime">Anytime</option>
				<option value="morning">Morning</option>
				<option value="afternoon">Afternoon</option>
				<option value="night">Night</option>
			</select>
			&emsp;
			Preferred Return Time
			<select>
				<option value="anytime">Anytime</option>
				<option value="morning">Morning</option>
				<option value="afternoon">Afternoon</option>
				<option value="night">Night</option>
			</select>
			<br><br>
			<input type="submit"/>
	<% 	}
		else if(request.getParameter("tripType").equals("oneway")){%>
			Starting Airport
			<select>
				<option value ="airport1">Airport 1</option>
				<option value ="airport2">Airport 2</option>
				<option value ="airport3">Airport 3</option>
				<option value ="airport4">Airport 4</option>
				<option value ="airport5">Airport 5</option>
			</select>
			<br><br>
			Destination Airport
			<select>
				<option value ="airport1">Airport 1</option>
				<option value ="airport2">Airport 2</option>
				<option value ="airport3">Airport 3</option>
				<option value ="airport4">Airport 4</option>
				<option value ="airport5">Airport 5</option>
			</select>
			<br><br>
			Depart Date
			<input type="date" name="startDate"/>
			<br><br>
			Preferred Depart Time
			<select>
				<option value="anytime">Anytime</option>
				<option value="morning">Morning</option>
				<option value="afternoon">Afternoon</option>
				<option value="night">Night</option>
			</select>
			<br><br>
			<input type="submit"/>
		<%}
		
		else if(request.getParameter("tripType").equals("multi")){
			
			if(request.getParameter("number")==null){%>
				<form method="get" action="MakeReservation.jsp">
					<label>How many cities do you want to visit?</label>
					<p>(If you're coming back to the original airport, include that as a city.)</p>
					<select name="number">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
					<input type='hidden' id='tripType' name = 'tripType' value='multi'></input>
					<br><br>
					<input type="submit">
				</form>
				
			
			<%}
			else{
				int i = 0;%>
				Starting Airport<br>
				<select>
					<option value ="airport1">Airport 1</option>
					<option value ="airport2">Airport 2</option>
					<option value ="airport3">Airport 3</option>
					<option value ="airport4">Airport 4</option>
					<option value ="airport5">Airport 5</option>
				</select>
				<br><br>
				
<%				while(i < Integer.parseInt(request.getParameter("number"))){
					if( (i == ((Integer.parseInt(request.getParameter("number")))-1))){
						out.println("Final Destination Airport<br>");
					}
					else{
						out.println("City #" + (i+1) + "<br>");
					}
					out.println("<select><br><option value ='airport1'>Airport 1</option><br><option value ='airport2'>Airport 2</option><br><option value ='airport3'>Airport 3</option><br><option value ='airport4'>Airport 4</option><br><option value ='airport5'>Airport 5</option></select><br><br>");
					i++;
				}
				out.println("<input type='submit'/>");	
			}
			%>
			
		<% 	
		}
	}
	catch(Exception e){
		out.println(e.getMessage());
	}
	%>
</body>
</html>