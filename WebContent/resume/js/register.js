function inputCheck(){
	if(document.regFrm.uid.value==""){
		alert("아이디를 입력해주세요");
		document.regFrm.uid.focus();
		return;
	}
	if(document.regFrm.pwd.value==""){
		alert("비밀번호를 입력해주세요.");
		document.regFrm.pwd.focus();
		return;
	}
	if(document.regFrm.repwd.value==""){
		alert("비밀번호 확인을 입력해주세요");
		document.regFrm.repwd.focus();
		return;
	}
	if(document.regFrm.pwd.value != document.regFrm.repwd.value){
		alert("비밀번호와 확인이 일치하지 않습니다.");
		document.regFrm.repwd.value="";
		document.regFrm.repwd.focus();
		return;
	}
	if(document.regFrm.name.value==""){
		alert("이름을 입력해주세요.");
		document.regFrm.name.focus();
		return;
	}
	
		if(document.regFrm.nickname.value==""){
		alert("닉네임을 입력해주세요");
		document.regFrm.nickname.focus();
		return;
	}
	if(document.regFrm.birth.value==""){
		alert("생년월일을 입력해주세요.");
		document.regFrm.birth.focus();
		return;
	}

	if(document.regFrm.email.value==""){
		alert("이메일을 입력해주세요.");
		document.regFrm.email.focus();
		return;
	}
    var str=document.regFrm.email.value;	   
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
	      document.regFrm.email.focus();
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
