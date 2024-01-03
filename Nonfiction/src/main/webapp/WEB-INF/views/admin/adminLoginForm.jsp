<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  rel="stylesheet" href="../css/admin.css">
</head>
<body>
<div id="wrap">
	<header>
		<div id="logo">
			<a href="admin"><img src="/nonimage/logo.svg" class="logoimg" style="width:135px;"></a>
		</div>
	</header>
	<div class="clear"></div>
	
	<article>
		<div id="loginform">
			<form name="frm" method="post" action="adminLogin">
				<fieldset>
					<legend> 관리자 </legend>
					<table class="login">
						<tr><td>아 이 디</td><td><input type="text" name="adminid" size="10" value="${adminid}"></td></tr>
						<tr><td>비밀번호</td><td><input type="password" name="adminpwd" size="10"></td></tr>
				       	<tr align="center" ><td  colspan="2">
				       		<h4 style="color:red">${message}</h4>
				       		<br><br>
				       		<input class="btn-outline btn-skin-outline" type="submit" value="업무 로그인" onClick="return worker_check();">
				       		</td></tr>
					</table>
				</fieldset>
			</form>
		</div>
	</article>
</div>

</body>
</html>