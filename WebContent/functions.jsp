<%@ include file = "header.jsp" %>
<%!

public Connection dbConnect(){
	Connection con = null;
	try{
		//Create a connection string
		String url = "jdbc:mysql://airlinedb.c8surmzzrrr4.us-east-2.rds.amazonaws.com:3306/airline";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		con = DriverManager.getConnection(url, "aniel928", "mookie1015");
	}
	catch(Exception e){
		System.out.println("Error");
		System.out.println(e.getMessage());
	}
	return con;
}

%>