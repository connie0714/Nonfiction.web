<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/index.css">
<link rel="stylesheet" type="text/css" href="../css/member.css">
<script type="text/javascript" src="../script/member.js"></script>
<!-- 멤버 관련 js  -->
<script type="text/javascript" src="../script/mypage.js"></script>
<!-- mypage, order, cart에 쓰일 js -->
<script type="text/javascript" src="../script/index.js"></script>
<!-- 모달 1:1 문의 버튼, 해더 스크롤 내릴시 일부 숨김용 js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
	<div id="wrap">
		<header>
			<div id="header">
				<div id="black-bar" align="center" style="font-family: FGR;">
					<a href="">전 구매 무료 배송 | 선물 포장 서비스 제공</a>
				</div>
				<br> <br>

				<div class="container">
					<div id="category-menu">
						<div class="serif category-item">
							<a href="#" class="category-link">SHOP</a>
							<div class="dropdown-menu">
								<a href="category?shop=0" style="color: #83A5FF">HOLIDAY
									GIFT EDITION</a> <a href="bestCategory?bestyn=Y">BEST SELLER</a> <a
									href="category?shop=1">PERFUME</a> <a href="category?shop=2">HAIR
									CARE</a> <a href="category?shop=3">BODY CARE</a> <a
									href="category?shop=4">HAND CARE</a> <a href="category?shop=5">GIFT
									SET</a> <a href="category?shop=6">HOME FRAGRANCE</a> <a
									href="category?shop=7">HOME OBJECTS</a> <a
									href="category?shop=8">TRIAL KIT</a> <a href="category?shop=9">ACC</a>
							</div>
						</div>
						<div class="serif category-item">
							<a href="#" class="category-link">ABOUT</a>
							<div class="dropdown-menu">
								<a href="#gift-set">OUR STORY</a> <a href="#gift-set">CAMPAIGN</a>
								<a href="#gift-set">PRESS</a>
							</div>
						</div>
						<div class="serif category-item">
							<a href="#">STORES</a>
						</div>
						<div class="serif category-item">
							<a href="#">CONTACT</a>
						</div>
						<div class="serif category-item">
							<a href="#">SEARCH</a>
						</div>
					</div>
				</div>

				<div id="top-menu-container">
					<div class="right-menu">
						<div class="serif dropdown">
							<a href="#" class="dropbtn">KR</a>
							<div class="dropdown-content">
								<a href="#">JP</a> <a href="#">EN</a>
							</div>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   		<c:choose>
							<c:when test="${empty loginUser}">
				                <div class="serif"><a href="loginForm">LOGIN</a></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				            </c:when>
				            <c:otherwise>
				                <div class="serif"><a href="logout">LOGOUT</a></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				            	<div class="serif"><a href="orderList">ACCOUNT</a></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				            </c:otherwise>
				        </c:choose>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="serif">
							<a href="cartList">CART()</a>
						</div>
					</div>
				</div>
			</div>
		</header>