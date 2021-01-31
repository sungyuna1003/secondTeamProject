<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "../bar/bar.jsp" %>
<%@include file= "../modal/modal.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>JSP Ajax 실시간 회원제 채팅 서비스</title>
</head>	
<body>
	<%session.invalidate(); %>
	<script type="text/javascript">
		location.href = '../main/main.jsp';
	</script>
</body>
</html>