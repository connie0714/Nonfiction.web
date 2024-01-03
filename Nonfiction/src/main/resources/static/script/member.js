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


document.addEventListener("DOMContentLoaded", () => {
	const modal = document.getElementById("modal");
	const openModalBtn = document.getElementById("btn-open-modal");
	const closeModalBtn = document.getElementById("btn-close-modal");

	// 모달창 열기
	openModalBtn.onclick = function() {
	modal.style.opacity = "0"; // 초기에 투명도를 0으로 설정
	modal.style.display = "block";
		 setTimeout(function() {
		   modal.style.opacity = "1"; // 일정 시간 후에 투명도를 1로 설정하여 부드러운 효과 적용
		  }, 0); // 0.05초(50ms) 후에 투명도를 1로 변경
		}
		
		// 모달창 닫기
		closeModalBtn.onclick = function() {
		  modal.style.opacity = "0"; // 투명도를 0으로 설정하여 부드러운 효과 적용
		  setTimeout(function() {
		    modal.style.display = "none";
		  }, 250); // 일정 시간 후에 모달창을 숨김
		}
	});
				  
				  
				  
				  
				  
				  
				  
				  
				  