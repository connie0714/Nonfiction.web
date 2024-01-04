<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/member.js"></script>

<script>
    var serverAuthCode = ""; // 서버에서 받은 인증번호를 저장하는 변수
    var isEmailVerified = false; // 이메일 인증 여부를 저장하는 변수

    function sendAuthCode() {
        // AJAX 요청을 보내는 코드 작성
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/emailCheck", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    serverAuthCode = xhr.responseText; // 서버에서 받은 인증번호를 변수에 할당
                    // 예시로는 간단히 인증번호가 발송되었다는 알림을 표시하는 코드를 작성했습니다.
                    alert("인증번호가 발송되었습니다.");
                } else {
                    console.error("인증번호 요청 실패");
                }
            }
        };
        xhr.send(JSON.stringify({ email: "hsh980515@gmail.com" }));
    }

    function checkAuthCode() {
        var inputAuthCode = document.getElementById("authCode").value;

        // 인증번호를 입력하지 않았을 경우 처리
        if (inputAuthCode === "") {
            alert("인증번호를 입력해주세요.");
            return;
        }

        // 서버에서 받은 인증번호와 사용자가 입력한 인증번호 비교
        if (inputAuthCode === serverAuthCode) {
            alert("이메일 인증이 완료되었습니다.");
            isEmailVerified = true; // 이메일 인증 완료 상태로 변경
            enableSignUpButton(); // 회원가입 버튼 활성화
        } else {
            alert("인증번호가 일치하지 않습니다.");
            isEmailVerified = false; // 이메일 인증 실패 상태로 변경
            disableSignUpButton(); // 회원가입 버튼 비활성화
        }
    }

    function enableSignUpButton() {
        document.getElementById("signUpButton").disabled = false; // 회원가입 버튼 활성화
    }

    function disableSignUpButton() {
        document.getElementById("signUpButton").disabled = true; // 회원가입 버튼 비활성화
    }
</script>

</head>
<body>

<h2>Sign Up</h2>
<form id="join" action="join" method="post" name="formm">
	<fieldset>
		
			<label>ID</label><input type="text" name="userid" size="12"  value="${dto.userid}" >
	        <input type="hidden" name="reid"   value="${reid}">
	        <input type="button" value="중복 확인" class="dup" onclick="idcheck()"><br>
	        <label>Password</label><input type="password"  name="pwd"><br> 
	        <label>Password Check</label><input type="password"  name="pwdCheck"><br> 
	        <label>Name</label><input type="text"  name="name"   value="${dto.name}"><br> 
	        <label>Phone</label><input type="text" name="phone"   value="${dto.phone}"><br>
	       <%--  <label>E-Mail</label><input type="text" name="email"   value="${dto.email}"><br> --%>
	           <label for="email">이메일:</label>
            <input type="email" id="email" name="email" value="${dto.email }"required>
            <input type="button" value="인증번호 받기" onclick="sendAuthCode()"><br>
            
           <label for="authCode">인증번호:</label>
			<input type="text" id="authCode">
			<input type="button" value="인증번호 확인" onclick="checkAuthCode()">
           
            <br>

	        
	</fieldset>	
	<fieldset>
       <legend>Shipping</legend>
        <label>Zipcode</label>
        <input type="text" id="sample6_postcode" name="zip_num" readonly>
		<input type="button" onclick="sample6_execDaumPostcode()" class="dup" 
			value="우편번호 찾기"><br>
		<label>Address</label>
		<input type="text" id="sample6_address" size="50" name="address1" 
			value="${dto.address1}" readonly><br>
		<!-- <label>detailAddress</label> -->
		<input type="text" id="sample6_detailAddress" name="address2" 
			value="${dto.address2}" size="50"><br>
		<!-- <label>extraAddress</label> -->
		<input type="text" id="sample6_extraAddress" name="address3" 
			value="${dto.address3}" readonly><br>
        
        
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		
		<script>
		    function sample6_execDaumPostcode() {
		        new daum.Postcode( {
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                } 
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){  
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script><br>
        
      	
        <div class="clear"></div>
        
        <div id="resultMessage"></div>
        
   		<div id="buttons">
	     <input type="submit" value="회원가입" class="submit" id="signUpButton" onclick="document.getElementById('resultMessage').innerHTML = '회원가입이 완료되었습니다.';" disabled>
	    <input type="reset" value="취소" class="cancel" onclick="location.href='loginCancle'">
	</div>
        
    </fieldset>	
</form>

</body>
</html>