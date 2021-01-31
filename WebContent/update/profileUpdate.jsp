<%@page import="user.UserDAO"%>
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
<script type="text/javascript">
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        var file = input.files[0];
        reader.onload = function (e) {
            $('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(file);
    }
}
</script>
<!-- 세션체크 -->
<c:if test="${sessionScope.userID != null}">
	<c:set var="userID" value="${sessionScope.userID}"> </c:set>
</c:if>
<c:if test="${sessionScope.userID == null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="현재 로그인이 되어 있지 않습니다." scope="session"/>
	<c:redirect url="index.jsp"/>
</c:if>
<script>
</script>
	<!-- 회원 등록양식 시작 -->
	<div class="container" style="padding-top: 50px">
		<form method="post" action="../user/userProfile" enctype="multipart/form-data">
			<table class="table table-bordered table-hober" style="text-align: center border: 1px soloid #dddddd">
				<thead>
					<tr>
						<th colspan="2"><h4>프로필 사진 수정 양식</h4>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td>
							<h5>${userID}</h5>
							<input type="hidden" name="userID" value="${userID}">
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>사진 업로드</h5></td>
						<td colspan="2">
								<input type="file" class="file" name="userProfile" id="upload" onchange="readURL(this)">
								<div class="input-group col-xs-12">
									<span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
									<input type="text" class="form-control input-lg" disabled placeholder="이미지를 업로드 하세요">
								<span class="input-group-btn">
									<button class="browse btn btn-primary input-lg" type="button"><i class="glyphicon glyphicon-search">파일 찾기</i></button>
								</span>
								</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
								<h5><label for="yy">이미지 미리보기</label></h5>
				        		<img id="preview" style="width: 300px; height: 300px;" src="${profile}" alt="your image">
		        		</td>
					</tr>
					
					<tr>
						<td style="text-align: letf;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5>
							<input class="btn btn-primary pull-right" type="submit" value="수정">
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
	<script type="text/javascript">
		$(document).on('click','.browse',function(){
			var file = $(this).parent().parent().parent().find('.file');
			file.trigger('click');
		});
		$(document).on('change','.file',function(){
			$(this).parent().find('.form-control').val($(this).val().replace(/c:\\fakepath\\/i, ' '));
		})
	</script>
</body>
</html>