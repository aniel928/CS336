<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Book Reservation</title>
<body>
<div class='trans'>
<h1>Book Reservation</h1>
<%

//round trip
if(request.getParameter("tripType")==null){
	out.println(request.getParameter("tripType"));
	out.println(request.getParameter("account"));
	out.println(request.getParameter("numpass"));
return;
}
//
if(request.getParameter("tripType").equals("round")){
	
	if(request.getParameter("pass1") == null || request.getParameter("meal1")==null || request.getParameter("seat1")==null){
		int num = -1;
		try{
			num = Integer.parseInt((request.getParameter("numPass").trim()));
		}catch(NumberFormatException e){
			out.println(e.getMessage());
		}
		int i = 0;
		
		out.println("<form method='post' action='book.jsp'>");
		if(session.getAttribute("type").equals("customer")){			
			out.println("Passenger#1: <input type='text' name='pass1' value='"+session.getAttribute("fname")+" "+session.getAttribute("lname")+"' required/><br>");
			out.println("Seat preference: <input type='text' name='seat1' value='"+session.getAttribute("seat")+"' required/><br>");
			out.println("Meal preference: <input type='text' name='meal1' value='"+session.getAttribute("meal")+"' required/><br><br>");
			i=1;
		}
		
		while (i < num){
			out.println("Passenger#"+(i+1)+": <input type='text' name='pass"+(i+1)+"' required/><br>");
			out.println("Seat preference: <input type='text' name='seat"+(i+1)+"' required/><br>");
			out.println("Meal preference: <input type='text' name='meal"+(i+1)+"' required/><br><br>");
			i++;
		}
		out.println("<input type='hidden' id='tripType' name = 'tripType' value='round'></input>");
		out.println("<input type='hidden' id='numPass' name = 'numPass' value='"+request.getParameter("numPass")+"'></input>");
		out.println("<input type='hidden' id='account' name = 'account' value='"+request.getParameter("account")+"'></input>");
		out.println("<input type='hidden' id='start' name = 'start' value='"+request.getParameter("start")+"'></input>");
		out.println("<input type='hidden' id='return' name = 'return' value='"+request.getParameter("return")+"'></input>");
		out.println("<input type='hidden' id='diffInDays' name = 'diffInDays' value='"+request.getParameter("diffInDays")+"'></input>");		
		
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
		}
		else{
			account_no = request.getParameter("account");
		}
		
		int i=0;
			
		String str = "SELECT max(ResNumber) from reservations";
		ResultSet rs = selectRequest(str);
		rs.next();
		int resno = rs.getInt(1);
		resno++;
		rs.close();
		
		str = "select FIFare from flightinfo where FINumber="+flightNum+";";
		rs = selectRequest(str);
		rs.next();
		double fare = rs.getDouble(1);

		fare *= num;

		rs.close();
		
		str = "select FIFare from flightinfo where FINumber="+retflightNum+";";
		rs = selectRequest(str);
		rs.next();
		fare += rs.getDouble(1);
		double booking = 0;
		String rest = "";
		rs.close();
		
		if(daysBet(new java.util.Date(),getDate(startDept))>30){
			rest = "Early; ";
			fare *= .8;
		}

		int diffInDays = 0;
		try{
			diffInDays = Integer.parseInt((request.getParameter("diffInDays")).trim());
		}catch(NumberFormatException e){
		}
		
		if(diffInDays >= 5){
			rest+= "Extended;";
			fare *= .9;
		}
		
		DecimalFormat decim = new DecimalFormat("0.00");
		Double fareFormat = Double.parseDouble(decim.format(fare));
		
		if(session.getAttribute("type").equals("employee")){
			booking = 35.00;
		}
		
		try{
			Connection con = dbConnect();
			
			//enter into reservations
			PreparedStatement statement = con.prepareStatement("INSERT INTO reservations VALUES ( ?, ?, ?, ?, ?)");
			statement.setInt(1, resno);
			statement.setString(2, formatDate(new java.util.Date()));
			statement.setDouble(3, fareFormat);
			statement.setString(4, rest);
			statement.setDouble(5, booking);
			statement.execute();
			statement.close();
			out.println("Reservation number "+resno+" created for account number "+account_no+".");
			if(rest!=null && (rest.equals("Early; ")||rest.equals("Early; Extended;"))){
				out.println("You saved 20% by booking early!");
			}
			if(rest!=null && (rest.equals("Early; Extended;")||rest.equals("Extended;"))){
				out.println("You saved 10% by staying 5 or more days!");
			}
			
			//write to has
			statement = con.prepareStatement("INSERT INTO has VALUES (?, ?, ?)");
			statement.setInt(1, resno);
			statement.setString(2, flightNum);
			statement.setString(3, startDept);
			statement.execute();
			statement.setString(2, retflightNum);
			statement.setString(3, retstartDept);
			statement.execute();
			statement.close();
//			out.println("Flights saved");
			
			//write to makes
			statement = con.prepareStatement("INSERT INTO makes VALUES(?, ?, ? )");
			statement.setInt(1,resno);
			statement.setString(2,account_no);
			if(session.getAttribute("type").equals("employee")){
				statement.setString(3,String.valueOf(session.getAttribute("ssn")));
			}else{
				statement.setString(3,null);
			}
			statement.execute();
			statement.close();
//			out.println("Saved to makes");
			
			//enter into passengers
			for(int j=0; j < num; j++){
				statement = con.prepareStatement("INSERT INTO passenger VALUES(?, ?, ?, ?)");
				statement.setInt(1,resno);
				statement.setString(2,(request.getParameter("pass"+(j+1))));
				statement.setString(3,(request.getParameter("seat"+(j+1))));
				statement.setString(4,(request.getParameter("meal"+(j+1))));
				statement.execute();
				statement.close();
//				out.println("Passengers updated");
			}	

		
			con.close();
		
		}catch(SQLException e){out.println(e.getMessage());}
		
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
		int i = 0;
		out.println("<form method='post' action='book.jsp'>");
		if(session.getAttribute("type").equals("customer")){
			
			out.println("Passenger#1: <input type='text' name='pass1' value='"+session.getAttribute("fname")+" "+session.getAttribute("lname")+"' required/><br>");
			out.println("Seat preference: <input type='text' name='seat1' value='"+session.getAttribute("seat")+"' required/><br>");
			out.println("Meal preference: <input type='text' name='meal1' value='"+session.getAttribute("meal")+"' required/><br>");
			i=1;
		}
		
		while (i < num){
			out.println("Passenger#"+(i+1)+": <input type='text' name='pass"+(i+1)+"' required/><br>");
			out.println("Seat preference: <input type='text' name='seat"+(i+1)+"' required/><br>");
			out.println("Meal preference: <input type='text' name='meal"+(i+1)+"' required/><br><br>");
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
		}
		else{
			account_no = request.getParameter("account");
		}
		
		int i=0;
			
		String str = "SELECT max(ResNumber) from reservations";
		ResultSet rs = selectRequest(str);
		rs.next();
		int resno = rs.getInt(1);
		resno++;
		rs.close();
		
		//str = "select FLFare from flights where FLNumber="+flightNum+";";
		str = "select FIFare from flightinfo where FINumber="+flightNum+";";
		rs = selectRequest(str);
		rs.next();
		double fare = rs.getDouble(1);

		fare *= num;

		double booking = 0;
		String rest = null;
		rs.close();
		
		if(daysBet(new java.util.Date(),getDate(startDept))>30){
			rest = "Early; ";
			fare *= .8;
		}
		else{
//			out.println("not early .  "+getDate(startDept)+"\n");
		}
		
		DecimalFormat decim = new DecimalFormat("0.00");
		Double fareFormat = Double.parseDouble(decim.format(fare));
		
		if(session.getAttribute("type").equals("employee")){
			booking = 35.00;
		}
		try{
			Connection con = dbConnect();
			
			//enter into reservations
			PreparedStatement statement = con.prepareStatement("INSERT INTO reservations VALUES ( ?, ?, ?, ?, ?)");
			statement.setInt(1, resno);
			statement.setString(2, formatDate(new java.util.Date()));
			statement.setDouble(3, fareFormat);
			statement.setString(4, rest);
			statement.setDouble(5, booking);
			statement.execute();
			statement.close();
			out.println("Reservation number "+resno+" created for account number "+account_no+".");
			if(rest!=null && (rest.equals("Early; "))){
				out.println("You saved 20% by booking early!");
			}

			//write to has
			statement = con.prepareStatement("INSERT INTO has VALUES (?, ?, ?)");
			statement.setInt(1, resno);
			statement.setString(2, flightNum);
			statement.setString(3, startDept);
			statement.execute();
			statement.close();
//			out.println("Flight saved");
			
			//write to makes
			statement = con.prepareStatement("INSERT INTO makes VALUES(?, ?, ? )");
			statement.setInt(1,resno);
			statement.setString(2,account_no);
			if(session.getAttribute("type").equals("employee")){
				statement.setString(3,String.valueOf(session.getAttribute("ssn")));
			}else{
				statement.setString(3,null);
			}
			statement.execute();
			statement.close();
//			out.println("Saved to makes");
			
			//enter into passengers
			for(int j=0; j < num; j++){
				statement = con.prepareStatement("INSERT INTO passenger VALUES(?, ?, ?, ?)");
				statement.setInt(1,resno);
				statement.setString(2,(request.getParameter("pass"+(j+1))));
				statement.setString(3,(request.getParameter("seat"+(j+1))));
				statement.setString(4,(request.getParameter("meal"+(j+1))));
				statement.execute();
				statement.close();
//				out.println("Passengers updated");
			}
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
		int i = 0;
		out.println("<form method='post' action='book.jsp'>");
		if(session.getAttribute("type").equals("customer")){
			
			out.println("Passenger#1: <input type='text' name='pass1' value='"+session.getAttribute("fname")+" "+session.getAttribute("lname")+"' required/><br>");
			out.println("Seat preference: <input type='text' name='seat1' value='"+session.getAttribute("seat")+"' required/><br>");
			out.println("Meal preference: <input type='text' name='meal1' value='"+session.getAttribute("meal")+"' required/><br>");
			i=1;
		}
		
		while (i < num){
			out.println("Passenger#"+(i+1)+": <input type='text' name='pass"+(i+1)+"' required/><br>");
			out.println("Seat preference: <input type='text' name='seat"+(i+1)+"' required/><br>");
			out.println("Meal preference: <input type='text' name='meal"+(i+1)+"' required/><br><br>");
			i++;
		}
		out.println("<input type='hidden' id='tripType' name = 'tripType' value='multi'></input>");
		out.println("<input type='hidden' id='numPass' name = 'numPass' value='"+request.getParameter("numPass")+"'></input>");
		out.println("<input type='hidden' id='account' name = 'account' value='"+request.getParameter("account")+"'></input>");
		out.println("<input type='hidden' id='start' name = 'start' value='"+request.getParameter("start")+"'></input>");
		out.println("<input type='hidden' id='return' name = 'return' value='"+request.getParameter("return")+"'></input>");
		out.println("<input type='hidden' id='numcity' name = 'numcity' value='"+request.getParameter("numcity")+"'></input>");
		out.println("<input type='hidden' id='startDate' name = 'startDate' value='"+request.getParameter("startDate")+"'></input>");
		
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
		String dates[] = new String [numCities+1];
		while(i<numCities){
			String str1 = request.getParameter("mid"+i);
			String[] list = new String [3];
			try{
				list = str1.split("_");
				flightNums[i] = list[0];
				startAirs[i] = list[1];
				dates[i] = list[2];
			}catch(NullPointerException e){
				out.println("....."+e.getMessage());
				out.println(i);
				out.println(request.getParameter("mid"+i));
				return;
				}
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
		}
		else{
			account_no = request.getParameter("account");
		}
		
		i=0;
			
		String str = "SELECT max(ResNumber) from reservations";
		ResultSet rs = selectRequest(str);
		rs.next();
		int resno = rs.getInt(1);
		resno++;
		rs.close();

		double fare = 0;		
		i=0;
		try{
		while(i < numCities){		
			//str = "select FLFare from flights where FLNumber="+flightNums[i]+";";
			str = "select FIFare from flightinfo where FINumber="+flightNums[i]+";";
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
		
		fare *= num;
		
		DecimalFormat decim = new DecimalFormat("0.00");
		Double fareFormat = Double.parseDouble(decim.format(fare));
		
		double booking = 0;
		String rest = null;
		
		try{
			if(daysBet(new java.util.Date(),getDate(String.valueOf(request.getParameter("startDate"))))>30){
				rest = "Early; ";
				fare *= .8;
			}
			else{
//				out.println("ok... "+String.valueOf(request.getParameter("startDate")));
	//			out.println("not early .  "+getDate(String.valueOf(request.getParameter("startDate")))+"\n");
				
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
		statement.setDouble(3, fareFormat);
		statement.setString(4, rest);
		statement.setDouble(5, booking);
		statement.execute();
		statement.close();
		out.println("Reservation number "+resno+" created for account number "+account_no+".");
		if(rest!=null && (rest.equals("Early; "))){
			out.println("You saved 20% by booking early!");
		}

		//write to has
		for(int j=0;j<numCities;j++){
			statement = con.prepareStatement("INSERT INTO has VALUES (?, ?, ?)");
			statement.setInt(1, resno);
			statement.setString(2, flightNums[j]);
			statement.setString(3, dates[j]);
			statement.execute();
			statement.close();
//			out.println("Flight saved");
		}		
		
		
		//write to makes
		statement = con.prepareStatement("INSERT INTO makes VALUES(?, ?, ? )");
		statement.setInt(1,resno);
		statement.setString(2,account_no);
		if(session.getAttribute("type").equals("employee")){
			statement.setString(3,String.valueOf(session.getAttribute("ssn")));
		}else{
			statement.setString(3,null);
		}
		statement.execute();
		statement.close();
//		out.println("Saved to makes");
		



		//write to passenger
		for(int j=0; j < num; j++){
			statement = con.prepareStatement("INSERT INTO passenger VALUES(?, ?, ?, ?)");
			statement.setInt(1,resno);
			statement.setString(2,(request.getParameter("pass"+(j+1))));
			statement.setString(3,(request.getParameter("seat"+(j+1))));
			statement.setString(4,(request.getParameter("meal"+(j+1))));
			statement.execute();
			statement.close();
//			out.println("Passengers updated");
		}
		
		
		
		con.close();
		}catch(SQLException e){out.println(e.getMessage());}
		
		
	//	out.println("INSERT INTO reservations values (1, )")
	}
	
}
 %>
 </div>
 <br><br><button type='button'> <a href="dashboard.jsp">Back to Dashboard</a></button></body></html>