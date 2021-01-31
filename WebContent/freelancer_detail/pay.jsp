<%@page import="bean.FreelancerBean"%>
<%@page import="freelancer.FreelancerMgr"%>
<%@page import="bean.UserBean"%>
<%@page import="job.JobMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	request.setCharacterEncoding("UTF-8");
	String fid = request.getParameter("fid");
	FreelancerMgr fmgr = new FreelancerMgr();
	FreelancerBean bean = new FreelancerBean();
	bean = fmgr.getFreelancer(fid);
String userid = (String) session.getAttribute("userID");
	JobMgr usermgr = new JobMgr();
	UserBean userbean = new UserBean();
	userbean = usermgr.getUser(userid);
	%>
<!DOCTYPE html>
<%@include file="../freelancer/bar.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>bbswrite.jsp</title>
<style>
span {
	width: 60px;
	display: inline-block;
}

textarea {
	width: 40%;
	height: 280px;
}
</style>
</head>
<body>
	<div class="container" style="padding-top: 50px">
		<form action="payto.jsp">
			<table class="table table-bordered table-hober" style="text-align: center border: 1px soloid #dddddd; ">
				<thead>
					<tr>
						<th colspan="3"><h4>결제 양식</h4>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control"  type="text" id="name" name="userName" maxlength="20" value="<%=userbean.getName() %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control"  type="email" id="email" name="userEmail" maxlength="20" value="<%=userbean.getEmail() %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>전화번호</h5></td>
						<td colspan="2"><input class="form-control"  type="tel" id="phone" name="userPhone" maxlength="20" placeholder="전화번호을 입력하세요"></td>
					</tr>
					<tr>
						 <td style="width: 110px;"><h5><label for="yy">주소</label></h5></td>
						 <td colspan="2"> <input type="text" id="userName" name="address" value="" ></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>총가격</h5></td>
						 <td colspan="2"> <input type="text" id="totalPrice" name="totalPrice" value="<%=bean.getPrice() %>" ></p></td>
					</tr>
											
					<tr>
						<td style="text-align: letf;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5>
							<input class="btn btn-primary pull-right" type="submit" value="결제">
							<input class="btn btn-primary pull-right" type="reset" value="취소">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>









