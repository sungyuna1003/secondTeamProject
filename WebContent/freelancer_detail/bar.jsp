<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>취업 정보 사이트</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" href="./css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script type="text/javascript">
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
			<a class="navbar-brand" href="../main/main.jsp"><img src="../img/logo.png" width="250" height="250" align="left"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="font-size: 30px; padding-top: 150px; padding-left: 350px;" >
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
									<li class><a href="../board_freelencer/free">프리랜서</a></li>
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
			<!-- 로그인 유무 판단 -->
				<ul class="nav navbar-nav navbar-right" id="ulbaridmatumoto2">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
							<!-- 임시의 주소링크 "#"을 기재한다. -->
							<!-- caret = creates a caret arrow icon (▼) -->
								<ul class="dropdown-menu">
									<!-- dropdown-menu : 버튼을 눌렀을때, 생성되는 메뉴(접속하기를 눌렀을때 로그인, 회원가입 메뉴 -->
									<li class><a href="../login/login.jsp">로그인</a></li>
									<!-- active = 활성화 되었을때 로그인, 회원가입-->
									<li><a href="../join/join.jsp">회원가입</a></li>
							</ul>
				</li>	
		</ul>
			<ul class="nav navbar-nav navbar-right" id="ulbaridmatumoto3">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li class><a href="../user/userUpdate">회원정보</a></li>
									<li class><a href="../user/userProfile">프로필 수정</a></li>
									<li><a href="../find/find.jsp">친구찾기</a></li>
									<li class><a href="../logout/logoutAction.jsp">로그아웃</a></li>
							</ul>
					</li>	
			</ul>
		<!-- 로그인 유무 판단 종료 -->
		</div>
	</nav>
	<!-- 네비 종료 -->
		<script type="text/javascript">
		</script>
</body>
</html>