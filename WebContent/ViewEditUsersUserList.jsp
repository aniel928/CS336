<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View and Edit User Information</title>
<style>
</style>
<body>
<div class="trans">
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
out.print("<form method='post' action='UpdateFromList.jsp'");
if(result.getString(18).equals("employee")|| result.getString(18).equals("manager")) { 
	out.print("<div id = 'Employee'>");
	out.print("<h3>Employee Information</h3>");
	out.print("<label>SSN: (9 digits)</label>");
	out.print("<input id ='field' type='text' name='ssn' value='" + result.getString(4) + "'"); 
	out.print("</div>");
}
else {
	out.print("<div id = 'Customer'>");
		out.print("<h3>Customer Information</h3>");
			out.print("<div>");
				out.print("<label>Account Number: (10 digits)</label><input type='text' name='account_no' value='" + result.getString(3) + "'"); 
			out.print("</div>");
	
			out.print("<div>");
				out.print("<label>Seat Preference:</label><input type='text' name='seat_preference' required value='" + result.getString(15) + "'");
			out.print("</div>");
				
			out.print("<div>");
				out.print("<label>Meal Preference:</label><input type='text' name='meal_preference' required value='" + result.getString(16) + "'");
			out.print("</div>");
			
			out.print("<div>");
				out.print("<label>Credit Card Number: (16 digits)</label>");
				out.print("<input type='text' name='CC_number' value='" + result.getString(14) + "'");
			out.print("</div>");
		out.print("</div>");
}
%>

<h3>Account Basics</h3>
					
<div>
	<label>First Name:</label><input id = "field" type="text" name='first_name' required value='<%out.print(result.getString(5));%>'/>
</div> 
		 
<div>
	<label>Last Name:</label><input id = "field" type="text" name='last_name' required value='<%out.print(result.getString(6));%>'/>
</div> 

<div>
	<label>Username:</label><input id = "field" type="text" name='username' required value='<%out.print(result.getString(1));%>'/>
</div>

<h3>Address</h3>

<div>
	<label>Street Address:</label><input id = "field" type="text" name='street_address' required value='<%out.print(result.getString(7));%>'>
</div> 
 
<div>
	<label>City:</label><input id = "field" type="text" name='city' required value='<%out.print(result.getString(8));%>'/>
</div> 

<div>
	<label>State:(two capital letters)</label><input id = "field" type="text" pattern='[A-Z]{2}' name='state'required value='<%out.print(result.getString(9));%>'/>
</div> 

<div>
	<label>Zipcode: (5 digits)</label><input id = "field" type="text" pattern='\d{5}'name='zipcode'required value='<%out.print(result.getString(10));%>'/>
</div> 
 
 <h3>Contact</h3>
 
<div>
	<label>Email:</label><input id = "field" type="text" name='email'required value='<%out.print(result.getString(11));%>'/>
</div> 
<div>
	<label>Phone: (10 digits, numbers only)</label><input id = "field"  type="tel" pattern='\d{10}' name='phone' required value='<%out.print(result.getString(12));%>' />
</div>	

<%
if(session.getAttribute("type").equals("manager")){
	out.print("<h3>Manager Information</h3>");
	if(!type.equals("customer")) {
		out.print("<div>");
			out.print("<label>Hourly Rate: </label><input id = 'field'  type='text'  name='rate' required value='" + result.getString(17) + "'/>");
		out.print("<div>");
	}
	out.print("<div>");
		out.print("<label>User Type: </label><input id = 'field'  type='text'  name='type' required value='" + result.getString(18) + "'/>");
	out.print("<div>");
}
%>
 			
<div style= "margin-top: 1cm"><input type="submit" value="Update"></div>




<%
if(type.equals("customer")){
	out.print("<input type='hidden' name = 'old_acc' value='" + result.getString(3) + "'></input>");
}
else{
	out.print("<input type='hidden' name = 'old_ssn' value='" + result.getString(4) + "'></input>");
}

//close connections
con.close();
result.close();
stmt.close();
%>
</form>
</div>
<button type='button' name='back'><a href='dashboard.jsp'>Back to Dashboard</a></button>
</body>
</html>