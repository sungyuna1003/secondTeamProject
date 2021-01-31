<%@page import="apiIntern.UtilMgr"%>
<%@page import="apiIntern.ApiDataBean"%>
<%@page import="apiIntern.ApiMgr"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="Amgr" class="apiIntern.ApiMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		String Region =request.getParameter("region");
		if(Region == ""||Region == null){
			Region = "";
		}else{
			Region = request.getParameter("region");
			if (Region.equals("0")){Region="";}
			if (Region.equals("1")){Region="11000";}
			if (Region.equals("2")){Region="26000";}
			if (Region.equals("3")){Region="27000";}
			if (Region.equals("4")){Region="28000";}
			if (Region.equals("5")){Region="29000";}
			if (Region.equals("6")){Region="30000";}
		}
		
		String Job = request.getParameter("job");
		if(Job == ""||Job == null){
			Job = "";
		}else{
			Job = request.getParameter("job");
			if (Job.equals("0")){Job="";}
			if (Job.equals("1")){Job="01";}
			if (Job.equals("2")){Job="02";}
			if (Job.equals("3")){Job="03";}
			if (Job.equals("4")){Job="04";}
			
		}
		String Keyword = request.getParameter("keyword");
		if(Keyword == ""||Keyword == null){
			Keyword = "";
		}else{
			Keyword = request.getParameter("keyword");
		}
		
		String NowPage =request.getParameter("nowPage");
		
		if(NowPage == ""||NowPage == null){
			NowPage = "1";
		}else{
			NowPage = request.getParameter("nowPage");
		}
		String Url = "http://openapi.work.go.kr/opi/internInfo/internApi.do?authKey=WNKJ18EWYUPN9WJQWH23D2VR1HK&returnType=XML"
				+"&startPage="+NowPage+"&display=10"+"&occupation="+Job+"&region="+Region+"&keyword="+Keyword;
		int totalRecord = Integer.parseInt(Amgr.total(Url));//총게시물수
		System.out.println("jsp 토탈"+totalRecord);
		System.out.println("현재 페이지"+NowPage);
		System.out.println("파싱 주소"+Url);
		System.out.println("검색 :"+Keyword);
		System.out.println("직업 :"+Job);
		System.out.println("지역 :"+Region);
		
		int numPerPage = 10;//페이지당 레코드 개수
		int pagePerBlock = 10;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock =0;//총 블럭 개수
		int nowPage = Integer.parseInt(NowPage);//현재 페이지
		int nowBlock = 1;//현재 블럭
		int number = 0;//글 번호
		
		
		
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		
		int start = (nowPage*numPerPage)-numPerPage;
	
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<Script language="javascript">
function pageing(page) {
	document.readFrm.nowPage.value=page;
	document.readFrm.submit();
}
function block(block) {
	document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
	document.readFrm.submit();
}
</Script>
<body>
<%
		String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
	}
	
	%>
	<div style="padding-top: 150px">
	<table>
	<tr>
		<td  width="700" align="center">
		Total : <%=totalRecord%>Articles(
		<font color="red"><%=nowPage+"/"+totalPage%>Pages</font>
		)
		</td>
	</tr>
</table>
<form method="get" action="/job/apiIntern/apiView.jsp">
 <label for ="region">지역</label>
<select id="region" name="region">
					<option value="0">--</option>
					<option value="1">서울</option>
					<option value="2">부산</option>
					<option value="3">대구</option>
					<option value="4">인천</option>
					<option value="5">광주</option>
					<option value="6">대전</option>
</select>
<p>
<label for ="job">직종</label>
<select id="job" name="job">
					<option value="0">--</option>
					<option value="1">경영사무금융보함</option>
					<option value="2">연구및공학</option>
					<option value="3">법률사회복지경찰소방</option>
					<option value="4">보건의료</option>
</select>
<p>
<input type="hidden" name="nowPage" value="1">
<input type="search" name="keyword" value="">
<input type="submit" value="전송">
</form>
<%
Vector<ApiDataBean> vlist = Amgr.ApiMgr(Url);
%>
<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
	<tr bgcolor="yellow">
		<td>번호</td>
		<td>회사명</td>
		<td>직무명</td>
		<td>지역</td>
		<td>최저학력</td>
		<td>모집인원</td>
	</tr>
		<%for(int i = 0; i < vlist.size(); i++){
			ApiDataBean Abean = vlist.get(i);
			number++;
		%>
	<tr>				
		<td><%=number+(nowPage-1)*10%></td>	
		<td><a href="<%=Abean.getDetailUrl()%>"><%=Abean.getCompanyNm()%></a></td>
		<td><%=Abean.getCollectJobsNm()%></td>
		<td><%=Abean.getRegionNm() %></td>
		<td><%=Abean.getMinEdubg() %></td>
		<td><%=Abean.getCollectPsncnt() %></td>
		
	</tr>
	    <%} %>
</table>
<!-- 페이징 및 블럭 Start -->
<table>
	<tr> 
		<td>
		<!-- 이전블럭 -->
		<a href="javascript:pageing(1)">처음</a>
		<%if(nowBlock>1){%>
			<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
		<%}%>
		<!-- 페이징 -->
		<%
				int pageStart = (nowBlock-1)*pagePerBlock+1;
				int pageEnd = (pageStart+pagePerBlock/*15*/)<=totalPage?
						pageStart+pagePerBlock:totalPage+1;
				for(;pageStart<pageEnd;pageStart++){
		%>
		<a href="javascript:pageing('<%=pageStart%>')">
			<%if(nowPage==pageStart){%><font color="blue"><%}%>
				[<%=pageStart%>]
			<%if(nowPage==pageStart){%></font><%}%>
		</a>
		<%}//--for%>
		<!-- 다음블럭 -->
		<%if(totalBlock>nowBlock){%>
			<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
		<%}%>
		<a href="javascript:pageing('<%=totalPage%>')">끝</a>
		</td>
	</tr>
</table>
</div>
<!-- 페이징 및 블럭 End -->
<form name="readFrm" method="get" action="/job/apiIntern/apiView.jsp">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="region" value="<%=Region%>">
	<input type="hidden" name="job" value="<%=Job%>">
	<input type="hidden" name="keyword" value="<%=Keyword%>">
</form>
</body>
</html>