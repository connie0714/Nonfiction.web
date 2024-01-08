<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/member.js"></script>
<link rel="stylesheet" type="text/css" href="../css/member.css">
</head>
<body>

		<div id="qnaform" style="text-align: center;">
			<form name="formm" method="post">
			<table>
				<tr><th>제목</th>
						<td  >${qnaVO.SUBJECT}</td></tr>
				<tr><th >등록일</th>
						<td ><fmt:formatDate value="${qnaVO.INDATE}" type="date"/></td></tr>
				<tr><th>질문내용</th>
						<td style="height:100px"><pre>${qnaVO.CONTENT}</pre></td></tr>
				<tr><th >답변 내용</th>
						<td style="height:100px">${qnaVO.REPLY}</tr>
				</table>
	
				
				<div id="buttons" style="float:right">
					<input type="button"  value="Back to List" id="backtolist" onclick="location.href='qnaList'"> 
					<input type="button"  value="쇼핑 계속하기"  id="gomain" onclick="location.href='/'">  
				</div>	
			</form>	
	</div>
</body>
</html>