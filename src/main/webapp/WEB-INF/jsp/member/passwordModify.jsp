<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="password-modify-page con">
	<div class="form">
		<form method="POST" action="doPasswordModify" class="password-modify"
			onsubmit="SubmitPasswordModify(this); return false;">
			<input type="hidden" name="loginPwReal" /> <input type="hidden"
				name="id" value="${loginedMemberId }" /> <input type="hidden"
				name="loginId" value="${loginedMember.loginId}" /> <input
				type="hidden" name="email" value="${loginedMember.email}" />
			<div class="table-control-box">
				<div class="title">비밀번호를 변경해주세요.</div>
			</div>
			<div class="table-control-box">
				<!-- <div class="title">새 비밀번호</div> -->
				<input type="password" name="loginPw" autofocus
					placeholder="new password" />
			</div>

			<div class="table-control-box">
				<input type="password" name="loginPwConfirm" autofocus
					placeholder="new password confirm" />
			</div>
			<div class="table-control-box">
				<!-- <input type="submit" class="btn black" value="변경" /> -->
				<button type="submit" class="">modify</button>
			</div>
		</form>
	</div>
</div>


<script>
	function SubmitPasswordModify(form) {
		if (isNowLoading()) {
			alert('처리중입니다.')
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호 확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPw.focus();
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		startLoading();

	}
</script>





<style>
.btn {
	padding: 0 25px;
	font-size: 1rem;
}

.password-modify-page {
}	

.password-modify-page .form {
	max-width: 800px;
	margin-top:200px;
	
}


.password-modify-page .title {
	margin-bottom: 30px;
	font-weight: bold;
	font-size: 1.2rem;
	
}


.password-modify-page .form .form-control-box {
	/* border: 3px solid blue; */
	display:flex;
	align-items:center;
	margin: 10px 0;
}



.password-modify-page .form {
	margin-left: auto;
	margin-right: auto;
	max-width: 700px;
}

.password-modify-form .form form button {
	margin-top: 30px;
	background: #fdbe3f;
}







/* 모바일 버전 */
@media ( max-width :1210px) {
	.con {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	.btn {
		
	}
}
</style>












<%@ include file="../part/foot.jspf"%>