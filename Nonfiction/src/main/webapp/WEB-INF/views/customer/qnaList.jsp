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

<div id="qna">Q&amp;A</div>
	<div class="center-align">
    <form name="formm" method="post">
        <table id="cartList">
            <c:forEach items="${qnaList}" var="qnaVO">
                <tr>
                    <td>${qnaVO.QSEQ}</td>
                    <td style="text-align: left">
                        <c:choose>
                            <c:when test="${qnaVO.SECRET == 'Y'}">
                            <a href="#" onClick="passCheck('${qnaVO.QSEQ}')">${qnaVO.SUBJECT}</a>
                                &nbsp;
                            </c:when>
                            <c:otherwise>
                                <a href="qnaView?qseq=${qnaVO.QSEQ}">${qnaVO.SUBJECT}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <fmt:formatDate value="${qnaVO.INDATE}" type="date" />
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${empty qnaVO.reply}"> N </c:when>
                            <c:otherwise> Y </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <input id="qnawrite" type="button"  value="Write"  class="cancel" onclick="location.href='/qnaWriteForm'">
</div>

<div id="page">
<jsp:include page="../include/paging/paging.jsp">
	<jsp:param name="command" value="qnaList" />
</jsp:include>
</div>

</body>
</html>

