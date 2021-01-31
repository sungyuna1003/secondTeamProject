<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="payForm.css">
</head>
<body>
	<div class="container" id="payformcontainer" >
		<div class="row">
			<form action="../pay/payto.jsp" method="get" style="width: 33%;">
				<div class="col-xs-12">
					<div class="row planBox premium text-center">
						<div class="col-md-12 section1">
							<p>1</p>
							<h1>
								<sup>$</sup>200<span>/ 달</span>
							</h1>
							<button class="btn btn-block box1btn">바로 구매</button>
						</div>
						<div class="col-md-12 section2">
							<p>5</p>
							<br>
							<p>4</p>
							<br>
						</div>
						<div class="col-md-12 section3">
							<button class="btn btn-block saveBtn">장바구니</button>
						</div>
					</div>
				</div>
			</form>
			<form action="../pay/payto.jsp" method="get" style="width: 33%;">

				<div class="col-xs-12">
					<div class="row planBox plus text-center">
						<div class="col-md-12 section1">
							<p>1</p>
							<h1>
								<sup>$</sup>300<span>/ 달</span>
							</h1>
							<button class="btn btn-block box1btn"
								onclick="location.href='../pay/payto.jsp'">바로 구매</button>
						</div>
						<div class="col-md-12 section2">
							<p>2</p>
							<br>
							<p>4x</p>
							<br>
						</div>
						<div class="col-md-12 section3">
							<button class="btn btn-block saveBtn">장바구니</button>
						</div>
					</div>
				</div>
			</form>
			<form action="../pay/payto.jsp" method="get" style="width: 33%;">

				<div class="col-xs-12">
					<div class="row planBox basic text-center">
						<div class="col-md-12 section1">
							<p>1</p>
							<h1>
								<sup>$</sup>50<span>/ 달</span>
							</h1>
							<button class="btn btn-block box1btn"
								onclick="location.href='../pay/payto.jsp'">바로 구매</button>
						</div>
						<div class="col-md-12 section2">
							<p>72</p>
							<br>
							<p>3 굿</p>
							<br>
						</div>
						<div class="col-md-12 section3">
							<button class="btn btn-block saveBtn">장바구니</button>
						</div>
					</div>
				</div>
			</form>

		</div>
	</div>
</body>
</html>