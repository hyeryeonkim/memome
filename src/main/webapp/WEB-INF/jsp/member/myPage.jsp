<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="My Page" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="mypage-box flex flex-jc-sb con">
	<div class="mypage-page ">
		<div class="form">
			<div class="form-control-box flex">
				<div class="title">Sign in date</div>
				<input type="text" name="regDate" value="${member.regDate}" readonly />
			</div>

			<div class="form-control-box flex">
				<div class="title">name</div>
				<input type="text" name="name" value="${member.name}" readonly />
			</div>

			<div class="form-control-box flex">
				<div class="title">nickname</div>
				<input type="text" name="nickname" value="${member.nickname}"
					readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">email</div>
				<input type="email" name="email" value="${member.email}" readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">last updateDate</div>
				<input type="text" name="updateDate" value="${member.updateDate}"
					readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">user information</div>
				<button type="button" class=""
					onclick="location.href='../member/modify?checkPasswordAuthCode=${param.checkPasswordAuthCode}'">modify</button>
			</div>
			<div class="form-control-box flex">
				<div class="title">new password</div>
				<button type="button" class=""
					onclick="location.href='../member/passwordModify?checkPasswordAuthCode=${param.checkPasswordAuthCode}'">password modify</button>
			</div>
			<div class="form-control-box flex">
				<div class="title">sign out</div>
				<button type="button" class=""
					onclick="location.href='../member/passwordAccountDelete'">sign
					out</button>
			</div>
		</div>
	</div>
	<div class="form hashtag-box">
		<h1>MY HASHTAG LIST</h1>
		<div class="hashtag-list">
			<div class="hashtag-contents flex flex-wrap">
				<c:forEach items="${myhashtags }" var="myhashtag">
					<div>${myhashtag}</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>


<style>

.mypage-box {
}



.mypage-box .form {
	max-width: 800px;
}

.mypage-box .form .form-control-box {
	/* border: 3px solid blue; */
	display:flex;
	align-items:center;
	margin: 10px 0;
}

.mypage-box .form .form-control-box  input {
	margin-top:auto;
	margin-bottom:auto;
}


.checkPassword-page .form {
	margin-left: auto;
	margin-right: auto;
	max-width: 700px;
}

.checkPassword-page .form form button {
	margin-top: 30px;
	background: #fdbe3f;
}

.mypage-box .form .form-control-box .title {
	/* font-size: 1.2rem; */
	width:300px;
}


.myPage-box .hashtag-box {
	border: 5px solid black;
	width: 600px;
}

.table-box table {
	width: 400px;
}

.table-box table th {
	text-align: center;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}

.mypage-box .hashtag-box  h1 {
	margin-bottom:30px;
}

.mypage-box .hashtag-box .hashtag-list .hashtag-contents>div {
	padding: 10px;
	/* border:3px solid red; */
}

/* 모바일 버전 */
@media ( max-width :1210px) {
	.con {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	.table-box table th {
		
	}
}
</style>


<%@ include file="../part/foot.jspf"%>