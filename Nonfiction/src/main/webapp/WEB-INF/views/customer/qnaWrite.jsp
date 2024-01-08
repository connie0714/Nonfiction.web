<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/member.css">
<script type="text/javascript" src="/script/member.js"></script>
</head>
<body>

	<div id="qnamain">Q&amp;A Write</div>
		<form name="formm" method="post" 	action="qnaWrite">
			
				<div id="qnasubject">Subject</div>
				<input id="subjectinput" type="text" name="subject"  size="60" ><br>
				
				<div id="secretmode">Secret mode</div>
				<input id="secret" name="secret" type="checkbox" value="Y" onchange="enable()">
				<input id="pass" name="pass" type="password" size="15" disabled><br>
				
				<div id="qnacontent">Content</div>
				<textarea id="contentbox" rows="8" cols="65" name="content" ></textarea><br>
			<div class="clear"></div>
			
		    <div id="buttons" style="float:right">
			    <input type="submit"  value="Write" id="qnasubmit"> 
		    	<input type="button"  value="Back to List"  id="back"  onclick="location.href='qnaList'"> 
		    </div>
		</form>

</body>
</html>