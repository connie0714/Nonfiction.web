<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

<!-- 카테고리 메뉴 -->
<div class="container">
    <div class="category-menu">
        <div class="serif category-item">
            <a href="#" class="category-link">SHOP</a>
            <div class="dropdown-menu">
            <a href="#holiday-gift" style="color: #83A5FF">HOLIDAY GIFT EDITION</a>
            <a href="#best-seller">BEST SELLER</a>
            <a href="#perfume">PERFUME</a>
            <a href="#hair-care">HAIR CARE</a>
            <a href="#body-care">BODY CARE</a>
            <a href="#hand-care">HAND CARE</a>
            <a href="#gift-set">GIFT SET</a>
            <a href="#home-fragrance">HOME FRAGRANCE</a>
            <a href="#home-objects">HOME OBJECTS</a>
            <a href="#trial-kit">TRIAL KIT</a>
            <a href="#acc">ACC</a>
            </div>
        </div>
        <div class="serif category-item">
            <a href="#" class="category-link">ABOUT</a>
            <div class="dropdown-menu">
          <a href="#gift-set">OUR STORY</a>
         <a href="#gift-set">CAMPAIGN</a>
         <a href="#gift-set">PRESS</a>
            </div>
        </div>
        <div class="serif category-item"><a href="#">STORES</a></div>
        <div class="serif category-item"><a href="#">CONTACT</a></div>
        <div class="serif category-item"><a href="#">SEARCH</a></div>
    </div>
</div>
   
    <div class="top-menu-container">
        <div class="right-menu">
            <div class="serif dropdown"> <!-- 여기를 수정합니다 -->
            <a href="#" class="dropbtn">KR</a>
            <div class="dropdown-content">
                <a href="#">JP</a>
                <a href="#">EN</a>
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <div class="serif"><a href="">LOGIN</a></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <div class="serif"><a href="">CART(<span class="cart-count">0</span>)</a></div>
    </div>
</div>

<div class="fullscreen-video">
  <video class="center" autoplay muted loop>
  <source src="/nonimage/mainvideo.mp4" type="video/mp4">
</video>
</div>

<div class="fullscreen-image">
    <img src="/nonimage/main2.jpg" alt="Descriptive Alt Text">
    <div class="centered-text">HOLIDAY GIFT EDITION</div>
</div>


 </div>
<%@ include file="include/footer.jsp" %>