<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<div id="align">
	<div id="qna">ID Search</div>
		<div class="center-align">
		    <form action="Searchpwd" method="post">
		        <label for="email">이메일 주소:</label>
		        <input type="email" id="email" name="email" required>
		        <br>
		        <label>아이디 :</label>
		        <input type="text" id="userid" name="userid" required>
		        
		        <input type="submit" value="비밀번호 찾기">
		        ${message}
			</form>
		</div>
	</div>

<%@ include file="../include/footer.jsp" %>