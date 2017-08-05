<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>
	<title>Registration</title>
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
							out.println("<p style='color: red'><b>Passwords don't match, please try again.</b></p>");
						}
						else if(request.getParameter("error").equals("missing")){
							out.println("<p style='color: red'><b>Please fill out all applicable fields.</b></p>");
						}
						else if(request.getParameter("error").equals("primary")){
							out.println("<p style='color: red'><b>Missing registration type, account number, or SSN.</b></p>");
						}
						else if(request.getParameter("error").equals("exists")){
							out.println("<p style='color: red'><b>Username, Account Number, or SSN taken. Please enter new one.</b></p>");
						}
					} 
					catch(Exception e){
						
					}%>
					<div id = "Employee" class = "inv">
						<h3>Employee Information</h3>
						<label>SSN: (9 digits)</label><input id = "field" type="text" pattern='\d{9}' name='ssn'/>
					</div>
					<div id = "Customer" class = "inv">
						<h3>Customer Information</h3>
						<div>
							<label>Account Number: (10 digits)</label><input type="text" pattern='\d{10}' name='account_no'/>
						</div>
						
						<div>
							<label>Seat Preference:</label><input type="text" name='seat_preference' required/>
						</div>
							
						<div>
							<label>Meal Preference:</label><input type="text" name='meal_preference' required/>
						</div>
						
						<div>
							<label>Credit Card Number: (16 digits)</label>
							<input type="text" pattern='\d{16} name='CC_number'/>
						</div>
					</div>
					
					<h3>Account Basics</h3>
					
    				<div>
						<label>First Name:</label><input id = "field" type="text" name='first_name' required/>
					</div> 
					 
					<div>
						<label>Last Name:</label><input id = "field" type="text" name='last_name' required/>
					</div> 
					
					
					<div>
						<label>Username:</label><input id = "field" type="text" name='username' required/>
					</div>
											
					<div>
						<label>Password:</label> <input id = "field" type="password" name = "password" required>
					</div>
					
					<div>
						<label> Re-Type Password:</label> <input id = "field" type="password" name = "password2" required>
					</div>
					
		
					
					<h3>Address</h3>
					
					<div>
						<label>Street Address:</label><input id = "field" type="text" name='street_address'/ required>
					</div> 
					 
					<div>
						<label>City:</label><input id = "field" type="text" name='city' required/>
					</div> 
					<div>
						<label>State:(two capital letters)</label><input id = "field" type="text" pattern='[A-Z]{2}' name='state'required/>
					</div> 
					<div>
						<label>Zipcode: (5 digits)</label><input id = "field" type="text" pattern='\d{5}'name='zipcode'required/>
					</div> 
					 
					 <h3>Contact</h3>
					 
					<div>
						<label>Email:</label><input id = "field" type="text" name='email'required/>
					</div> 
					<div>
						<label>Phone: (10 digits, numbers only)</label><input id = "field"  type="tel" pattern='\d{10}' name='phone' required/>
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