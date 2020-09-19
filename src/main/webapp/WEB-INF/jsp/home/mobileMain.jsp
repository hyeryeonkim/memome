<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<!-- 모바일 버전 -->
<div id="body" class="con body visible-on-sm-down">
	<p>
		<strong>메모</strong>는 기억해야 하는 어떤 내용을 잊지 않기 위해서 기록하는 <strong>짧은
			글</strong>을 말한다.
	</p>
	<p>
		메모는 대부분 글을 읽거나, 다른 사람에게 어떤 사항을 전달해야 하거나, 어떤 내용을 듣고 중요사항을 <strong>기억</strong>해야
		할 때 작성한다.
	</p>
	<p>
		글을 읽을 때 메모를 하면 글에 <strong>집중</strong>할 수 있으며, 쉽게 잊을 수 있는 내용을 <strong>오래
			기억 </strong>및 <strong>보존</strong>할 수 있다.
	</p>
	<p>
		또한 <strong>중요한 사항</strong>이나 <strong>확인</strong>해야 하는 사항을 메모하게 되면 <strong>한번
			더 확인</strong>할 수 있으며, 일이나 학업의 <strong>효율을 높일 수</strong> 있다.
	</p>
	<p>
		메모를 작성할 때에는 긴 문장으로 기록하기 보다 <strong>짧고 간결한 문장</strong>이나 <strong>핵심
			단어</strong>를 기재하는 것이 좋다.
	</p>
	<p>
		이는 메모를 <strong>확인</strong>하여야 하는 <strong>상대방</strong> 혹은 <strong>자신</strong>이
		<strong>쉽게</strong> 내용을 <strong>확인</strong>할 수 있도록 하기 위함이다.
	</p>
</div>

<!-- PC버전 -->
<div class="title con margin-top-30 visible-on-md-up">메모는 어떤 내용을
	이지 않기 위해 기록하는 짧은 글이다.</div>
<br />
<br />
<div class="serve-title con  visible-on-md-up">서식 구성 : 제목, 메모내용,
	언제, 누가, 전달사항, 전화받은 사람</div>
<br />
<br />
<div id="body" class="con body visible-on-md-up mobile">
	<p>
		<strong>메모</strong>는 기억해야 하는 어떤 내용을 잊지 않기 위해서 기록하는 <strong>짧은
			글</strong>을 말한다.
	</p>
	<p>
		메모는 대부분 글을 읽거나, 다른 사람에게 어떤 사항을 전달해야 하거나, 어떤 내용을 듣고 중요사항을 <strong>기억</strong>해야
		할 때 작성한다.
	</p>
	<p>
		글을 읽을 때 메모를 하면 글에 <strong>집중</strong>할 수 있으며, 쉽게 잊을 수 있는 내용을 <strong>오래
			기억 </strong>및 <strong>보존</strong>할 수 있다.
	</p>
	<p>
		또한 <strong>중요한 사항</strong>이나 <strong>확인</strong>해야 하는 사항을 메모하게 되면 <strong>한번
			더 확인</strong>할 수 있으며, 일이나 학업의 <strong>효율을 높일 수</strong> 있다.
	</p>
	<p>
		메모를 작성할 때에는 긴 문장으로 기록하기 보다 <strong>짧고 간결한 문장</strong>이나 <strong>핵심
			단어</strong>를 기재하는 것이 좋다.
	</p>
	<p>
		이는 메모를 <strong>확인</strong>하여야 하는 <strong>상대방</strong> 혹은 <strong>자신</strong>이
		<strong>쉽게</strong> 내용을 <strong>확인</strong>할 수 있도록 하기 위함이다.
	</p>
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
	body {
		border: 10px solid red;
	}
	/* .body {
		display:none;
	} */
}
</style>

<script>
	setTimeout(function() {
		jQuery('#img').addClass('remove');
	}, 2000);
	setTimeout(function() {
		jQuery('#body').addClass('add');
	}, 2000);
</script>

<%@ include file="../part/foot.jspf"%>