<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


		<div class="item-container">
		  <c:forEach items="${productShopList}" var="productVO">
		    <div class="item">
		      <a href="productDetail?pseq=${productVO.PSEQ}">
		        <img class="productimage" src="/nonimage/${productVO.IMAGE}" />
		        <h3>${productVO.NAME}</h3>
		        <p>${productVO.PRICE2}</p>
		      </a>
		    </div>
		  </c:forEach>
		</div>

	   	<div class="clear"></div>

<%@ include file="../include/footer.jsp" %> 