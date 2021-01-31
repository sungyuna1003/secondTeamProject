<%@page import="java.io.PrintWriter"%>
<%@page import="Community.CommunitiyMgr"%>
<%@page import="Community.CommunityBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../bar/bar.jsp"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='../login/login.jsp'");
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
			script.println("location.href='../Community/view.jsp?cid="+cid);
			script.println("</script>");
		}
		CommunityBean Cbean = new CommunityBean();
		CommunitiyMgr communitiyMgr = new CommunitiyMgr();
		Cbean = communitiyMgr.getRow(cid);
		if(!userID.equals(Cbean.getUid_seeker())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='../Community/view.jsp?cid="+cid);
			script.println("</script>");
		} else{
			if(request.getParameter("c_title") == null || request.getParameter("c_content") == null
				|| request.getParameter("c_title").equals("") || request.getParameter("c_content").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				int result = communitiyMgr.update(cid, request.getParameter("c_title"), request.getParameter("c_content"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정하기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정하기 성공')");
					script.println("location.href='view.jsp?cid="+cid+"'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>