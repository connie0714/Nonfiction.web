<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/admin.js"></script>
<link rel="stylesheet" type="text/css" href="../css/member.css">
</head>
<body>

<div id="memberList">Q&amp;A 게시글 리스트</div>  
<form name="frm" method="post">


<table id="memberSearch" style="float: right;">
	<tr><td>제목+내용 검색 
		<input type="text" name="key" value="${key}" > 
		    <input id="memberListSearch" type="button" value="검색"   onClick="searchPosts('adminQnaList');">
		    <input id="allList" type="button" name="btn_total" value="전체보기 "  onClick="go_qnaList();">
	    </td></tr>
</table>
</form>
<table id="table"  align="center">
	<tr><th>번호(답변여부)</th> <th>제목</th> <th>작성자</th><th>작성일</th></tr>
  	<c:forEach items="${qnaList}" var="qnaVO">
    	<tr><td>${qnaVO.QNAOPTION}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qnaVO.QSEQ}
      		<c:choose>          
        		<c:when test='${empty qnaVO.REPLY}'>(미처리)</c:when>
        		<c:otherwise>(답변완료)</c:otherwise>
      		</c:choose></td>
      		<td><a href="adminQnaView?qseq=${qnaVO.QSEQ}"><span style="font-weight: bold;">${qnaVO.SUBJECT}</span>
      		</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀글 (${qnaVO.SECRET})</td>
      		<td> ${qnaVO.USERID} </td><td> <fmt:formatDate value="${qnaVO.INDATE}"/></td></tr>
    </c:forEach>
</table><br>
	<div id="qnaListPaging">
		<jsp:include page="../../include/paging/paging.jsp">
	   		<jsp:param name="command" value="adminQnaList" />
		</jsp:include>
	</div>
</body>

</html>