<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

<script>
	window.onload = function() {
	    var video = document.querySelector(".fullscreen-video video");
	    video.style.width = "100%";
	    video.style.height = "100%";
	    video.style.objectFit = "fill";
	}
</script>

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
<%@ include file="include/footer.jsp"  %>