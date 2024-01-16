<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/script/mypage.js"></script>
<<<<<<< HEAD
</head>
<body>

<div id="align">
	<div id="qna">상품 상세</div>
	   <div class="center-align">
	   	<div id="itemdetail" >
			<form  method="post" name="formm">
				<fieldset><legend> Item detail Info</legend><span style="float: left;">
					<img src="/nonimage/${productVO.IMAGE}"
	           			style="border-radius:20px 20px 20px 20px;width:500px;"/></span>
	       			<h2> ${productVO.NAME} </h2> 
					<label> 가 격 :  </label><p> ${productVO.PRICE2} 원</p> 
		   			<label> 수 량 : </label><input  type="text" name="quantity" size="2" value="1">
		   			<br><input  type="hidden" name="pseq" value="${productVO.PSEQ}"><br>
				</fieldset> 
				<div class="clear"></div>
	   			<div><h3 style="font-size:170%;">${productVO.CONTENT}</h3></div>	<br><br>
				<div class="clear"></div>
				<div id="buttons">
					<input type="button" value="장바구니에 담기" class="submit"    onclick="go_cart()"> 
				    <input type="button" value="즉시 구매" 	class="submit"    onclick="go_order()"> 
				    <input type="button"  value="메인으로" class="submit" onclick="location.href='/'">
	        	</div>
			</form>
=======

<form  method="post" name="formm">
<input  type="hidden" name="pseq" value="${productVO.PSEQ}">
<div id="detail-align">
	<div id="product-image">
		<img src="/nonimage/${productVO.IMAGE}">
	</div>
	<div id="content-box">
		<div id="product-title">
			<h3 class="pname">${productVO.NAME}</h3>
			<h3 class="price">${productVO.PRICE2} KRW</h3>
			<br />
			<hr>
		</div>
		<div id="product-content">
			<h3>Product Info</h3>
			<br />
			<br />
			<div style="width: 360px;height: 200px;">
				<h3>${productVO.CONTENT}</h3>	
			</div>
	   		<label> 수 량 : </label><input  type="text" name="quantity" size="2" value="1">
			<div id="msg-card">
				<c:choose>
					<c:when test="${productVO.MSGYN == 'Y'}">
						<select name="msgcard" id="lang">
								<option value="3">선택 안함</option>
								<option value="0">Thank you</option>
								<option value="1">Happy birthday</option>
								<option value="2">Congratulation</option>
							</optgroup>
						</select>
					</c:when>
					<c:otherwise>
						<select name="msgcard" id="lang">
								<option value="3">선택 안함</option>
						</select>
					</c:otherwise>
				</c:choose>
				<div id="product-btn">
					<input type="button" value="장바구니에 담기" class="submit"    onclick="go_cart()"><br /> 
			    	<input type="button" value="즉시 구매" 	class="submit"    onclick="go_order()"><br />
			    	<input type="button" value="메인으로" class="submit" onclick="location.href='/'"><br />
        		</div>
			</div>
>>>>>>> branch 'main' of https://github.com/connie0714/Nonfiction.web.git
		</div>
	</div>
</div>
</form>

<%@ include file="../include/footer.jsp" %>

<<<<<<< HEAD
</body>
</html>
=======









>>>>>>> branch 'main' of https://github.com/connie0714/Nonfiction.web.git
