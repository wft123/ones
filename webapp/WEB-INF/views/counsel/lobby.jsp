<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<title>OneS</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style>
.content { height:100%; }
th { text-align: center; }
</style>
</head>
<body>

	<div class="container">
		<c:import url="/WEB-INF/views/includes/counsel-header.jsp"/>
		<div class="wrapper">
			<div class="content">
				<ul id="tabs" class="nav nav-tabs nav-justified">
				  <li role="presentation" class="active"><a href="#">All</a></li>
				  <li role="presentation"><a href="#">Bank</a></li>
				  <li role="presentation"><a href="#">Card</a></li>
				  <li role="presentation"><a href="#">Capital</a></li>
				  <li role="presentation"><a href="#">Stock</a></li>
				</ul>
			
				<table id="rooms" class="table table-hover table-bordered">
					<tr>
						<th>업무 내용</th>
						<th>신청 시간</th>
					</tr>
				</table>				
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/counsel-footer.jsp"/>
	</div>
	
  	<script src="${pageContext.request.contextPath}/assets/js/notify.js"></script>
  	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://${ip }:30000/socket.io/socket.io.js"></script>
	<script>
		$(function(){
			var socket = io.connect('https://${ip }:30000');
			var $rooms = $('#rooms');
			var categori;
			
			$(".content").css("height",$(window).height()-120);
			
			socket.emit('get clientList');
			
			socket.on('rooms', function(data){
				categori = $(".active").children("a").text();
				var html = '<tr>';
				html += '<th>업무 내용</th>';
				html += '<th>신청 시간</th>';
				html += '</tr>';
				for(var key in data){
					if(categori==='All' || data[key].roomname.indexOf(categori)!=-1){
						html += '<tr class="roomname" id="'+key+'">'
						html += '<td>'+data[key].roomname+"</td>";
						html += '<td>'+data[key].time+"</td>";
						html += '</tr>'
					}
				}
				$rooms.html(html);
				if($(".roomname").length==0){
					html += '<tr><td colspan=2 align=center>대기 고객이 없습니다.</td></tr>';
					$rooms.html(html);
				}
			});
			
			socket.on('newClientJoin', function(data){
				if(categori==='All' || data.indexOf(categori)!=-1)		notifyMe(data);
			});
			
			$(document).on("click", ".roomname",function(e){
				var url ="${pageContext.request.contextPath}/counsel/chat/?name=${authUser.name}&key="+e.target.parentElement.id.substring(2);
				$(location).attr('href',url);
				socket.emit('pull client',{id : e.target.parentElement.id}, function(){});
			});
			
			$(document).on("click","#tabs > li", function(e){
				$(".active").removeClass();				
				$(this).addClass("active");
				socket.emit('get clientList');
			});
			
		})
	</script>
</body>
</html>