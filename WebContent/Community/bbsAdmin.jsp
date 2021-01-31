<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Vector" %>
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
				<li class="active"><a href="bbs">게시판</a></li>
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
	
	<!-- 게시판 양식 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
							<tr>
								<th style="background-color: #eeeeee; text-align: center; color: red">Hot</th>
								<th style="background-color: #eeeeee; text-align: center;">제목</th>
								<th style="background-color: #eeeeee; text-align: center;">작성자</th>
								<th style="background-color: #eeeeee; text-align: center;">작성일</th>
								<th style="background-color: #eeeeee; text-align: center;">조회수</th>
							</tr>
						</thead>
						<c:set var="b" value="${bestBean}"/>
							<tr>
									<c:if test="${b.tab eq '유머'}">
								<td style="color: red">${b.tab}</td>  
							</c:if>
							<c:if test="${b.tab eq '구인'}">
								<td style="color: blue">${b.tab}</td> 
								</c:if>
									<c:if test="${b.tab eq '프리'}">
								<td style="color: green">${b.tab}</td> 
								</c:if>		
								<c:if test="${b.tab eq '헤드'}">				
								<td style="color: gray">${b.tab}</td> 
								</c:if>
								<td><a href="view.jsp?cid=${b.cid }">
							${b.c_title }</a></td>
								<td>${b.uid_seeker}
								</td>
								<td>${b.date}
								</td>
								<td>${b.hit}
								</td>
							</tr>
						</tbody>
				</table>
				<form action="../api/bbsAdmin" method="post">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">탭</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
						<th style="background-color: #eeeeee; text-align: center;">공개</th>
						<th style="background-color: #eeeeee; text-align: center;">삭제</th>
						
					</tr>
				</thead>
				<tbody>
				<c:forEach var="n" items = "${list}">
									<c:set var="open" value=""/>
									<c:if test="${n.available == 1}">
									<c:set var="open" value="checked"/>
									</c:if>
						<tr>
							<td>${n.cid}</td>
							<c:if test="${n.tab eq '유머'}">
								<td style="color: red">${n.tab}</td> 
							</c:if>
							<c:if test="${n.tab eq '구인'}">
								<td style="color: blue">${n.tab}</td> 
								</c:if>
									<c:if test="${n.tab eq '프리'}">
								<td style="color: green">${n.tab}</td> 
								</c:if>		
								<c:if test="${n.tab eq '헤드'}">				
								<td style="color: gray">${n.tab}</td>  
								</c:if>
							<td><a href="view.jsp?cid=${n.cid}">
							${n.c_title}</a></td>
							<td>${n.uid_seeker }</td>
							<td>${n.date}</td>
							<td>${n.hit}</td>
							<td><input type="checkbox" name="open-id" value="${n.cid}" ${open} ></td>
							<td><input type="checkbox" name="del-id" value="${n.cid}"></td>
						</tr>	
				</c:forEach>
			
			</tbody>
			
			</table>
					<div class="text-align-right margin-top" align="right">
					
						<input type="submit" class="btn-text btn-default" name ="cmd" value="선택공개">
						<input type="submit" class="btn-text btn-default" name ="cmd" value="선택비공">
						<input type="submit" class="btn-text btn-default" name ="cmd" value="선택삭제">
						<input type="submit" class="btn-text btn-default" name ="cmd" value="번호리셋">
					</div>
			<table align="center">
				</form>
	 <!-- 페이징 --> 
	 <c:set var="page" value="${(empty param.p)?1:param.p}" /> 
										<c:set var="startNum" value="${page-(page-1)%5}" /> 
										<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(count/10),'.')}" /> 
											<div>
								<ul class="nav">
									<li>
										<h3 class="hidden">현재 페이지</h3>
										<span class="text-orange text-strong">${(empty param.p)?1:param.p}</span>/ ${lastNum} pages
									</li>
									<li>
										<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
										<a href="../api/bbs" class="btn btn-primary pull-right">회원 게시판</a>
									</li>
								</ul>
							</div>

						<div class="margin-top align-center pager">
							<ul class="-list- center">
							<li>
								<c:if test="${startNum>1}">
									<a class="btn btn-prev" href="?p=${startNum-1}&t=&q=">이전 블록</a>
								</c:if>
								<c:if test="${startNum<=1}">
									<span class="btn btn-prev" onclick="alert('이전 페이지가 없습니다.');">이전
										블록</span>
								</c:if>
							</li>
								<c:forEach begin="0" end="4" var="i">
									<c:if test="${ (startNum+i) <= lastNum }">
										<li><a
											class="-text- ${(page== (startNum+i))?'orange':''} } bold"
											href="?p=${startNum+i}&f=${param.f }&q=${param.q}">${startNum+i}</a></li>
									</c:if>
								</c:forEach>
								<li>
											<c:if test="${startNum+4 < lastNum}">
									<a href="?p=${startNum+5}&t=&q=" class="btn btn-next">다음
										블록</a>
								</c:if>
								<c:if test="${startNum+4 >= lastNum}">
									<span class="btn btn-next" onclick="alert('다음 페이지가 없습니다.');">다음
										블록</span>
								</c:if>				
								</li>
							</ul>
						</div>
</table>
<!-- 페이징 및 블럭 End -->
			<a href="writeAdmin.jsp" class="btn btn-primary pull-right">글쓰기 </a>
		</div>
	</div>
	<!-- 게시판  양식 영역 끝 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	
</body>
</html>
