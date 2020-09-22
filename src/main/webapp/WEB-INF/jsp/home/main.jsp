<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<!-- 모바일 버전 -->
<div id="body" class="con body visible-on-sm-down">
	<p>
		<strong>메모</strong>는 기억해야 하는 어떤 내용을 잊지 않기 위해서 기록하는 <strong>짧은
			글</strong>을 말합니다.
	</p>
	<!-- <p>
		메모는 대부분 글을 읽거나, 다른 사람에게 어떤 사항을 전달해야 하거나, 어떤 내용을 듣고 중요사항을 <strong>기억</strong>해야
		할 때 작성합니다.
	</p>
	<p>
		글을 읽을 때 메모를 하면 글에 <strong>집중</strong>할 수 있으며, 쉽게 잊을 수 있는 내용을 <strong>오래
			기억 </strong>및 <strong>보존</strong>할 수 있습니다.
	</p>
	<p>
		또한 <strong>중요한 사항</strong>이나 <strong>확인</strong>해야 하는 사항을 메모하게 되면 <strong>한번
			더 확인</strong>할 수 있으며, 일이나 학업의 <strong>효율을 높일 수</strong> 있습니다.
	</p> -->
	<p>
		메모를 작성할 때에는 긴 문장으로 기록하기 보다 <strong>짧고 간결한 문장</strong>이나 <strong>핵심
			단어</strong>를 기재하는 것이 좋습니다.
	</p>
	<p>
		이는 메모를 <strong>확인</strong>하여야 하는 <strong>상대방</strong> 혹은 <strong>자신</strong>이
		<strong>쉽게</strong> 내용을 <strong>확인</strong>할 수 있도록 하기 위함입니다.
	</p>
</div>

<!-- PC버전 -->
<div class="con body-box ">
	<div class="back"></div>
	<div class="back-img">
		<img src="/resource/img/캡처.PNG" alt="" />
	</div>
	<div class="back-text"></div>
	<div class="body-contents">
		<div class="title con margin-top-30 visible-on-md-up">
			메모는 어떤 내용을 잊지 않기 위해서 기록하는 <strong>짧은</strong> 글을 말합니다.
		</div>
		<br /> <br />
		<!-- <div class="serve-title con  visible-on-md-up">서식 구성 : 제목, 메모내용,
			언제, 누가, 전달사항, 전화받은 사람</div>
		<br />  -->
		<br />
		<div id="body" class="con body visible-on-md-up mobile">
			<!-- <p>
				<strong>메모</strong>는 기억해야 하는 어떤 내용을 잊지 않기 위해서 기록하는 <strong>짧은
					글</strong>을 말한다.
			</p> -->
			<p>
				메모는 대부분 글을 읽거나, 다른 사람에게 어떤 사항을 전달해야 하거나, 어떤 내용을 듣고 중요사항을 <strong>기억</strong>해야
				할 때 작성합니다.
			</p>
			<p>
				글을 읽을 때 메모를 하면 글에 <strong>집중</strong>할 수 있으며, 쉽게 잊을 수 있는 내용을 <strong>오래
					기억 </strong>및 <strong>보존</strong>할 수 있습니다.
			</p>
			<p>
				또한 <strong>중요한 사항</strong>이나 <strong>확인</strong>해야 하는 사항을 메모하게 되면 <strong>한번
					더 확인</strong>할 수 있으며, 일이나 학업의 <strong>효율을 높일 수</strong> 있습니다.
			</p>
			<p>
				메모를 작성할 때에는 긴 문장으로 기록하기 보다 <strong>짧고 간결한 문장</strong>이나 <strong>핵심
					단어</strong>를 기재하는 것이 좋습니다.
			</p>
			<p>
				이는 메모를 <strong>확인</strong>하여야 하는 <strong>상대방</strong> 혹은 <strong>자신</strong>이
				<strong>쉽게</strong> 내용을 <strong>확인</strong>할 수 있도록 하기 위함입니다.
			</p>
		</div>
	</div>
