/*1:1talk*/
$(document).ready(function() {
    // 버튼 클릭 시 모달 창 열거나 닫기
    $('#btn-open-chat').on('click', function() {
        var $modal = $('.modal');
        if ($modal.css('display') === 'none') {
            // 모달창이 닫혀있을 때: 모달창 열고 버튼 텍스트를 'X'로 변경
            $modal.show().css('transform', 'translateX(0)');
            $(this).text('X').css({'font-weight': 'bold', 'font-size': '18px'});
        } else {
            // 모달창이 열려있을 때: 모달창 닫고 버튼 텍스트를 '1:1 TALK'으로 변경
            $modal.css('transform', 'translateX(120%)');
            setTimeout(function() {
                $modal.hide();
            }, 500); // Wait for the animation to finish before hiding the modal
            $(this).text('1:1 TALK');
        }
    });
    
});


/*	스크롤 내릴시 해더 부분 일부 숨김 의훈 작성	*/
window.onscroll = function() {
  var currentScrollPos = window.pageYOffset;  
  var targetElement = document.getElementById("black-bar"); 

  // 스크롤 위치가 100px을 넘어가면 'top' 부분을 숨김
  if (currentScrollPos > 30) {
    targetElement.style.top = "-50px";
  } else {
    targetElement.style.top = "0px"; 
  }
};
/*	스크롤 내릴시 해더 부분 일부 숨김 의훈 작성	*/

