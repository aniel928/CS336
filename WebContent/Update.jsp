<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View and Edit User Information</title>
<style>
</style>
<body>

<h1>Update Page</h1>


Note:this will most likely just run java and redirect to dash board
This may have to turn into two pages, one for ViewEditUsersDashboard and one for ViewEditUsersList


<%
String acc=null;
String ssn=null;
String type=null;
String str;


if(acc != null) {
	str ="SELECT * FROM users WHERE account_no=" + acc;
}
else {
	str ="SELECT * FROM users WHERE ssn=" + ssn; 
}

//create query			
Connection con = dbConnect();

//Create a SQL statement
Statement stmt = con.createStatement();

//issu query
ResultSet result = stmt.executeQuery(str);

//use arrributes below to compare the possible new value to the value in the database, i
//if any are different issue anoterh query that updates the table
//finally redirect to dashboard stating changes have been made

//employee
session.getAttribute("ssn");

//customer
session.getAttribute("account_no");
session.getAttribute("seat_prefrence");
session.getAttribute("meal_prefrence");
session.getAttribute("CC_number");

//everyone
session.getAttribute("first_name");
session.getAttribute("last_name");
session.getAttribute("username");
session.getAttribute("password");
session.getAttribute("password2");
session.getAttribute("street_address");
session.getAttribute("city");
session.getAttribute("state");
session.getAttribute("zipcode");
session.getAttribute("email");
session.getAttribute("phone");


%>