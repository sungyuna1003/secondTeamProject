<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<%@include file= "../bar/bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:if test="${sessionScope.userID != null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="현재 로그인이 되어 있는 상태입니다." scope="session"/>
</c:if>
<!-- ajax를 시작 -->
<script type="text/javascript">
 
function registerCheckFunction() {
    var userID = $('#userID').val();
        $.ajax({
            type : 'POST',
            url : '../user/UserRegisterCheck', 
            data : {
                userID : userID
            },
            success : function(result) { 
                if (result == 1) {
                    $('#checkMessage').html("아이디를 사용할수 있습니다"); 
                    $('#checkType')
                            .attr('class', 'modal-content panel-success');
                } else {
                    $('#checkMessage').html("아이디를 사용할수 없습니다");
                    $('#checkType')
                            .attr('class', 'modal-content panel-warning'); 
                }
                $('#checkModal').modal("show"); 
            }
        })
    }
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
<title>Insert title here</title>
</head>
<body>
	<div class="container" style="padding-top: 50px">
		<form method="post" action="../user/userRegister">
			<table class="table table-bordered table-hober" style="text-align: center border: 1px soloid #dddddd; ">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 기본 등록 양식</h4>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td><input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="아이디를 입력하세요"></td>
						<td style="width: 110px"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button">중복체크</button></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input class="form-control"  type="password" id="userPassword1" name="userPassword1" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
						<td colspan="2"><input class="form-control" onkeyup="passwordCheckFunction();" type="password" id="userPassword2" name="userPassword2" maxlength="20" placeholder="비밀번호 확인을 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control"  type="text" id="userName" name="userName" maxlength="20" placeholder="본인 이름을 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>닉네임</h5></td>
						<td colspan="2"><input class="form-control"  type="text" id="userNickName" name="userNickName" maxlength="20" placeholder="닉네임을 입력하세요"></td>
					</tr>
					<tr>
						 <td style="width: 110px;"><h5><label for="yy">생년월일</label></h5></td>
						 <td colspan="2"> <input type="date" id="userName" name="userAge" value="2000-01-01" min="1950-01-01" max="2019-09-25"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
							<div class="form-group" style="text-align: center; margin: 0 auto">
								<div class="button-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userGender" autocomplete="off" value="남자" >남자
									</label>
									<label class="btn btn-primary ">
										<input type="radio" name="userGender" autocomplete="off" value="여자">여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control"  type="email" id="userEmail" name="userEmail" maxlength="20" placeholder="이메일을 입력하세요"></td>
					</tr>
					<tr>
						<td style="text-align: letf;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5>
							<input class="btn btn-primary pull-right" type="submit" value="등록">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<c:set var="messageType" value="null"> </c:set>
			<c:if test="${sessionScope.messageType != null}">
				<c:set var="messageType" value="${sessionScope.messageType}"></c:set>
			<c:if test="${messageType eq  '오류메세지'}">  
				<c:set var="m" value="panel-success"></c:set>
			</c:if>
				<c:set var="m" value="panel-warning"></c:set>
		</c:if>
	
		<c:set var="messageContent" value="null"> </c:set>
		<c:if test="${sessionScope.messageContent != null}">
			<c:set var="messageContent" value="${sessionScope.messageContent}"></c:set>
		</c:if>
		<!-- 모달창  -->
		<c:if test="${not empty sessionScope.messageContent}" >
			<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="vertical-alignment-helper">
					<div class="modal-dialog vertical-align-center">
							<div class="modal-content  ${m}" >
								<div class="modal-header panel-heading">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times</span>
										<span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title">
										${messageType}
									</h4>
								</div>
								<div class="modal-body">
									${messageContent}
								</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='../join/join.jsp';">
								 	확인
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 모달창 실행 -->
				<script type="text/javascript">
					$('#messageModal').modal("show");
				</script>
			<!--세션 제거 -->
				<c:remove var="messageContent" scope="session" />
				<c:remove var="messageType" scope="session" />
		</c:if>
		<!-- 체크 모달 중복 체크 알림창 -->
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
										아이디 중복 확인 메세지
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
	<%@include file="../bar/bottom.jsp" %>	
</body>
</html>