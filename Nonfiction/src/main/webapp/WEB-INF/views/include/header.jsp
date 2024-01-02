<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="stylesheet" type="text/css" href="../css/index.css">
</head>
<body>
   <div id="wrap">
      <header>
      <div id="black-bar" align="center" style=font-family:FGR><a href="">12월 한정 신규 가입 시 10% 쿠폰 | 전 구매 무료 배송 | 선물 포장 서비스 제공</a></div>
      <br><br>
       <ul>
          <c:choose>
            <c:when test="${empty loginUser}">
           		  
                  <li><a href="loginForm">LOGIN</a></li>
                  <li><a href="contract">JOIN</a></li>
                  <li><a href="#" onClick="find_id_pw()">FIND ID/PW</a></li>
            </c:when>
             <c:otherwise>
             		  <li>${loginUser.name }</li>	
                      <li><a href="memberUpdate">EDIT MEMBER</a></li>
                      <li><a href="logout">LOGOUT</a></li>
            </c:otherwise>
         </c:choose>
    </ul>
      
      </header>
      