<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/member.js"></script>

</head>
<body>

<div id="wrap">
<h1>ID 검색</h1>
<form method="get" name="formmm" action="pwdCheckForm">
    User ID <input type="text" name="userid" value="${userid}">
    <input type="submit" value="검색" class="submit"><br>     
    <div style="margin-top: 20px">
        <c:if test="${result == 1}">
            <input type="button" value="사용" class="cancel" onclick="idokforpwd('${userid}')">
            아이디 확인이 완료되었습니다.
        </c:if>
        <c:if test="${result == -1}">
            아이디가 없습니다.
        </c:if>
    </div>
</form>
</div>

</body>
</html>