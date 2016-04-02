<%@ page pageEncoding="UTF-8"%>
<div data-role="header" id="header">
	<a href="#popupMenu" data-rel="popup" data-transition="turn" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-bars ui-btn-icon-left ui-btn-a"></a>
	<h1>OneS</h1>
	<a id="hangUpBtn" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a"><img src="${pageContext.request.contextPath}/assets/img/telexit.png"></a>
</div>

<div data-role="popup" id="popupMenu" data-theme="a">
        <ul data-role="listview" data-inset="true" style="min-width:210px;">
			<li><a id="homeBtn" class="ui-btn ui-corner-all ui-shadow ui-btn-inline">HOME</a></li>
		    <li><a id="fileSelectBtn" href="#popupDialog" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow ui-btn-inline">파일전송</a></li>
		    <li><a id="saveBtn" class="ui-btn ui-corner-all ui-shadow ui-btn-inline">대화내용저장</a></li>
		 </ul>
</div>


<div data-role="popup" id="popupDialog" data-overlay-theme="a" data-theme="a" data-dismissible="false" style="max-width:400px;">
	<div data-role="header" data-theme="a">
		<h1>File Transfer</h1>
	</div>
	<div role="main" class="ui-content">
		<h3 class="ui-title">파일을 선택해 주세요</h3>
		<input type="file" data-clear-btn="true" id="sendFileInput" name="files" value="">
		<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a" data-rel="back">취소</a>
		<a href="#"  id="sendFileBtn" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a" data-rel="back" data-transition="flow">전송</a>
	</div>
</div>
