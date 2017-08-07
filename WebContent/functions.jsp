<%@ include file = "header.jsp" %>
<%@ page import="java.util.*" %>
 <%@ page import= "java.lang.*" %> 
<%@ page import= "java.net.*" %>
<%@ page import= "java.io.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "java.text.*" %>
<%@ page import= "java.time.*" %>
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

public ResultSet selectRequest(String str){
	Connection con = dbConnect();
	ResultSet result = null;
	try{
		Statement stmt = con.createStatement();
	
		result = stmt.executeQuery(str);
		
//		con.close();
	} catch(Exception e){
		
		return null;
	}	
	
	return result;
}

public java.util.Date getDate(String dateString){
	DateFormat df = new SimpleDateFormat("yyy-MM-dd");
	java.util.Date date = new java.util.Date();
	try{
		date = df.parse(dateString);
	}
	catch(ParseException e){
		e.getMessage();
	}
	return date;
}

public String formatDate(java.util.Date date){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String dateString = sdf.format(date);
	return dateString;
	
}

public String getWeekDay(java.util.Date date){
	SimpleDateFormat sdf = new SimpleDateFormat("E");
	String dateString = sdf.format(date);
	return dateString;
}

public int daysBet(java.util.Date d1, java.util.Date d2){
	Calendar calendar1 = Calendar.getInstance();
    Calendar calendar2 = Calendar.getInstance();
    calendar1.set(d1.getYear(), d1.getMonth(), d1.getDate());
    calendar2.set(d2.getYear(), d2.getMonth(), d2.getDate());
    long milliseconds1 = calendar1.getTimeInMillis();
    long milliseconds2 = calendar2.getTimeInMillis();
    long diff = milliseconds2 - milliseconds1;
    long diffDays = diff / (24 * 60 * 60 * 1000);	
	
	return (int)diffDays;
}

public String timeOfDay(String s){
	String retS = null;
	if(s.equals("early")){
		retS = " AND FIDptTime < 5";
	}else if(s.equals("morning")){
		retS = " AND FIDptTime >= 5 AND FIDptTime < 12";
	}else if(s.equals("afternoon")){
		retS = " AND FIDptTime >=12 AND FIDptTime < 18";
	}else if(s.equals("night")){
		retS = " AND FIDptTime >=18 AND FIDptTime < 24";
	}else{
		retS =" ";
	}
	return retS;
}




%>