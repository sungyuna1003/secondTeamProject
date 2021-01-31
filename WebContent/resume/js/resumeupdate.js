function schoolplus() {
			var div = document.createElement('div');

			div.innerHTML = document.getElementById('resume-box3h').innerHTML;
			var divplus = document.getElementById('resume-boxplus')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box3h');

		}

		function certiplus() {
			var div = document.createElement('div');

			div.innerHTML = document.getElementById('resume-box4h').innerHTML;
			var divplus = document.getElementById('resume-boxplus2')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box4h');

		}

		function awardplus() {
			var div = document.createElement('div');

			div.innerHTML = document.getElementById('resume-box5h').innerHTML;
			var divplus = document.getElementById('resume-boxplus3')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box5h');

		}

		function careerplus() {
			var div = document.createElement('div');

			div.innerHTML = document.getElementById('resume-box6h').innerHTML;
			var divplus = document.getElementById('resume-boxplus4')
					.appendChild(div);
			divplus.style.display = 'block';
			divplus.setAttribute('class', 'col-md-12 resume-box plus');
			divplus.setAttribute('id', 'resume-box6h');
		}

		function creerdel(btn) {
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		function awarddel(btn) {
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		function certidel(btn) {
			var c = btn.parentNode;
			var p = c.parentElement;
			p.removeChild(c);

		}

		function schooldel(btn) {
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
				URL.revokeObjectURL(output.src) // free memory
				output.style.display = 'block';
			}
		};