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
		response.sendRedirect("ViewPopular.jsp");
		return;
	}
	else if(temp.equals("viewProfile")) {
		response.sendRedirect("ViewProfile.jsp");
		return;
	}
	else if(temp.equals("editProfile")) {
		response.sendRedirect("EditProfile.jsp");
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
	else if(temp.equals("logout")){
		session.invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	else
		response.sendRedirect("dashboard.jsp");

}
catch (Exception e) {
	out.println("error");
}
%>

