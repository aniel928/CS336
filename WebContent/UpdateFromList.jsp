<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Update</title>
<style>
</style>
<body>
<%
String ssn=null;
String acc=null;

if(request.getParameter("ssn") != null) {
	ssn=request.getParameter("ssn");
}
if(request.getParameter("acc") != null){
	acc=request.getParameter("account_number");
}

out.print("ssn= " + ssn);
out.print("acc= "+ acc);
%>

</body>