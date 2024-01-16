<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>


<h2>회원 가입 현황</h2>

    <form action="memberCount" method="post">
        <label for="startDate">시작 날짜:</label>
        <input type="date" id="startDate" name="startDate" required>

        <label for="endDate">종료 날짜:</label>
        <input type="date" id="endDate" name="endDate" required>

        <input type="submit" value="조회">
    </form>

</body>
</html>