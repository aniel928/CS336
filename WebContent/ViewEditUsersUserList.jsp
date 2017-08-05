<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View and Edit User Information</title>
<style>
</style>
<body>

<%
//get values from ViewUsers
String acc=null;
String ssn=null;
String str;

if(request.getParameter("acc") != null) {
	acc=request.getParameter("acc");
}

if(request.getParameter("ssn") != null) {
	ssn=request.getParameter("ssn");
}

//create query			
Connection con = dbConnect();

//Create a SQL statement
Statement stmt = con.createStatement();

if(acc != null) {
	out.print("acc");
	str ="SELECT * FROM users WHERE account_no=" + acc;
}
else {
	out.print("ssn");
	str ="SELECT * FROM users WHERE ssn=123456123"; //+ ssn; 
}
//select * from users where ssn=123456123;
ResultSet result = stmt.executeQuery(str);

if(result.next()) {
out.print(result.getString(1));
out.print(result.getString(2));
out.print(result.getString(3));
out.print(result.getString(4));
out.print(result.getString(5));
out.print(result.getString(6));
out.print(result.getString(7));
out.print(result.getString(9));
out.print(result.getString(10));
out.print(result.getString(11));
out.print(result.getString(12));
out.print(result.getString(13));
out.print(result.getString(14));
out.print(result.getString(15));
out.print(result.getString(16));
out.print(result.getString(17));
}
else
	out.print("no such account");
%>
</body>
</html>