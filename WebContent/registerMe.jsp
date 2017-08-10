<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>


<title>Registered</title>
</head>
<body>
<div class="trans">
	<%
		if(!request.getParameter("password").equals(request.getParameter("password2"))){
			out.println("<form method='post'><input type='hidden' id='errormsg' name = 'error' value='error'></input></form>");
			response.sendRedirect("register.jsp?error=nopass");
			return;
		}	
		else if((request.getParameter("username")=="") || (request.getParameter("password")=="") || (request.getParameter("password2")=="")){
			out.println("<form method='post'><input type='hidden' id='errormsg' name = 'error' value='error'></input></form>");
			response.sendRedirect("register.jsp?error=missing");
			return;
		}
		else{
	
			try {
				
				//connect to database
				Connection con = dbConnect();
				Statement stmt = con.createStatement();
				
				String str = "SELECT * FROM users WHERE username='"+ request.getParameter("username") +
						"' OR account_no='"+ request.getParameter("account_no") + 
						"' OR ssn='" + request.getParameter("ssn") + "';";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				//does the record exist in user?
				if(!result.next()){
					
					if(request.getParameter("account_no")!=""){
						PreparedStatement statement = con.prepareStatement(
								"INSERT INTO users (username, password, account_no, first_name, last_name, street_address, city, state, zipcode, email, phone, acct_date, CC_number, seat_preference, meal_preference, usertype)"+
								"VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE(), ?, ?, ?,'customer')");
						statement.setString(1, request.getParameter("username"));
						statement.setString(2, request.getParameter("password"));
						statement.setString(3, request.getParameter("account_no"));
						
						statement.setString(4, request.getParameter("first_name"));
						statement.setString(5, request.getParameter("last_name"));
						
						statement.setString(6, request.getParameter("street_address"));
						statement.setString(7, request.getParameter("city"));
						statement.setString(8, request.getParameter("state"));
						statement.setString(9, request.getParameter("zipcode"));
						
						statement.setString(10, request.getParameter("email"));
						statement.setString(11, request.getParameter("phone"));
						
						statement.setString(12, request.getParameter("CC_number"));
						statement.setString(13, request.getParameter("seat_preference"));
						statement.setString(14, request.getParameter("meal_preference"));
						
						statement.execute();
						//out.println("Customer created");
					}
					//else if employee is filled out 
					else if(request.getParameter("ssn")!=""){
						PreparedStatement statement = con.prepareStatement("INSERT INTO users (username, password, ssn, first_name, last_name, street_address, city, state, zipcode, email, phone, usertype, start_date) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,'employee' , SYSDATE())");
						
						statement.setString(1, request.getParameter("username"));	
						statement.setString(2, request.getParameter("password"));
						statement.setString(3, request.getParameter("ssn"));
						
						statement.setString(4, request.getParameter("first_name"));
						statement.setString(5, request.getParameter("last_name"));
						
						statement.setString(6, request.getParameter("street_address"));
						statement.setString(7, request.getParameter("city"));
						statement.setString(8, request.getParameter("state"));
						statement.setString(9, request.getParameter("zipcode"));
						
						statement.setString(10, request.getParameter("email"));
						statement.setString(11, request.getParameter("phone"));
						
						statement.execute();
						//out.println("Employee created");
					}
					//neither filled out.
					else{
						out.println("<form method='post'><input type='hidden' id='errormsg' name = 'error' value='error'></input></form>");
						response.sendRedirect("register.jsp?error=primary");
						return;
					}
				}
				else{
					//record exists in Customer, pick new username.
					out.println("<form method='post'><input type='hidden' id='errormsg' name = 'error' value='error'></input></form>");
					response.sendRedirect("register.jsp?error=exists");
					return;
				}
	
				//close the connection.
				con.close();
				response.sendRedirect("index.jsp");
	
			} catch (Exception e) {
				out.println(e.getMessage());
				out.println("Uh oh");
			}
		}
			%>
	</div>
	</body>
