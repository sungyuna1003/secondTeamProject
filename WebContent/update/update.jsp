<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "../bar/bar.jsp" %>
<%@include file= "../modal/modalNone.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>JSP Ajax 실시간 회원제 채팅 서비스</title>
</head>	
<body>
<!-- 세션체크 -->
<c:if test="${sessionScope.userID != null}">
	<c:set var="userID" value="${sessionScope.userID}"> </c:set>
</c:if>
<c:if test="${sessionScope.userID == null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="현재 로그인이 되어 있지 않습니다." scope="session"/>
	<c:redirect url="../main/main.jsp"/>
</c:if>
<script>
function passwordCheckFunction(){
    var userPassword1 = $('#userPassword1').val();
    var userPassword2 = $('#userPassword2').val();
     
    if(userPassword1!=userPassword2){
        $('#passwordCheckMessage').html("비밀번호가 일치하지 않습니다");
    }
    else{
        $('#passwordCheckMessage').html("");
    }
	 }
</script>
	<!-- 회원 등록양식 시작 -->
	<div class="container" style="padding-top: 50px">
		<form method="post" action="../update/userUpdate">
			<!-- 테이블 호버 가운데 // 테두리 존재 하도록 -->
			<table class="table table-bordered table-hober" style="text-align: center border: 1px soloid #dddddd">
				<thead>
					<tr>
						<!-- 제목 3개열 크기만큼-->
						<th colspan="2"><h4>회원 정보 수정 양식</h4>
					</tr>
				</thead>
				<tbody>
				<c:set var="u" value="${userDTO}"/>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td>
							<h5>${u.uid}</h5>
							<input type="hidden" name="userID" value="${u.uid}">
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<!-- 온키업 : 데이터 입력할때마다 실행 -->
						<td colspan="2"><input class="form-control"  type="password" id="userPassword1" name="userPassword1" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
						<td colspan="2"><input class="form-control" onkeyup="passwordCheckFunction();" type="password" id="userPassword2" name="userPassword2" maxlength="20" placeholder="비밀번호 확인을 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
							<td colspan="2"><input class="form-control"  type="text" id="userName" name="userName" maxlength="20" placeholder="${u.name}"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
							<td colspan="2"><input class="form-control" type="number" id="userAge" name="userAge" maxlength="20" placeholder="${u.birth}"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
						<!-- 라디오 버튼 입력위해 폼 그룹 //디자인 중간-->
							<c:if test="${u.gender eq '남자'}">
								<c:set var="m" value="active"/>
							</c:if>
							<c:if test="${u.gender eq '여자'}"> 
								<c:set var="w" value="active"/>
							</c:if>
							<c:out value="${u.gender }"></c:out>
							<div class="form-group" style="text-align: center; margin: 0 auto">
								<div class="button-group" data-toggle="buttons">
									<label class="btn btn-primary  ${m}">
										<input type="radio" name="userGender" autocomplete="off" value="남자"  >남자
									</label>
									<label class="btn btn-primary ${w}">
										<input type="radio" name="userGender" autocomplete="off" value="여자"  >여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
							<td colspan="2"><input class="form-control"  type="email" id="userEmail" name="userEmail" maxlength="20" placeholder="${u.email}"></td>
					</tr>
					<tr>
						<td>
							<h5>현재 프로필</h5>
						</td>
						<td>
							<img alt="" src="${profile}" width="300px" height="300px" >
							<input class="btn btn-primary pull-right"  value="프로필 수정"  onclick="location.href='../user/userProfile'" >
						</td>
					</tr>
					<tr>
						<td>
							<td style="text-align: letf;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5>
							<input class="btn btn-primary pull-right" type="submit" value="수정" src="">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 회원 등록양식 끝-->
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
<%@include file="../bar/bottom.jsp" %>
</body>
</html>