<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airline Reservations</title>
</head>
<body>
<h1>Welcome!</h1> <br> <br> <h2>Please sign in! </h2>
<br>
<div>
	<form method="post" action="login.jsp">
		<table>
			<tr>
				<td>User Name: </td>
				<td><input type="text" name="userID"></td>
			</tr>
			<tr>
				<td>Password: </td>
				<td><input type="password" name="password"></td>
		</table>
		<input type="submit" value="Log In">
	</form>
	<form action="register.jsp">
		<input type="submit" value="Register">
	</form>
	
</div>