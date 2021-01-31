<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "../bar/bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<c:if test="${sessionScope.userID == null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="로그인을 먼저 하세요." scope="session"/>
	<script type="text/javascript">
	console.log(5555);
	</script>
</c:if>
<c:set var="userID" value="${sessionScope.userID}"></c:set>
<title>JSP Ajax 실시간 회원제 채팅 서비스</title>
<script type="text/javascript">
function findFunction() {
	var userID = $('#findID').val();
	$.ajax({
		type: "post",
		url: '../user/UserFindServlet',
		data: {userID: userID},
		success: function(result){
			console.log(result);
			if(result == -1){
				$('#checkType').attr('class','modal-content panel-success');
				$('#checkMessage').html('친구를 찾을수 없습니다.');
				getFriend(userID);
			}else if(result == 0){
				$('#checkType').attr('class','modal-content panel-success');
				$('#checkMessage').html('검색한건 본인입니다.');
				getFriend(userID);
			}else {
				$('#checkType').attr('class','modal-content panel-success');
				$('#checkMessage').html('친구찾기에 성공했습니다.');
				var data = JSON.parse(result);
				var Profile = data.userProfile;
				console.log(Profile);
				getFriend(userID,Profile);
			}
			$('#checkModal').modal("show");
		}
	})
}
function getFriend(findID,userProfile) {
	$('#friendResult').html('<thread>'+
	'<tr>'+
	'<th><h4>검색 결과</h4></th>'+
	'</tr>'+
	'</thead>'+
	'<tbody>'+
	'<tr>'+
	''+
	'<td style="text-align: center;"><h5 style="text-align: center;">친구의 아이디는~!</h5><br>' +
	'<img class="media-object img -circle" style="max-width: 300px; margin: 0 auto;" src="' + userProfile +'">' +
	'<h3>' +findID+ '</h3><a href="../chat/chat?toID=' +encodeURIComponent(findID) +' "class="btn btn-primary pull-right">'+'친구랑 대화하기</a></td>' +
	'</tr>'+
	'<tbody>' );
}
function failFriend() {
	$('#friendResult').html('');
}
</script>
<script type="text/javascript">
</script>
</head>	
<body>
	<div class="container">
		<table class="table table-bordered table-hober" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<td colspan="2"><h4>검색으로 친구찾기</h4></td>
				</tr>
			</thead>
				<tbody>
					<tr>
						<td style="width: 110px"><h5>친구 아이디</h5></td>
						<td><input class="form-control" type="text" id="findID" maxlength="20" placeholder="찾을 아이디를 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px"><h5>친구 아이디</h5></td>
						<td colspan="2"><button class="btn btn-primary pull-right" onclick="findFunction()">검색</button></td>
					</tr>
				</tbody>
		</table>
	</div>
	<div class="container">
		<table id="friendResult" class="table table-bordered table-hover" style="text-align: center; border=1px; solid; #dddddd" >
		
		</table>
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
	
	<!-- 체크 모달을 만들기 //정보 알림창인데 // 회원가입했을때 아이디 중복 체크 알림창 모양을 만든거임-->
		<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
					<div class="modal-dialog vertical-align-center">
							<div id="checkType" class="modal-content panel-info">
								<div class="modal-header panel-heading">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times</span>
										<span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title">
										친구 찾기 메시지
									</h4>
								</div>
								<div id="checkMessage" class="modal-body">
								</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">
								 	확인
								</button>
							</div>
						</div>
					</div>
				</div>
		</div>
<%@include file= "../modal/modal.jsp" %>
<%@include file="../bar/bottom.jsp" %>
</body>
</html>