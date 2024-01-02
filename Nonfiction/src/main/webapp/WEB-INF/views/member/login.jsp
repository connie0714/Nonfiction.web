<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form method="post" action="login" name="loginFrm">
		<fieldset><legend>LogIn&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="font-size:80%; font-weight:bold">${message} </legend>
			<label>User ID</label><input name="userid" type="text" value="${dto.userid}"><br> 
			<label>Password</label><input name="pwd" type="password" >
			<div>
	            <input type="submit" value="로그인"  style="width:200px;">
	            <input type="button" value="일반회원가입"  onclick="location.href='contract'"  style="width:200px;">
	            <input type="button" value="아이디 비밀번호 찾기"  onclick=""  style="width:200px;">
	            <input type="button" value="카카오 로그인"  onclick=""  style="width:200px;">
	            <hr>
	        </div>
        </fieldset>
</form> 

</body>
</html>