<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>


		<title>Registration Page</title>
	</head>
	<body>
		<h1>Please register below </h1>
		<br>
		<div>
			<form method="post" action="registerMe.jsp">
				<table>
					<%try{
						if(request.getParameter("error").equals("nopass")){				
							out.println("<tr><td style='color: red'><b>Passwords don't match, please try again.</b></td></tr>");
						}
						else if(request.getParameter("error").equals("missing")){
							out.println("<tr><td style='color: red'><b>Please fill out all applicable fields.</b></td></tr>");
						}
						else if(request.getParameter("error").equals("primary")){
							out.println("<tr><td style='color: red'><b>Missing account number or SSN.</b></td></tr>");
						}
						else if(request.getParameter("error").equals("exists")){
							out.println("<tr><td style='color: red'><b>Username taken, please pick different username.</b></td></tr>");
						}
					} 
					catch(Exception e){
						
					}%>
					
					<tr>    
						<td>Account Number (customers only): </td><td><input type="text" name="account_no"></td>
					</tr>
					<tr>    
						<td>SSN (employees only): </td><td><input type="text" name="ssn"></td>
					</tr>						
					<tr>
						<td>Username: </td><td><input type="text" name="username"></td>
					</tr>
					<tr>
						<td>Password: </td><td><input type="password" name="password"></td>
					</tr>
					<tr>
						<td>Re-type Password: </td><td><input type="password" name="password2"></td>
					</tr>
				</table>
				<br>
				<input type="submit" value="Register">
			</form>
		</div>