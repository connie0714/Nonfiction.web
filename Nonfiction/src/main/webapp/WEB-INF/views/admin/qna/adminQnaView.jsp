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

<div id="qnaList">Q&amp;A 게시판</div>   
<form name="frm" method="post">
	<input type="hidden" name="qseq" value="${qnaVO.QSEQ}">
	<table id="qnaViewtable"> <!-- 게시물의 내용 -->
		<tr><th>작성자</th><td align="left">${qnaVO.USERID}</td></tr>
		<tr><th width="20%">제목</th>
		<td align="left">
		${qnaVO.SUBJECT} </td></tr>
		<tr><th>등록일</th><td align="left"> <fmt:formatDate value="${qnaVO.INDATE}"/></td></tr>
		<tr><th>내용</th><td  align="left"> <pre>${qnaVO.CONTENT}</pre></td></tr>
	</table>
	<!-- 관리자가 쓴 답글 또는 답글 쓰는 입력란 표시 -->
	<c:choose>          
		<c:when test='${empty qnaVO.REPLY}'> <!-- 관리자 답변 전 표시 -->
			<table id="writeReply">
				<tr><td colspan="2"></td></tr>
	    		<tr><td colspan="2"><textarea name="reply" rows="3" cols="50"></textarea>
	   				<input type="button" id="replySubmit" value="저장" onClick="go_rep()"></td></tr>
			</table>
		</c:when>
		<c:otherwise>  <!-- 관리자 답변 완료 후 표시 -->
			<table id="writtenReply"><tr><th>댓글</th><td>${qnaVO.REPLY}</td></tr></table>
		</c:otherwise>
	</c:choose>
	<input type="button" id="goQnaList" value="목록" 	onClick="location.href='adminQnaList'">
</form>

</body>
</html>