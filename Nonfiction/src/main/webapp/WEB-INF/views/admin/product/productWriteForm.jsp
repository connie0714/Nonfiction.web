<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin/header.jsp"%>
<article>
<h1>상품등록</h1>  
<form name="frm" method="post" >
<table id="list">
	<tr><th>상품분류</th><td colspan="5">
		<select name="kind">
    		<c:forEach items="${shopList}" var="shop" varStatus="status">
      			<option value="${status.count}">${shop}</option>
   			</c:forEach>
  		</select></td>
	<tr><th>상품명</th> <td width="343" colspan="5">
	       <input type="text" name="name" size="47" maxlength="100" > </td></tr>
	<tr><th>원가[A]</th> <td width="70"><input type="text" name="price1" size="11" onKeyup="cal()"></td>
		<th>판매가[B]</th><td width="70"><input type="text" name="price2" size="11" onKeyup="cal()"></td>
	    <th>[B-A]</th><td width="72"><input type="text" name="price3" size="11"></td></tr>
	<tr><th>상세설명</th><td colspan="5">
	      <textarea name="content" rows="8" cols="70" ></textarea></td></tr>
    
    <!-- <tr><th>상품이미지</th><td width="343" colspan="5">
    				<input type="file" name="image"></td></tr>-->

    <tr height="200">
    	<th>상품이미지</th>
	    <td width="343" colspan="5" style="vertical-align:top;">
	   		<input type="hidden" name="image" id="image" > <!-- 전송될 파일이름 -->
	   		<div id="filename"></div> <!-- 화면에 표시될 파일이름과 미리보기 -->
		</td>
	</tr>
    
    
</table>
<input class="btn" type="button" value="등록" onClick="go_save()">           
<input class="btn" type="button" value="취소" onClick="go_mov()"><br/>
<div id="msg" ></div>
</form> 


<!-- 화면전환 없이 서버와 송수신이 가능한 기능 : ajax -->
<div style="position:relative;  border:1px solid black; width:500px; margin:0 auto;">
	<form name="fromm" id="fileupForm" method="post" enctype="multipart/form-data">
				<input type="file" name="fileimage"><input type="button" id="myButton" value="추가">
	</form>
</div>

</article>
<%@ include file="../../include/admin/footer.jsp"%>






