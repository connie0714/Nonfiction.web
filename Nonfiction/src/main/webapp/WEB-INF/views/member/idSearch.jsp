<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<div id="align">
	<div id="qna">ID Search</div>
		<div class="center-align">
		    <form action="Searchid" method="post">
		        <label for="email">이메일 주소:</label>
		        <input type="email" id="email" name="email" required>
		        <br>
		        <input type="submit" value="아이디 찾기">
		        ${message}
			</form>
		</div>
	</div>

<%@ include file="../include/footer.jsp" %>