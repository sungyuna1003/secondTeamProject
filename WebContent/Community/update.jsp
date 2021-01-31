<%@page import="java.io.PrintWriter"%>
<%@page import="Community.CommunitiyMgr"%>
<%@page import="Community.CommunityBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../bar/bar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter  script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 먼저 하세요')");
			script.println("location.href = 'bbs.jsp");
			script.println("<script>");
		}
		
		int cid = 0;
		if(request.getParameter("cid") != null){
			cid = Integer.parseInt(request.getParameter("cid"));
		}
		if(cid == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다')");
			script.println("location.href = 'bbs.jsp");
			script.println("<script>");
		}
		CommunityBean Cbean = new CommunityBean();
		CommunitiyMgr communitiyMgr = new CommunitiyMgr();
		 Cbean = communitiyMgr.getRow(cid);
		System.out.println("cid: "+cid);
		System.out.println("userID: "+userID);
		System.out.println("uid_seeker: "+Cbean.getUid_seeker());
		if(!userID.equals(Cbean.getUid_seeker())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href = 'bbs.jsp");
			script.println("<script>");
		}
	%>
	<!-- 게시판 글수정 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?cid=<%=cid%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="c_title" maxlength="50"
							value=<%=Cbean.getC_title() %>></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="c_content" maxlength="2048" style="height: 350px;">
							<%=Cbean.getC_content() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="수정하기">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>