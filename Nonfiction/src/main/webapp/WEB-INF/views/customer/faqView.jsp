<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/member.css">
</head>
<body>

<div id="qnaform" style="text-align: center;">
			<form name="formm" method="post">
			<table>
				
						<td>${faqVO.TITLE}</td>
				
						
				
						<td style="height:300px"><pre>${faqVO.CONTENT}</pre></td>
				</table>
	
				
				<div id="buttons" style="float:right">
					<input type="button"  value="Back to List" id="backtolist" onclick="location.href='faqList'"> 
					<input type="button"  value="쇼핑 계속하기"  id="gomain" onclick="location.href='/'">  
				</div>	
			</form>	
	</div>

</body>
</html>