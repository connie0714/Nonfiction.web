<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<link rel="stylesheet" type="text/css" href="../css/member.css">
<script>
$(document).ready(function() {
	   
	   $('#downbtn').on('click', function() {
		   	document.formm.action="cartcntdown";
		document.formm.submit();
	})
	})
		
		
	$(document).ready(function() {
	   
	   $('#upbtn').on('click', function() {
		document.formm.action="cartcntup";
		document.formm.submit();
	})
	})

 function quantityup(cseq) {
    $.ajax({
        url: '/updateQuantity',
        type: 'POST',
        data: {
            cseq: cseq,
            quantity: 1 // 수량 1 증가
        },
        success: function(result) {
            location.reload(); // 페이지 새로고침
        }
    });
}

function quantitydown(cseq) {
    $.ajax({
        url: '/updateQuantity',
        type: 'POST',
        data: {
            cseq: cseq,
            quantity: -1 // 수량 1 감소
        },
        success: function(result) {
            location.reload(); // 페이지 새로고침
        }
    });
} 

function removeItem(cseq){
    $.ajax({
        url: '/removeItem',
        type: 'POST',
        data: {
            cseq: cseq
        },
        success: function(result) {
            location.reload(); // 페이지 새로고침
        }
    });
}
</script>
<div id="align">
	<div id="qna">
		<header>
		<div id="logo" style="margin-top: -150px;">
			<a href="admin"><img src="/nonimage/logo.svg" class="logoimg" style="width:135px;"></a>
		</div>
	</header>
	<br><br>
        <div>
            <a href="#">Return to store</a>
        </div>
    </div>

    <hr>
		<div class="center-align">
		<form name="formm" method="post">
		<c:choose>
			<c:when test="${cartList.size()==0}">
				<h3 style="color: red;text-align: center;">장바구니가 비었습니다.</h3>
			</c:when>
			<c:otherwise>
				<table id="cartList">
					<tr><th>상품명</th><th>수량</th><th>가격</th><th>삭제</th></tr>
					<c:forEach items="${cartList}" var="cartVO">
						<tr>
                            <td>
                                
                                <a href="productDetail&pseq=${cartVO.PSEQ}">
                                <img src="/nonimage/${productVO.IMAGE}"> <h3> ${cartVO.PNAME} </h3>
                                </a>
                                <input type="hidden" name="cseq" value="${cartVO.CSEQ}">
                                <input type="hidden" name="quantity" value="${cartVO.QUANTITY}">
                            </td>
                            <td>
                                <%-- <button type="button" onclick="quantitydown();" id="downbtn">down</button>--%>
                                <button type="button" onclick="quantitydown(${cartVO.CSEQ});" id="downbtn">down</button>
                                ${cartVO.QUANTITY} 
                                
                                <!-- <button type="button" onclick="quantityup();" id="upbtn">up</button> -->
                                <button type="button" onclick="quantityup(${cartVO.CSEQ});" id="upbtn">up</button>
                            </td>
		   					<td><fmt:formatNumber value="${cartVO.PRICE2*cartVO.QUANTITY}" type="currency"/></td>
		       				<td><button type="button" onclick="removeItem(${cartVO.CSEQ})">remove</button></td>
                        </tr>
					</c:forEach>
				</table>
			</c:otherwise>
		</c:choose>
		<div class="clear"></div>
		<div id="buttons" style="float: right">
			<input type="button" value="쇼핑 계속하기" class="cancel"  onclick="location.href='/'">
			<c:if test= "${cartList.size() != 0}">
				<input type="button" value="주문하기"  class="submit"  onclick="go_order_insert()">
			</c:if>
		</div>	
		</form>
	</div>
</div>

 <%@ include file="../include/footer.jsp" %>
