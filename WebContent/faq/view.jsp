<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<%@page import="Community.CommunitiyMgr"%>
<%@page import="Community.CommunityBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<script type="text/javascript">

</script>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int cid = 0;
		if(request.getParameter("cid")!=null){
			cid = Integer.parseInt(request.getParameter("cid"));
		}
		if(cid==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script");
		}
		CommunityBean Cbean = new CommunitiyMgr().getRow(cid);
	%>
	<nav class="navbar navbar-inverse">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li ><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			<li ><a href="apiBoard.jsp">인턴</a></li>
			</ul>
			<%
				if(userID == null){
			
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						w
						<ul class="dropdown-menu">
						
							<li><a href="login.jsp">로그인</a></li>
							
							<li><a href="join.jsp">회원가입</a></li>
							
						</ul>
					</li>	
			</ul>
			<%
				}else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
						
							<li><a href="login.jsp">로그아웃</a></li>
							
						</ul>
					</li>	
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->
	
	<!-- 게시판 글보기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
					<td style = "width: 20%;">글 제목</td>
					<td colspan="2"> <%=Cbean.getC_title() %></td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td colspan="2"> <%= Cbean.getUid_seeker() %></td>
				</tr>			
				
				<tr>
					<td>작성일자</td>
					<td colspan="2"><%= Cbean.getDate().substring(0, 11) + Cbean.getDate().substring(11, 13) + 
					"시 " + Cbean.getDate().substring(14, 16) + "분 " %></td>
				</tr>
				
				<tr>
					<td>첨부파일</td>
					<td colspan="2"><a download href="fileupload/<%=(Cbean.getFiles()==null)?"":Cbean.getFiles()%>"><%=(Cbean.getFiles()==null)?"":Cbean.getFiles()%></a></td>
				</tr>
				
				<tr>
					<td>내용</td>
					
					<td colspan="2" style="height: 200px; min-height:200px; text-align: left;">
					 <%= Cbean.getC_content().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>								

					</tbody>
				</table>
			</table>
			
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			
			<%
				if(userID != null && userID.equals(Cbean.getUid_seeker())){
			%>
					<a href="update.jsp?cid=<%= cid %>" class="btn btn-primary">수정</a>
					<a onclick = "return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?cid=<%= cid %>" class="btn btn-primary">삭제</a>
			<% 
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>