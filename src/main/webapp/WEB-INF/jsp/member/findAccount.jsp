<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 찾기" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form action="doFindLoginId" method="POST" class="table-box con form1"
	onsubmit="findLoginIdForm__submit(this); return false;">
	<div class="table-box-title">로그인 아이디 찾기</div>
	<table>
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="name" placeholder="이름을 입력해주세요."
							maxlength="30" autofocus />
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" name="email" placeholder="이메일을 입력해주세요."
							maxlength="50" style="ime-mode:inactive;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 아이디 찾기</th>
				<td>
					<button type="submit" class="btn black">아이디 찾기</button>
				</td>
			</tr>

		</tbody>
	</table>
</form>




<form action="doFindLoginPw" method="POST" class="table-box con form1"
	onsubmit="findLoginPwForm__submit(this); return false;">
	<div class="table-box-title">비밀번호 찾기</div>
	<input type="hidden" name="redirectUri" value="/usr/member/login" />
	<table>
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="loginId" placeholder="로그인 아이디를 입력해주세요."
							maxlength="30" autofocus />
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" name="email" placeholder="이메일을 입력해주세요."
							maxlength="50" style="ime-mode:inactive;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비밀번호 찾기</th>
				<td>
					<button type="submit" class="btn black">비밀번호 찾기</button>
				</td>
			</tr>

		</tbody>
	</table>
</form>






<script>
	// 로그인 아이디 찾는 자바스크립트
	function findLoginIdForm__submit(form) {

		if ( isNowLoading() ) {
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

		if ( isNowLoading() ) {
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
.con {
	margin-top:3%;
	width:30%;
}
.btn {
	padding:0 25px;
	font-size:1rem;
}


.table-box {
	border:5px solid black;
}

.table-box table th {
	text-align:center;
	
}

.table-box .table-box-title {
	font-size:1.2rem;
	padding:10px;
	font-weight:bold;
}

/* 모바일 버전 */

@media (max-width :1210px)  {
    .con {
    	width:80%;
    	margin-left:auto;
    	margin-right:auto;
    }
}

</style>



<%@ include file="../part/foot.jspf"%>