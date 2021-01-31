<%@page import="java.io.PrintWriter"%>
<%@page import="Community.CommunitiyMgr"%>
<%@page import="Community.CommunityBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int cid = 0;
		if(request.getParameter("cid") != null){
			cid = Integer.parseInt(request.getParameter("cid"));
		}
		if(cid == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		// 글 삭제 수행
		CommunitiyMgr communitiyMgr = new CommunitiyMgr();
		int result = communitiyMgr.delete(cid);
		//db오류인 경우
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정하기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		//글 삭제가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
		} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제하기 성공')");
					script.println("location.href='bbs.jsp'");
					script.println("</script>");
				}
	
	%>
</body>
</html>