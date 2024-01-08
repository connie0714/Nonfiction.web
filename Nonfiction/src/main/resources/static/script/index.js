/*1:1talk*/
$(document).ready(function() {
	// 버튼 클릭 시 모달 창 열거나 닫기
	$('#btn-open-chat').on('click', function() {
		var $modal = $('.modal');
		if ($modal.css('display') === 'none') {
			// 모달창이 닫혀있을 때: 모달창 열고 버튼 텍스트를 'X'로 변경
			$modal.show().css('transform', 'translateX(0)');
			$(this).text('X').css({ 'font-weight': 'bold', 'font-size': '18px' });
		} else {
			// 모달창이 열려있을 때: 모달창 닫고 버튼 텍스트를 '1:1 TALK'으로 변경
			$modal.css('transform', 'translateX(120%)');
			setTimeout(function() {
				$modal.hide();
			}, 500); // Wait for the animation to finish before hiding the modal
			$(this).text('1:1 TALK').css({'font-weight':'100', 'font-size': '13px'});
		}
	})
})


/* 모달창 홈 버튼*/
$(document).ready(function() {
	
	$('#close-btn').on('click', function() {
	alert('홈버튼 작동 테스트');
		var $modal = $('.modal');
			// 모달창이 열려있을 때: 모달창 닫고 버튼 텍스트를 '1:1 TALK'으로 변경
		if ($modal.css('display') != 'none') {
			// 모달창이 열려있을 때: 모달창 닫고 버튼 텍스트를 '1:1 TALK'으로 변경
			$modal.css('transform', 'translateX(120%)');
			setTimeout(function() {
				$modal.hide();
			}, 500); // Wait for the animation to finish before hiding the modal
    	}
	})
})



/* 모달창용 ajax */
function sendRequest(kind) {
   var formselect = $("#answer")[0];   // 지정된 폼을 변수에 저장
   var formdata = new FormData(formselect);   // 전송용 폼객에 다시 저장
   var host = window.location.origin;

	if(kind == "주문/배송"){
		$("#answer-content").append("<div class='answer-area'>" + kind + "</div>");
		$(".select-qna").hide();
		setTimeout(function() {
				$(".chat-box").append("<div id='non-area'><label>논픽션</label><div class='chat-area'><p class='msg'>죄송합니다 현재 이용이 불가능 합니다.</p></div></div>");
			}, 500);
	}else if(kind == "상담원 연결"){
		$("#answer-content").append("<div class='answer-area'>" + kind + "</div>");
		$(".select-qna").hide();
			setTimeout(function() {
				$(".chat-box").append("<div id='non-area'><label>논픽션</label><div class='chat-area'><p class='msg'>죄송합니다 현재 이용이 불가능 합니다.</p></div></div>");
			}, 500);
	}else if(kind == "상품문의"){
		$("#answer-content").append("<div class='answer-area'>" + kind + "</div>");
		$(".select-qna").hide();
			setTimeout(function() {
				$(".chat-box").append("<div id='non-area'><label>논픽션</label><div class='chat-area'><p class='msg'>죄송합니다 현재 이용이 불가능 합니다.</p></div></div>");
			}, 500);
	}else{
		alert('잘못된 접근입니다.');
	}

/*   $.ajax({    // 웹페이지 이동 또는 새로고침이 필요없는 request요청
      // 현재주소의 fileup 리퀘스트로 요청  http://localhost:8070/fileup
      //<%=request.getContextPath() %>/fileup
      url: host + "/answer",
      type: "POST",
      async: false,
      data: formdata,
      timeout: 10000,
      contentType: false,
      processData: false,
      success: function(data) {    // controller 에서 린턴된 해시맵이  data 로 전달됩니다
         if (data.STATUS == 1) {     // 동적으로 div태그 달아주기.
            //$("#filename").append("<div>" + data.FILENAME + "</div>");
            $("#non-area").append("<label>논픽션</label><div class='chat-area'><p class='msg'>" + data.content + "</p></div>");
         }
      },
      error: function() { alert("실패"); }
   });*/
   
}




/* 모달창용 ajax */



/*	스크롤 내릴시 해더 부분 일부 숨김 의훈 작성	*/
window.onscroll = function() {
	var currentScrollPos = window.pageYOffset;
	var targetElement = document.getElementById("black-bar");
	var targetElement1 = document.getElementById("category-menu");
	var targetElement2 = document.getElementById("top-menu-container");

	// 스크롤 위치가 100px을 넘어가면 'top' 부분을 숨김
	if (currentScrollPos > 30) {
		targetElement.style.top = "-50px";
		targetElement1.style.top = "30px";
		targetElement2.style.top = "30px";
	} else {
		targetElement.style.top = "0px";
		targetElement1.style.top = "50px";
		targetElement2.style.top = "50px";
	}
};
/*	스크롤 내릴시 해더 부분 일부 숨김 의훈 작성	*/

