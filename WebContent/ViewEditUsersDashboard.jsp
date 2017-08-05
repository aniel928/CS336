<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	<title>View/Edit</title>
	</head>
	<body>
		<h1>View and Edit User Information</h1>
		<br>
		<div>
			<form method="post" action="temp.jsp"> 
					<%
					try{
						if(request.getParameter("error").equals("nopass")){				
							out.println("<p style='color: red'><b>Passwords don't match, please try again.</b></p>");
						}
						else if(request.getParameter("error").equals("missing")){
							out.println("<p style='color: red'><b>Please fill out all applicable fields.</b></p>");
						}
						else if(request.getParameter("error").equals("primary")){
							out.println("<p style='color: red'><b>Missing registration type, account number, or SSN.</b></p>");
						}
						else if(request.getParameter("error").equals("exists")){
							out.println("<p style='color: red'><b>Username, Account Number, or SSN taken. Please enter new one.</b></p>");
						}
					} 
					catch(Exception e){
						
					}%>
					<%//get values for values
					
					if(session.getAttribute("type").equals("employee") || session.getAttribute("type").equals("manager")) { 
						out.print("<div id = 'Employee'>");
						out.print("<h3>Employee Information</h3>");
						out.print("<label>SSN: (9 digits)</label>");
						out.print("<input id ='field' type='text' name='ssn' value= " + session.getAttribute("ssn")); 
						out.print("</div>");
					}
					else {
						out.print("<div id = 'Customer'");
						out.print("<h3>Customer Information</h3>");
						out.print("<div>");
							out.print("<label>Account Number: (10 digits)</label><input type='text' name='account_no' value= " + session.getAttribute("account_no")); 
						out.print("</div>");
						
						out.print("<div>");
							out.print("<label>Seat Preference:</label><input type='text' name='seat_preference' required value= " + session.getAttribute("seat"));
						out.print("</div>");
							
						out.print("<div>");
							out.print("<label>Meal Preference:</label><input type='text' name='meal_preference' required value= " + session.getAttribute("meal"));
						out.print("</div>");
						
						out.print("<div>");
							out.print("<label>Credit Card Number: (16 digits)</label>");
							out.print("<input type='text' name='CC_number' value= " + session.getAttribute("ccnum"));
						out.print("</div>");
					out.print("</div>");
					}%>
					
					<h3>Account Basics</h3>
					
    				<div>
						<label>First Name:</label><input id = "field" type="text" name='first_name' required value=<%out.print(session.getAttribute("fname"));%>/>
					</div> 
					 
					<div>
						<label>Last Name:</label><input id = "field" type="text" name='last_name' required value=<%out.print(session.getAttribute("lname"));%>/>
					</div> 
					
					
					<div>
						<label>Username:</label><input id = "field" type="text" name='username' required value=<%out.print(session.getAttribute("username"));%>/>
					</div>
											
					<div>
						<label>Old Password:</label> <input id = "field" type="password" name = "password" required value=<%out.print(session.getAttribute("pass"));%>>
					</div>
					
					<div>
						<label>Password:</label> <input id = "field" type="password" name = "password" required value="****">
					</div>
					
					<div>
						<label> Re-Type New Password:</label> <input id = "field" type="password" name = "password2" required value="****">
					</div>
					
		
					
					<h3>Address</h3>
					
					<div>
						<label>Street Address:</label><input id = "field" type="text" name='street_address'/ required value=<%out.print(session.getAttribute("address"));%>>
					</div> 
					 
					<div>
						<label>City:</label><input id = "field" type="text" name='city' required value=<%out.print(session.getAttribute("city"));%>/>
					</div> 
					<div>
						<label>State:(two capital letters)</label><input id = "field" type="text" pattern='[A-Z]{5}' name='state'required value=<%out.print(session.getAttribute("state"));%>/>
					</div> 
					<div>
						<label>Zipcode: (5 digits)</label><input id = "field" type="text" pattern='\d{5}'name='zipcode'required value=<%out.print(session.getAttribute("zip"));%>/>
					</div> 
					 
					 <h3>Contact</h3>
					 
					<div>
						<label>Email:</label><input id = "field" type="text" name='email'required value=<%out.print(session.getAttribute("email"));%>/>
					</div> 
					<div>
						<label>Phone: (10 digits, numbers only)</label><input id = "field"  type="tel" pattern='\d{10}' name='phone' required value=<%out.print(session.getAttribute("phone"));%> />
					</div>	
	       			
				<div style= "margin-top: 1cm"><input type="submit" value="Update"></div>
			</form>
		</div>