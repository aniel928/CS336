<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>View Sales Report</title>
<body>
<div class="trans">
<h1>View Sales Report</h1>
<form method="post" action="ViewRevenue.jsp">

	<div style= "margin-top: 1cm">
		<select name= "months" id="months">
			<option value = "'1'">Jan</option>
			<option value = "'2'">Feb</option>
			<option value = "'3'">Mar</option>
			<option value = "'4'">Apr</option>
			<option value = "'5'">May</option>
			<option value = "'6'">Jun</option>
			<option value = "'7'">Jul</option>
			<option value = "'8'">Aug</option>
			<option value = "'9'">Sep</option>
			<option value = "'10'">Oct</option>
			<option value = "'11'">Nov</option>
			<option value = "'12'">Dec</option>
		</select>
		<select name = "years" id="years">
			<option value = "'2017'">2017</option>
			<option value = "'2018'">2018</option>
			<option value = "'2019'">2019</option>
		</select>
	</div>
	
	
	<div style= "margin-top: 1cm"><input type="submit" value="Submit"></div>

</form>
</div>
</body>
</html>