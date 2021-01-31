<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Vector" %>
<%@ include file="../bar/bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- 게시판 양식 시작 -->
	<div class="container" style="padding-top: 50px">
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
						<tbody>
							<c:set var="b" value="${bestBean}"></c:set>
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">탭</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td style="font: bold;">공지</td>
							<td>공지</td>
							<td>공지</td>
							<td>공지</td>
							<td>공지</td>
				<c:forEach var="n" items = "${list}">
						<tr>
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
							<td>${n.hit}
						</tr>	
				</c:forEach>
			</tbody>
			</table>
			</div>
			</div>
			<!-- 페이징 --> 
<table align="center">
		<c:set var="page" value="${(empty param.p)?1:param.p}" /> 
										<c:set var="startNum" value="${page-(page-1)%5}" /> 
										<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(count/10),'.')}" /> 
											<div align="right">
								<ul class="nav"  style="padding-right: 60px">
									<li>
										<h3 class="hidden">현재 페이지</h3>
										<span class="text-orange text-strong">${(empty param.p)?1:param.p}</span>/ ${lastNum} pages
									</li>
									<li>
										<a href="./write.jsp" class="btn btn-primary pull-right">글쓰기</a>
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
			<!-- 글쓰기 버튼  -->
			<div class="container">
			
<!-- 게시판  양식 영역 끝 -->
<div class="search-form margin-top first align-right" align="center">
					<h3 class="hidden">공지사항 검색폼</h3>
					<form class="table-form" name="readFrm" method="get" action="../api/bbs">
						<fieldset>
							<legend class="hidden">공지사항 검색 필드</legend>
							<label class="hidden">검색분류</label>
							<select name="f">
								<option value="c_title" ${ (param.f == "c_title")?"selected":""}>제목</option>
								<option value="c_content" ${ (param.f == "c_content")?"selected":""}>내용</option>
								<option value="uid_seeker" ${ (param.f == "uid_seeker")?"selected":""}>작성자</option>
							</select>
							<label class="hidden">검색어</label>
							<input type="text" name="q" value="${param.q}" />
							<input type="hidden" name="p" value="1">
							<input class="btn btn-search" type="submit" value="검색" />
						</fieldset>
					</form>
				</div>
				</div>
	<%@include file="../bar/bottom.jsp" %>
</body>
</html>
