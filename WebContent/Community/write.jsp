<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/bar/bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<script type="text/javascript" src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<div class="container">
		<div>
			<form method="post" action="../Community/write" enctype="multipart/form-data" >
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
								<script type="text/javascript">CKEDITOR.replace('c_content',{filebrowserUploadUrl: '${pageContext.request.contextPath }/adm/fileupload.do'});</script>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
</body>
</html>