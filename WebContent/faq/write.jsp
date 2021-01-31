<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../bar/bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div>
			<form method="post" action="write" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td align="left">
								<label class="btn btn-primary" >
									<input type="radio" name="tab" autocomplete="off" value="유머" checked>유머
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="tab" autocomplete="off" value="구인" >구인
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="tab" autocomplete="off" value="프리" >프리
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="tab" autocomplete="off" value="헤드" >헤드
								</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="file" name="file" />
							</td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="c_title" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="c_content" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>