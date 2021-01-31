<%@page import="user.UserDAO"%>
<%@page import="org.apache.catalina.User"%>
<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<jsp:useBean id="UserDAO" class="user.UserDAO"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "../bar/bar.jsp" %>
<%@include file= "../modal/modal.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>JSP Ajax 실시간 회원제 채팅 서비스</title>
</head>
<c:if test="${sessionScope.userID != null}">
	<c:set var="userID" value="${sessionScope.userID}"> </c:set>
</c:if>
<c:if test="${sessionScope.userID == null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="현재 로그인이 되어 있지 않습니다." scope="session"/>
	<c:redirect url="index.jsp"/>
</c:if>
<c:if test="${sessionScope.userID == param.toID}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="나 자신에겐 보낼수 없습니다." scope="session"/>
	<c:redirect url="index.jsp"/>
</c:if>
<c:if test="${param.toID == null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="대화 상대가 지정되지 않았습니다." scope="session"/>
	<c:redirect url="index.jsp"/>
</c:if>

<c:set var="toID" value="${param.toID}"/>
<c:out value="현재 to 아이디: ${toID}"></c:out>
<script type="text/javascript">
	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function(){ alert.hide() }, delay);
		};
		
	function submitFunction() {
		var fromID = "${userID}";
		var toID = "${toID}";
		var chatContent = $('#chatContent').val();	
		
		$.ajax({
			type : "POST",
			url : "../chat/chatSubmit",
			data : {
				fromID : fromID,
				toID : toID,
				chatContent : chatContent,
			},
			success : function(result) {
				if (result == 1) {
					autoClosingAlert('#successMessage', 2000);
				} else if (result == 0) {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}
			},
			 error : function(request, status, error) { // 결과 에러 콜백함수
			        console.log(error)
			    }
		});
		$('#chatContent').val('');
	}	
	var lastID = 0;
	function chatListFunction(type) {
		console.log(type)
		var fromID = "${userID}";
		var toID = "${toID}";
		$.ajax({
			type: "POST",
			url: "../chat/chatList",
			 data: {
			     fromID: fromID,
			     toID: toID,
			     listType: type
			    },
			    success : function(data) {

					if (data == "")

						return;
					var parsed = JSON.parse(data);

					var result = parsed.result;
					for (var i = 0; i < result.length; i++) {
						if(result[i][0].value == fromID){
							result[i][0].value="나";
						}
						addChat(result[i][0].value, result[i][1].value,

								result[i][2].value, result[i][3].value);

					}
				lastID = Number(parsed.last);
			}
		});
	}
		function addChat(chatName,toID,chatContent,chatTime) {
			if(chatName == '나'){
			$('#chatList')

			.append(

					'<div class="row">'

							+ '<div class="col-lg-12">'

							+ '<div class="media">'

							+ '<a class="pull-right" href="#">'

							+ '<img class="media-object img-circle" style="height:60px; width:60px;" src = "${fromProfile}" alt="">'

							+ '</a>' + '<div class="media-body"align="right">'

							+ '<h4 class="media-heading">' + chatName

							+ '<span class="small pull-left">' +   chatTime
							
							+ '</span>' + '</h4>' + '<p>' +'to:'+toID 

							+ '<p>' +chatContent

							+ '</p>' + '</div>' + '</div>' + '</div>'

							+ '</div>' + '<br>');
			}else{
				$('#chatList')

				.append(

						'<div class="row">'

								+ '<div class="col-lg-12">'

								+ '<div class="media">'

								+ '<a class="pull-left" href="#">'

								+ '<img class="media-object img-circle" style="height:60px; width:60px;" src = "${toProfile}"  alt="">'

								+ '</a>' + '<div class="media-body">'

								+ '<h4 class="media-heading">' + chatName

								+ '<span class="small pull-right">' +   chatTime
								
								+ '</span>' + '</h4>' + '<p>' +'to:'+toID 

								+ '<p>' +chatContent

								+ '</p>' + '</div>' + '</div>' + '</div>'

								+ '</div>' + '<br>');
			}
	$('#chatList').scrollTop($('#chatList')[0].scrollHeight);

}
		function getInfiniteChat() {

			setInterval(function() {

				chatListFunction(lastID);
				console.log(lastID);

			}, 5000);

		}
</script>	
<body>
	<div class="container bootstrap snippet" style="padding-top: 50px">
		<div class="row">
			<div class="portlet portlet-heading">
				<div class="portlet-title">
					<h4><i class="fa fa-circle text-green"></i>실시간 채팅창</h4>
						<div class="clearfix">	</div>
				</div>
				<div id="chat" class="panel-collapse collapse in">
					<div id="chatList" class="portlet-body chat-widget" style="overflow-y:auto; width: auto; height: 600px" ></div>
					<div class="portlet-footer">
						<div class="row" style="height:  90px">
							<div class="form-group col-xs-10">
								<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메시지를 입력하세요" maxlength="100"></textarea>
							</div>
							<div class="form-group col-xs-2">
								<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
								<div class="clearfix"></div>
							</div>
						</div>
						</div>
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
	<script type="text/javascript">
	$('#messageModal').modal("show");
	$(document).ready(function(){
		chatListFunction('0');
		getInfiniteChat();
	})
</script>
</body>
</html>