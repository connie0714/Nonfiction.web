<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript" src="/script/mypage.js"></script>

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
		</div>
	</div>
</div>
</form>

<%@ include file="../include/footer.jsp" %>










