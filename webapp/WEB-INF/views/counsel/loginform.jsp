<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon"	href="${pageContext.request.contextPath}/assets/img/favicon.png">
<link	href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css"	rel="stylesheet" media="screen">
<link	href="${pageContext.request.contextPath}/assets/bootstrap/css/landing-page.css"	rel="stylesheet" media="screen">
<link	href="${pageContext.request.contextPath}/assets/bootstrap/font-awesome/css/font-awesome.min.css"	rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/assets/css/loginform.css"	rel="stylesheet" media="screen">

<title>OneS</title>

</head>
<body>
	<div class="container-fluid">
		<div class="header">
			<c:import url="/WEB-INF/views/includes/counsel-header.jsp" />
		</div>

		<div class="wrapper">
			<div class="content">
				<div class='form animated flipInX'>
					<h2>Login To Your ID</h2>
					<form id="login-form" name="loginform" method="post"
						action="${pageContext.request.contextPath}/counsel/loginSuccess">
						<input id="employeeId" name="employeeId" placeholder='ID'
							type='text'> 
						<input id="password" name="password"
							placeholder='password' type='password'>
						<button class='animated infinite pulse'>Login</button>
					</form>
				</div>
			</div>
		</div>

		<div class="footer">
			<c:import url="/WEB-INF/views/includes/counsel-footer.jsp" />
		</div>
	</div>
	
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>	
	<script>
	$(".content").css("height",$(window).height()-130);
	
	 $("input[type=submit]").click(function () {
	        $.ajax({
	          url: "loginSuccess",
	            type: "POST",
	            contentType: "application/json;charset=utf-8",
	            data: JSON.stringify({
	            	employeeId: $("input[placeholder=employeeId]").val(),
	                password: $("input[placeholder=password]").val()
	            }),
	            success: function (response) {
	                alert("success");
	            },
	            error: function (e) {
	                alert("error");
	            }
	        });
	    });
	</script>

</body>
</html>