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
		<form name="formm" method="post" action="qnaWrite">
			<div id="qnaTheme">
				<label>
		            <input type="radio" name="qnaoption" value="상품문의" checked> 상품문의
		        </label>
		        <label>
		            <input type="radio" name="qnaoption" value="배송문의"> 배송문의
		        </label>
		        <label>
		            <input type="radio" name="qnaoption" value="교환/환불문의"> 교환/환불문의
		        </label>
		    </div>
		        <br><br>
			
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

<script>
function submitForm() {
	  // 선택한 카테고리 값을 가져오기
	  var selectedCategory = document.getElementById("categoryDropdown").value;

	  // 폼 데이터 생성
	  var formData = new FormData();
	  formData.append("qnaoption", selectedCategory); // qnaoption 열에 선택한 카테고리 값 추가

	  // AJAX 요청 전송
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", "qnaWrite.php", true);
	  xhr.onreadystatechange = function() {
	    if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
	      // 요청이 성공적으로 완료되었을 때의 동작
	      // 예: 작성한 글을 등록한 후 다른 페이지로 이동
	      window.location.href = "qnaList.jsp";
	    }
	  };
	  xhr.send(formData);
	}
</script>

</html>