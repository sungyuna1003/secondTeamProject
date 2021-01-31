<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "../bar/bar.jsp" %>
<%@include file= "../modal/modal.jsp" %>
<!DOCTYPE html>
<html>
<head>
<c:if test="${sessionScope.userID != null}">
	<c:set var="userID" value="${sessionScope.userID}"> </c:set>
</c:if>
<c:if test="${sessionScope.userID == null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="현재 로그인이 되어 있지 않습니다." scope="session"/>
	<c:redirect url="../main/main.jsp"/>
</c:if>
<title>JSP Ajax 실시간 회원제 채팅 서비스</title>
</head>	
<body>
<div class="container">
	<div class="jumbotron" style="background-color: white;">
		<div class="container" style="padding-top: 50px">
			<table class="table" style="margin: 0 auto;">
				<thead>
					<th><h4>주고받은 메시지 목록</h4></th>
				</thead>
				<div style="overflow-y: auto; width:100%; max-height: 450px;">
					<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid; #dddddd; margin: 0 auto;">
						<tbody id="boxTable">
						</tbody>
					</table>
				</div>
			</table>
			<p>
			<div align="right" style="padding-right: 18px">
					<button class="btn btn-primary" onclick="location.href='../find/find.jsp'" >새로운 상대와 대화</button>
			</div>
		</div>	
	</div>
</div>
	<!--  알림창 만들기 -->		
	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong>메세지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong>데이터 베이스 오류가 발생했습니다.</strong>
	</div>
</body>
</html>