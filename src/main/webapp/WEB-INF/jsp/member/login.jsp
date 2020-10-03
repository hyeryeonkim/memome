<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>




<div class="join-top-bar visible-on-md-up">
	<h1>Login</h1>
	<h2>메모미에 로그인 하세요.</h2>
</div>

<style>
.join-top-bar {
	position: absolute;
	top: 130px;
	right: 25%;
	text-align: right;
}
</style>

	<div class="login-page  ">
		
		
		<div class="login-page-title con visible-on-sm-down ">지금 바로 memome를 시작해보세요.</div>
		
		<div class="border-main margin-bottom-40"></div>

		<div class="form">
			<form action="doLogin" method="POST" class="login-form "
				onsubmit="MemberLoginForm__submit(this); return false;">

				<input type="hidden" name="loginPwReal" /> <input type="hidden"
					name="redirectUri" value="${param.redirectUri }" />
				<div class="form-control-box">
					<input name="loginId" type="text" placeholder="userID" autofocus
						maxlength="30" />
				</div>
				<div class="form-control-box">
					<input name="loginPw" type="password" placeholder="password"
						maxlength="30" />
				</div>
				<div class="form-control-box">
					<!-- <input type="submit" value="LOGIN" class="btn black" /> -->
					<button type="submit" class="login-btn">LOGIN</button>
				</div>
				<div class="form-control-box">
					<button type="button" class="findAccount-btn"
						onclick="location.href='../member/findAccount'">Forgot
						userID or password ?</button>
				</div>
				<div class="form-control-box">
					<button type="button" class="join-btn"
						onclick="location.href='../member/join'">sign up for
						memome</button>
				</div>
			</form>
		</div>
	</div>



<script>
	function MemberLoginForm__submit(form) {

		
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
.con {
	width: 50%;
}

.table-box table th {
	text-align: center;
}

.table-box {
	border: 5px solid black;
}

.login-page .form form .form-control-box .login-btn {
	margin-top: 30px;
}

.login-page .form form .form-control-box .findAccount-btn, .login-page .form form .form-control-box .join-btn
	{
	margin-top: 30px;
	background: white;
	color: black;
	font-weight: bold;
}

.login-page .form form .form-control-box .join-btn {
	color: #2346f6;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}

/* 모바일 버전 */
@media ( max-width :800px ) {
	.login-page {
		margin-top:-30px;
	}


	.login-page .login-page-title {
		width: 100%;
		text-align: center;
		margin-bottom:30px;
		font-size:1rem;
		font-weight:bold;
	}
	.login-page .form {
		margin-top: 0px;
	}
	.login-page .border-main {
		border: 2px solid #e6e6e6;
		width: 100%;
	}
}
}
</style>






<%@ include file="../part/foot.jspf"%>