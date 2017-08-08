<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Flights</title>
</head>
<style>
table, th, td {
	border: 1px solid black;
}
td {
	width:10%;
}</style>
<body>

	<%if(request.getParameter("showby")==null){

		if(session.getAttribute("type").toString().equals("customer")){
			out.println("<h1>Popular Flights</h1>");
			out.println("<div id='trans'");
			Connection con;
			Statement stmt;
			String type;
			String str;
			ResultSet result;
			
			con = dbConnect();
			
			stmt = con.createStatement();
			str="SELECT FLnumber, FIDeparts, FIDptTime, FIArrives, FIArrTime,  COUNT(FLNumber) " +
					"FROM airline.has h, airline.passenger p, airline.flightinfo f " +
					"WHERE h.ResNumber=p.ResNumber AND f.FInumber=h.FLNumber GROUP BY FLNumber HAVING COUNT(FLNumber)>3 ORDER BY COUNT(FLNumber) desc;";
			
	 		result = stmt.executeQuery(str);

			out.println("<table style='width:1000'>");
	 		out.println("<tr>");
			out.println("<td>");
				out.println("Flight Number");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Departing Airport");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Arriving Time");  
			out.println("</td>");
		
			out.println("<td>");
				out.println("Arriving Airport");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Arriving Time");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Reservations");  
			out.println("</td>");
		
			out.println("</tr>");
			for(int i=0; i < 5; i++){
				
				
				out.println("<td>");
				out.print(result.getString(1));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(2));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(3) + ":00");
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(4));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(5)+ ":00");
				out.println("</td>");
				out.println("<td>");
				out.println("<form name= 'flightnum' method='post' action = 'CustFlight.jsp'>");
				out.print("<input type='submit' name= 'num' value='"
							+ result.getString(1) + "' style = 'align:center'/>");
				
				out.println("</tr>");
			}
			 out.println("</table>");
			
		} else{%>
			<h1>Select Flights</h1>
			<form method="post" action="ViewFlights.jsp">
				<select id="showby" name = "showby">
					<option value="all">All Flights</option>
					<option value="active">Best Selling</option>
					<option value="airport">Flight by Airport</option>>
					<!--<option value="ontime">On-Time Flights</option>
					<option value="delayed">Delayed Flights></option>
					<option value="bestsell">Best Selling</option> -->
				</select>
					<select name= "airport" id = "airport" class= "inv">
					<% 
					//for depart, always start in US?
					String str1 = "SELECT * FROM airports order by APName;";
						
					
					//pull starting airports
					ResultSet result = selectRequest(str1);
					//print airports
					while(result.next()){
						out.println("<option value = '"+ result.getString(1) + "'>"+result.getString(2)+" (" + result.getString(1)+")</option>");
					}	
					result.close();
					%>
					</select>
					<script>
         		   document
               			.getElementById('showby')
                		.addEventListener('change', function () {
                    		'use strict';
		                    var vis = document.querySelector('.vis'),   
		                    	showby = document.getElementById(this.value);
		                    if (vis !== null) {
		                        vis.className = 'inv';
		                    }
		                    if (showby !== null ) {
		                    	showby.className = 'vis';
		                    }
         	   		});
	       			</script>
				
				
				<input type="submit"/>
			</form>
			
		<%} 
		}

	else{
		Connection con;
		Statement stmt;
		String type;
		String str;
		ResultSet result;
		
		con = dbConnect();
		
		stmt = con.createStatement();
		String view = request.getParameter("showby");
		
		if(view.equals("all")){
				str="SELECT FInumber, FIDeparts, FIDptTime, FIArrives, FIArrTime FROM airline.flightinfo;";
	
		 		result = stmt.executeQuery(str);
	
				out.println("<table style='width:1000'>");
		 		out.println("<tr>");
				out.println("<td>");
					out.println("Flight Number");
				out.println("</td>");
				
				out.println("<td>");
					out.println("Departing Airport");  
				out.println("</td>");
				
				out.println("<td>");
					out.println("Arriving Time");  
				out.println("</td>");
			
				out.println("<td>");
					out.println("Arriving Airport");  
				out.println("</td>");
				
				out.println("<td>");
					out.println("Arriving Time");  
				out.println("</td>");
				
				out.println("<td>");
					out.println("Reservations");  
				out.println("</td>");
			
				out.println("</tr>");
				out.println("<form name= 'flightnum' method='post' action = 'CustFlight.jsp'>");
				while(result.next()) {
					
					
					out.println("<td>");
					out.print(result.getString(1));
					out.println("</td>");
					
					out.println("<td>");
					out.print(result.getString(2));
					out.println("</td>");
					
					out.println("<td>");
					out.print(result.getString(3) + ":00");
					out.println("</td>");
					
					out.println("<td>");
					out.print(result.getString(4));
					out.println("</td>");
					
					out.println("<td>");
					out.print(result.getString(5)+ ":00");
					out.println("</td>");
					
					out.println("<td>");
					out.println("<form name= 'flightnum' method='post' action = 'CustFlight.jsp'>");
					out.print("<input type='submit' name= 'num' value='"
								+ result.getString(1) + "' style = 'align:center'/>");
					out.println("</td>");
					
					out.println("</tr>");
				}
				 out.println("</table>");
				 out.println("</form>");
		}
		else if(view.equals("active")){
			str="SELECT FLnumber, FIDeparts, FIDptTime, FIArrives, FIArrTime,  COUNT(FLNumber) " +
					"FROM airline.has h, airline.passenger p, airline.flightinfo f " +
					"WHERE h.ResNumber=p.ResNumber AND f.FInumber=h.FLNumber GROUP BY FLNumber HAVING COUNT(FLNumber)>3;";
			
	 		result = stmt.executeQuery(str);

			out.println("<table style='width:1000'>");
	 		out.println("<tr>");
			out.println("<td>");
				out.println("Flight Number");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Departing Airport");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Arriving Time");  
			out.println("</td>");
		
			out.println("<td>");
				out.println("Arriving Airport");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Arriving Time");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Reservations");  
			out.println("</td>");
		
			out.println("</tr>");
			while(result.next()) {
				
				
				out.println("<td>");
				out.print(result.getString(1));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(2));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(3) + ":00");
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(4));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(5)+ ":00");
				out.println("</td>");
				out.println("<td>");
				out.println("<form name= 'flightnum' method='post' action = 'CustFlight.jsp'>");
				out.print("<input type='submit' name= 'num' value='"
							+ result.getString(1) + "' style = 'align:center'/>");
				
				out.println("</tr>");
			}
			 out.println("</table>");
		}
		else if(view.equals("cust")){
			out.println("Customer selected.");
		}
		else if(view.equals("airport")){
			str="SELECT FInumber, FIDeparts, FIDptTime, FIArrives, FIArrTime FROM airline.flightinfo WHERE FIDeparts= '"+ request.getParameter("airport")+ "';";
			
	 		result = stmt.executeQuery(str);

			out.println("<table style='width:1000'>");
	 		out.println("<tr>");
			out.println("<td>");
				out.println("Flight Number");
			out.println("</td>");
			
			out.println("<td>");
				out.println("Departing Airport");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Arriving Time");  
			out.println("</td>");
		
			out.println("<td>");
				out.println("Arriving Airport");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Arriving Time");  
			out.println("</td>");
			
			out.println("<td>");
				out.println("Reservations");  
			out.println("</td>");
		
			out.println("</tr>");
			while(result.next()) {
				
				
				out.println("<td>");
				out.print(result.getString(1));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(2));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(3) + ":00");
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(4));
				out.println("</td>");
				
				out.println("<td>");
				out.print(result.getString(5)+ ":00");
				out.println("</td>");
				
				out.println("<td>");
				out.println("<form name= 'flightnum' method='post' action = 'CustFlight.jsp'>");
				out.print("<input type='submit' name= 'num' value='"
							+ result.getString(1) + "' style = 'align:center'/>");
				out.println("</td>");
				
				out.println("</tr>");
			}
		}
		else if(view.equals("ontime")){
			out.println("On Time selected.");
		}
		else if(view.equals("delayed")){
			out.println("Delayed selected.");
		}
		else{
			out.println("Error.");			
		}
		con.close();
	
	}

%>


</div>
</body>
</html>