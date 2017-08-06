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
String type=null;
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
	str ="SELECT * FROM users WHERE account_no=" + acc;
}
else {
	str ="SELECT * FROM users WHERE ssn=" + ssn; 
}
//select * from users where ssn=123456123;
ResultSet result = stmt.executeQuery(str);

result.next();
type=result.getString(18);
if(type == null) {
	out.print("<h3> User Type is null</h3>");
}

out.print("<h1>View and Edit User Information</h1>");


//start form
out.print("<form method='post' action='update.jsp'");
if(result.getString(18).equals("employee")|| result.getString(18).equals("manager")) { 
	out.print("<div id = 'Employee'>");
	out.print("<h3>Employee Information</h3>");
	out.print("<label>SSN: (9 digits)</label>");
	out.print("<input id ='field' type='text' name='ssn' value= "); 
	out.print("</div>");
}
else {
	out.print("<div id = 'Customer'");
	out.print("<h3>Customer Information</h3>");
	out.print("<div>");
		out.print("<label>Account Number: (10 digits)</label><input type='text' name='account_no' value= " + result.getString(3)); 
	out.print("</div>");
	
	out.print("<div>");
		out.print("<label>Seat Preference:</label><input type='text' name='seat_preference' required value= " + result.getString(15));
	out.print("</div>");
		
	out.print("<div>");
		out.print("<label>Meal Preference:</label><input type='text' name='meal_preference' required value= " + result.getString(16));
	out.print("</div>");
	
	out.print("<div>");
		out.print("<label>Credit Card Number: (16 digits)</label>");
		out.print("<input type='text' name='CC_number' value= " + result.getString(14));
	out.print("</div>");
out.print("</div>");
}
%>

<h3>Account Basics</h3>
					
<div>
	<label>First Name:</label><input id = "field" type="text" name='first_name' required value=<%out.print(session.getAttribute("fname"));%>/>
</div> 
		 
<div>
	<label>Last Name:</label><input id = "field" type="text" name='last_name' required value=<%out.print(session.getAttribute("lname"));%>/>
</div> 

<div>
	<label>Username:</label><input id = "field" type="text" name='username' required value=<%out.print(session.getAttribute("username"));%>/>
</div>
						
<div>
	<label>Old Password:</label> <input id = "field" type="password" name = "password" required value=<%out.print(session.getAttribute("pass"));%>>
</div>

<div>
	<label>Password:</label> <input id = "field" type="password" name = "password" required value="****">
</div>

<div>
	<label> Re-Type New Password:</label> <input id = "field" type="password" name = "password2" required value="****">
</div>



<h3>Address</h3>

<div>
	<label>Street Address:</label><input id = "field" type="text" name='street_address'/ required value=<%out.print(session.getAttribute("address"));%>>
</div> 
 
<div>
	<label>City:</label><input id = "field" type="text" name='city' required value=<%out.print(session.getAttribute("city"));%>/>
</div> 

<div>
	<label>State:(two capital letters)</label><input id = "field" type="text" pattern='[A-Z]{5}' name='state'required value=<%out.print(session.getAttribute("state"));%>/>
</div> 

<div>
	<label>Zipcode: (5 digits)</label><input id = "field" type="text" pattern='\d{5}'name='zipcode'required value=<%out.print(session.getAttribute("zip"));%>/>
</div> 
 
 <h3>Contact</h3>
 
<div>
	<label>Email:</label><input id = "field" type="text" name='email'required value=<%out.print(session.getAttribute("email"));%>/>
</div> 
<div>
	<label>Phone: (10 digits, numbers only)</label><input id = "field"  type="tel" pattern='\d{10}' name='phone' required value=<%out.print(session.getAttribute("phone"));%> />
</div>	
    			
<div style= "margin-top: 1cm"><input type="submit" value="Update"></div>
</form>
</div>
</body>
</html>