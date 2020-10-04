<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 찾기" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="find-page-box flex flex-jc-sb">
	<div class="find-page con find-loginId-box">
		<div class="form">
			<form action="doFindLoginId" method="POST" class=" "
				onsubmit="findLoginIdForm__submit(this); return false;">
				<div class="table-box-title">로그인 아이디 찾기</div>
				<div class="form-control-box">
					<input name="name" type="text" placeholder="userName" autofocus
						maxlength="30" />
				</div>
				<div class="form-control-box">
					<input type="email" name="email" placeholder="userEmail"
						maxlength="50" style="ime-mode: inactive;" />
				</div>
				<div class="form-control-box">
					<button type="submit" class="loginId-find-btn">check</button>
				</div>
				<div class="form-control-box">
					<button type="button" class="find-loginpw-btn find-btn"
						onclick="find__loginPw__btn();">Forgot password ?</button>
				</div>
			</form>
		</div>
	</div>



	<div class="find-page con find-password-box">
		<div class="form">
			<form action="doFindLoginPw" method="POST" class=""
				onsubmit="findLoginPwForm__submit(this); return false;">
				<div class="table-box-title">비밀번호 찾기</div>
				<input type="hidden" name="redirectUri" value="/usr/member/login" />
				<div class="form-control-box">
					<input type="text" name="loginId" placeholder="userID"
						maxlength="30" autofocus />
				</div>
				<div class="form-control-box">
					<input type="email" name="email" placeholder="userEmail"
						maxlength="50" style="ime-mode: inactive;" />
				</div>
				<button type="submit" class="">check</button>

				<div class="form-control-box">
					<button type="button" class="find-loginId-btn find-btn"
						onclick="find__loginId__btn();">Forgot userID ?</button>
				</div>
			</form>
		</div>
	</div>
</div>





<script>
	function find__loginPw__btn() {
		$(".find-password-box").addClass("find-loginPw-box-block");
		$(".find-loginId-box").addClass("find-loginId-box-none");
	}

	function find__loginId__btn() {
		$(".find-password-box").removeClass("find-loginPw-box-block");
		$(".find-loginId-box").removeClass("find-loginId-box-none");
	}

	// 로그인 아이디 찾는 자바스크립트
	function findLoginIdForm__submit(form) {

		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		form.submit();
		startLoading();
	}

	// 로그인 비밀번호 찾는 자바스크립트 
	function findLoginPwForm__submit(form) {

		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');

		if (form.loginId.value.length == 0) {
			alert('로그인 아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}

		if (form.loginId.value.length < 4) {
			alert('로그인 아이디를 4자 이상 입력해주세요.');
			form.loginId.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		form.email.value = form.email.value.replaceAll(' ', '');
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		form.submit();
		startLoading();

	}
</script>


<style>
/* .con {
	margin-top: 3%;
	width: 30%;
} */
.btn {
	padding: 0 25px;
	font-size: 1rem;
}

.table-box {
	border: 5px solid black;
}

.table-box table th {
	text-align: center;
}

.find-page-box {
	width: 1600px;
	margin-left: auto;
	margin-right: auto;
}

.find-page .form {
	height: 300px;
}

.find-page-box .find-password-box {
	display: none;
}

.find-page .form form .table-box-title {
	font-size: 1.2rem;
	padding: 10px;
	font-weight: bold;
	margin-bottom: 30px;
}

.find-page .form form .form-control-box .find-btn {
	margin-top: 30px;
	background: white;
	color: #2346f6;
	font-weight: bold;
}

.find-page-box .find-loginPw-box-block {
	display: block;
}

.find-page-box .find-loginId-box-none {
	display: none;
}

/* 모바일 버전 */
@media ( max-width :800px ) {
	.find-page-box {
		max-width: 100%;
		margin-left: auto;
		margin-right: auto;
	}
	.find-page .form {
		height: 300px;
		max-width: 100%;
		padding:50px;
				
		
	}
}
</style>



<%@ include file="../part/foot.jspf"%>