</div>
<div class="text-box">
	<div class="text">
		<p>메모는</p>
		<p>
			<span class="word wisteria">우리의 소중한 추억</span> <span
				class="word belize">잊지못할 기억들</span> <span class="word pomegranate">돌이킬
				수 없는 순간</span> <span class="word green">좋은 습관의 시작</span> <span
				class="word midnight">성장하는 지름길</span>
		</p>
	</div>
</div>

<!-- <div class="logo-box con flex flex-jc-sb margin-top-50 flex-wrap">
	<div class="">
		<img src="/resource/img/main1.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main2.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main3.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main4.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main5.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main6.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main7.PNG" alt="" />
	</div>
	<div class="">
		<img src="/resource/img/main8.PNG" alt="" />
	</div>
</div>
 -->
<style>
body {
	
}

.body-contents {
	/* border: 4px solid blue; */
	position: absolute;
	top: 79%;
	left: auto;
}

.body-box {
	/* border: 4px solid red; */
	height: 1400px;
}

.back {
	/* border: 5px solid gold; */
	width: 100%;
	position: absolute;
	top: 0;
	left: auto;
	right: 0;
	height: 60%;
	background-color: #efeff5;
	z-index: -1;
}

.back-img img {
	position: absolute;
	top: 8%;
	left: 0;
	width: 100%;
	height: 50%;
	z-index: -1;
}

.body-box .back-text {
	width: 100%;
	position: absolute;
	top: 77%;
	left: auto;
	right: 0;
	height: 77%;
	z-index: -1;
	background-color: #e6e6e6;
}

.body  img {
	width: 100%;
	height: 500px;
	margin-left:
}

.title {
	font-weight: bold;
	font-size: 2.6rem;
}

.serve-title {
	font-weight: bold;
	font-size: 1.8rem;
}

.body {
	font-size: 1.6rem;
}

.body>p {
	margin-top: 3rem;
}

.body>p>strong {
	color: orange;
}

/* PC버전 */
@media ( max-width : 800px) {
	.body>p {
		font-size: 1rem;
		margin-top: 1.5rem;
	}
}

/* PC 버전 */
.text-box {
	width: 100%;
	height: 17%;
	position: absolute;
	top: 60%;
	background-color: white;
}

.text {
	position: absolute;
	height: 40px;
	left: 23%;
	top: 12%;
	font-size: 6rem;
}

p {
	display: inline-block;
	vertical-align: top;
	margin: 0;
}

.word {
	position: absolute;
	width: 800px;
	opacity: 0;
}

.letter {
	display: inline-block;
	position: relative;
	float: left;
	transform: translateZ(25px);
	transform-origin: 50% 50% 25px;
}

.letter.out {
	transform: rotateX(90deg);
	transition: transform 0.32s cubic-bezier(0.55, 0.055, 0.675, 0.19);
}

.letter.behind {
	transform: rotateX(-90deg);
}

