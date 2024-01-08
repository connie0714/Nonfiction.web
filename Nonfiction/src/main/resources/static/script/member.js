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




