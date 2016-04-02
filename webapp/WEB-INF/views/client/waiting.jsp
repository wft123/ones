<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>OneS</title>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/assets/css/jquery.mobile-1.4.5.min.css">
<link href="${pageContext.request.contextPath}/assets/css/waiting.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.mobile-1.4.5.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugin/jquery.bxslider/jquery.bxslider.min.js"></script>
</head>
<body>
	<div data-role="page" id="pageone">
		
		<div data-role="main" class="ui-content">

			<p><img src="${pageContext.request.contextPath }/assets/img/loading.gif"/></p>
			<div id="panel">
				<p>현재 대기인원</p>
				<div id="wait"></div>
			</div>
			
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
		
	</div>
	
	<script src="https://${ip }:30000/socket.io/socket.io.js"></script>
	<script>
	$(function(){
		var socket = io.connect('https://${ip }:30000');
		var name = '${name }';
		var key = '${key }';
		var time = '${time }';
		var waitUsers = $('#wait');
		
		if(key.length!=0){
			socket.emit('new client', {nick:name, room: key, time: time }, function(data){
			});
		} 
		
		$('.ui-content').css("height",$(window).height()-62);
		
		socket.on('waitUsers', function(data){
			waitUsers.html(data+"명");
		});
		
		socket.on('go Chat', function(data) {
			var url ="${pageContext.request.contextPath}/chat/?name="+name+"&key="+data.roomname.substring(2);
			$(location).attr('href',url);
		});
	});
	</script>
</body>
</html>