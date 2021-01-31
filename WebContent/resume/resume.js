//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function sample4_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample4_postcode').value = data.zonecode;
							document.getElementById("sample4_roadAddress").value = roadAddr;

							
							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								guideTextBox.innerHTML = '(예상 지번 주소 : '
										+ expJibunAddr + ')';
								guideTextBox.style.display = 'block';
							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}
						}
					}).open();
		}
		
		var schoolcnt=0;
		var careercnt=0;
		var certicnt=0;
		var awardcnt=0;
		
		
		function schoolplus() {
			var div = document.createElement('div');
			schoolcnt = schoolcnt + 1;
			div.innerHTML = document.getElementById('resume-box3h').innerHTML;
			var divplus = document.getElementById('resume-boxplus')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box3h');

		}

		function certiplus() {
			var div = document.createElement('div');
			certicnt = certicnt +1;
			div.innerHTML = document.getElementById('resume-box4h').innerHTML;
			var divplus = document.getElementById('resume-boxplus2')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box4h');

		}

		function awardplus() {
			var div = document.createElement('div');
			awardcnt = awardcnt +1;
			div.innerHTML = document.getElementById('resume-box5h').innerHTML;
			var divplus = document.getElementById('resume-boxplus3')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box5h');

		}

		function careerplus() {
			var div = document.createElement('div');
			careercnt = careercnt + 1;
			div.innerHTML = document.getElementById('resume-box6h').innerHTML;
			var divplus = document.getElementById('resume-boxplus4')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box6h');
		}
		
		
		function creerdel(btn) {
			careercnt = careercnt - 1;
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		function awarddel(btn) {
			awardcnt = awardcnt -1;
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		function certidel(btn) {
			certicnt = certicnt -1;
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		function schooldel(btn) {
			schoolcnt = schoolcnt -1;
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		$(function() {
			$('.datePicker').datepicker({
				format : "yyyy-mm-dd", //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
				autoclose : true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
				language : "ko" //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.

			});//datepicker end
		});//ready end

		var loadFile = function(event) {
			var output = document.getElementById('output');
			output.src = URL.createObjectURL(event.target.files[0]);
			output.onload = function() {

				var imglabel = document.querySelector('#imglabel');
				var imghover = document.querySelector('.imghover')
				URL.revokeObjectURL(output.src) // free memory
				imglabel.style.display = 'none';
				output.style.display = 'block';
			}
		};
		
	function resumecofirm(){
	if(document.postFrm.name.value==""){
		alert("아이디를 입력해주세요");
		document.postFrm.name.focus();
		return;
	}
	if(document.postFrm.birth.value==""){
		alert("생년월일을 입력해주세요.");
		document.postFrm.birth.focus();
		return;
	}
	
	if(document.postFrm.email.value==""){
		alert("이메일을 입력해주세요.");
		document.postFrm.email.focus();
		return;
	}
    var str=document.postFrm.email.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail을 제대로 입력해주세요');
	      document.postFrm.email.focus();
		  return;
    }
    if(document.regFrm.grade.value=="0"){
		alert("회원유형을 선택해주세요.");
		document.regFrm.grade.focus();
		return;
	}
	if(document.regFrm.company.value==""){
		alert("회사명을 입력해주세요.");
		document.regFrm.company.focus();
		return;
	}
	document.regFrm.submit();
			
		}