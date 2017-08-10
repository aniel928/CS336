<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Summary</title>
</head>
<body>
<div class="trans">
<h1>Select Summary Type</h1>
<form method="post" action="Summary.jsp">
<select name = "showby" style= "margin-top: 1cm" id="showby">
	<option value = "1" selected= "selected">Flight</option>
	<option value = "2">Customer</option>
	<option value = "3">Airport</option>
</select>

	
<div style= "margin-top: 1cm"><input type="submit" value="Submit"></div>

</form>
</div>
</body>
</html>