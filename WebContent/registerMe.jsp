<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registered</title>
</head>
<body>
	<%
///		List<String> list = new ArrayList<String>();
		try {

			//Create a connection string
			String url = "jdbc:mysql://airlinedb.c8surmzzrrr4.us-east-2.rds.amazonaws.com:3306/airline";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "aniel928", "mookie1015");

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the HelloWorld.jsp
			//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			
			
			
			if(request.getParameter("account_no")!=null){
				PreparedStatement statement = con.prepareStatement("INSERT INTO Customer (account_no, username, password) VALUES ( ?, ?, ?)");
				statement.setString(1, request.getParameter("account_no"));
				statement.setString(2, request.getParameter("username"));
				statement.setString(3, request.getParameter("password"));
				statement.execute();
			}
			else{
				PreparedStatement statement = con.prepareStatement("INSERT INTO Employee (ssn, username, password) VALUES ( ?, ?, ?)");
				statement.setString(1, request.getParameter("ssn"));
				statement.setString(2, request.getParameter("username"));
				statement.setString(3, request.getParameter("password"));
				statement.execute();
			}
			out.println("<h1>Hi</h1>");
			
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.println(e.getMessage());
			out.println("Uh oh");
		}
	%>

	</body>
