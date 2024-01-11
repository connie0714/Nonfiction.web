<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/admin/admin.css">
<script src="/admin/admin.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/script/member.js"></script>
<script type="text/javascript" src="/script/mypage.js"></script>
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
	            	$("#filename").append("<img src='product_images/"+data.FILENAME+"' height='150'/>");
	            }
	        },
	        error: function() {				alert("실패");			}
		});
	
	});
});
/*admin배너  */
var num=0;
setInterval( function(){
	document.getElementById("imgs").style.left = num * -968 + 'px';
	num++;
    if(num==5 )num=0;
}, 2000);
</script>

</head>
<body>

<div id="wrap">
<header>			
	<div id="logo">
		<img style="width:800px" src="/admin/bar_01.gif">
		<img src="/admin/text.gif">
	</div>	
	<input class="btn" type="button" value="logout" style="float: right;"
		onClick="location.href='adminLogout'">		
		
				<div id="logo">
			<a href="/"><img src="/images/logo.png"  width="180" height="100"></a></div>
		<nav id="top_menu"> <!-- top menu -->
				<ul>
						<c:choose>
							<c:when test="${empty loginUser}">
								<li><a href="loginForm">LOGIN</a></li>
								<li><a href="contract">JOIN</a></li>
							</c:when>
				    		<c:otherwise>
				       			<li style="color:blue;font-weight:bold;font-size:100%;     ">
				       				${loginUser.NAME}(${loginUser.USERID})</li>
				       			<li><a href="memberEditForm">정보수정</a></li>
				       			<li><a href="logout">LOGOUT</a></li>
							</c:otherwise>
						</c:choose>
						<li><a href="cartList">CART</a></li><li><a href="myPage">MY PAGE</a></li>
				    	<li ><a href="customer">고객센터</a></li>
				</ul>
		</nav>
		

		<div class="clear"></div><hr>	
</header>
<div class="clear"></div>