<%@page import="job.JobMgr"%>
<%@page import="bean.Freelancer_userBean"%>
<%@page import="freelancer.UtilMgr"%>
<%@page import="bean.FreelancerBean"%>
<%@page import="java.util.Vector"%>
<%@page import="freelancer.FreelancerMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Vector<FreelancerBean> fvlist = new Vector<FreelancerBean>();
String userid = (String) session.getAttribute("userID");
System.out.println("아이디:" + userid);
FreelancerMgr fmgr = new FreelancerMgr();
Freelancer_userBean fuBean = new Freelancer_userBean();
JobMgr usermgr = new JobMgr();
int totalRecord = 0;//총게시물수
int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
int pagePerBlock = 15;//블럭당 페이지 개수
int totalPage = 0;//총 페이지 개수
int totalBlock = 0;//총 블럭 개수
int nowPage = 1;//현재 페이지
int nowBlock = 1;//현재 블럭

//요청된 numPerPage 처리
if (request.getParameter("numPerPage") != null) {
	//Integer.parseInt(request.getParameter(name));
	numPerPage = UtilMgr.parseInt(request, "numPerPage");
}

//검색에 필요한 변수
String keyWord = "", region = "0", includetype = "0", edutype = "0", educnt = "0";
if (request.getParameter("region") != null) {
	region = request.getParameter("region");
	includetype = request.getParameter("includetype");
	edutype = request.getParameter("edutype");
	educnt = request.getParameter("educnt");
	keyWord = request.getParameter("keyWord");
}

//검색 후에 다시 처음 리스트 요청
if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
	keyWord = "";
	region = "0";
	includetype = "0";
	edutype = "0";
	educnt = "0";
}

totalRecord = fmgr.getTotalCount(keyWord, region, includetype, edutype, educnt);

if (request.getParameter("nowPage") != null) {
	nowPage = UtilMgr.parseInt(request, "nowPage");
}

//sql문에 들어가는 start, cnt 선언
int start = (nowPage * numPerPage) - numPerPage;
int cnt = numPerPage;

//전체페이지 개수
totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
//전체블럭 개수
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
//현재블럭
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
%>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8">

<title>프리랜서 게시판</title>


<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">

<!-- Place favicon.ico in the root directory -->

<!-- CSS here -->

<link rel="stylesheet" href="./css/freelancer.css">
<!-- script -->
<script type="text/javascript">
	function list() {
		document.listFrm.action = "./board_include_F.jsp";
		document.listFrm.submit();
	}

	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}

	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}

	function block(block) {
		document.readFrm.nowPage.value =
<%=pagePerBlock%>
	* (block - 1) + 1;
		document.readFrm.submit();
	}
</script>
</head>


