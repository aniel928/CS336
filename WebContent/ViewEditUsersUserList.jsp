<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View and Edit User Information</title>
<style>
</style>
<body>

<%
//get values from ViewUsers
String acc=request.getParameter("acc");
String ssn=request.getParameter("ssn");

//create query			
Connection con = dbConnect();

//Create a SQL statement
Statement stmt = con.createStatement();

if(acc != null) {
	out.print("acc");
	String str ="SELECT * FROM users WHERE account_no=" + acc + "'";
}
else {
	out.print("ssn");
	String str ="SELECT * FROM users WHERE account_no='" + ssn + "'"; 
}

ResultSet result = stmt.executeQuery(str);

%>


</body>