<!-- include1.jsp -->

<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
		
%>
<!-- first home page navbar -->
<%@ include file="../bar/bar.jsp"%>
<%@include file= "../modal/modal.jsp" %>

<!-- first home page first slides introduction about job & partner -->
<%@ include file="./firstslide.jsp"%>

<!-- first home page img and text capability about job & partner -->
<%@ include file="./aboutUs.jsp"%>

<!-- first home page last slides review about job & partner -->
<%@ include file="./lastslide.jsp"%>

