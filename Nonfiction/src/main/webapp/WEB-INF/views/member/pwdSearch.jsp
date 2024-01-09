<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">  
<title>Insert title here</title>

<script type="text/javascript" src="/script/member.js"></script>

<script>
function pwdSearch() {
    if (document.foorm.userid.value === "") {
        alert("아이디를 입력해주세요");
        document.foorm.userid.focus();
        return;
    }
    var url = "pwdSearchForm?userid=" + document.foorm.userid.value;
    var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
    window.open(url, "pwdSearch", opt);
}
</script>

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
            showPasswordFields(); // 새로운 비밀번호 입력 필드 표시
        } else {
            alert("인증번호가 일치하지 않습니다.");
            isEmailVerified = false; // 이메일 인증 실패 상태로 변경
            hidePasswordFields(); // 새로운 비밀번호 입력 필드 숨김
        }
    }

    function showPasswordFields() {
        document.getElementById("passwordFields").style.display = "block"; // 새로운 비밀번호 입력 필드 표시
    }

    function hidePasswordFields() {
        document.getElementById("passwordFields").style.display = "none"; // 새로운 비밀번호 입력 필드 숨김
    }

    function changePassword() {
        var newPassword = document.getElementById("newPassword").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        // 새로운 비밀번호와 비밀번호 확인이 일치하는지 확인
        if (newPassword === confirmPassword) {
            // 서버에 비밀번호 변경 요청을 보내는 코드 작성
            // 비밀번호 변경이 성공하면 로그인 페이지로 이동 또는 다른 작업을 수행
            alert("비밀번호 변경이 완료되었습니다.");
        } else {
            alert("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        }
    }
</script>

</head>
<body>

    <div>
        <form action="pwdSearch" method="get" name="foorm">
            <h2>비밀번호 찾기</h2>
            <p>
                아래 이메일주소를 입력하시면,<br> 입력하신 이메일로 새암호를 보내드립니다<br>
                <br>
          <!--   <div>
                <input type="text" name="username" placeholder="이름">
            </div>
            <div>
                <input type="text" name="email" placeholder="이메일주소">
                <p>'@'포함한 이메일주소를 정확히 입력해주세요.</p>
            </div> -->
            
            <label>ID</label><input type="text" name="userid" size="12"  value="${dto.userid}" >
	        <input type="hidden" name="reid"   value="${reid}">
	        <input type="button" value="아이디 확인" class="dup" onclick="pwdSearch()"><br>
            
 
             <input type="email" id="email" name="email" value="${dto.email }"required>
            <input type="button" value="인증번호 받기" onclick="sendAuthCode()"><br>
            
            <label for="authCode">인증번호:</label>
			<input type="text" id="authCode">
			<input type="button" value="인증번호 확인" onclick="checkAuthCode()">

            <div id="passwordFields" style="display: none;">
                <input type="password" id="newPassword" placeholder="새로운 비밀번호">
                <input type="password" id="confirmPassword" placeholder="비밀번호 확인">
                <input type="button" value="비밀번호 변경" onclick="changePassword()">
            </div>
        </form>
    </div>

</body>
</html>