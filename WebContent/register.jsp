<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	</head>
	<body>
		<h1>Please register below </h1>
		<br>
		<p> Choose registration type: 
		<select id = "acctType">
			<option selected disabled> ... </option>
			<option value = "Customer"> Customer </option>
			<option value = "Employee"> Employee </option>
		</select> </p>
		<div>
			<form method="post" action="registerMe.jsp">
					<%try{
						if(request.getParameter("error").equals("nopass")){				
							out.println("<tr><td style='color: red'><b>Passwords don't match, please try again.</b></td></tr>");
						}
						else if(request.getParameter("error").equals("missing")){
							out.println("<tr><td style='color: red'><b>Please fill out all applicable fields.</b></td></tr>");
						}
						else if(request.getParameter("error").equals("primary")){
							out.println("<tr><td style='color: red'><b>Missing account number or SSN.</b></td></tr>");
						}
						else if(request.getParameter("error").equals("exists")){
							out.println("<tr><td style='color: red'><b>Username taken, please pick different username.</b></td></tr>");
						}
					} 
					catch(Exception e){
						
					}%>
					<div id = "Employee" class = "inv">
						<h3>Employee Information</h3>
						<label>SSN:</label><input id = "field" type="text" name='ssn'/>
					</div>
					<div id = "Customer" class = "inv">
						<h3>Customer Information</h3>
						<label>Account Number:</label><input type="text" name='account_no'/>
						<label>Seat Preference:</label><input type="text" name='seat_preference'/>
						<label>Meal Preference:</label><input type="text" name='meal_preference'/>
						<label>Credit Card Number:</label><input type="text" name='CC_number'/>
					</div>
					
					<h3>Account Basics</h3>
					
    				<div>
						<label>First Name:</label><input id = "field" type="text" name='first_name'/>
					</div> 
					 
					<div>
						<label>Last Name:</label><input id = "field" type="text" name='last_name'/>
					</div> 
					
					
					<div>
						<label>Username:</label><input id = "field" type="text" name='username'/>
					</div>
											
					<div>
						<label>Password:</label> <input id = "field" type="password" name = "password">
					</div>
					
					<div>
						<label> Re-Type Password:</label> <input id = "field" type="password" name = "password2">
					</div>
					
		
					
					<h3>Address</h3>
					
					<div>
						<label>Street Address:</label><input id = "field" type="text" name='street_address'/>
					</div> 
					 
					<div>
						<label>City:</label><input id = "field" type="text" name='city'/>
					</div> 
					<div>
						<label>State:</label><input id = "field" type="text" name='state'/>
					</div> 
					<div>
						<label>Zipcode:</label><input id = "field" type="text" name='zipcode'/>
					</div> 
					 
					 <h3>Contact</h3>
					 
					<div>
						<label>Email:</label><input id = "field" type="text" name='city'/>
					</div> 
					<div>
						<label>Phone:</label><input id = "field"  type="tel" pattern='[\(]\d{3}[\)]\d{3}[\-]\d{4}' name='phone'/>
					</div>
					
							
    				
					<script>
	         		   document
	               			.getElementById('acctType')
	                		.addEventListener('change', function () {
	                    		'use strict';
			                    var vis = document.querySelector('.vis'),   
			                    	acctType = document.getElementById(this.value);
			                    if (vis !== null) {
			                        vis.className = 'inv';
			                    }
			                    if (acctType !== null ) {
			                    	acctType.className = 'vis';
			                    }
	         	   		});
	       			</script>	
	       			
				<div style= "margin-top: 1cm"><input type="submit" value="Register"></div>
			</form>
		</div>