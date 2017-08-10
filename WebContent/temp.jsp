<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>


<%
Enumeration<String> param;
try {
	//gets the parmater names into the param
	param=request.getParameterNames();
	
	//gets next element and stores in temp
	String temp=param.nextElement();
	
	if(temp.equals("makeRes")) {
		response.sendRedirect("MakeReservation.jsp");
		return;
	}
	else if(temp.equals("viewRes")) {
		response.sendRedirect("ViewReservation.jsp");
		return;
	}
	else if(temp.equals("viewPopular")) {
		response.sendRedirect("ViewFlights.jsp");
		return;
	}
	else if(temp.equals("viewUsers")) {
		response.sendRedirect("ViewUsers.jsp");
		return;
	}
	else if(temp.equals("viewEditUsers")) {
		response.sendRedirect("ViewEditUsers.jsp");
		return;
	}
	else if(temp.equals("mailList")) {
		response.sendRedirect("MailList.jsp");
		return;
	}
	else if(temp.equals("report")) {
		response.sendRedirect("SalesReport.jsp");
		return;
	}
	else if(temp.equals("viewFlights")) {
		response.sendRedirect("ViewFlights.jsp");
		return;
	}
	else if(temp.equals("addUser")) {
		response.sendRedirect("register.jsp");
		return;
	}
	else if(temp.equals("revenue")) {
		response.sendRedirect("ViewRevenue.jsp");
		return;
	}
	else if(temp.equals("salesReport")) {
		response.sendRedirect("SalesReport.jsp");
		return;
	}
	else if(temp.equals("Summary")) {
		response.sendRedirect("MakeSummary.jsp");
		return;
	}
	else if(temp.equals("viewMine")) {
		response.sendRedirect("ViewMine.jsp");
		return;
	}
	else if(temp.equals("viewUsers")) {
		response.sendRedirect("ViewUsers.jsp");
		return;
	}
	else if(temp.equals("logout")){
		session.invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	else if(temp.equals("editProfile")){
		response.sendRedirect("ViewEditUsersDashboard.jsp");
		return;
	}
	else if(temp.equals("delete")){
		response.sendRedirect("delete.jsp?user="+session.getAttribute("username"));
		return;
	}
	else if(temp.equals("deleteFromList")){
		response.sendRedirect("delete.jsp?user="+ request.getParameter("listName"));
		return;
	}
	else if(temp.equals("suggest")){
		response.sendRedirect("Suggestions.jsp");
		return;
	}
	
	else
		response.sendRedirect("dashboard.jsp");

}
catch (Exception e) {
	out.println("error= " + e.getMessage());
}
%>

