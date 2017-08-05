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
		  		<%
		  		if(session.getAttribute("type").equals("employee")){
		  			out.println("Account number: <input name='account' type='text'/>");
		  		}
		  		%>
		  		<br><br>
		  		<input type="submit" value="submit" />
		  		<br><br>
			</form>
		
		<%} 
		//RoundTrip page
		else if(request.getParameter("tripType").equals("round")){
			if(request.getParameter("error")!=null){
				if(request.getParameter("error").equals("allreq")){				
					out.println("<p style='color: red'><b>All fields are required, please try again.</b></p>");
				}
				else if(request.getParameter("error").equals("dates")){
					out.println("<p style='color: red'><b>Please check your dates.  Return date should be after start date.</b></p>");					
				}
				else if(request.getParameter("error").equals("prior")){
					out.println("<p style='color: red'><b>Please check your dates.  Start date should not be before today.</b></p>");					
				}
				else if(request.getParameter("error").equals("short")){
					out.println("<p style='color: red'><b>Your trip is too short! There ust be at least one day between start date and return date.</b></p>");					
				}
				else if(request.getParameter("error").equals("long")){
					out.println("<p style='color: red'><b>Your trip is too long! Trip can be a maximum of 30 days.</b></p>");					
				}
				else if(request.getParameter("error").equals("noneStart")){
					out.println("<p style='color: red'><b>No flights match your origin flight information.  Please select different valeus.</b></p>");					
				}
				else if(request.getParameter("error").equals("noneReturn")){
					out.println("<p style='color: red'><b>No flights match your return flight information.  Please select different valeus.</b></p>");					
				}
				else{
					out.println("<p style='color: red'><b>We've encountered an error.  Please try again later.</b></p>");					
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
		
				<table style="all:unset">
				
				<tr><td>Starting Airport
				<select name="startAirport">
				<% 
				//for depart, always start in US?
				String str1 = "select * from airports where APCountry = 'United States' order by APName;";
				//for arrival
				String str2 = "SELECT * FROM airports " + country + " order by APName;";
					
				
				//pull starting airports
				ResultSet result = selectRequest(str1);
				//print airports
				while(result.next()){
					out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
				}	
				result.close();
				%>
				</select>
				
				</td>
				<td>&emsp;</td>
				<td>
				Destination Airport
				<select name="destAirport">
					<%//pull destination airports
					result = selectRequest(str2);
					//print airports
					while(result.next()){
						out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
					}
					result.close();
					%>
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
					<option value="early">Early Morning (12:00a - 4:59a)</option>
					<option value="morning">Morning (5:00a - 11:59a)</option>
					<option value="afternoon">Afternoon (12:00p - 5:59p)</option>
					<option value="night">Evening (6:00p - 11:59p)</option>
					
				</select>
				</td>
				<td>&emsp;</td>
				<td>
				Preferred Return Depart Time
				<select name = "returnTime">
					<option value="anytime">Anytime</option>
					<option value="early">Early Morning (12:00a - 4:59a)</option>
					<option value="morning">Morning (5:00a - 11:59a)</option>
					<option value="afternoon">Afternoon (12:00p - 5:59p)</option>
					<option value="night">Evening (6:00p - 11:59p)</option>
				</select>
				</td>
				</tr>
				<tr><td>Number of Passengers:<input type="text" name="numPass"></td><td>&emsp;</td><td>
				&emsp;</td>
				</tr>
				</table>
				<br><br>
				<input type='hidden' id='tripType' name = 'tripType' value='round'></input>
				<input type='hidden' id='account' name = 'account' value=<% out.println(request.getParameter("account"));%>></input>
				<input type='hidden' id='domintl' name = 'doimntl' value=<% out.println(request.getParameter("domintl"));%>></input>
				<input type="submit"/>
			</form>
	<% 	}
		//Oneway page
		else if(request.getParameter("tripType").equals("oneway")){
			if(request.getParameter("error")!=null){
				if(request.getParameter("error").equals("allreq")){				
					out.println("<p style='color: red'><b>All fields are required, please try again.</b></p>");
				}
				else if(request.getParameter("error").equals("none")){
					out.println("<p style='color: red'><b>No flights match your origin flight information.  Please select different valeus.</b></p>");					
				}
				else{
					out.println("<p style='color: red'><b>We've encountered an error.  Please try again later.</b></p>");					
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
				<% //for depart, always start in US?
					String str1 = "select * from airports where APCountry = 'United States' order by APName;";
					//for arrival
					String str2 = "SELECT * FROM airports " + country + " order by APName;";
						
					//get starting airports
					ResultSet result = selectRequest(str1);
					//print airports
					while(result.next()){
						out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
					}
					result.close();
						
						
						%>
				</select>
				<br><br>
				Destination Airport
				<select name="destAirport">
					<%//get destination airports
					result = selectRequest(str2);
					//print airports
					while(result.next()){
						out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
					}
					result.close();
					%>
					
				</select>
				<br><br>
				Depart Date
				<input type="date" name="startDate"/>
				<br><br>
				Preferred Depart Time
				<select name="departTime">
					<option value="anytime">Anytime</option>
					<option value="early">Early Morning (12:00a - 4:59a)</option>
					<option value="morning">Morning (5:00a - 11:59a)</option>
					<option value="afternoon">Afternoon (12:00p - 5:59p)</option>
					<option value="night">Evening (6:00p - 11:59p)</option>
				</select>
				<br><br>
				Number of Passengers:<input type="text" name="numPass"/>
				<input type='hidden' id='tripType' name = 'tripType' value='oneway'></input>
				<input type='hidden' id='domintl' name = 'doimntl' value=<% out.println(request.getParameter("domintl"));%>></input>
				<input type='hidden' id='account' name = 'account' value=<% out.println(request.getParameter("account"));%>></input>
				<input type="submit"/>
			</form>
			
		<%}
		//Multi-City Page
		else if(request.getParameter("tripType").equals("multi")){
			if(request.getParameter("error")!=null){
				if(request.getParameter("error").equals("allreq")){				
					out.println("<p style='color: red'><b>All fields are required, please try again.</b></p>");
				}
				else {
					int errno = 0;
					try{
						errno = Integer.parseInt(request.getParameter("error"));
						errno++;
					}catch(NumberFormatException e){
						
					}
					out.println("<p style='color: red'><b>No flights match your #"+errno+ " flight. Please try again.</b></p>");					
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
					<input type='hidden' id='account' name = 'account' value= '<%out.println(request.getParameter("account")); %>'/>
					<br><br>
					<input type="submit"/>
				</form>
				
			
			<%}
			else{
				int i = 0;%>
				
				<form method="post" action="pickFlights.jsp">
					
					<b>Starting Airport</b><br>
					<select name="startAirport">
					<% 	//for depart, always start in US?
						String str1 = "select * from airports where APCountry = 'United States' order by APName;";
						//for arrival
						String str2 = "SELECT * FROM airports order by APName;";
							
						//get starting airports
						ResultSet result = selectRequest(str1);
						//print airports
						while(result.next()){
							out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
						}
						result.close();
				%>
				
					</select><br>Depart Date<br><input name="startDepart" type="date"/><br>
					
					Preferred Depart Time<br>
					<select name="startTime">
						<option value="anytime">Anytime</option>
						<option value="early">Early Morning (12:00a - 4:59a)</option>
						<option value="morning">Morning (5:00a - 11:59a)</option>
						<option value="afternoon">Afternoon (12:00p - 5:59p)</option>
						<option value="night">Evening (6:00p - 11:59p)</option>
					</select>
					
					<br>
				<%	//get ALL airports
					result = selectRequest(str2);
					//print everything out for as many cities as chosen
					while(i < Integer.parseInt(request.getParameter("number"))){
						//if last airport
						if( (i == ((Integer.parseInt(request.getParameter("number")))-1))){
							out.println("<br><b>Final Destination Airport</b><br><select name=\"finalAirport\">");
							while(result.next()){
								out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
							}
							
							out.println("</select>");//"<br>Depart Date<br><input name = \"finalDepart\" type=\"date\"/><br>Preferred Depart Time<br><select name = \"finalTime\">"
									//+"<option value=\"anytime\">Anytime</option>"
									//+"<option value=\"early\">Early Morning (12:00a - 4:59a)</option>"
									//+"<option value=\"morning\">Morning (5:00a - 11:59a)</option>"
									//+"<option value=\"afternoon\">Afternoon (12:00p - 5:59p)</option>"
									//+"<option value=\"night\">Evening (6:00p - 11:59p)</option></select><br>");
						}
						//otherwise it's in between start and last
						else{
							out.println("</select><br><b>City #" + (i+1) + "</b><br><select name=\"airport"+(i+1)+"\")>");
							while(result.next()){
								out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
							}
							out.println("</select><br>Depart Date<br><input name = \"dept"+ (i+1) + "\" type = \"date\"/><br>Preferred Depart Time<br><select name = \"time"+(i+1)+"\">"
									+"<option value=\"anytime\">Anytime</option>"
									+"<option value=\"early\">Early Morning (12:00a - 4:59a)</option>"
									+"<option value=\"morning\">Morning (5:00a - 11:59a)</option>"
									+"<option value=\"afternoon\">Afternoon (12:00p - 5:59p)</option>"
									+"<option value=\"night\">Evening (6:00p - 11:59p)</option></select><br>");

							result.beforeFirst();
						}
						i++;
					}
					result.close();
					%>

					<br>Number of Passengers:<input type="text" name="numPass"/>
					<br><br>
	<% 				out.println("a"+	request.getParameter("account"));%>
					
					<input type='hidden' id='tripType' name = 'tripType' value='multi'></input>
					<input type='hidden' id='numcity' name = 'numcity' value=<% out.println(request.getParameter("number"));%>/>
					<input type='hidden' id='account' name = 'account' value='<% out.println(request.getParameter("account"));%>'/>
					<input type='hidden' id='domintl' name = 'domintl' value=<% out.println(request.getParameter("domintl"));%>/>
					<input type='submit'/>
				</form>	
			
			
			
		<%
			}
		}
	}
	catch(Exception e){
		out.println(e.getMessage());
	}
	%>
</body>
</html>