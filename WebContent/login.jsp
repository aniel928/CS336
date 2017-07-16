<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
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
			String str = "SELECT * FROM Customer WHERE username='"+ request.getParameter("userID") + "' AND password='" + request.getParameter("password")+"';";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			if(!result.next()){
				String str2 = "SELECT * FROM Employee WHERE username='"+ request.getParameter("userID") + "' AND password='" + request.getParameter("password")+"';";
				ResultSet result2 = stmt.executeQuery(str2);
				if(!result2.next()){
					out.println("<h1>Error<h1>");
				}
				else{
					out.println("<h1>Hi i'm an employee.</h1>");
				}
			}
			else{
				out.println("<h1>Hi I'm a customer.</h1>");
			}
			
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.println(e.getMessage());
			out.println("Uh oh");
		}
	%>

	</body>
</html>