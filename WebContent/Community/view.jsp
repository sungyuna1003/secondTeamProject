<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<%@page import="Community.CommunitiyMgr"%>
<%@page import="Community.CommunityBean" %>
<%@ include file="../bar/bar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int cid = 0;
		if(request.getParameter("cid")!=null){
			cid = Integer.parseInt(request.getParameter("cid"));
		}
		if(cid==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script");
		}
		CommunityBean Cbean = new CommunitiyMgr().getRow(cid);
	%>
	<script type="text/javascript">
	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function(){ alert.hide() }, delay);
		};
	function submitFunction() {
		var uid_seeker = "<%=userID%>";
		var cid = <%=cid%>;
		var comment = $('#comment').val();	
		
		$.ajax({
			type : "POST",	
			url : "../Community/CReplySubmit",
			data : {
				uid_seeker : "<%=userID%>",
				cid : <%=cid%>,
				comment : $('#comment').val(),
			},
			success : function(result) {
				console.log(result);
				if (result == 1) {
					autoClosingAlert('#successMessage', 2000);
				} else if (result == 0) {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}
			},
			 error : function(request, status, error) { // 결과 에러 콜백함수
			        console.log(error)
			    }
		});
		$('#comment').val('');
	}	
	var lastID = 0;
	function CommentBoxFunction(type) {
		console.log(type)
		var userID = '${userID}'
		var cid = ${param.cid}
		$.ajax({
			type: "post",
			url: "../Community/Reply",
			data:{
				userID : userID,
				cid : cid,
				listType: type
			},
		success: function (data) {
			if (data == "")

				return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
				for(var i = 0; i<result.length; i++){
					console.log(result[i][0].value)
				addBox(result[i][0].value , result[i][1].value , result[i][2].value)
				}
				lastID = Number(parsed.last);
			}
		});
	}
	function addBox(uid_seeker,comment_con,date) {
		$('#CboxTable').append('<tr>' +
				'<td style="width:150px;">' +
				'<h5>' + uid_seeker + '</h5></td>'+
				'<td>' +
				'<h5>' + comment_con + '</h5>' +
				'<div class="pull-right">' + date + '</div>' + 
				'</td>' +
				'</tr>');
	}
	function getInfiniteRBox() {

		setInterval(function() {
			CommentBoxFunction(lastID);
			console.log(lastID);

		}, 1000);

	}
	</script>
	<!-- 게시판 글보기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
					<td style = "width: 20%;">글 제목</td>
					<td colspan="2"> <%=Cbean.getC_title() %></td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td colspan="2"> <%= Cbean.getUid_seeker() %></td>
				</tr>			
				
				<tr>
					<td>작성일자</td>
					<td colspan="2"><%= Cbean.getDate().substring(0, 11) + Cbean.getDate().substring(11, 13) + 
					"시 " + Cbean.getDate().substring(14, 16) + "분 " %></td>
				</tr>
				
				<tr>
					<td>첨부파일</td>
					<td colspan="2"><a download href="../images/<%=(Cbean.getFiles()==null)?"":Cbean.getFiles()%>"><%=(Cbean.getFiles()==null)?"":Cbean.getFiles()%></a></td>
				</tr>
				
				<tr>
					<td>내용</td>
					
					<td colspan="2" style="height: 200px; min-height:200px; text-align: left;">
					 <%= Cbean.getC_content().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>								

					</tbody>
				</table>
			</table>
			
			<a href="../Community/bbs" class="btn btn-primary">목록</a>
			
			<%
				if(userID != null && userID.equals(Cbean.getUid_seeker())){
			%>
					<a href="update.jsp?cid=<%= cid %>" class="btn btn-primary">수정</a>
					<a onclick = "return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?cid=<%= cid %>" class="btn btn-primary">삭제</a>
			<% 
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	<!-- 댓글 -->
			<div class="container">
	<div class="jumbotron" style="background-color: white;">
		<div class="container" style="padding-top: 50px">
			<table class="table" style="margin: 0 auto;">
				<thead>
					<th><h4>댓글 목록</h4></th>
				</thead>
				<div style="overflow-y: auto; width:100%; max-height: 450px;">
					<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid; #dddddd; margin: 0 auto;">
						<tbody id="CboxTable">
						</tbody>
					</table>
				</div>
			</table>
			<p>
			<div class="container" >
				<div align="right" style="padding-right: 18px;" >
					<table class="table table-bordered table-hober" style="text-align: center border: 1px soloid #dddddd; ">
					<tr>
						<td style="width: 110px;"><h5>댓글</h5></td>
						<td><input class="form-control" type="text" id="comment" name="conmment" maxlength="20" placeholder="댓글을 입력하세요"></td>
					</tr>
					</table>
						<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
				</div>
		    </div>
		</div>	
	</div>
</div>
<!--  알림창 만들기 -->		
	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong>메세지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong>데이터 베이스 오류가 발생했습니다.</strong>
	</div>
<script type="text/javascript">
			$('#messageModal').modal("show");
			$(document).ready(function () {
				CommentBoxFunction('0');
				getInfiniteRBox();
			});
		</script>
</body>
</html>