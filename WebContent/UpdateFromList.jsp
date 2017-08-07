<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Update</title>
<style>
</style>
<body>
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
	acc=request.getParameter("acc");
	temp="SELECT * FROM users WHERE account_no='" + acc + "'";
}

out.print("temp= " + temp);
out.print("<br>");

//make initial query to DB
ResultSet result = stmt.executeQuery(temp);
if(!result.next()){
	out.println("no result");
	
}

//initilaize type
type=result.getString(18);
out.print("type= " + type);
out.print("<br>");

//string builder for the query
StringBuilder str=new StringBuilder();

//add begining of query
str.append("UPDATE users ");
str.append("SET ");


if(type.equals("customer")) {
	result.beforeFirst();
	result.next();

	if(!request.getParameter("account_no").equals(result.getString(3))){
		out.print("changed account no");
		str.append("account_no= " + "'" + request.getParameter("account_no") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("seat_preference").equals(result.getString(15))){
		out.print("changed seat preference");
		str.append("seat_preference= " + "'" + request.getParameter("seat_preference") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("meal_preference").equals(result.getString(16))){
		out.print("changed meal preference");
		str.append("meal_preference= " + "'" + request.getParameter("meal_preference") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	if(!request.getParameter("CC_number").equals(result.getString(14))){
		out.print("changed credit card");
		str.append("CC_number= " + "'" + request.getParameter("CC_number") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("username").equals(result.getString(1))){
		out.print("changed username");
		str.append("username= " + "'" + request.getParameter("username") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	if(!request.getParameter("first_name").equals(result.getString(5))){
		out.print("changed first name");
		str.append("first_name= " + "'" + request.getParameter("first_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	if(!request.getParameter("last_name").equals(result.getString(6))){
		out.print("changed last name");
		str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
		
	}
	if(!request.getParameter("street_address").equals(result.getString(7))){
		out.print("changed street address");
		str.append("street_address= " + "'" + request.getParameter("street_address") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("street_address").equals(result.getString(8))){
		out.print("changed city");
		str.append("street_address= " + "'" + request.getParameter("street_address") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	out.println(request.getParameter("state"));
	if(!request.getParameter("state").equals(result.getString(9))){
		out.print("changed state");
		str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("zipcode").equals(result.getString(10))){
		out.print("changed zip");
		str.append("state= " + "'" + request.getParameter("state") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("state").equals(result.getString(11))){
		out.print("changed email");
		str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("phone").equals(result.getString(12))){
		out.print("changed phone");
		str.append("last_name= " + "'" + request.getParameter("last_name") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
	if(!request.getParameter("type").equals(result.getString(18))){
		out.print("changed credit card");
		str.append("type= " + "'" + request.getParameter("type") + "' ");
		str.append("WHERE account_no= " + "'" + acc + "' ;");
		stmt.executeUpdate(str.toString());
		str.replace(0, str.length(), "UPDATE users SET ");
	}
}
else {
	result.beforeFirst();

	if(!request.getParameter("ssn").equals(result.getString(4))){
		out.print("changed ssn");
		out.print("<br>");
	}
	if(!request.getParameter("rate").equals(result.getString(17))){
		out.print("changed rate");
		out.print("<br>");
	}
	if(!request.getParameter("username").equals(result.getString(1))){
		out.print("changed username");
		out.print("<br>");
	}
	if(!request.getParameter("first_name").equals(result.getString(5))){
		out.print("changed first name");
		out.print("<br>");
	}
	if(!request.getParameter("last_name").equals(result.getString(6))){
		out.print("changed last name");
		out.print("<br>");
	}
	if(!request.getParameter("street_address").equals(result.getString(7))){
		out.print("changed street address");
		out.print("<br>");
	}
	if(!request.getParameter("city").equals(result.getString(8))){
		out.print("changed city");
		out.print("<br>");
	}
	if(!request.getParameter("state").equals(result.getString(9))){
		out.print("changed state");
		out.print("<br>");
	}
	if(!request.getParameter("zipcode").equals(result.getString(10))){
		out.print("changed zip");
		out.print("<br>");
	}
	if(!request.getParameter("email").equals(result.getString(11))){
		out.print("changed email");
		out.print("<br>");
	}
	if(!request.getParameter("phone").equals(result.getString(12))){
		out.print("changed phone");
		out.print("<br>");
	}
	if(!request.getParameter("type").equals(result.getString(18))){
		out.print("changed credit card");
		out.print("<br>");
	}

}
}catch(SQLException e){
	out.print("<br>");
	out.println(e.getMessage());
}
//close connections
//result.close();
//stmt.close();
//con.close();
%>

</body>