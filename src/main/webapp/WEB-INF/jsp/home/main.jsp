<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>


<div id="wrap">
	<div id="contents">
		<div class="content3_border"></div>
		<div class="new_container">
			<div class="contents">
				<div class="content1">
					<div class="content1_img">
						<img src="/resource/img/content1.png" alt="이미지를 지원하지 않습니다." />
					</div>
					<div class="content1_contents">
						<div class="content1_contents_text">	
							<p>self</p>
							<p>anytime</p>
						</div>
						<div class="content1_contents_border"></div>
					</div>
				</div>
				<div class="content2">
					<!-- swiper슬라이더 메인컨테이너 -->
					<div class="swiper-container">
						<!-- 보여지는 영역 -->
						<div class="swiper-wrapper">
							<!-- div class="swiper-slide" 를 추가하면된다 -->
							<div class="swiper-slide">
								<img src="/resource/img/slide1.jpg" alt="이미지를 지원하지 않습니다." />
							</div>
							<div class="swiper-slide">
								<img src="/resource/img/slide2.jpg" alt="이미지를 지원하지 않습니다." />
							</div>
							<div class="swiper-slide">
								<img src="/resource/img/slide3.jpg" alt="이미지를 지원하지 않습니다." />
							</div>
							<div class="swiper-slide">
								<img src="/resource/img/slide4.jpg" alt="이미지를 지원하지 않습니다." />
							</div>
						</div>
						<!-- 페이징 버튼 처리 -->
						<div class="swiper-pagination"></div>

					</div>

				</div>
				<div class="content3">

					<div class="content3_text">
						<span>memo</span> <span>memo</span>
					</div>
					<div class="content3_contents">
						<div>
							<div class="contents1 circle">
								<span>25%</span>
							</div>
							<p>메모에 관심이 있나요?</p>
						</div>
						<div>
							<div class="contents2 circle">
								<span>60%</span>
							</div>
							<p>기억하고 싶은 에피소드가 있나요?</p>
						</div>
						<div>
							<div class="contents3 circle">
								<span>100%</span>
							</div>
							<p>계획하는 것에 관심이 있나요?</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div class="new_container">
			<div class="footer">
				<div class="footer_title">
					<span>내 삶을 Design 하다.</span>
				</div>
				<div class="footer_border">
					<div></div>
				</div>
				<div class="footer_info">
					<p>site maker : hye-ryeon, Kim</p>
					<p>email : kim5638yw@gmail.com</p>
					<p>tel : 이메일 문의</p>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	const swiper = new Swiper('.swiper-container', {
		//기본 셋팅
		//방향 셋팅 vertical 수직, horizontal 수평 설정이 없으면 수평
		direction : 'horizontal',
		//한번에 보여지는 페이지 숫자
		slidesPerView : 1,
		//페이지와 페이지 사이의 간격
		spaceBetween : 0,
		//드레그 기능 true 사용가능 false 사용불가
		debugger : true,
		//마우스 휠기능 true 사용가능 false 사용불가
		mousewheel : true,
		//반복 기능 true 사용가능 false 사용불가
		loop : true,
		//선택된 슬라이드를 중심으로 true 사용가능 false 사용불가 djqt
		centeredSlides : true,
		// 페이지 전환효과 slidesPerView효과와 같이 사용 불가
		// effect: 'fade',
		speed : 1000,

		//자동 스크를링
		autoplay : {
			//시간 1000 이 1초
			delay : 3500,
			disableOnInteraction : false,
		},

		//페이징
		pagination : {
			//페이지 기능
			el : '.swiper-pagination',
			//클릭 가능여부
			clickable : true,
		},

		//방향표
		navigation : {
			//다음페이지 설정
			nextEl : '.swiper-button-next',
			//이전페이지 설정
			prevEl : '.swiper-button-prev',
		},

	});
</script>



<%@ include file="../part/foot.jspf"%>