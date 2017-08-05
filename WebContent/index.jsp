<%@ include file = "header.jsp" %>

<title>Airline Reservations</title>
</head>
	<body>
		<h1>Welcome!</h1> 
		<br> <br> 
		<h2>Please sign in! </h2>
		<br>
		<div>
			<form method="post" action="dashboard.jsp">
				<table>
				
				<% 
					try{
						if(request.getParameter("error") != null){
							out.println("<tr><td style='color: red'><b>Username or password not found.</b><td><tr>");
						} 
						if(request.getParameter("delete") != null){
							out.println("<tr><td style='color: red'><b>Account has been deleted.</b><td><tr>");							
						}
					}
					catch(Exception e){
					}
					%>
					<tr>
						<td>User Name: </td>
						<td><input type="text" name="userID"></td>
					</tr>
					<tr>
						<td>Password: </td>
						<td><input type="password" name="password"></td>
				</table>
				<input type="submit" value="Log In">
			</form>
			<form action="register.jsp">
			<input type="submit" value="Register">
			</form>
	
		</div>
	</body>
</html>