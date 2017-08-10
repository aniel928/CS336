<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Update</title>
<style>
</style>
<body>
<div class="trans">
<%try{
String ssn=null;
String acc=null;
String type=null;
String temp=null;

Connection con = dbConnect();

//Create a SQL statement
Statement stmt = con.createStatement();

if(request.getParameter("old_ssn") != null) {
	ssn=request.getParameter("old_ssn");
	temp="SELECT * FROM users WHERE ssn='" + ssn + "'";
}
else{
	acc=request.getParameter("old_acc");
	temp="SELECT * FROM users WHERE account_no='" + acc + "'";
}

out.print("temp= " + temp);
out.print("<br>");


//make initial query to DB
ResultSet result = stmt.executeQuery(temp);
if(!result.next()){
	out.println("no result");
	
}

//initilaize needed variables
String username=result.getString(1);
String password=result.getString(2);
String fName=result.getString(5);
String lName=result.getString(6);
String address=result.getString(7);
String city=result.getString(8);
String state=result.getString(9);
String zip=result.getString(10);
String email=result.getString(11);
String phone=result.getString(12);
String ccNumber=result.getString(14);
String seat=result.getString(15);
String meal=result.getString(16);
String rate=result.getString(17);
type=result.getString(18);

//close result set
result.close();

//string builder for the query
StringBuilder str=new StringBuilder();

//add begining of query
str.append("UPDATE users ");
str.append("SET ");


if(type.equals("customer")) {
	if(!request.getParameter("account_no").equals(acc)){
		out.print("changed account no");
		str.append("account_no= " + "'" + request.getParameter("account_no") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("seat_preference").equals(seat)){
		out.print("changed seat preference");
		str.append("seat_preference= " + "'" + request.getParameter("seat_preference") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("meal_preference").equals(meal)){
		out.print("changed meal preference");
		str.append("meal_preference= " + "'" + request.getParameter("meal_preference") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	
	if(!request.getParameter("CC_number").equals(ccNumber)){
		out.print("changed credit card");
		str.append("CC_number= " + "'" + request.getParameter("CC_number") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("username").equals(username)){
		out.print("changed username");
		str.append("username= " + "'" + request.getParameter("username") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	
	if(!request.getParameter("first_name").equals(fName)){
		out.print("changed first name");
		str.append("first_name= " + "'" + request.getParameter("first_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	if(!request.getParameter("last_name").equals(lName)){
		out.print("changed last name");
		str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	if(!request.getParameter("street_address").equals(address)){
		out.print("changed street address");
		str.append("street_address= " + "'" + request.getParameter("street_address") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("city").equals(city)){
		out.print("changed city");
		str.append("city= " + "'" + request.getParameter("city") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("state").equals(state)){
		out.print("changed state");
		str.append("state= " + "'" + request.getParameter("state") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("zipcode").equals(zip)){
		out.print("changed zip");
		str.append("zipcode= " + "'" + request.getParameter("zipcode") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("phone").equals(phone)){
		out.print("changed phone");
		str.append("phone= " + "'" + request.getParameter("phone") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("email").equals(email)){
		out.print("changed email");
		str.append("email= " + "'" + request.getParameter("email") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("type").equals(type)){
		out.print("changed credit card");
		str.append("type= " + "'" + request.getParameter("type") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}

}

else {
	if(!request.getParameter("ssn").equals(ssn)){
		out.print("ssn");
		str.append("ssn= " + "'" + request.getParameter("ssn") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	
	if(!request.getParameter("rate").equals(rate)){
		out.print("changed rate");
		str.append("hourly_rate= " + "'" + request.getParameter("rate") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("username").equals(username)){
		out.print("changed username");
		str.append("username= " + "'" + request.getParameter("username") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("first_name").equals(fName)){
		out.print("changed first name");
		str.append("first_name= " + "'" + request.getParameter("first_name") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("last_name").equals(lName)){
		out.print("changed last name");
		str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("street_address").equals(address)){
		out.print("changed street address");
		str.append("street_address= " + "'" + request.getParameter("street_address") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("city").equals(city)){
		out.print("changed city");
		str.append("city= " + "'" + request.getParameter("city") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("state").equals(state)){
		out.print("changed state");
		str.append("state= " + "'" + request.getParameter("state") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("zipcode").equals(zip)){
		out.print("changed zip");
		str.append("zipcode= " + "'" + request.getParameter("zipcode") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("email").equals(email)){
		out.print("changed email");
		str.append("email= " + "'" + request.getParameter("email") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("phone").equals(phone)){
		out.print("changed phone");
		str.append("phone= " + "'" + request.getParameter("phone") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("type").equals(type)){
		out.print("changed type");
		str.append("type= " + "'" + request.getParameter("type") + "' ");
		str.append("WHERE ssn= " + "'" + ssn + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
}
}catch(SQLException e){
	out.print("<br>");
	out.println("error= " + e.getMessage());
}
//close connections
//result.close();
//stmt.close();
//con.close();
%>
</div>
</body>