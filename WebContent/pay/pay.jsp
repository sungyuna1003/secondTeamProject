<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@include file="../bar/bar.jsp" %>
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
		<form action="../pay/payto.jsp">
			<table class="table table-bordered table-hober" style="text-align: center border: 1px soloid #dddddd; ">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 기본 등록 양식</h4>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control"  type="text" id="name" name="userName" maxlength="20" placeholder="본인 이름을 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control"  type="email" id="email" name="userEmail" maxlength="20" placeholder="이메일을 입력하세요"></td>
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
						 <td colspan="2"> <input type="text" id="totalPrice" name="totalPrice" value=""></td>
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









