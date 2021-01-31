<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="apievent.*"%>
<%@page import="apievent.BoardBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="mgr" class="apievent.BoardMgr"/>
<jsp:useBean id="rmgr" class="apievent.ApiEventMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock =0;//총 블럭 개수
		int nowPage = 1;//현재 페이지
		int nowBlock = 1;//현재 블럭
		
		//요청된 numPerPage 처리
		if(request.getParameter("numPerPage")!=null){
			//Integer.parseInt(request.getParameter(name));
			numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
		}
		
		//검색에 필요한 변수
		String areaCd = "";
		if(request.getParameter("areaCd")!=null){
			areaCd = request.getParameter("areaCd");
		}
		
		//검색 후에 다시 처음 리스트 요청
		if(request.getParameter("reload")!=null&&
				request.getParameter("reload").equals("true")){
			areaCd=""; 
		}
		
		totalRecord = rmgr.gettotal(areaCd);
		
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		//sql문에 들어가는 start, cnt 선언
		int start = (nowPage*numPerPage)-numPerPage;
		int cnt = numPerPage;
		
		//전체페이지 개수
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		//전체블럭 개수
		 totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		//현재블럭
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<Script>
function check() {
	document.searchFrm.submit();
}

function list() {
	document.listFrm.action = "list.jsp";
	document.listFrm.submit();
}

function numPerFn(numPerPage) {
	document.readFrm.numPerPage.value=numPerPage;
	document.readFrm.submit();
}

function pageing(page) {
	document.readFrm.nowPage.value=page;
	document.readFrm.submit();
}

function block(block) {
	document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
	document.readFrm.submit();
}

function read(num) {
	document.readFrm.num.value = num;
	document.readFrm.action = "read.jsp";
	document.readFrm.submit();
}
</Script>
	<base href="http://localhost:8080/job/" />
<link href="./css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="./css/api.css" rel="stylesheet">
<link href="./css/bar.css" rel="stylesheet">
<meta charset="UTF-8">
<title>api</title>

<style>
div {
	text-align: center;
}
</style>
</head>




<body>
<script type="text/javascript" src="./js/api.js"></script>

	<div id="api">
		<div class="container">
			<div id="api-row"
				class="row justify-content-center align-items-center">
				<div id="api-column" class="col-md-10">
				<div id="api-box" class="col-md-14">
					<h2>채용행사 api</h2><br/>
<table>
	<tr>
		<td  width="950" align="center">
		Total : <%=totalRecord%>Articles(<font color="red">
		<%=nowPage+"/"+totalPage%>Pages</font>)

		</td>
		<td align="right">
			<form name="npFrm" method="post">
				<select name="numPerPage" size="1" 
				onchange="numPerFn(this.form.numPerPage.value)">
    				<option value="5">5개 보기</option>
    				<option value="10" selected>10개 보기</option>
    				<option value="15">15개 보기</option>
    				<option value="30">30개 보기</option>
   				</select>
   			</form>
   			<script>document.npFrm.numPerPage.value=<%=numPerPage%>;</script>
		</td>
	</tr>
</table>
<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="areaCd" size="1" >
    				<option value="">지 역</option>
    				<option value="51">서울, 강원</option>
    				<option value="52">부산, 경남</option>
    				<option value="53">대구, 경북</option>
    				<option value="54">경기, 인천</option>
    				<option value="55">광주, 전라, 제주</option>
    				<option value="56">대전, 충청</option>
   				</select>
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
</form>
<%
				Vector<EventBean> vlist = 
				rmgr.getEventlist(nowPage, numPerPage, areaCd);
				//브라우저 화면에 표시될 게시물 번호, 마지막 페이지에는 10개 이하의 개수 리턴 될수 있다.
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println("등록된 게시물이 없습니다.");
				}else{
		%>
<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
	<tr bgcolor="yellow">
	
		<td>번호</td>
		<td>지역</td>
		<td>행사명</td>
		<td>행사기간</td>
		
	</tr>	
				<%
						for(int i=0;i<numPerPage/*10*/;i++){
							if(i==listSize) break;
							EventBean bean = vlist.get(i);
							String area = bean.getArea();//지역
							String evnetNm = bean.getEventNm();//제목
							String eventTerm = bean.getEventTerm();//기간
					%>
					<tr align="center">
						<td><%=totalRecord-start-i%></td>
						<td align="left">
						<%=area%>
						</td>
						<td><%=evnetNm%></td>
						<td><%=eventTerm%></td>
					</tr>
					<%}//---for%>		
</table>
<%}//---if-else%>
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
		<!-- 페이징 및 블럭 End -->
<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="areaCd" value="<%=areaCd%>">
	<input type="hidden" name="num">
</form>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>