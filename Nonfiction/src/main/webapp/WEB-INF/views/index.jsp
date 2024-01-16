<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

<script>
	window.onload = function() {
	    var video = document.querySelector(".fullscreen-video video");
	    video.style.width = "100%";
	    video.style.height = "100%";
	    video.style.objectFit = "fill";
	}
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">

	var num=0;
	setInterval(function(){
		document.getElementById("imgs").style.left=num* -968 + 'px';
		num++;
		if(num==5)num=0;
	},2000);



</script>


<script type="text/javascript">
$(function(){
	$('#myButton').click( function(){
		
		var formselect = $("#fileupForm")[0];   // 지목된 폼을 변수에 저장
		var formdata = new FormData(formselect);   // 전송용 폼객체에 폼과 안의 데이터를 저장
		
		$.ajax({    // 웹페이지 이동 또는 새로고침이 필요없는 request요청
			// 현재주소의 fileup 리퀘스트로 요청  http://localhost:8070/fileup     @PostMapping("/fileup")
			url:"<%=request.getContextPath() %>/fileup", 
			type:"POST",
			enctype:"multipart/form-data",
			async: false, 
			data: formdata,
	    	timeout: 10000,
	    	contentType : false,
	        processData : false,
	        
	        success : function(data){    // controller 에서 린턴된 해시맵이  data 로 전달됩니다
	            if( data.STATUS == 1 ){  	// 동적으로 div태그 달아주기.
	            	$("#filename").append("<div>"+data.FILENAME+"</div>");
	            	$("#image").val(data.FILENAME);
	            	$("#filename").append("<img src='nonimage/"+data.FILENAME+"' height='150'/>");
	            }
	        },
	        error: function() {				alert("실패");			}
		});
	
	});
});
</script>

<div class="fullscreen-video">
  <video class="center" autoplay muted loop>
  <source src="/nonimage/mainvideo.mp4" type="video/mp4">
</video>
</div>

<%-- 	<div class="fullscreen-image">
        <img id="bannerImage" src="/nonimage/main2.jpg" alt="Descriptive Alt Text">
        <c:forEach	items="${bannerList }" var="bannerVO">
 				<img src="/nonimage/${bannerVO.IMAGE }" style="width:965px; height:350px; margin:0">
 			</c:forEach>
        <div class="centered-text">HOLIDAY GIFT EDITION</div>
    </div>
     --%>
     
    <div class="fullscreen-image">
 	<!-- <img src="images/main_img.jpg" 	style="border-radius:20px 20px 20px 20px;border:2px solid white;"> -->
 	<div id="view" style="position:relative; width:965px; overflow:hidden; height:350px; border-radius:20px;">
 		<div id="imgs"	style="position:absolute; width:4860px; height:350px; text-align:left; transition:1s">
 			<c:forEach	items="${bannerList }" var="bannerVO">
 				<img src="/nonimage/${bannerVO.IMAGE }" style="width:965px; height:350px; margin:0">
 			</c:forEach>
 		</div>
 	</div>
 </div>
    
    
    


 </div>
<%@ include file="include/footer.jsp"  %>