<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<c:set var="userID" value= "null"/>
<c:if test="${sessionScope.userID != null}">
	<c:set var="userID" value= "${sessionScope.userID}"> </c:set>
	<c:set var="rid" value= "${sessionScope.rid}"> </c:set>
	<c:set var="grade" value= "${sessionScope.grade}"> </c:set>
</c:if>
<c:out value="현재 접속 아이디: ${userID}"></c:out>
<c:out value="현재  이력서: ${rid}"></c:out>
<c:out value="현재  등급: ${grade}"></c:out>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>취업 정보 사이트</title>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script type="text/javascript">

	function getUnread() {
		$.ajax({
			type: "post",
			url: "../user/chatUnread",
			data:{
				userID: encodeURIComponent("${userID}"),
			},
		success: function (result) {
			if(result >= 1){
				showUnread(result);
			}else{
				showUnread(' ');
			}
		}
		});
	}
	function getInfiniteUnread() {
		 setInterval(function () {
			getUnread();
		}, 1000);
	}
	function showUnread(result) {
		$('#unread').html(result);
		$('#faq').html("new");
	}
	function chatBoxFunction() {
		var userID = '${userID}'
		$.ajax({
			type: "post",
			url: "../chat/chatBox",
			data:{
				userID: encodeURIComponent('${userID}')
			},
		success: function (data) {
			var parsed = JSON.parse(data);
			var result = parsed.result;
				for(var i = 0; i<result.length; i++){
				if(result[i][0].value == "${userID}"){
					result[i][0].value=result[i][1].value;
				}else{
					result[i][1].value=result[i][0].value;
				}
				addCBox(result[i][0].value , result[i][1].value , result[i][2].value , result[i][3].value , result[i][4].value ,result[i][5].value)
			}
		}
		});
	}
	function addCBox(lastID,toID,chatContent,chatTIme,unread,profile) {
		$('#boxTable').append('<tr onclick="location.href=\' ../chat/chat?toID=' + encodeURIComponent(toID) + '\'">' +
				'<td style="width:150px;">' +
				'<img class="media-object img-circle" style="margin: 0 auto; max-width: 40px; max-height: 40px;" src="' + profile + '">' +
				'<h5>' + lastID + '</h5></td>'+
				'<td>' +
				'<h5>' + chatContent + '</h5>' +
				'<span class="label label-info">' +unread + '</span>' +	
				'<div class="pull-right">' + chatTIme + '</div>' + 
				'</td>' +
				'</tr>');
	}
	function getInfiniteBox() {
		setInterval(function () {
		}, 3000);
	}
	

	</script>
</head>	
<body>
		
		<nav class="navbar navbar-default" style="color: lightseagreen;"> 
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				
			</button>
		</div>
		<div>
			<a class="navbar-brand" href="../main/main.jsp"><img src="../img/logo.png" width="200" height="200" align="left"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="font-size: 30px; padding-top: 150px; padding-left: 350px; background-color: white;" >
			<ul class="nav navbar-nav" id="ulbaridmatumoto"> 
					<li><a href="../main/main.jsp" style="color: lightseagreen;">메인</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">API정보<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../apiIntern/apiView.jsp">인턴</a></li>
									<li class><a href="userProfile">행사</a></li>
									<li class><a href="logoutAction.jsp">구인</a></li>
							</ul>
					</li>	
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">파트너쉽<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../freelancer/freelancer_include.jsp">프리랜서</a></li>
									<li class><a href="userProfile">구인구직</a></li>
									<li class><a href="logoutAction.jsp">헤드헌터</a></li>
							</ul>
					</li>	
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">커뮤니티<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../Community/bbs">자유게시판</a></li>
							</ul>
					</li>	
					<li><a href="../message/box.jsp">메시지함<span id="unread" class="" style="color: green; font-size: 30px;" ></span></a></li>
					<li><a href="../faq/faqbbs">공지사항<span id="faq" class="" style="color: red; font-size: 15px;" ></span></a></li>
			</ul>
			<!-- 로그인 판단 -->
				<c:if test="${sessionScope.userID == null}">
				<ul class="nav navbar-nav navbar-right" id="ulbaridmatumoto2">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../login/login.jsp">로그인</a></li>
									<li><a href="../join/join.jsp">회원가입</a></li>
							</ul>
				</li>	
		</ul>
		</c:if>
		<c:if test="${sessionScope.userID != null}">
			<c:if test="${sessionScope.rid == ''}">
			<ul class="nav navbar-nav navbar-right" id="ulbaridmatumoto3">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../user/userUpdate">회원 기본정보</a></li>
									<li class><a href="../user/userProfile">회원 프로필 사진 </a></li>
									<li class><a href="../resume/resume.jsp">이력서 등록 </a></li>
									<li><a href="../find/find.jsp">친구찾기</a></li>
									<li class><a href="../logout/logoutAction.jsp">로그아웃</a></li>
							</ul>
					</li>	
			</ul>
			</c:if>
		</c:if>
		<!-- 이력서 판단 -->
		<c:if test="${sessionScope.userID != null}">
			<c:if test="${sessionScope.rid != 0}">
			<ul class="nav navbar-nav navbar-right" id="ulbaridmatumoto3">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../user/userUpdate">회원 기본정보</a></li>
									<li class><a href="../user/userProfile">회원 프로필 사진 </a></li>
									<li class><a href="../resume/resumeupdate.jsp">이력서 수정 </a></li>
									<li><a href="../find/find.jsp">친구찾기</a></li>
									<li class><a href="../logout/logoutAction.jsp">로그아웃</a></li>
							</ul>
					</li>	
			</ul>
			</c:if>
		</c:if>
		<!-- 로그인 유무 판단 종료 -->
		</div>
	</nav>
	<!-- 네비 종료 -->
		<c:if test="${userID != null }">
		<script type="text/javascript">
			$(document).ready(function () {
				getUnread();
				getInfiniteUnread()
				chatBoxFunction();
				getInfiniteBox();
			});
		</script>
		</c:if>
</body>
</html>