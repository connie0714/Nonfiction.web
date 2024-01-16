<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/member.css">
</head>
<body>

<div id="faqsubject">FAQ</div>

<table id="table"  align="center">
	<tr><th>번호</th> <th>제목</th> <th>작성자</th><th>작성일</th></tr>
  	<c:forEach items="${faqList}" var="faqVO">
    	<tr><td>${faqVO.FSEQ}
      		<td><a href="faqView?fseq=${faqVO.FSEQ}"><span style="font-weight: bold;">${faqVO.TITLE}</span>
      		</a></td>
      		<td> ${faqVO.ADMINID} </td><td> <fmt:formatDate value="${faqVO.INDATE}"/></td></tr>
    </c:forEach>
</table><br>
</body>
</html>