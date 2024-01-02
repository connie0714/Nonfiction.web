<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <ul>
    		<c:choose>
				<c:when test="${empty loginUser}">
						<li><a href="loginForm">LOGIN</a></li>
						<li><a href="contract">JOIN</a></li>
						<li><a href="#" onClick="find_id_pw()">FIND ID/PW</a></li>
				</c:when>
		    	<c:otherwise>
		       			<li><a href="memberEditForm">EDIT MEMBER</a></li>
		      			<li><a href="logout">LOGOUT</a></li>
				</c:otherwise>
			</c:choose>
    </ul>

</body>
</html>