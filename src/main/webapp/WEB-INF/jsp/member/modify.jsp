<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="modify-page con">
	<div class="form">
		<form method="POST" action="doModify" class=""
			onsubmit="submitMemberDataModify(this); return false;">
			<div class="table-control-box">
				<div class="modify-title">회원정보를 변경해주세요.</div>
			</div>
			<div class="form-control-box flex">
				<div class="title">Sign in date</div>
				<input type="text" name="regDate" value="${loginedMember.regDate}"
					readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">name</div>
				<input type="text" name="name" value="${loginedMember.name}"
					readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">
					nickname <strong style="color: red;">(choice)</strong>
				</div>
				<input class="border-red-1" type="text" name="nickname"
					value="${loginedMember.nickname}" />
			</div>
			<div class="form-control-box flex">
				<div class="title">
					email <strong style="color: red;">(choice)</strong>
				</div>
				<input class="border-red-1" type="email" name="email"
					value="${loginedMember.email}" />
			</div>
			<div class="form-control-box flex">
				<div class="title">last updateDate</div>
				<input type="text" name="updateDate"
					value="${loginedMember.updateDate}" readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">modify</div>
				<button type="submit">modify</button>
			</div>
		</form>
	</div>
</div>

<script>
	function submitMemberDataModify(form) {
		if (isNowLoading()) {
			alert('처리중입니다.')
			return;
		}

		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}

		form.email.value = form.emali.value.trim();
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

/* 모바일 버전 */
@media ( max-width :1210px) {
	.con {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
}

.modify-page {
	
}

.modify-page .form {
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 200px;
}

.modify-page .modify-title {
	margin-bottom: 30px;
	font-weight: bold;
	font-size: 1.2rem;
	
}


.modify-page .form .form-control-box {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.modify-page .form .form-control-box  input {
	margin-top: auto;
	margin-bottom: auto;
}

.modify-page .form .form-control-box:nth-child(3) input,
	.form-control-box:nth-child(4) input {
	background: #cccccc;
}

.modify-page .form form button {
	background: #fdbe3f;
}

.modify-page .form .form-control-box .title {
	/* font-size: 1.2rem; */
	width: 300px;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}
</style>





<%@ include file="../part/foot.jspf"%>