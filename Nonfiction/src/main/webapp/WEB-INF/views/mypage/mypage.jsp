<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div id="align">
<div id="account-section">
  <img src="../nonimage/logo.svg">
  <br>
  <a href="logout">Logout</a>
  <br><br><br>
  <p>YOUR ACCOUNT</p>
  <br><br><br>
  <p>ACCOUNT</p>
  <hr class="short-hr">
  <br>
  <p>이름 <br>${orderVO.PNAME}</p>
  <br>
  <a href="memberEditForm">회원정보수정</a>
  <br><br><br>
  <p>ORDER HISTORY</p>
  <hr class="short-hr">
  <br>
  <p>주문내역</p>
  <br>
  <p>0/0</p>
  <br>
  <a href="orderList">주문내역 모두보기</a>
  <br><br><br>
  <hr class="long-hr">
  <br><br><br>
</div>
</div>
<%@ include file="../include/footer.jsp" %>