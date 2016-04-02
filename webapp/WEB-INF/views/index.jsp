<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>OneS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/assets/css/jquery.mobile-1.4.5.min.css">
<link href="${pageContext.request.contextPath}/assets/css/index.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/plugin/jquery.bxslider/jquery.bxslider.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.mobile-1.4.5.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugin/jquery.bxslider/jquery.bxslider.min.js"></script>
<style>
.bx-wrapper .bx-pager, .bx-wrapper .bx-controls-auto{ visibility: hidden; }
#menuPanel { display: inherit; }
</style>
</head>
<body>

	<div data-role="page" id="pageone">
		
		<div data-role="main" class="ui-content">
			<div id="slider">
				<ul class="mbxslider">
					<li><img src="${pageContext.request.contextPath}/assets/img/slider/ad01.png" /></li>
					<li><img src="${pageContext.request.contextPath}/assets/img/slider/ad02.png" /></li>
					<li><img src="${pageContext.request.contextPath}/assets/img/slider/ad03.png" /></li>
					<li><img src="${pageContext.request.contextPath}/assets/img/slider/ad04.png" /></li>
					<li><img src="${pageContext.request.contextPath}/assets/img/slider/ad05.png" /></li>
				</ul>
			</div>
			<div id="business">
				<div onclick='location.href="#bank"'><div>Bank</div></div>
				<div onclick='location.href="#card"'><div>Card</div></div>
				<div onclick='location.href="#capital"'><div>Capital</div></div>
				<div onclick='location.href="#stock"'><div>Stock</div></div>
			</div>
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
	
	
	<div data-role="page" id="bank">
	   
	   <div data-role="main" class="ui-content">
	   
			<div class="detailMenuImg">
				<img src="${pageContext.request.contextPath}/assets/img/slider/ad01.png" >
			</div>
			
	   		<div class="detailMenu" title="Bank">
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/account.png')">계 좌</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/bills.png')">공과금</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/deposit.png')">예 금</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/fe.png')">외 환</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/fund.png')">펀 드</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/loan.png')">대 출</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/cert.png')">공인인증</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/security.png')">개인금고</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/bank/etc.png')">기타상담</div>
	   		</div>
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div> 
	
	<div data-role="page" id="card">
	   
	   <div data-role="main" class="ui-content">
			
			<div class="detailMenuImg">
				<img src="${pageContext.request.contextPath}/assets/img/slider/ad02.png" >
			</div>
			
	   		<div class="detailMenu" title="Card">
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/guide.png')">안내</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/create.png')">발급</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/loss.png')">분실</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/cancel.png')">해지</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/details.png')">사용내역</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/atm.png')">ATM</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/oversee.png')">해외사용</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/security.png')">공인인증</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/card/etc.png')">기타상담</div>
	   		</div>
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div> 
	
	
	<div data-role="page" id="capital">
	   
	   <div data-role="main" class="ui-content">
			
			<div class="detailMenuImg">
				<img src="${pageContext.request.contextPath}/assets/img/slider/ad03.png" >
			</div>
			
	   		<div class="detailMenu" title="Capital">
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/product.png')">상 품</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/application.png')">신 청</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/search.png')">조 회</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/repay.png')">상 환</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/interest.png')">이 자</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/condition.png')">약 정</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/security.png')">담 보</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/certification.png')">공인인증</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/capital/etc.png')">기타상담</div>
	   		</div>
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div> 
	
	
	<div data-role="page" id="stock">
	   
	   <div data-role="main" class="ui-content">
		
			<div class="detailMenuImg">
				<img src="${pageContext.request.contextPath}/assets/img/slider/ad04.png" >
			</div>
			
	   		<div class="detailMenu" title="Stock">
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/product.png')">상 품</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/account.png')">계 좌</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/search.png')">조회</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/loan.png')">대 출</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/fund.png')">펀 드</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/insurance.png')">보 험</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/bond.png')">채 권</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/cert.png')">공인인증</div>
		   		<div style="background-image:url('${pageContext.request.contextPath}/assets/img/stock/etc.png')">기타상담</div>
	   		</div>
		</div>
		
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div> 
	
	<script>
		$('.detailMenu div').on("click", function(e){
			var url ="${pageContext.request.contextPath}/chat/waiting/?name=client&key="+ e.target.parentElement.title+"/"+e.target.innerText;
			$(location).attr('href',url);
		});
		$('.ui-content').css("height",$(window).height()-62);
		$(document).ready(function () {
			$('.mbxslider').bxSlider({
				auto : true,
				autoControls : true,
				useCSS:false,
				controls : false,
				pager : false
			});
		});
	</script>

</body>
</html>