<!-- job_listing_area_start  -->
<div class="job_listing_area plus_padding">
	<div class="container">
		<div class="row">
			<div class="col-lg-3">
				<div class="well">
					<form name="readSrc">


						<h3>검색창</h3>
						<div class="row">
							<div class="col-lg-12">
								<div class="single_field">
									<input type="text" name="keyWord" class="form-control margin10"
										placeholder="검색">
								</div>
							</div>
							<div class="col-lg-12">
								<div class="single_field">
									<select class="form-control margin10" name="region">
										<option value="0" data-display="지역">지역</option>
										<option value="1">전국</option>
										<option value="2">서울</option>
										<option value="3">경기/인천</option>
										<option value="4">부산/대구/울산</option>
										<option value="5">대전/충청</option>
										<option value="6">광주/전라</option>
										<option value="7">강원/제주</option>
									</select>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="single_field">
									<select class="form-control margin10" name="includetype">
										<option value="0" data-display="모집형태">모집형태</option>
										<option value="1">개인교육</option>
										<option value="2">그룹교육</option>
										<option value="3">기업교육</option>
									</select>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="single_field">
									<select class="form-control margin10" name="edutype">
										<option value="0" data-display="교육형태">교육형태</option>
										<option value="1">대면수업</option>
										<option value="2">비대면수업</option>
									</select>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="single_field">
									<select class="form-control margin10" name="educnt">
										<option value="0" data-display="교육횟수">교육횟수</option>
										<option value="2">원데이클래스</option>
										<option value="1">정규교육과정</option>
									</select>
								</div>
							</div>

						</div>


						<div class="reset_btn">
							<input type="submit" class="btn btn-success width100" value="찾기">
							<input type="hidden" name="nowPage" value="1">
						</div>

					</form>
				</div>
			</div>

			<!-- 검색창 -->
			<!-- 체크보드 -->
			<div class="col-lg-9">
				<div class="col-md-14 well checkboard">

					<div class="col-md-10">
						<h5 style="text-align: left;">
							상품 리스트
							</h4>
					</div>
					<div class="col-md-2" id="checkboardseldiv1">
						<div id="checkboardseldiv">
							<select class="form-control" id="checkboardsel">
								<option data-display="최신순">최신순 정렬</option>
								<option value="1">추천순 정렬</option>
								<option value="2">조회수 정렬</option>
							</select>
						</div>
					</div>

				</div>
				<!-- 체크보드 -->
				<!-- 메인보드 -->
				<div id="main-board">
					<!-- 공지사항 더미 -->
					<form name="gongjiFrm" id="gongjiFrm" class="form" method="post"
						action="../freelancer_detail/freelancer_detail_include.jsp">
						<div class="row" style="height: 60px">
							<div class="col-lg-12 col-md-12" style="height: 60px">
								<div class="main-menu">
									<div class="imgtitle">
										<div class="manu-imgplace"
											style="height: 40px; width: 40px; padding: 5px;">
											<img src="img/gongji.jpg" width="30px" height="30px">
										</div>

										<div class="freetitle">
											<a style="text-align: left;" href="#">
												<h6>프리랜서 게시판 공지사항</h6>
											</a>

										</div>
									</div>
									<div>
										<div>
											</a> <a href="#"
												class="freeboxed-btn3">상세보기</a>
										</div>
										<div class="date">
											<p style="font-size: 10px;"></p>
										</div>
									</div>
								</div>
							</div>

						</div>

					</form>
					<!-- 공지사항 더미 -->

					<%
						fvlist = fmgr.getFreelancerlist(keyWord, region, includetype, edutype, educnt, start, cnt);

					for (int i = 0; i < numPerPage; i++) {
						if (i == fvlist.size())
							break;
					%>
					<form name="freelistFrm<%=i%>" id="freelistFrm<%=i%>" class="form"
						method="post" action="../freelancer_detail/freelancer_detail_include.jsp">
						<div class="row" style="height: 60px">
							<div class="col-lg-12 col-md-12" style="height: 60px">
								<div class="main-menu">
									<div class="imgtitle">
										<div class="manu-imgplace">
											<img src="img/1212.png" alt="">
										</div>

										<div class="freetitle">
											<a style="text-align: left;"
												href="javascript:freelistsubmit(<%=i%>);">
												<h5 style="margin-bottom: 1px;"><%=fvlist.get(i).getF_title()%></h5>
											</a>
											<div>
												<div style="float: left; margin-right: 5px;">
													<p style="font-size: 12px;">
														<i class="fa fa-map-marker"></i>
														<%
															String regiondetail = null;
														if (fvlist.get(i).getF_region().equals("1")) {
															regiondetail = "전국";
														} else if (fvlist.get(i).getF_region().equals("2")) {
															regiondetail = "서울";
														} else if (fvlist.get(i).getF_region().equals("3")) {
															regiondetail = "경기/인천";
														} else if (fvlist.get(i).getF_region().equals("4")) {
															regiondetail = "부산/대구/울산";
														} else if (fvlist.get(i).getF_region().equals("5")) {
															regiondetail = "대전/충청";
														} else if (fvlist.get(i).getF_region().equals("6")) {
															regiondetail = "광주/전라";
														} else if (fvlist.get(i).getF_region().equals("7")) {
															regiondetail = "강원/제주";
														}
														out.print(regiondetail);
														%>
													</p>
												</div>
												<div style="float: left;">
													<p style="font-size: 12px;">
														<i class="fa fa-clock-o"></i>
														<%
															String educntdetail = null;
														if (fvlist.get(i).getF_educount().equals("1")) {
															educntdetail = "정규수업";
														} else if (fvlist.get(i).getF_educount().equals("2")) {
															educntdetail = "원데이클래스";
														}
														out.print(educntdetail);
														%>
													</p>
												</div>
											</div>
										</div>
									</div>
									<div class="jobs_right">
										<div class="apply_now">
											<a class="heart_mark" id="heart_mark<%=i%>"
												onmouseover="javascript:votechange()"
												href=<%if (userid == null) {%>
												"javascript:idnull()"<%} else if (usermgr.getUser(userid).getGrade() == 2 || usermgr.getUser(userid).getGrade() == 3) {%>"javascript:idgrade()"<%} else {%>"./freevoteProc.jsp?uid=<%=userid%>
												&fid=<%=fvlist.get(i).getFid()%> "<%}%>><%=fmgr.getvote(fvlist.get(i).getFid())%>
											</a> <a href="javascript:freelistsubmit(<%=i%>);"
												class="freeboxed-btn3">상세보기</a>
										</div>
										<div class="date">
											<p style="font-size: 10px;">
												조회수:
												<%=fvlist.get(i).getf_viewcnt()%>회&nbsp;&nbsp;&nbsp;<%=fvlist.get(i).getF_time()%></p>
										</div>
									</div>
								</div>
							</div>

						</div>
						<input type="hidden" name="fid"
							value="<%=fvlist.get(i).getFid()%>">
					</form>
					<%
						}
					%>
					<div class="row">
						<div class="col-lg-12">
							<div class="freepagination_wrap">
								<ul>
									<%
										if (nowBlock > 1) {
									%>
									<li><a href="javascript:block('<%=nowBlock - 1%>')"> <span>
												< </span>
									</a></li>
									<%}%>
									<%
										int pageStart = (nowBlock - 1) * pagePerBlock + 1;
									int pageEnd = (pageStart + pagePerBlock/*15*/) < totalPage ? pageStart + pagePerBlock : totalPage + 1;
									for (; pageStart < pageEnd; pageStart++) {
									%>
									<li><a href="javascript:pageing('<%=pageStart%>')"> <span
											<%if (nowPage == pageStart) {%> style="color: blue;" <%}%>>
												<%=pageStart%></span></a></li>
									<%
										} //--for
									%>
									<!-- 다음블럭 -->
									<%
										if (totalBlock > nowBlock) {
									%>

									<li><a href="javascript:block('<%=nowBlock + 1%>')"> <span>
												> </span>
									</a></li>

									<%}%>
									<!-- 페이징 및 블럭 End -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true"> <input
		type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>"> <input
		type="hidden" name="numPerPage" value="<%=numPerPage%>"> <input
		type="hidden" name="region" value="<%=region%>"> <input
		type="hidden" name="includetype" value="<%=includetype%>"> <input
		type="hidden" name="edutype" value="<%=edutype%>"> <input
		type="hidden" name="educnt" value="<%=educnt%>"> <input
		type="hidden" name="keyWord" value="<%=keyWord%>"> <input
		type="hidden" name="num">
</form>

<script type="text/javascript">
	function freelistsubmit(i) {

		document.getElementById("freelistFrm" + i).submit();

	}
</script>
<!-- job_listing_area_end  -->


<!-- link that opens popup -->
<!-- JS here -->

<!-- <script src="js/gijgo.min.js"></script> -->



<!--contact js-->


<script>
	function votechange() {
		document.getElementById('heart').style.diplay = 'block';
	}

	function idnull() {
		alert("추천에는 로그인이 필요합니다.");
	}
	function idgrade() {
		alert("구직자만 추천 가능합니다.");
	}
</script>


<script>
	$(function() {
		$("#slider-range").slider(
				{
					range : true,
					min : 0,
					max : 24600,
					values : [ 750, 24600 ],
					slide : function(event, ui) {
						$("#amount").val(
								"$" + ui.values[0] + " - $" + ui.values[1]
										+ "/ Year");
					}
				});
		$("#amount").val(
				"$" + $("#slider-range").slider("values", 0) + " - $"
						+ $("#slider-range").slider("values", 1) + "/ Year");
	});
</script>
</body>

</html>