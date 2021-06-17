<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>



<div class="checkPassword-page con">
	<div class="form">
		<form method="POST" action="doCheckPassword" class=""
			onsubmit="MemberCheckPasswordForm__submit(this); return false;">
			<input type="hidden" name="loginPwReal" /> <input type="hidden"
				name="redirectUri" value="${param.redirectUri}" />
			<div class="table-control-box">
				<div class="title">Check your password !</div>
			</div>
			<div class="table-control-box">
				<input type="password" name="loginPw" autofocus />
			</div>
			<div class="table-control-box">
				<button type="submit" class="">check</button>
			</div>
		</form>
	</div>
</div>

<script>
	function MemberCheckPasswordForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
		startLoading();

	}
</script>


<style>
.checkPassword-page {
	margin-top: 300px;
}

.checkPassword-page .title {
	margin-bottom: 30px;
	font-weight: bold;
	font-size: 1.2rem;
	
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

.btn {
	padding: 0 25px;
	font-size: 1rem;
}

/* 모바일 버전 */
@media ( max-width :1210px) {
	.btn {
		padding: 5px 20px;
	}
}
</style>






<%@ include file="../part/foot.jspf"%>