<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Dashboard</title>
<%
try{
	Connection con = dbConnect();
	
	if(request.getParameter("delete") != null){
		out.println("Account has been deleted");
		%>
		<a href="dashboard.jsp">Back to Dashboard</a>
		<a href="ViewEditUsersDashboard.jsp">Back to View Users</a>
		<%
	}

	String user = request.getParameter("user");

	Statement stmt = con.createStatement(); 
	String command = "delete from users where username = '"+user+"';";
	stmt.executeUpdate(command);
	stmt.close();
	
	con.close();
	
	if(request.getParameter("user").equals(session.getAttribute("username"))){
		response.sendRedirect("index.jsp?delete=delete");
	}
	else{
		response.sendRedirect("delete.jsp?delete=delete");
	}
	
	
}
catch(Exception e){
	out.println("something happened");
}

 %>
