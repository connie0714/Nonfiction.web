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

<div id="memberList">회원리스트</div>  
<form name="frm" method="post">
<table id="memberSearch" style="float:right; ">
	<tr><td>회원 이름 <input type="text" name="key" value="${key}">
	<input id="memberListSearch" type="button" value="검색" onClick="searchPosts('memberList');">
	<input id="allList" type="button" name="btn_total" value="전체보기 " onClick="go_memberList();"></td> </tr>
</table><br>
<table id="table">
	<tr><th>아이디(탈퇴여부)</th><th> 이름 </th><th>이메일</th><th>우편번호</th><th>주소</th><th>전화</th><th>가입일</th></tr>
    <c:forEach items="${memberList}" var="memberVO">  
	    <tr><td>${memberVO.USERID} 
	    	<c:choose>
	      		<c:when test='${memberVO.USEYN=="Y"}'>
	        		<input type="checkbox" name="useyn"   
	        			onchange="reInsert('${memberVO.USERID}', '${memberVO.USEYN}');">
		        </c:when>
		        <c:otherwise>
		        	<input type="checkbox" name="useyn" checked="checked"
		        		onchange="reInsert('${memberVO.USERID}', '${memberVO.USEYN}');" >
		        </c:otherwise>
	    	</c:choose></td>
	    	<td>${memberVO.NAME}${memberVO.USEYN}</td><td>${memberVO.EMAIL}</td><td>${memberVO.PROVIDER}</td>
	    	<td style="text-align:left">${memberVO.ZIP_NUM}${memberVO.ADDRESS1} ${memberVO.ADDRESS2} </td>
	    	<td>${memberVO.PHONE}</td><td><fmt:formatDate value="${memberVO.INDATE}"/></td></tr>
  </c:forEach>
</table>
	<div id="memberListPaging">
	<jsp:include page="../../include/paging/paging.jsp">
	   		<jsp:param name="command" value="memberList" />
		</jsp:include>
	</div>
</form>

</body>
</html>