function go_next(){
	 if( document.contractFrm.okon[1].checked==true){
		alert('회원 약관에 동의 하셔야 회원가입이 가능합니다');
	}else{
		document.contractFrm.action = "joinForm";
		document.contractFrm.submit();
	}
}

function idcheck(){
	if( document.formm.userid.value=="" ){
		alert("아이디를 입력하고 중복체크를 진행하세요" );
		documnet.formm.userid.focus();
		return;
	}
	var url = "idCheckForm?userid=" + document.formm.userid.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "idcheck", opt);	
}


function idok( userid ){
	opener.formm.userid.value = userid;
	opener.formm.reid.value = userid;
	self.close();
}