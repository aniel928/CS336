<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View and Edit User Information</title>
<style>
</style>
<body>
<div class="trans">
<%
//string builder for the query
StringBuilder str=new StringBuilder();

//add begining of query
str.append("UPDATE users ");
str.append("SET ");


Connection con = dbConnect();

//Create a SQL statement
Statement stmt = con.createStatement();

/*
UPDATE users
SET phone = '7323563832'
WHERE account_no= '1232344565' ;
*/

if(session.getAttribute("type").equals("customer")) {
	
	if(!request.getParameter("account_no").equals(session.getAttribute("account_no"))) {
		out.println("account number");
		str.append("account_no= " + "'" + request.getParameter("account_no") + "' ");
		str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("seat_preference").equals(session.getAttribute("seat"))) {
		out.println("changed seat prefrence");
		str.append("seat_preference= " + "'" + request.getParameter("seat_preference") + "' ");
		str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("meal_preference").equals(session.getAttribute("meal"))) {
		out.println("changed meal_prefrence");
		str.append("meal_preference= " + "'" + request.getParameter("meal_preference") + "' ");
		str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
		out.print(str);
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("CC_number").equals(session.getAttribute("ccnum"))) {
		out.println("changed credit card");
		str.append("CC_number= " + "'" + request.getParameter("CC_number") + "' ");
		str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
}
else {
	if(!request.getParameter("ssn").equals(session.getAttribute("ssn"))) {
		out.println("changed ssn");
		str.append("ssn= " + "'" + request.getParameter("ssn") + "' ");
		str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}	
}

//all user data
if(!request.getParameter("first_name").equals(session.getAttribute("fname"))) {
	out.println("changed first name");
	str.append("first_name= " + "'" + request.getParameter("first_name") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("last_name").equals(session.getAttribute("lname"))) {
	//out.println("changed last_name");
	str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("username").equals(session.getAttribute("username"))) {
	out.println("changed username");
	str.append("uersname= " + "'" + request.getParameter("uersname") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("password").equals(session.getAttribute("password"))) {
	//change password to password2
}

if(!request.getParameter("street_address").equals(session.getAttribute("address"))) {
	out.println("changed street");
	str.append("street_address= " + "'" + request.getParameter("street_address") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("city").equals(session.getAttribute("city"))) {
	out.println("changed city");
	str.append("city= " + "'" + request.getParameter("city") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("state").equals(session.getAttribute("state"))) {
	out.println("changed state");
	str.append("state= " + "'" + request.getParameter("state") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("zipcode").equals(session.getAttribute("zip"))) {
	out.println("changed zipcode");
	str.append("zipcode= " + "'" + request.getParameter("zipcode") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

if(!request.getParameter("email").equals(session.getAttribute("email"))) {
	out.println("changed email");
	str.append("email= " + "'" + request.getParameter("email") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
	
}

if(!request.getParameter("phone").equals(session.getAttribute("phone"))) {
	out.println("changed phone");
	str.append("phone= " + "'" + request.getParameter("phone") + "' ");
	str.append("WHERE account_no= " + "'" + session.getAttribute("account_no") + "' ;");
	out.print(str);
	stmt.executeUpdate(str.toString());
	str.replace(0, str.length(), "UPDATE users SET ");
}

out.print("<h3> Information Updated</h3>");

out.print("<form method=get action='temp.jsp'>");
out.println("<button name='backToDash' value='backToDash'>Go Back to Dashboard </button> <br> <br>");

%>
</div>