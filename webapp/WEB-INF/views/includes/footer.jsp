<%@ page pageEncoding="UTF-8"%>
<div data-role="footer"  id="footer">
	<div data-role="navbar">
		<ul>
			<li><a id="leafletBtn" href="#" data-icon="grid">FINANCE</a></li>
			<li id="homeBtn"><a data-icon="home">Home</a></li>
			<!--  <li id="infoBtn"><a href="#infoDialog" data-rel="popup" data-position-to="window" data-transition="pop" data-icon="info">Information</a></li>-->
			<li><a id="infoBtn" href="#"  data-icon="info">Information</a></li>
		</ul>
	</div>
</div>

<!-- Leaflet -->
<div data-role="popup" id="leafletDialog" data-overlay-theme="a"	data-theme="a" style="max-width: 310px; margin-left: -10px;">
	<div role="main" class="ui-content">
		<h3 class="notiTitle">
			<a	href="">&lt; 금융상품	&gt;</a>
		</h3>
		<div class="leafletWrapper">
			<ul class="lbxslider">
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_01.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_02.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_03.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_04.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_05.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_06.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_07.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_08.jpeg" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_09.png" /></li>
				<li><img src="${pageContext.request.contextPath}/assets/img/leaflet/Leaflet_10.jpeg" /></li>
			</ul>
		</div>
	
		
	</div>
</div>
<!-- /Leaflet -->

<!-- infomation -->
<div data-role="popup" id="infoDialog" data-overlay-theme="a"	data-theme="a" style="max-width: 310px; margin-left: -10px;">
	<div role="main" class="ui-content">
	<div id="notify">
		<div class="title">
			<a href="http://www.hanabank.co.kr/nhana/customer/customer05/CaNew0001/index.jsp" target="_blank"> 새소식 > </a>
		</div>
		<ul>
			<li><a href="http://www.hanabank.co.kr/nhana/customer/customer05/CaNew0001/1418926_104363.jsp?Ctype=B&cid=HUB_News&oid=1418926" target="_blank">그룹사간 고객정보 제공내역조회 오...</a></li>
			<li><a href="http://www.hanabank.co.kr/nhana/customer/customer05/CaNew0001/1420162_104363.jsp?Ctype=B&cid=HUB_News&oid=1420162" target="_blank">KEB하나은행 소유 부동산 매각 공고</a></li>
			<li><a href="http://www.hanabank.co.kr/nhana/customer/customer05/CaNew0001/1418238_104363.jsp?Ctype=B&cid=HUB_News&oid=1418238" target="_blank">금융거래 한도계좌 시행 안내</a></li>
		</ul>
	</div>

		<!-- event -->
		<div class="notiEvent">
			<h3 class="notiTitle">
				<a	href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/index.jsp">이벤트	&gt;</a>
			</h3>
			<div class="eventList">
				<ul class="rollingList bxslider">
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0503/customer201603/index.jsp" target="_blank">
						최고 지역KEB하나은행<br><strong>고객 사은 이벤트!!</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1419160_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1419160" target="_blank">
						깨어나라, 연금저축! 일어나라...<br><strong>'연금저축 계좌이체' 이벤트</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1418939_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1418939" target="_blank">
						온라인환전<br><strong>머니? 머니! 이벤트</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1418881_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1418881" target="_blank">
						절세 만능통장(ISA) 출시<br><strong>소원을 말해봐! 이벤트</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1418844_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1418844" target="_blank">
						상품 가입하면 하나머니 적립<br><strong>따스한 봄날 행복한 이벤트</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1418230_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1418230" target="_blank">
						가족의 생명과 안전을 지키는<br><strong>119생명지킴이 이벤트~!</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1418211_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1418211" target="_blank">
						비과세 해외주식투자전용 펀드<br><strong>신규 가입 이벤트</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1417017_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1417017" target="_blank">
						연금펀드 인터넷뱅킹 오픈기념<br><strong>"열려라, 연금펀드"</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1416976_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1416976" target="_blank">
						계좌이동서비스 변경 이벤트<br><strong>하나로 모아~!!</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1417259_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1417259" target="_blank">
						하나멤버스 가입 이벤트!<br><strong>힘내라 청춘~!</strong>					</a></li>
					<li style="display: none"><a href="http://www.hanabank.co.kr/nhana/customer/customer05/customer0502/CaEve0001/1416130_101519.jsp?page=1&Ctype=B&cid=Hub_Roll_BN&oid=1416130" target="_blank">
						G마켓.옥션 적금고객 用<br><strong>1Q카드 출시이벤트</strong>					</a></li>
				</ul>
			</div>
		</div>
		<!-- //event -->
		<h3 class="serviceTitle">
				<a	href="/nhana/customer/customer05/customer0502/CaEve0001/index.jsp">관련서비스	&gt;</a>
		</h3>
		<table class="hana_service">
		<tr>
			<td class="icon"><a href="https://play.google.com/store/apps/details?id=com.hanabank.ebk.channel.android.hananbank">
				<img class="icon" src="${pageContext.request.contextPath }/assets/img/icon/01_1Q_Bank_icon.png">
			</a></td>
			<td class="icon"><a href="https://play.google.com/store/apps/details?id=com.keb.android.mbank">
				<img class="icon" src="${pageContext.request.contextPath }/assets/img/icon/02_smart_bank_icon_white.png">
			</a></td>
			<td class="icon"><a href="https://play.google.com/store/apps/details?id=kr.co.hanamembers.hmscustomer">
				<img class="icon" src="${pageContext.request.contextPath }/assets/img/icon/03_hana_members_icon.png">
			</a></td>
		</tr>
		<tr>
			<td class="icon"><a href="https://play.google.com/store/apps/details?id=com.hanaskcard.rocomo.potal">
				<img class="icon" src="${pageContext.request.contextPath }/assets/img/icon/04_hana_card_icon.png">
			</a></td>
			<td class="icon"><a href="https://play.google.com/store/apps/details?id=com.hanaskcard.paycla">
				<img class="icon" src="${pageContext.request.contextPath }/assets/img/icon/05_mobi_pay_icon.png">
			</a></td>
			<td class="icon"><a href="https://play.google.com/store/apps/details?id=com.hanawm.derivatives">
				<img class="icon" src="${pageContext.request.contextPath }/assets/img/icon/06_hana_wm_icon.png">
			</a></td>
		</tr>
	</table>
	</div>
</div>
<!-- /infomation -->
<script>
$(document).ready(function () {
	$(".bxslider").find("li").show();
	$('.bxslider').bxSlider({
		auto:true,
		mode:'vertical',
		autoControls : true,
		controls : false,
		slideMargin:15
	});
	$('.lbxslider').bxSlider({
		auto:true,
		autoControls : true,
		adaptiveHeight: true,
		controls : false,
		slideMargin:15
	});
	
	$("#leafletBtn").on("click",function(){
		$("#leafletDialog").popup("open");
	});
	$("#homeBtn").on("click",function(){
		setTimeout("location.href='${pageContext.request.contextPath}/'",100);
	});
	$("#infoBtn").on("click",function(){
		$("#infoDialog").popup("open");
	});

});
</script>
