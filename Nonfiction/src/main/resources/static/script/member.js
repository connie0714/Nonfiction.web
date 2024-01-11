/*	member 관련 승희 작성	*/

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
		documenet.formm.userid.focus();
		return;
	}
	var url = "idCheckForm?userid=" + document.formm.userid.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "idcheck", opt);	
}





function pwdCheck() {
    if (document.formmm.userid.value === "") {
        alert("아이디를 입력하세요");
        document.formmm.userid.focus();
        return;
    }
    var url = "pwdSearchForm?userid=" + document.formmm.userid.value;
    var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
    window.open(url, "pwdcheck", opt);
}



function idokforpwd( userid ){
	opener.formmm.userid.value = userid;
	opener.formmm.reid.value = userid;
	self.close();
}



function changePassword() {
    var newPassword = document.getElementById("newPassword").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    // 비밀번호 일치 여부 체크
    if (newPassword !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return false; // 폼 전송을 중지합니다.
    }

    return true; // 폼을 제출합니다.
}






function idok( userid ){
	opener.formm.userid.value = userid;
	opener.formm.reid.value = userid;
	self.close();
}


function withdrawal(){
	var ans = confirm("정말로 탈퇴하시겠습니까?");
	if(ans) location.href='deleteMember';
}


function gojoinButton() {
  var joinButton = document.getElementById("joinbtn");
  if (joinButton) {
    joinButton.addEventListener("click", function() {
      window.location.href = "contract";
    });
  }
}

document.addEventListener("DOMContentLoaded", gojoinButton);

function passCheck( qseq ){
	var url = "passCheck?qseq=" + qseq;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
    window.open(url, "passCheck", opt);
}

function passCheck( qseq ){
   var url = "passCheck?qseq=" + qseq;
   var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
    window.open(url, "passCheck", opt);
}




function enable() {
    var secretCheckbox = document.getElementsByName("secret")[0];
    var passwordInput = document.getElementsByName("pass")[0];
    
    if (secretCheckbox.checked) {
        passwordInput.disabled = false;
    } else {
        passwordInput.disabled = true;
    }
}

/*	member 관련 승희 작성	*/

/*	cart부분	*/
function addToCart() {

    var currentCart = localStorage.getItem('cart');
  

    if (!currentCart) {
        currentCart = 0;
    }
  
    currentCart = Number(currentCart) + 1;
    localStorage.setItem('cart', currentCart);
 
    document.querySelector('.cart-count').innerText = `CART(${currentCart})`;
}




