<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Make Reservation</title>
<body>
<h1>Make Reservation</h1>
	
	<%
	try{
	//Start page - pick a travel type
		if(request.getParameter("tripType")==null){%>
		
			<form method="get" action="MakeReservation.jsp" enctype=text/plain>
		    	Trip Type:<br><br>
		  		<input type="radio" name="tripType" value="round" checked="true"/> Round-trip
		  		<br><br>
		  		<input type="radio" name="tripType" value="oneway"/> One-way
		  		<br><br>
		  		<input type="radio" name="tripType" value="multi"/> Multi-city
		  		<br><br><br><br>
		  		Type of Travel (not applicable for multi-city):<br><br>
		  		
		  		<input type="radio" name="domintl" value="domestic" checked="true"/> Domestic
		  		<br><br>
		  		<input type="radio" name="domintl" value="international"/> International
		  		<br><br>
		  		<input type="submit" value="submit" />
		  		<br><br>
			</form>
		
		<%} 
		
		else if(request.getParameter("tripType").equals("round")){
			if(request.getParameter("error")!=null){
				if(request.getParameter("error").equals("allreq")){				
					out.println("<p style='color: red'><b>All fields are required, please try again.</b></p>");
				}
			}
				String country=null;
			//check for domestic vs international and set the WHERE clause appropriately	
			if(request.getParameter("domintl").equals("domestic")){
				country = "WHERE APCountry = 'United States'";
			}
			else{
				country = "WHERE APCountry <> 'United States'";
			}
			
			
			%>
			<form method="post" action="pickFlights.jsp">
			<table>
			<tr><td>Starting Airport
			<select name="startAirport">
			<% Connection con = dbConnect();
			Statement stmt = con.createStatement();
			//for depart, always start in US?
			String str1 = "select * from airports where APCountry = 'United States' order by APName;";
			//for arrival
			String str2 = "SELECT * FROM airports " + country + " order by APName;";
				
			
			//Replace below with this one database is setup.  assume airport ID is first column and second is airport name.
			
			ResultSet result = stmt.executeQuery(str1);
			
			while(result.next()){
				out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
			}
				
				
				%>
			</select>
			
			</td>
			<td>&emsp;</td>
			<td>
			Destination Airport
			<select name="destAirport">
				<%result = stmt.executeQuery(str2);
				
				while(result.next()){
					out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
				}%>
			
				</select>
			</td></tr>
			<tr><td>
			Depart Date
			<input type="date" name="startDate"/>
			</td>
			<td>&emsp;</td>
			<td>
			Return Date
			<input type="date" name="returnDate"/>
			</td>
			</tr>
			<tr>
			<td>
			Preferred Depart Time
			<select name="departTime">
				<option value="anytime">Anytime</option>
				<option value="morning">Morning</option>
				<option value="afternoon">Afternoon</option>
				<option value="night">Night</option>
			</select>
			</td>
			<td>&emsp;</td>
			<td>
			Preferred Return Depart Time
			<select name = "returnTime">
				<option value="anytime">Anytime</option>
				<option value="morning">Morning</option>
				<option value="afternoon">Afternoon</option>
				<option value="night">Night</option>
			</select>
			</td>
			</tr>
			<tr><td>Number of Passengers:<input type="text"/ name="numPass"></td><td>&emsp;</td><td>
			&emsp;</td>
			</tr>
			</table>
			<br><br>
			<input type='hidden' id='tripType' name = 'tripType' value='round'></input>
			<input type='hidden' id='domintl' name = 'doimntl' value=<% request.getParameter("domintl");%>></input>
			<input type="submit"/>
			</form>
	<% 	}
		else if(request.getParameter("tripType").equals("oneway")){
			if(request.getParameter("error")!=null){
				if(request.getParameter("error").equals("allreq")){				
					out.println("<p style='color: red'><b>All fields are required, please try again.</b></p>");
			}
			}
			
			String country=null;
			if(request.getParameter("domintl").equals("domestic")){
				country = "WHERE APCountry = 'United States'";
			}
			else{
				country = "WHERE APCountry <> 'United States'";
			}
			
		%>
			<form method="post" action="pickFlights.jsp">
			Starting Airport
			<select name="startAirport">
			<% Connection con = dbConnect();
				Statement stmt = con.createStatement();
				//for depart, always start in US?
				String str1 = "select * from airports where APCountry = 'United States' order by APName;";
				//for arrival
				String str2 = "SELECT * FROM airports " + country + " order by APName;";
					
				
				//Replace below with this one database is setup.  assume airport ID is first column and second is airport name.
				
				ResultSet result = stmt.executeQuery(str1);
				
				while(result.next()){
					out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
				}
					
					
					%>
					</select>
			<br><br>
			Destination Airport
			<select name="destAirport">
					<%result = stmt.executeQuery(str2);
				
				while(result.next()){
					out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
				}%>
			
		</select>
			<br><br>
			Depart Date
			<input type="date" name="startDate"/>
			<br><br>
			Preferred Depart Time
			<select name="departTime">
				<option value="anytime">Anytime</option>
				<option value="morning">Morning</option>
				<option value="afternoon">Afternoon</option>
				<option value="night">Night</option>
			</select>
			<br><br>
			Number of Passengers:<input type="text"/ name="numPass">
			<input type='hidden' id='tripType' name = 'tripType' value='oneway'></input>
			<input type='hidden' id='domintl' name = 'doimntl' value=<% request.getParameter("domintl");%>></input>
			<input type="submit"/>
			</form>
			
		<%}
		
		else if(request.getParameter("tripType").equals("multi")){
			if(request.getParameter("error")!=null){
				if(request.getParameter("error").equals("allreq")){				
					out.println("<p style='color: red'><b>All fields are required, please try again.</b></p>");
			}
			}
			
			if(request.getParameter("number")==null){%>
				<form method="get" action="MakeReservation.jsp">
					<p>How many cities do you want to visit?</p>
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
				<form method="post" action="pickFlights.jsp">
				<b>Starting Airport</b><br>
				<select name="startAirport">
					<% 	Connection con = dbConnect();
						Statement stmt = con.createStatement();
						//for depart, always start in US?
						String str1 = "select * from airports where APCountry = 'United States' order by APName;";
						//for arrival
						String str2 = "SELECT * FROM airports order by APName;";
							
						
						//Replace below with this one database is setup.  assume airport ID is first column and second is airport name.
						
						ResultSet result = stmt.executeQuery(str1);
						
						while(result.next()){
							out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
						}
				%>
				
						</select><br>Depart Date<br><input name="startDepart" type="date"/><br>
						
						Preferred Depart Time<br>
						<select name="startTime">
							<option value="anytime">Anytime</option>
							<option value="morning">Morning</option>
							<option value="afternoon">Afternoon</option>
							<option value="night">Night</option>
						</select>
						
				<br>
				<%	result = stmt.executeQuery(str2);
					while(i < Integer.parseInt(request.getParameter("number"))){
						if( (i == ((Integer.parseInt(request.getParameter("number")))-1))){
							out.println("<br><b>Final Destination Airport</b><br><select name=\"finalAirport\">");
							while(result.next()){
								out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
							}
							
							out.println("</select><br>Depart Date<br><input name = \"finalDepart\" type=\"date\"/><br>Preferred Depart Time<br><select name = \"finalTime\">"
									+"<option value=\"anytime\">Anytime</option>"
									+"<option value=\"morning\">Morning</option>"
									+"<option value=\"afternoon\">Afternoon</option>"
									+"<option value=\"night\">Night</option></select><br>");
						}
						else{
							out.println("</select><br><b>City #" + (i+1) + "</b><br><select name=\"airport"+(i+1)+"\")>");
							while(result.next()){
								out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
							}
							out.println("</select><br>Depart Date<br><input name = \"dept"+ (i+1) + "\" type = \"date\"/><br>Preferred Depart Time<br><select name = \"time"+(i+1)+"\">"
									+"<option value=\"anytime\">Anytime</option>"
									+"<option value=\"morning\">Morning</option>"
									+"<option value=\"afternoon\">Afternoon</option>"
									+"<option value=\"night\">Night</option></select><br>");

							result.beforeFirst();
						}
						i++;
					}
					out.println("<br>Number of Passengers:<input type=\"text\"/ name=\"numPass\"/>");
					out.println("<br><br><input type='hidden' id='tripType' name = 'tripType' value='multi'></input><input type='hidden' id='numcity' name = 'numcity' value='"+request.getParameter("number")+"'></input><input type='hidden' id='domintl' name = 'doimntl' value='"+request.getParameter("domintl")+"'></input><input type='submit'/></form>");	
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