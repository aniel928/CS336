<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Registration Page</title>
	</head>
	<body>
		<h1>Please register below </h1>
		<br>
		<div>
			<form method="post" action="registerMe.jsp">
				<table>
					<tr>    
						<td>Account Number (customers only): </td><td><input type="text" name="account_no"></td>
					</tr>
					<tr>    
						<td>SSN (employees only): </td><td><input type="text" name="ssn"></td>
					</tr>						
					<tr>
						<td>Username: </td><td><input type="text" name="username"></td>
					</tr>
					<tr>
						<td>Password: </td><td><input type="text" name="password"></td>
					</tr>
				</table>
				<br>
				<input type="submit" value="Register">
			</form>
		</div>