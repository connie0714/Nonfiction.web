<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/member.js"></script>
</head>
<body>

<form id="join" action="joinForm" method="post" name="contractFrm">
        약관 동의<br><br>
         
      <textarea rows="15" cols="100"></textarea> <br><br>
       
      <div style="text-align: center;">
      <input type="radio" name="okon" > 동의함 &nbsp; &nbsp; &nbsp;
      <input type="radio" name="okon" checked> 동의안함
      </div>
      <input type="button" value="Next" class="submit" onClick="go_next();" 
      	style="float: right;"> 
    </form>

</body>
</html>