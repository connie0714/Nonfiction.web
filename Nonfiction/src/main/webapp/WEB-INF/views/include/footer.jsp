<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
	<!--1:1 talk 가변식 버튼  -->
	<button id="btn-open-chat">
		1:1 <br>TALK
	</button>

	<!-- 모달 창 -->
	<div class="modal">
		<div class="modal-content">
			<div class="top-content">
				<img src="/nonimage/qnalogo.jpg" class="content-image">
				<div class="content-text">
					<p style="font-weight: bold; font-size: 16px">논픽션</p>
					<p style="font-size: 12px;">안녕하세요 라이프스타일 뷰티 브랜드 논픽션 입니다.</p>
				</div>
			</div>
			<div class="chat-box">
				<div id="non-area">
					<label>논픽션</label>
					<div class="chat-area">
						<p class="msg">안녕하세요. 라이프스타일 뷰티 브랜드 논픽션입니다. 문의하실 내용의 유형을 선택해주세요.</p>
					</div>
				</div>
				<div id="answer-content">
				</div>
				<form id="answer">
					<div class="select-qna">
						<ul>
							<li><button type="button" class="select-btn" id="select-btn" onclick="sendRequest('주문/배송')" value="0">주문/배송</button></li>
							<li><button type="button" class="select-btn" id="select-btn" onclick="sendRequest('상담원 연결')" value="1">상담원 연결</button></li>
							<li><button type="button" class="select-btn" id="select-btn" onclick="sendRequest('상품문의')" value="2">상품문의</button></li>
						</ul>
					</div>
				</form>
			</div>
			<div class="bottom-content">
				<button type="button" class="close-btn" id="close-btn">
					<img src="../nonimage/homebtn.png" style="width: 80px">
				</button>
			</div>
		</div>
	</div>

	<div id="footer">
		<div class="footer_conbox">

			<div class="footer_box">
				<div class="footer_box_inner">
					<h3 class="serif">Customer Service</h3>
					<p class="footer_cs">
						<i class="fa fa-phone" style="position: relative; top: -4px;"></i>
						<span style="font-size: 24px;">1666-7891</span><br /> <span
							style="opacity: 0.45;"> <i class="fa fa-clock-o"></i>
							10:00 ~ 17:00 <br /> <i class="fa fa-check"></i>주말 및 공휴일 휴무
						</span>
					</p>
					<div class="terms_container">
						<h6>이용약관&nbsp;|&nbsp;개인정보처리방침&nbsp;|&nbsp;사업자정보확인</h6>
					</div>
				</div>
			</div>


			<div class="footer_box">
				<div class="footer_box_inner">
					<h3 class="serif">
						MEMBERSHIP<br> BENEFIT
					</h3>
					<ul class='no_dot'>
						<li><a href="">공식 온라인 스토어 <br>혜택
						</a></li>
						<li><a href="">오드퍼퓸 체험 키트</a></li>
					</ul>
				</div>
			</div>



			<div class="footer_box">
				<div class="footer_box_inner">
					<h3 class="serif">Info</h3>
					<ul class='no_dot'>
						<li><a href="">공지사항</a></li>
						<li><a href="">채용</a></li>
						<li><a href="">자주묻는 질문</a></li>
						<li><a href="">배송 &amp; 교환/반품</a></li>
					</ul>
				</div>
			</div>



			<div class="footer_box">
				<div class="footer_box_inner">
					<h3 class="serif">Contact Us</h3>
					<ul class='no_dot'>
						<li><a href="">주문조회</a></li>
						<li><a href="qnaList">문의하기</a></li>
						<li><a href="">기업구매 문의</a></li>
						<li><a href="/contact.html">고객 센터</a></li>
						<li><a href="/stores.html">매장안내</a></li>
					</ul>
				</div>
			</div>



			<div class="footer_box">
				<div class="footer_box_inner">
					<h3 class="serif">Social</h3>
					<ul class='no_dot'>
						<li><a href="https://instagram.com/official.nonfiction"
							target="_blank">Instagram</a></li>
						<li><a href="https://www.pinterest.co.kr/officialnonfiction/"
							target="_blank">Pinterest</a></li>
						<li><a href="http://pf.kakao.com/_GxcuyT" target="_blank">Kakao</a></li>
						<li><a href="admin">Admin Home</a></li>
					</ul>
				</div>
			</div>


		</div>
	</div>
</footer>

</div>
</body>
</html>
