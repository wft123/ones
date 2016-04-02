<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/assets/css/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/chat.css" />
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>

	<div data-role="page" id="pageone">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		
		<div data-role="main" class="ui-content">
			<div id="videoArea"><video id="remoteVideo" autoplay></video></div>
			<div id="myCam" onmousedown="startDrag(event, this)"><video id="localVideo" autoplay muted></video></div>
			<ul id="receivedChatArea"></ul>
		</div>
		
		<div data-role="footer"  id="footer">
			<div id="navbar" data-role="navbar">
				<form onsubmit="return false;">
					<input id="sendChatArea"  type="text" /> 
					<input id="sendChatBtn" type="submit" data-inline="true"  value="전송" />
				</form>
			</div>
		</div>
		
	</div>
	<input type="hidden" id="ip" value="${ip }"/>
	<input type="hidden" id="key" value="${key }"/>
	<input type="hidden" id="name" value="${name }"/>
	
	<script src="https://${ip }:30000/socket.io/socket.io.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/ga.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/adapter.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/ClevisURL.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/main2.js"></script>
	<script>
    	$("#receivedChatArea").css("height",$(window).height()-160);
    	$("#tables").css("display","none");
    	$("#popupMenu>ul>li").on("click",function(){$("#popupMenu").popup("close");});
    	$("#homeBtn").on("click",function(){setTimeout("location.href='${pageContext.request.contextPath}/'",500);});
    	$("#fileSelectBtn").on("click",function(){
			setTimeout(function(){  $("#popupDialog").popup("open"); }, 500);
		});
    	$("#hangUpBtn").on("click",function(){
    		if(confirm("통화를 종료하시겠습니까?")){
    			closeVideo();
    			hangupMediaCall('video');
			}
    	});
    	
    	var openVideo = function(){
    		if($("#videoArea").height()==0){
	    		$("#receivedChatArea").animate({height:($(window).height()-160)/2}, "slow",function(){
		    		document.getElementById("receivedChatArea").scrollTop=document.getElementById("receivedChatArea").scrollHeight;
	    		});
	    		$("#videoArea").animate({height:($(window).height()-160)/2}, "slow",function(){
	    			$("#myCam").css("top",$("#videoArea").offset().top);
		    		$("#myCam").css("left",$("#videoArea").offset().left);
		    		$("#myCam").fadeIn("slow");
		    		$("#hangUpBtn").fadeIn("slow");
	    		});
    		}
    	}
    	
    	var closeVideo = function(){
    		if($("#videoArea").height()!=0){
	    		$("#hangUpBtn").fadeOut("fast");
	    		$("#myCam").fadeOut("fast");
	    		$("#videoArea").animate({height:'0'}, "slow");
	    		$("#receivedChatArea").animate({height:$(window).height()-160}, "slow");
    		}
    	}
    	
		var img_L = 0;
		var img_T = 0;
		var targetObj;

		function getLeft(o) {
			return parseInt(o.style.left.replace('px', ''));
		}
		function getTop(o) {
			return parseInt(o.style.top.replace('px', ''));
		}

		// 이미지 움직이기
		function moveDrag(e) {
			var e_obj = window.event ? window.event : e;
			var dmvx = parseInt(e_obj.clientX + img_L);
			var dmvy = parseInt(e_obj.clientY + img_T);

			var limitMinX = $("#videoArea").offset().left;
			var limitMinY = $("#videoArea").offset().top;
			var limitMaxX = limitMinX
					+ ($("#videoArea").width() - $("#myCam").width());
			var limitMaxY = limitMinY
					+ ($("#videoArea").height() - $("#myCam").height());
			if (dmvx < limitMinX)
				dmvx = limitMinX;
			if (dmvx > limitMaxX)
				dmvx = limitMaxX;
			if (dmvy < limitMinY)
				dmvy = limitMinY;
			if (dmvy > limitMaxY)
				dmvy = limitMaxY;

			targetObj.style.left = dmvx + "px";
			targetObj.style.top = dmvy + "px";
			return false;
		}

		// 드래그 시작
		function startDrag(e, obj) {
			targetObj = obj;
			var e_obj = window.event ? window.event : e;
			img_L = getLeft(obj) - e_obj.clientX;
			img_T = getTop(obj) - e_obj.clientY;

			document.onmousemove = moveDrag;
			document.onmouseup = stopDrag;
			if (e_obj.preventDefault)
				e_obj.preventDefault();
		}

		// 드래그 멈추기
		function stopDrag() {
			document.onmousemove = null;
			document.onmouseup = null;
		}
	</script>

</body>
</html>