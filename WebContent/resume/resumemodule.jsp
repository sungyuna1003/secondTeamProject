<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="job.JobMgr" />
<jsp:useBean id="user" class="bean.UserBean" />
<jsp:useBean id="r_award" class="bean.Resume_awardBean" />
<jsp:useBean id="r_career" class="bean.Resume_careerBean" />
<jsp:useBean id="r_certificate" class="bean.Resume_certificateBean" />
<jsp:useBean id="r_edu" class="bean.Resume_eduBean" />
<jsp:useBean id="r" class="bean.ResumeBean" />
<%
String id = session.getAttribute("userID").toString();
	if (id == null) {
	response.sendRedirect("../main/main.jsp");
	return;
}
user = mgr.getUser(id);
System.out.println("1"+user.getImg());
%>
<!DOCTYPE html>
<html>
<head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resume/css/bootstrap-datepicker.css">
<link href="../resume/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="../resume/css/resume.css">
<script src="../resume/js/bootstrap-datepicker.js"></script>
<script src="../resume/js/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../resume/js/resumeupdate.js"></script>
<link rel="stylesheet" href="../bar/bar.css" />

<meta charset="UTF-8">
<title>이력서 작성</title>


<style>
div {
	text-align: center;
}
</style>
</head>



<body>
	<div id="resume">
		<div class="container">
			<div id="resume-row"
				class="row justify-content-center align-items-center">
				<div id="resume-column" class="col-md-6">
					<!-- 기본 박스 -->
					<form name="postFrm" method="post" action="resumepost"
						enctype="multipart/form-data">

						<div id="resume-box1" class="col-md-12 resume-box">


							<h3 class="text-center text-info">기본 정보</h3>

							<div class="form-group">
								<label class="text-info text-left label-full">이름:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control"  name="name" id="name"
											value=<%=user.getName()%> />
									</div>
								</div>
							</div>


							<div class="form-group" style="float: left;">
								<label class="text-info text-left label-full">성별:</label>
								<div class="radio">
									<label><input type="radio" name="gender" value="1"
										<%if (user.getGender().equals("1")) {
	out.println("checked");
}%>>남성</label>
								</div>
								<div class="radio">
									<label><input type="radio" name="gender" value="2"
										<%if (user.getGender().equals("2")) {
	out.println("checked");
}%>>여성</label>
								</div>


							</div>

							<div class="form-group">
								<label for="birth" class="text-info text-left label-full">생년월일:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" id="birth" name="birth"
											class="form-control datePicker" value=<%=user.getBirth()%>>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label for="email" class="text-info text-left label-full">이메일:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" id="email"
											name="email" value=<%=user.getEmail()%> />
									</div>
								</div>
							</div>

							<div class="form-group">
								<label for="img" class="text-info text-left label-full">11이력서
									사진(3X4):</label>
								<div class="cols-sm-10">
									<div class="input-group">

										<input type="file" accept="image/*" onchange="loadFile(event)"
											id="img" name="img"> <br>

									</div>
									<div class="imghover"
										style="margin-top: 10px; width: 94.4px; height: 113.3px; align: center; background-color: white;">
										<img id="output" style="display: block;"
											src="../images/<%out.println(user.getImg());%>" />
									</div>
								</div>
							</div>

						</div>
						<!-- 기본 박스 -->

						<!-- 추가 정보 박스 -->
						<div id="resume-box2" class="col-md-12 resume-box">

							<h3 class="text-center text-info">추가 정보</h3>



							<div class="form-group">
								<label for="e_name" class="text-info text-left label-full">이름(영어):</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" id="e_name"
											name="e_name" placeholder="이름(영어)를 입력해주세요" />

									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">주소:</label>
								<div class="cols-sm-10">
									<div class="input-group" style="text-align: left;">
										<input type="text" id="sample4_postcode" name="addressA"
											placeholder="우편번호" style="margin: 5px;"> <input
											type="button" onclick="sample4_execDaumPostcode()"
											value="우편번호 찾기" style="margin: 5px;"><br> <input
											type="text" id="sample4_roadAddress" placeholder="도로명주소"
											style="margin: 5px; width: 290px;" name="addressB"> <span
											id="guide" style="color: #999; display: none"></span> <br>
										<input type="text" id="sample4_detailAddress"
											placeholder="상세주소" style="margin: 5px; width: 290px;"
											name="addressC">


									</div>
								</div>
							</div>

							<div class="form-group cols-sm-10">
								<label for="telnum" class="text-info text-left label-full">연락처:</label>
								<input name="telnum" id="telnum"
									class="form-control"
									placeholder="연락처를 입력해주세요.(여백, '-' 제외, ex01099998888)" />
							</div>

							<div class="form-group">
								<label for="selfintroduce"
									class="text-info text-left label-full">자기소개:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<textarea class="form-control" id="selfintroduce"
											name="selfintroduce" rows="5" cols="33" /></textarea>
									</div>
								</div>
							</div>

						</div>
						<!-- 추가 정보 박스 -->

						<!-- 학력 박스 -->
						<div id="resume-box3" class="col-md-12 resume-box">

							<h3 class="text-center text-info">학력사항</h3>

							<div class="form-group">
								<label for="schoolname" class="text-info text-left label-full">학교명:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" name="schoolname" id="schoolname"
											placeholder="학교명을 입력해주세요" />
									</div>
								</div>
							</div>

							<div class="form-group">
								<label for="admission" class="text-info text-left label-full">재학기간:</label>
								<div class="cols-sm-10">

									<div class="input-group" style="width: 50%; float: left;">
										<input type="text" id="admission" name="admission"
											class="form-control datePicker" style="width: 65%;">
										<select name="admissionselect"
											style="width: 25%; heigth: 100%;">
											<option value="입학" selected>입학
											<option value="편입">편입
										</select>


									</div>
									<div class="input-group" style="width: 50%; float: left;">
										<input type="text" name="graduated" id="graduated"
											class="form-control datePicker" style="width: 65%;">
										<select name="graduatedselect"
											style="width: 25%; heigth: 100%;">
											<option value="졸업" selected>졸업
											<option value="재학중">재학중
											<option value="휴학중">휴학중
											<option value="수료">수료
											<option value="중퇴">중퇴
											<option value="자퇴">자퇴
											<option value="졸업예정">졸업예정
										</select>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label for="major" class="text-info text-left label-full">전공:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" id="major" name="major"
											placeholder="전공을 입력해주세요" />
									</div>
								</div>
							</div>
						</div>



						<!-- 학력 박스 -->
						<!-- 학력 박스 추가 -->
						<div id="resume-boxplus"></div>

						<!-- 학력 박스 추가 -->

						<div id="boxplusbtn" class="col-md-12 resume-box">

							<input type="button"
								class="btn btn-info btn-lg btn-block login-button" value="학력 추가"
								onclick="schoolplus()">




						</div>

						<!-- 자격증 경력 박스 -->
						<div id="resume-box4" class="col-md-12 resume-box">

							<h3 class="text-center text-info">자격증 및 경력 사항</h3>

							<div class="form-group">
								<label class="text-info text-left label-full">취득일자:</label>
								<div class="cols-sm-10">
									<div class="input-group">

										<input type="text" name="certi_date"
											class="form-control datePicker">
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">자격 및 교육명:</label>
								<div class="cols-sm-10">

									<div class="input-group">
										<input type="text" class="form-control" name="certi_name"
											placeholder="자격 및 교육명을 입력해주세요" />

									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">기관명:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" name="agency"
											placeholder="자격을 발급한 기관명을 입력해주세요." />
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">자격 등급:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" name="certi_grade"
											placeholder="자격 등급 혹은 점수를 입력해주세요." />
									</div>
								</div>
							</div>

						</div>



						<!--  자격증 경력 박스 추가  -->
						<div id="resume-boxplus2"></div>

						<!--  자격증 경력 박스 추가  -->


						<div id="boxplusbtn" class="col-md-12 resume-box">

							<input type="button"
								class="btn btn-info btn-lg btn-block login-button"
								value="자격증 추가" onclick="certiplus()">




						</div>


						<!--  자격증 경력 박스  -->

						<!-- 수상 경력 박스 -->
						<div id="resume-box5" class="col-md-12 resume-box">

							<h3 class="text-center text-info">수상 경력 사항</h3>

							<div class="form-group">
								<label class="text-info text-left label-full">수상일자:</label>
								<div class="cols-sm-10">
									<div class="input-group">

										<input type="text" name="award_date"
											class="form-control datePicker">
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">수상 단체:</label>
								<div class="cols-sm-10">

									<div class="input-group">
										<input type="text" class="form-control" name="award_group"
											placeholder="수상단체명을 입력해주세요" />

									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">수상 내용:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" name="award_contents"
											placeholder="수상 내용을 입력해주세요" />
									</div>
								</div>
							</div>



						</div>


						<!--  수상 경력 박스 추가  -->
						<div id="resume-boxplus3"></div>

						<!--  수상 경력 박스 추가  -->


						<div id="boxplusbtn" class="col-md-12 resume-box">

							<input type="button"
								class="btn btn-info btn-lg btn-block login-button"
								value="수상 사항 추가" onclick="awardplus()">




						</div>


						<!--  수상 경력 박스  -->

						<!-- 직업 경력 박스 -->
						<div id="resume-box6" class="col-md-12 resume-box">


							<h3 class="text-center text-info">경력 사항</h3>

							<div class="form-group">
								<label class="text-info text-left label-full">회사명:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" name="r_company"
											placeholder="근무 경력이 있는 회사명을 입력해주세요" />

									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">입사일:</label>
								<div class="cols-sm-10">

									<div class="input-group">
										<input type="text" name="entered_date"
											class="form-control datePicker">

									</div>
								</div>
							</div>

							<div class="form-group">
								<label class ="text-info text-leftlabel-full">퇴사일:</label>
								<div class="cols-sm-10">

									<div class="input-group">
										<input type="text" name="resignation_date"
											class="form-control datePicker">

									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="text-info text-left label-full">직무 내용:</label>
								<div class="cols-sm-10">
									<div class="input-group">
										<input type="text" class="form-control" name="job_title"
											placeholder="근무 내용 및 직위에 대해서 작성해주세요" />
									</div>
								</div>
							</div>




						</div>



						<!--  직업 경력 박스 추가  -->
						<div id="resume-boxplus4"></div>

						<!--  직업 경력 박스 추가  -->


						<div id="boxplusbtn" class="col-md-12 resume-box">

							<input type="button"
								class="btn btn-info btn-lg btn-block login-button"
								value="수상 사항 추가" onclick="careerplus()">




						</div>


						<!--  직업 경력 박스  -->


						<div id="boxplusbtn" class="col-md-12 resume-box"
							style="border-radius: 20px;">

							<input type="submit"
								class="btn btn-info btn-lg btn-block login-button"
								value="이력서 저장" >




						</div>
						<input type="hidden" name="uid" value="<%=id%>">
					</form>

					<!-- 추가 박스 -->
					<div id="resume-box3h" class="col-md-12 resume-box hide">
						<input type="button" value="삭제" onclick="schooldel(this)"
							style="float: right;"> <br>


						<h3 class="text-center text-info">학력사항</h3>

						<div class="form-group">
							<label for="schoolname" class="text-info text-left label-full">학교명:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="schoolname"
										placeholder="학교명을 입력해주세요" />
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="schoolname" class="text-info text-left label-full">재학기간:</label>
							<div class="cols-sm-10">

								<div class="input-group" style="width: 50%; float: left;">
									<input type="text" name="admission"
										class="form-control datePicker" style="width: 65%;"> <select
										name="admissionselect" style="width: 25%; heigth: 100%;">
										<option value="입학" selected>입학
										<option value="편입">편입
									</select>


								</div>
								<div class="input-group" style="width: 50%; float: left;">
									<input type="text" name="graduated"
										class="form-control datePicker" style="width: 65%;"> <select
										name="graduatedselect" style="width: 25%; heigth: 100%;">
										<option value="졸업" selected>졸업
										<option value="재학중">재학중
										<option value="휴학중">휴학중
										<option value="수료">수료
										<option value="중퇴">중퇴
										<option value="자퇴">자퇴
										<option value="졸업예정">졸업예정
									</select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="major" class="text-info text-left label-full">전공:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="major"
										placeholder="전공을 입력해주세요" />
								</div>
							</div>
						</div>
						<br>
					</div>
					<div id="resume-box5h" class="col-md-12 resume-box hide">
						<input type="button" value="삭제" onclick="awarddel(this)"
							style="float: right;"> <br>

						<h3 class="text-center text-info">수상 경력 사항</h3>

						<div class="form-group">
							<label for="" class="text-info text-left label-full">수상일자:</label>
							<div class="cols-sm-10">
								<div class="input-group">

									<input type="text" name="award_date"
										class="form-control datePicker">
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">수상
								단체:</label>
							<div class="cols-sm-10">

								<div class="input-group">
									<input type="text" class="form-control" name="award_group"
										placeholder="수상단체명을 입력해주세요" />

								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">수상
								내용:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="award_contents"
										placeholder="수상 내용을 입력해주세요" />
								</div>
							</div>
						</div>



					</div>

					<div id="resume-box6h" class="col-md-12 resume-box hide">
						<input type="button" value="삭제" class="creerdelbtn"
							onclick="creerdel(this)" style="float: right;"> <br>

						<h3 class="text-center text-info">경력 사항</h3>

						<div class="form-group">
							<label class="text-info text-left label-full">회사명:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="r_company"
										placeholder="근무 경력이 있는 회사명을 입력해주세요" />

								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">입사일:</label>
							<div class="cols-sm-10">

								<div class="input-group">
									<input type="text" name="entered_date"
										class="form-control datePicker">

								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">퇴사일:</label>
							<div class="cols-sm-10">

								<div class="input-group">
									<input type="text" name="resignation_date"
										class="form-control datePicker">

								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">직무
								내용:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="job_title"
										placeholder="근무 내용 및 직위에 대해서 작성해주세요" />
								</div>
							</div>
						</div>



					</div>

					<div id="resume-box4h" class="col-md-12 resume-box hide">
						<input type="button" value="삭제" onclick="certidel(this)"
							style="float: right;"> <br>

						<h3 class="text-center text-info">자격증 및 경력 사항</h3>

						<div class="form-group">
							<label  class="text-info text-left label-full">취득일자:</label>
							<div class="cols-sm-10">
								<div class="input-group">

									<input type="text" name="certi_date"
										class="form-control datePicker">
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">자격
								및 교육명:</label>
							<div class="cols-sm-10">

								<div class="input-group">
									<input type="text" class="form-control" name="certi_name"
										placeholder="자격 및 교육명을 입력해주세요" />

								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">기관명:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="agency"
										placeholder="자격을 발급한 기관명을 입력해주세요." />
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="text-info text-left label-full">자격
								등급:</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<input type="text" class="form-control" name="certi_grade"
										placeholder="자격 등급 혹은 점수를 입력해주세요." />
								</div>
							</div>
						</div>

					</div>
					<!-- 추가 박스 -->

				</div>

			</div>
		</div>
	</div>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="../resume/resume.js" charset="UTF-8">
		
	</script>

</body>
</html>