.letter.in {
	transform: rotateX(0deg);
	transition: transform 0.38s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.wisteria {
	color: #8e44ad;
}

.belize {
	color: #2980b9;
}

.pomegranate {
	color: #c0392b;
}

.green {
	color: #16a085;
}

.midnight {
	color: #2c3e50;
}

/* 모바일 버전 */
@media ( max-width :800px ) {
	body {
		
	}
	.body {
		position: absolute;
		top: 60%;
		
	}
	.body-contents {
		/* border: 4px solid blue; */
		position: absolute;
		top: 3%;
		left: auto;
	}
	.body-box {
		/* border: 4px solid red; */
		height:100px;
	}
	.back {
		/* border: 5px solid gold; */
		width: 100%;
		position: absolute;
		top: 4%;
		left: auto;
		right: 0;
		height: 60%;
		background-color: #efeff5;
		z-index: -1;
	}
	.back-img img {
		position: absolute;
		top: 3%;
		left: 0;
		width: 100%;
		height: 30%;
		z-index: -1;
	}
	  .body-box .back-text {
		width: 100%;
		position: absolute;
		 top: 77%; 
		left: auto;
		right: 0;
		 height: 25%; 
		z-index: -1;
		background-color: #e6e6e6;
	}  
	/* 
	
	.body  img {
		width: 100%;
		height: 500px;
		margin-left:
	} */
	.title {
		font-weight: bold;
		font-size: 2.6rem;
	}
	.serve-title {
		font-weight: bold;
		font-size: 1.8rem;
	}
	.body {
		font-size: 1.6rem;
	}
	.body>p:first-child {
			margin-top: 3rem;
	}
	.body>p:not(:first-child ) {
		margin-top: 2rem;
	}
	.body>p>strong {
		color: orange;
	}
	/* 모바일 버전 */
	.text-box {
		height: 17%;
		position: absolute;
		top: 40%;
		left:0;
		background-color: white;
		
	}
	.text {
		position: absolute;
		width: 250px;
		height: 40px;
		left: 15%;
		right: 15%;
		top: 35%;
		font-size: 1.7rem;
		
	}
	p {
		display: inline-block;
		vertical-align: top;
		margin: 0;
	}
	.word {
		position: absolute;
		width: 220px;
		opacity: 0;
	}
	.letter {
		display: inline-block;
		position: relative;
		float: left;
		transform: translateZ(25px);
		transform-origin: 50% 50% 25px;
	}
	.letter.out {
		transform: rotateX(90deg);
		transition: transform 0.32s cubic-bezier(0.55, 0.055, 0.675, 0.19);
	}
	.letter.behind {
		transform: rotateX(-90deg);
	}
	.letter.in {
		transform: rotateX(0deg);
		transition: transform 0.38s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	}
	.wisteria {
		color: #8e44ad;
	}
	.belize {
		color: #2980b9;
	}
	.pomegranate {
		color: #c0392b;
	}
	.green {
		color: #16a085;
	}
	.midnight {
		color: #2c3e50;
	}
}
</style>

<script>
	setTimeout(function() {
		jQuery('#img').addClass('remove');
	}, 2000);
	setTimeout(function() {
		jQuery('#body').addClass('add');
	}, 2000);

	var words = document.getElementsByClassName('word');
	var wordArray = [];
	var currentWord = 0;

	words[currentWord].style.opacity = 1;
	for (var i = 0; i < words.length; i++) {
		splitLetters(words[i]);
	}

	function changeWord() {
		var cw = wordArray[currentWord];
		var nw = currentWord == words.length - 1 ? wordArray[0]
				: wordArray[currentWord + 1];
		for (var i = 0; i < cw.length; i++) {
			animateLetterOut(cw, i);
		}

		for (var i = 0; i < nw.length; i++) {
			nw[i].className = 'letter behind';
			nw[0].parentElement.style.opacity = 1;
			animateLetterIn(nw, i);
		}

		currentWord = (currentWord == wordArray.length - 1) ? 0
				: currentWord + 1;
	}

	function animateLetterOut(cw, i) {
		setTimeout(function() {
			cw[i].className = 'letter out';
		}, i * 80);
	}

	function animateLetterIn(nw, i) {
		setTimeout(function() {
			nw[i].className = 'letter in';
		}, 340 + (i * 80));
	}

	function splitLetters(word) {
		var content = word.innerHTML;
		word.innerHTML = '';
		var letters = [];
		for (var i = 0; i < content.length; i++) {
			var letter = document.createElement('span');
			letter.className = 'letter';
			letter.innerHTML = content.charAt(i);
			word.appendChild(letter);
			letters.push(letter);
		}

		wordArray.push(letters);
	}

	changeWord();
	setInterval(changeWord, 4000);
</script>



<%@ include file="../part/foot.jspf"%>