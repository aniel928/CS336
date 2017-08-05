<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Dashboard</title>
<style>
button.accordion {
    background-color: #eee;
    color: #444;
    cursor: pointer;
    padding: 18px;
    width: 100%;
    text-align: left;
    border: none;
    outline: none;
    transition: 0.4s;
}



button.expand{
    background-color: white;
    color: black;
    cursor: pointer;
    padding: 18px;
    width: 100%;
    text-align: center;
    border: none;
    outline: none;
    transition: 0.4s;
}


/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
button.accordion.active, button.accordion:hover {
    background-color: #ddd;
}

/* Style the accordion panel. Note: hidden by default */
div.panel {
    padding: 0 18px;
    background-color: white;
    display: none;
}
</style>

</head>
<body>
	<%
		try {
			//store userName
			String uname=request.getParameter("userID");
			
			Connection con = dbConnect();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = "SELECT * FROM users WHERE username='"+ uname + "' AND password='" + request.getParameter("password")+"';";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			if(!result.next()){
				out.println("<form method='post'><input type='hidden' id='errormsg' name = 'error' value='error'></input></form>");
				response.sendRedirect("index.jsp?error=error");
				return;
			}
			else{
			
				//logic to build dashboard
				//TODO:this needs to be primary key, not name
				session.setAttribute("username", result.getString(1)); 
				session.setAttribute("fname", result.getString(5));
				session.setAttribute("lname",result.getString(6));
				session.setAttribute("address", result.getString(7));
				session.setAttribute("city", result.getString(8));
				session.setAttribute("state", result.getString(9));
				session.setAttribute("zip", result.getString(10));
				session.setAttribute("type", result.getString(18));
				if(session.getAttribute("type").equals("customer")){
					session.setAttribute("account_no", result.getString(3));
					session.setAttribute("email", result.getString(11));
					session.setAttribute("acctDate", result.getString(13));
					session.setAttribute("ccnum", result.getString(14));
					session.setAttribute("seat", result.getString(15));
					session.setAttribute("meal", result.getString(16));
				}
				else{
					session.setAttribute("ssn", result.getString(4));
					session.setAttribute("city", result.getString(12));
					session.setAttribute("startdate", result.getString(17));
				}
				
				out.println("<h1>Welcome, " + session.getAttribute("fname") +"!</h1>");
				
			
				
				//reservation panel
				
			
				out.println("<button class='accordion'>Reservations</button>");
				out.println("<div class='panel'>");
				
					out.println("<form method=get action='temp.jsp'>");
					
					if(session.getAttribute("type").equals("customer") || session.getAttribute("type").equals("employee")){
						out.println("<button class= 'expand' name='makeRes' value='makeRes'>Make Reservation</button> <br> <br>");
						out.println("<button class= 'expand' name='viewMine' value='viewMine'>View My Reservations</button> <br> <br>");
					}
					
					if(session.getAttribute("type").equals("employee") || result.getString(18).equals("manager")) {
						out.println("<button class= 'expand' name='viewRes' value='viewRes'>View All Reservation</button> <br> <br>");
					}
				
					out.println("</form>");
				out.println("</div>");
				
				
				//customer panel
				
				out.println("<button class='accordion'>Customer</button>");
				out.println("<div class='panel'>");
					
					out.println("<form method=get action='temp.jsp'>");
					
					if(session.getAttribute("type").equals("customer") || session.getAttribute("type").equals("employee")){
						out.println("<button class= 'expand' name='viewProfile' value='viewProfile'>View Profile</button> <br> <br>");
						
					}
					if(session.getAttribute("type").equals("employee")){
						out.println("<button class= 'expand' name='mailList' value='mailList'>Mail List</button> <br> <br>");
					}
					if(session.getAttribute("type").equals("manager")) {
						out.println("<button class= 'expand' name='addUser' value='addUser'>Add User </button> <br> <br>");
						out.println("<button class= 'expand' name='viewUsers' value='viewUsers'>View Users </button> <br> <br>");
					}

					out.println("<button class= 'expand' name='editProfile' value='editProfile'>Edit Profile</button> <br> <br>");
					
					out.println("</form>");
				out.println("</div>");
				
				//flight panel
				
				out.println("<button class='accordion'>Flights</button>" );
				out.println("<div class='panel'>");
				
					out.println("<form method=get action='temp.jsp'>");
					
					if(session.getAttribute("type").equals("customer")){
						out.println("<button class= 'expand' name='viewPopular' value='viewPopular'>View Popular Flights</button> <br> <br>");
					}

					out.println("<button class= 'expand' name='viewFlights' value='viewFlights'>View All Flights </button> <br> <br>");
					
					out.println("<button class= 'expand' name='viewFlights' value='viewFlights'>Flights Lookup</button> <br> <br>");
					
					out.println("</form>");
					
				out.println("</div>");
				
				//Revenue Panel
				if(session.getAttribute("type").equals("employee") || result.getString(18).equals("manager")) {	
					out.println("<button class='accordion'>Revenue</button>");
					out.println("<div class='panel'>");
					
					out.println("<form method=get action='temp.jsp'>");
				
						out.println("<button class= 'expand' name='salesReport' value='salesReport' >Sales Report</button> <br> <br>");
						out.println("<button class= 'expand' name='Summary' value='Summary'>Summary</button> <br> <br>");
						out.println("</div>");
					
					out.println("</form>");
					
					out.println("</div>");
					
				}
				
				out.println("<button style= 'margin-top:1cm' class='logout' name='logout' value='logout'>Log Out</button><br><br>");
				
				
				out.println("</form>");
				
				
	
			
				
				
				//close the connection.
				con.close();
			}
		} catch (Exception e) {
			out.println(e.getMessage());
			out.println("Uh oh");
		}
	%>
	<script>
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	    acc[i].onclick = function(){
	        this.classList.toggle("active");
	
	        var panel = this.nextElementSibling;
	        if (panel.style.display === "block") {
	            panel.style.display = "none";
	        } else {
	            panel.style.display = "block";
	        }
	    }
	}
	</script>
	</body>
</html>