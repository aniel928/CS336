<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Book Reservation</title>
<body>
<h1>Book Reservation</h1>
<%

//round trip
if(request.getParameter("tripType")==null){
	out.println(request.getParameter("tripType"));
	out.println(request.getParameter("account"));
	out.println(request.getParameter("numpass"));
return;
}
if(request.getParameter("tripType").equals("round")){
	
	if(request.getParameter("pass1") == null || request.getParameter("meal1")==null || request.getParameter("seat1")==null){
		int num = -1;
		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		int i = 1;
		out.println("<form method='post' action='book.jsp'>");
		out.println("Passenger#1: <input type='text' name='pass1' value='"+session.getAttribute("fname")+" "+session.getAttribute("lname")+"'/><br>");
		out.println("Seat preference: <input type='text' name='seat1' value='"+session.getAttribute("seat")+"'/><br>");
		out.println("Meal preference: <input type='text' name='meal1' value='"+session.getAttribute("meal")+"'/><br>");
	
		while (i < num){
			out.println("Passenger#"+(i+1)+": <input type='text' name='pass"+(i+1)+"'/><br>");
			out.println("Seat preference: <input type='text' name='seat"+(i+1)+"'/><br>");
			out.println("Meal preference: <input type='text' name='meal"+(i+1)+"'/><br><br>");
			
			i++;
		}
		out.println("<input type='hidden' id='tripType' name = 'tripType' value='round'></input>");
		out.println("<input type='hidden' id='numPass' name = 'numPass' value='"+request.getParameter("numPass")+"'></input>");
		out.println("<input type='hidden' id='account' name = 'account' value='"+request.getParameter("account")+"'></input>");
		out.println("<input type='hidden' id='start' name = 'start' value='"+request.getParameter("start")+"'></input>");
		out.println("<input type='hidden' id='return' name = 'return' value='"+request.getParameter("return")+"'></input>");
		out.println("<input type='submit' value='Confirm and Book.'></form>");
		
	}
	else{
	
		String start = request.getParameter("start");
		String[] list = start.split("_");
		String flightNum = list[0];
		String startAir = list[1];
		String startDept = list[2];
		
		String fin = request.getParameter("return");
		String[] retlist = fin.split("_");
		String retflightNum = retlist[0];
		String retstartAir = retlist[1];
		String retstartDept = retlist[2];
		//find highest reservation number: 
		
		int num = -1;
		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		String account_no = null;
		if(session.getAttribute("type").equals("customer")){
			account_no = (String.valueOf(session.getAttribute("account_no")));
			out.println("account_no: "+account_no);
		}
		else{
			account_no = request.getParameter("account");
			out.println("account: "+account_no);
		}
		
		int i=0;
		while(i<num){
			
			//Printing for now, save into Passengers table later.
			out.println(request.getParameter("pass"+(i+1)));
			out.println(request.getParameter("seat"+(i+1)));
			out.println(request.getParameter("meal"+(i+1)));
			i++;
		}
			
		String str = "SELECT max(ResNumber) from reservations";
		ResultSet rs = selectRequest(str);
		rs.next();
		int resno = rs.getInt(1);
		resno++;
		str = "select FLFare from flights where FLNumber="+flightNum+";";
		rs = selectRequest(str);
		rs.next();
		double fare = rs.getDouble(1);
		str = "select FLFare from flights where FLNumber-"+retflightNum+";";
		rs = selectRequest(str);
		rs.next();
		fare += rs.getDouble(1);
		
		
		double booking = 0;
		String rest = null;
		rs.close();
		
		if(daysBet(new java.util.Date(),getDate(startDept))>30){
			rest = "Early";
		}
		
		if(session.getAttribute("type").equals("employee")){
			booking = 35.00;
		}
		try{
		Connection con = dbConnect();
		PreparedStatement statement = con.prepareStatement("INSERT INTO reservations VALUES ( ?, ?, ?, ?, ?)");
		statement.setInt(1, resno);
		statement.setString(2, formatDate(new java.util.Date()));
		statement.setDouble(3, fare);
		statement.setString(4, rest);
		statement.setDouble(5, booking);
		statement.execute();
		out.println("Reservation number "+resno+" created");
		con.close();
		}catch(SQLException e){out.println(e.getMessage());}
		
		
	//	out.println("INSERT INTO reservations values (1, )")
	}	
}
else if(request.getParameter("tripType").equals("oneway")){
	if(request.getParameter("pass1") == null || request.getParameter("meal1")==null || request.getParameter("seat1")==null){
		int num = -1;
		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		int i = 1;
		out.println("<form method='post' action='book.jsp'>");
		out.println("Passenger#1: <input type='text' name='pass1' value='"+session.getAttribute("fname")+" "+session.getAttribute("lname")+"'/><br>");
		out.println("Seat preference: <input type='text' name='seat1' value='"+session.getAttribute("seat")+"'/><br>");
		out.println("Meal preference: <input type='text' name='meal1' value='"+session.getAttribute("meal")+"'/><br>");
			
		while (i < num){
			out.println("Passenger#"+(i+1)+": <input type='text' name='pass"+(i+1)+"'/><br>");
			out.println("Seat preference: <input type='text' name='seat"+(i+1)+"'/><br>");
			out.println("Meal preference: <input type='text' name='meal"+(i+1)+"'/><br><br>");
			i++;
		}			
		out.println("<input type='hidden' id='tripType' name = 'tripType' value='oneway'/>");
		out.println("<input type='hidden' id='numPass' name = 'numPass' value='"+request.getParameter("numPass")+"'></input>");
		out.println("<input type='hidden' id='account' name = 'account' value='"+request.getParameter("account")+"'></input>");
		out.println("<input type='hidden' id='start' name = 'start' value='"+request.getParameter("start")+"'></input>");
			
			
	
		out.println("<input type='submit' value='Confirm and Book.'></form>");
		
	}
	else{
	
		String start = request.getParameter("start");
		String[] list = start.split("_");
		String flightNum = list[0];
		String startAir = list[1];
		String startDept = list[2];
		//find highest reservation number: 
		
		int num = -1;
		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		String account_no = null;
		if(session.getAttribute("type").equals("customer")){
			account_no = (String.valueOf(session.getAttribute("account_no")));
			out.println("account_no: "+account_no);
		}
		else{
			account_no = request.getParameter("account");
			out.println("account: "+account_no);
		}
		
		int i=0;
		while(i<num){
			
			//Printing for now, save into Passengers table later.
			out.println(request.getParameter("pass"+(i+1)));
			out.println(request.getParameter("seat"+(i+1)));
			out.println(request.getParameter("meal"+(i+1)));
			i++;
		}
			
		String str = "SELECT max(ResNumber) from reservations";
		ResultSet rs = selectRequest(str);
		rs.next();
		int resno = rs.getInt(1);
		resno++;
		str = "select FLFare from flights where FLNumber="+flightNum+";";
		rs = selectRequest(str);
		rs.next();
		double fare = rs.getDouble(1);
		double booking = 0;
		String rest = null;
		rs.close();
		
		if(daysBet(new java.util.Date(),getDate(startDept))>30){
			rest = "Early";
		}
		
		if(session.getAttribute("type").equals("employee")){
			booking = 35.00;
		}
		try{
		Connection con = dbConnect();
		PreparedStatement statement = con.prepareStatement("INSERT INTO reservations VALUES ( ?, ?, ?, ?, ?)");
		statement.setInt(1, resno);
		statement.setString(2, formatDate(new java.util.Date()));
		statement.setDouble(3, fare);
		statement.setString(4, rest);
		statement.setDouble(5, booking);
		statement.execute();
		out.println("Reservation number "+resno+" created");
		con.close();
		}catch(SQLException e){out.println(e.getMessage());}
		
		
	//	out.println("INSERT INTO reservations values (1, )")
	}
}else if(request.getParameter("tripType").equals("multi")){
	
	//return 
	if(request.getParameter("pass1") == null || request.getParameter("meal1")==null || request.getParameter("seat1")==null){
		int num = -1;
		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		int i = 1;
		out.println("<form method='post' action='book.jsp'>");
		out.println("Passenger#1: <input type='text' name='pass1' value='"+session.getAttribute("fname")+" "+session.getAttribute("lname")+"'/><br>");
		out.println("Seat preference: <input type='text' name='seat1' value='"+session.getAttribute("seat")+"'/><br>");
		out.println("Meal preference: <input type='text' name='meal1' value='"+session.getAttribute("meal")+"'/><br>");
			
		while (i < num){
			out.println("Passenger#"+(i+1)+": <input type='text' name='pass"+(i+1)+"'/><br>");
			out.println("Seat preference: <input type='text' name='seat"+(i+1)+"'/><br>");
			out.println("Meal preference: <input type='text' name='meal"+(i+1)+"'/><br><br>");
			i++;
		}
		out.println("<input type='hidden' id='tripType' name = 'tripType' value='multi'></input>");
		out.println("<input type='hidden' id='numPass' name = 'numPass' value='"+request.getParameter("numPass")+"'></input>");
		out.println("<input type='hidden' id='account' name = 'account' value='"+request.getParameter("account")+"'></input>");
		out.println("<input type='hidden' id='start' name = 'start' value='"+request.getParameter("start")+"'></input>");
		out.println("<input type='hidden' id='return' name = 'return' value='"+request.getParameter("return")+"'></input>");
		out.println("<input type='hidden' id='numcity' name = 'numcity' value='"+request.getParameter("numcity")+"'></input>");
		
		if(request.getParameter("mid0")!=null){
			out.println("<input type='hidden' id='mid0' name = 'mid0' value='"+request.getParameter("mid0")+"'></input>");	
		}
		if(request.getParameter("mid1")!=null){
			out.println("<input type='hidden' id='mid1' name = 'mid1' value='"+request.getParameter("mid1")+"'></input>");	
		}
		if(request.getParameter("mid2")!=null){
			out.println("<input type='hidden' id='mid2' name = 'mid2' value='"+request.getParameter("mid2")+"'></input>");	
		}
		if(request.getParameter("mid3")!=null){
			out.println("<input type='hidden' id='mid3' name = 'mid3' value='"+request.getParameter("mid3")+"'></input>");	
		}
		if(request.getParameter("mid4")!=null){
			out.println("<input type='hidden' id='mid4' name = 'mid4' value='"+request.getParameter("mid4")+"'></input>");	
		}
		
		out.println("<input type='submit' value='Confirm and Book.'></form>");
		
	}
	else{
		int numCities = -1;
		try{
			String s = request.getParameter("numcity").trim();
			numCities = Integer.parseInt(s);
		}catch(NumberFormatException e){
			out.println("......"+e.getMessage());
		}
		int i = 0;
		String flightNums[] = new String [numCities+1];
		String startAirs[] = new String [numCities+1];
		String deptAirs[] = new String [numCities+1];
		while(i<numCities){
			String str1 = request.getParameter("mid"+i);
			String[] list = new String [3];
			try{
				list = str1.split("_");
			flightNums[i] = list[0];
			startAirs[i] = list[1];
			deptAirs[i] = list[2];
			}catch(NullPointerException e){out.println("....."+e.getMessage());return;}
			i++;
		}
		int num = -1;	

		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		
		String account_no = null;
		if(session.getAttribute("type").equals("customer")){
			account_no = (String.valueOf(session.getAttribute("account_no")));
			out.println("account_no: "+account_no);
		}
		else{
			account_no = request.getParameter("account");
			out.println("account: "+account_no);
		}
		
		i=0;
		while(i<num){
			
			//Printing for now, save into Passengers table later.
			out.println(request.getParameter("pass"+(i+1)));
			out.println(request.getParameter("seat"+(i+1)));
			out.println(request.getParameter("meal"+(i+1)));
			i++;
		}
			
		String str = "SELECT max(ResNumber) from reservations";
		ResultSet rs = selectRequest(str);
		rs.next();
		int resno = rs.getInt(1);
		rs.close();
		resno++;
		double fare = 0;		
		i=0;
		while(i < numCities){
			out.println(i+ " " +flightNums[i]);
			i++;
		}
		i=0;
		try{
		while(i < numCities){		
			str = "select FLFare from flights where FLNumber="+flightNums[i]+";";
			rs = selectRequest(str);
			rs.next();
			fare += rs.getDouble(1);
			rs.close();
			i++;
		}		
		}catch(NullPointerException e){
			out.println("fare "+e.getMessage());
			return;
		}
		
		double booking = 0;
		String rest = null;
		
		try{
			out.println(startAirs[0]);
	
		if(daysBet(new java.util.Date(),getDate(startAirs[0]))>30){
			rest = "Early";
		}
		}catch(ArrayIndexOutOfBoundsException e){
			e.getMessage();
		}
		
		if(session.getAttribute("type").equals("employee")){
			booking = 35.00;
		}
		try{
		Connection con = dbConnect();
		
		//write to reservations
		PreparedStatement statement = con.prepareStatement("INSERT INTO reservations VALUES ( ?, ?, ?, ?, ?)");
		statement.setInt(1, resno);
		statement.setString(2, formatDate(new java.util.Date()));
		statement.setDouble(3, fare);
		statement.setString(4, rest);
		statement.setDouble(5, booking);
		statement.execute();
		out.println("Reservation number "+resno+" created");

		//write to has
		for(int j=0;j<numCities;j++){
			statement = con.prepareStatement("INSERT INTO has VALUES (?, ?)");
			statement.setInt(1, resno);
			statement.setString(2, flightNums[j]);
			statement.execute();
			out.println("Flight saved");
		}		
		
		
		//write to makes
//		statement = con.prepareStatement("INSERT INTO makes VALUES(?, ?, ? )");
//		statement.setInt(1,resno);
//		statement.setString(2,account_no);
//		if(session.getAttribute("type").equals("employee")){
//			statement.setString(3,String.valueOf(session.getAttribute("username")));
//		}else{
//			statement.setString(3,null);
//		}
//		statement.execute();
//		out.println("Saved to makes");
		



		//write to passenger
//		for(int j=0; j < num; k++){
//		statement = con.prepareStatement("INSERT INTO passenger VALUES(?, ?, ?, ?, ?)");
//			//not correct in db yet
//			
//		}
		
		
		
		con.close();
		}catch(SQLException e){out.println(e.getMessage());}
		
		
	//	out.println("INSERT INTO reservations values (1, )")
	}	
}

 %>