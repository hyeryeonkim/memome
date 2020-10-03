<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원탈퇴" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>




<div class="delete-page con visible-on-md-up">
	<div class="form">
		<form method="POST" action="accountDelete" class=""
			onsubmit="submitAccountDeleteForm(this); return false;">
			<input type="hidden" name="memberId" value="${loginedMemberId}" />
			<div class="table-control-box">
				<div class="modify-title">회원탈퇴를 결정하셨습니까?</div>
			</div>
			<div class="form-control-box flex">
				<div class="title">password</div>
				<input type="password" name="loginPw"
					placeholder="회원탈퇴 후 사이트 활동이 어려우므로 신중이 결정해주세요." autofocus />
			</div>

			<div class="form-control-box flex">
				<div class="title">sign out</div>
				<button type="submit"
					onclick="if ( confirm('탈퇴하시겠습니까?') == false) return false;">sign
					out</button>
			</div>
		</form>
	</div>
</div>




<div class="mobile-delete-page con visible-on-sm-down">
	<div class="form">
		<form method="POST" action="accountDelete" class=""
			onsubmit="submitAccountDeleteForm(this); return false;">
			<input type="hidden" name="memberId" value="${loginedMemberId}" />
			<div class="table-control-box">
				<div class="modify-title">회원탈퇴를 결정하셨습니까?</div>
			</div>
			<div class="form-control-box flex">
				<div class="title">password</div>
				<input type="password" name="loginPw"
					placeholder="탈퇴 후 memome 이용제한이 있을 수 있습니다." autofocus />
			</div>

			<div class="form-control-box flex">
				<div class="title">sign out</div>
				<button type="submit"
					onclick="if ( confirm('탈퇴하시겠습니까?') == false) return false;">sign
					out</button>
			</div>
		</form>
	</div>
</div>

<script>
	function submitAccountDeleteForm(form) {
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
.modify-page {
	
}

.delete-page .form {
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 200px;
}

.delete-page .modify-title {
	margin-bottom: 30px;
	font-weight: bold;
	font-size: 1.2rem;
}

.delete-page .form .form-control-box {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.delete-page .form .form-control-box  input {
	margin-top: auto;
	margin-bottom: auto;
}

.delete-page .form form button {
	background: #fdbe3f;
}

.delete-page .form .form-control-box .title {
	/* font-size: 1.2rem; */
	width: 300px;
}

/* 모바일 버전 */
@media ( max-width :800px ) {
	.mobile-delete-page .form {
		max-width: 800px;
		margin-left: auto;
		margin-right: auto;
		margin-top: 200px;
		padding:40px 5px;
	}
	.mobile-delete-page .modify-title {
		margin-bottom: 30px;
		font-weight: bold;
		font-size: 1.1rem;
	}
	.mobile-delete-page .form .form-control-box {
		display: flex;
		align-items: center;
		margin: 10px 0;
	}
	.mobile-delete-page .form .form-control-box  input {
		margin-top: auto;
		margin-bottom: auto;
		font-size:0.6rem;
	}
	.mobile-delete-page .form form button {
		background: #fdbe3f;
	}
	.mobile-delete-page .form .form-control-box .title {
		/* font-size: 1.2rem; */
		width: 100px;
		font-size:0.9rem;
	}
}
</style>






<%@ include file="../part/foot.jspf"%>