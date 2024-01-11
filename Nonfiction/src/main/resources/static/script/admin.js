function go_search( requestName ){

	document.frm.action = requestName + "?page=1";
	document.frm.submit();
}

function go_view(qseq){
	location.href="adminQnaView?qseq="+qseq;
}

function go_rep(){
	if(document.frm.reply.value==""){
		alert("내용을 입력하세요");
		return;
	}
	document.frm.action="adminQnaRepSave";
	document.frm.submit();
}

function searchPosts(page) {
    var keyword = document.getElementsByName("key")[0].value;
    location.href = page + "?key=" + keyword; 
}


function go_qnaList() {
    document.getElementsByName("key")[0].value = "";
    searchPosts('adminQnaList'); 
}


function go_memberList() {
    document.getElementsByName("key")[0].value = "";
    searchPosts('memberList'); 
}



function reInsert(userid,useyn){
	location.href="memberReinsert?userid="+userid+"&useyn"+useyn;
}



/*adminBanner*/
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function (e) {
            document.getElementById('bannerImage').src = e.target.result;
            document.querySelector('.fullscreen-image img').src = e.target.result;
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}


function go_banner_save(){
	
	// 밸리데이션 동작 추가
	// ....
	
	var theForm = document.frm;  
	theForm.action = "bannerWrite";
	theForm.submit();
	
}

function go_mov(){
	location.href = "productList";
}

/*adminBanner*/




window.onload = function() {
    var video = document.querySelector(".fullscreen-video video");
    video.style.width = "100%";
    video.style.height = "100%";
    video.style.objectFit = "fill";

    var swiper = new Swiper('.swiper-container', {
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
    });

    $.ajax({
        url: '/api/banners',
        success: function(banners) {
            for (var i = 0; i < banners.length; i++) {
                swiper.appendSlide('<div class="swiper-slide"><img src="' + banners[i].imageUrl + '"></div>');
            }
        }
    });
}