<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Dashboard</title>
<%
try{
	if(request.getParameter("delete") != null){
		out.println("Account has been deleted");
		%>
		<a href="dashboard.jsp">Back to Dashboard</a>
		<a href="ViewEditUsersDashboard.jsp">Back to View Users</a>
		<%
		
		}
	
		String user = request.getParameter("username");

		String command = "DELETE FROM users WHERE username = "+user+";";
		if(request.getParameter("username").equals(session.getAttribute("username"))){
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
