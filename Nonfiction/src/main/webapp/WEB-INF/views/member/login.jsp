<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/member.js"></script>
<link rel="stylesheet" type="text/css" href="../css/member.css">

</head>
<body>


	<form method="post" action="login" name="loginFrm">
		 <div id="message-container">
   		 <span style="font-size: 80%; font-weight: bold;">${message}</span>
 	 	</div>
		<div id="loginsub">Login</div>
		<div id="idsub">ID</div>
		<input id="idinput"name="userid" type="text" value="${dto.userid}"><br>
		<div id="pwsub">Password</div>
		<input id="pwinput" name="pwd" type="password">
		<input id="submit" type="submit" value="Login"><br>
						
		<div id="forgotten">Forgotten&nbsp;</div>
		<div id="forgottenid"><a href="member/idSearch">ID</a>&nbsp;</div>
		<div id="forgottenor">or&nbsp;</div>
	    <div id="forgottenpw"><a href="member/pwdSearch">Password</a>&nbsp;</div>
	    
	    <div id="nonmem">아직 회원이 아니세요?</div>
	     <button type="button" id="joinbtn">Sign Up</button>
		
		<div id="kakao">간편로그인</div>
		<div id="kakaologin">
		<a href="kakaostart"><button type="button" id="kakaobtn" class="button-with-icon">&nbsp;&nbsp;&nbsp;Kakaotalk</button></a>
		</div>
		
		<div id="notice1">+ 카카오톡 채널 추가 시 5% 할인쿠폰 혜택 제공</div>
		<div id="notice2">+ 회원가입시 즉시 사용 가능한 10% 쿠폰 혜택 제공</div>
		      
	</form>

</body>
</html>