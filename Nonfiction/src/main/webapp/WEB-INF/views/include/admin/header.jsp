<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/admin/admin.css">
<script src="/admin/admin.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/script/member.js"></script>
<script type="text/javascript" src="/script/mypage.js"></script>


</head>
<body>

<div id="wrap">
<header>			
	<div id="logo">
		<img style="width:800px" src="/admin/bar_01.gif">
		<img src="/admin/text.gif">
	</div>	
	<input class="btn" type="button" value="logout" style="float: right;"
		onClick="location.href='adminLogout'">		
		
				<div id="logo">
			<a href="/"><img src="/images/logo.png"  width="180" height="100"></a></div>
		<nav id="top_menu"> <!-- top menu -->
				<ul>
						<c:choose>
							<c:when test="${empty loginUser}">
								<li><a href="loginForm">LOGIN</a></li>
								<li><a href="contract">JOIN</a></li>
							</c:when>
				    		<c:otherwise>
				       			<li style="color:blue;font-weight:bold;font-size:100%;     ">
				       				${loginUser.NAME}(${loginUser.USERID})</li>
				       			<li><a href="memberEditForm">정보수정</a></li>
				       			<li><a href="logout">LOGOUT</a></li>
							</c:otherwise>
						</c:choose>
						<li><a href="cartList">CART</a></li><li><a href="myPage">MY PAGE</a></li>
				    	<li ><a href="customer">고객센터</a></li>
				</ul>
		</nav>
		

		<div class="clear"></div><hr>	
</header>
<div class="clear"></div>