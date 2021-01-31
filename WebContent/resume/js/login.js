
	function loginCheck() {
		if (document.loginFrm.uid.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.uid.focus();
			return;
		}
		if (document.loginFrm.pwd.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
