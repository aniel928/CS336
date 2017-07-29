<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>


<title>Registered</title>
</head>
<body>
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

				String str = "SELECT * FROM users WHERE username='"+ request.getParameter("username") +"';";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				//does the record exist in user?
				if(!result.next()){
					
					if(request.getParameter("account_no")!=""){
						PreparedStatement statement = con.prepareStatement("INSERT INTO users (account_no, username, password) VALUES ( ?, ?, ?)");
						statement.setString(1, request.getParameter("account_no"));
						statement.setString(2, request.getParameter("username"));
						statement.setString(3, request.getParameter("password"));
						statement.execute();
						out.println("Customer created");
					}
					//else if employee is filled out 
					else if(request.getParameter("ssn")!=""){
						PreparedStatement statement = con.prepareStatement("INSERT INTO users (ssn, username, password) VALUES ( ?, ?, ?)");
						statement.setString(1, request.getParameter("ssn"));
						statement.setString(2, request.getParameter("username"));
						statement.setString(3, request.getParameter("password"));
						statement.execute();
						out.println("Employee created");
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
	
			} catch (Exception e) {
				out.println(e.getMessage());
				out.println("Uh oh");
			}
		}
			%>

	</body>
