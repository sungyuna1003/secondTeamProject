<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>	
<body>
		<!-- 모달 설정 -->
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
		<!-- 모달창 만들기 -->
		<c:if test="${not empty sessionScope.messageContent}" >
			<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
				<!-- css용 div 클래스  -->
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
								<button type="button" class="btn btn-primary" data-dismiss="modal" >
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
			<!--서버로부터 받아온 세션인 //사용한 세션 제거 -->
				<c:remove var="messageContent" scope="session" />
				<c:remove var="messageType" scope="session" />
		</c:if>
</body>
</html>