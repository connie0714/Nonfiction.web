<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<form name="formm" method="post">
	<table width="600">
		<tr><th width="100" align="center">제목</th>
				<td  style="text-align:left; font-size:120%">${qnaVO.SUBJECT}</td></tr>
		<tr><th align="center">등록일</th>
				<td style="text-align:left;"><fmt:formatDate value="${qnaVO.INDATE}" type="date"/></td></tr>
		<tr><th align="center">질문내용</th>
				<td  style="text-align:left; font-size:120%"><pre>${qnaVO.CONTENT}</pre></td></tr>
		<tr><th align="center">답변 내용</th>
				<td  style="text-align:left; font-size:120%">${qnaVO.REPLY}</tr>
		</table>
		
		<div id="buttons" style="float:right">
			<input type="button"  value="Back to List" class="submit" onclick="location.href='qnaList'"> 
			<input type="button"  value="쇼핑 계속하기"  class="cancel" onclick="location.href='/'">  
		</div>	
	</form>	

</body>
</html>