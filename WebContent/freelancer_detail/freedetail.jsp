<%@page import="bean.UserBean"%>
<%@page import="job.JobMgr"%>
<%@page import="bean.FreelancerBean"%>
<%@page import="freelancer.FreelancerMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
String userid = (String) session.getAttribute("userID");
System.out.println("아이디:" + userid);
String fid = request.getParameter("fid");
FreelancerMgr fmgr = new FreelancerMgr();
FreelancerBean bean = new FreelancerBean();
fmgr.viewcntplus(fid);
bean = fmgr.getFreelancer(fid);
JobMgr usermgr = new JobMgr();
UserBean userbean = new UserBean();
userbean = usermgr.getUser(userid);
System.out.println(userid);
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>프리랜서 상품 상세보기</title>



<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="../css/freelancer_D.css">

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-3">
				<div class="well">
					<div class="summery_header">
						<h3 style="color: LightSeaGreen;">클래스 소개</h3>
					</div>
					<div class="job_content">

						<li>지역: <span>
								<%
									String regiondetail = null;
								if (bean.getF_region() != null) {
									if (bean.getF_region().equals("1")) {
										regiondetail = "전국";
									} else if (bean.getF_region().equals("2")) {
										regiondetail = "서울";
									} else if (bean.getF_region().equals("3")) {
										regiondetail = "경기/인천";
									} else if (bean.getF_region().equals("4")) {
										regiondetail = "부산/대구/울산";
									} else if (bean.getF_region().equals("5")) {
										regiondetail = "대전/충청";
									} else if (bean.getF_region().equals("6")) {
										regiondetail = "광주/전라";
									} else if (bean.getF_region().equals("7")) {
										regiondetail = "강원/제주";
									}
								}
								out.print(regiondetail);
								%>
						</span></li>
						<li>교육형태: <span>
								<%
									String edutypedetail = null;
								if (bean.getF_edutype() != null) {
									if (bean.getF_edutype().equals("1")) {
										edutypedetail = "대면";
									} else if (bean.getF_edutype().equals("2")) {
										edutypedetail = "비대면";
									}
								}
								out.print(edutypedetail);
								%>
						</span></li>
						<li>모집형태: <span>
								<%
									String includedetail = null;
								if (bean.getF_includetype() != null) {
									if (bean.getF_includetype().equals("1")) {
										includedetail = "개인수업";
									} else if (bean.getF_includetype().equals("2")) {
										includedetail = "그룹수업";
									} else if (bean.getF_includetype().equals("3")) {
										includedetail = "기업수업";
									}
								}
								out.print(includedetail);
								%>
						</span></li>
						<li>교육횟수: <span>
								<%
									String educntdetail = null;
								if (bean.getF_educount() != null) {
									if (bean.getF_educount().equals("1")) {
										educntdetail = "정규수업";
									} else if (bean.getF_educount().equals("2")) {
										educntdetail = "원데이클래스";
									}
								}
								out.print(educntdetail);
								%>
						</span></li>

					</div>
				</div>

			</div>
			<div class="col-lg-8">
				<div class="well" style="height: 85px; padding: 15px;">
					<div>
						<div class="manu-imgplace">
							<img src="img/svg_icon/1.svg" alt="">
						</div>
						<div style="display: inline-block;">
							<a style="text-align: left;"
								onmouseover="this.style.textDecoration='none';" href="#"><h4>
									<%=bean.getF_title()%></h4></a>
							<div>
								<div style="float: left; margin-right: 10px;">
									<p>
										<i class="fa fa-map-marker"></i><%=regiondetail%>
									</p>
								</div>
								<div style="float: left;">
									<p>
										<i class="fa fa-clock-o"></i><%=educntdetail%>
									</p>
								</div>
							</div>

						</div>
						<div class="jobs_right">
							<div class="apply_now"></div>
						</div>
					</div>
				</div>
				<div class="well">
					<div class="single_wrap">
						<h4 style="color: MediumAquaMarine;">서비스 설명</h4>
						<p style="color: black;">
							<%=bean.getF_self()%>
						</p>
					</div>
					<div class="single_wrap">
						<h4 style="color: MediumAquaMarine;">분류</h4>
						<p style="color: black;"><%=bean.getF_product()%></p>
					</div>
				</div>
				<div class="well">
					<div class="submit_btn">
					<button type="button" style="width: 80px"
							onclick=<%if (userid == null) {%> "alert("결재는 로그인을 해야
							합니다.")"<%} else {%>"location.href='pay.jsp?fid=<%=fid %>' "<%}%>><%=bean.getPrice()%>원
							신청하기
						</button>
					</div>
				</div>
			</div>
		</div>
		<br>

	</div>
	<script>
function price(userid) {
	if(userid===null){
		alert("결재는 로그인을 해야 합니다.");
	} else {
		location.href="pay.jsp";
	}
	
}
</script>

</body>

</html>