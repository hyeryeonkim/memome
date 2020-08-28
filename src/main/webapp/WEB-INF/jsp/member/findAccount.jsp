<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 찾기" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<h3 class="con">로그인 아이디 찾기</h3>
<form action="doFindLoginId" method="POST" class="table-box con form1"
	onsubmit="findLoginIdForm__submit(this); return false;">
	<table>
		<colgroup>
			<col width="100"/>
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="name" placeholder="이름을 입력해주세요."
						maxlength="30" autofocus/>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" name="email" placeholder="이메일을 입력해주세요."
						maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 아이디 찾기</th>
				<td>
					<button type="submit" >아이디 찾기</button>
				</td>
			</tr>
			
		</tbody>
	</table>
</form>



<h3 class="con">로그인 비밀번호 찾기</h3>
<form action="doFindLoginPw" method="POST" class="table-box con form1"
	onsubmit="findLoginPwForm__submit(this); return false;">
	<table>
		<colgroup>
			<col width="100"/>
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="loginId" placeholder="로그인 아이디를 입력해주세요."
						maxlength="30" autofocus/>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" name="email" placeholder="이메일을 입력해주세요."
						maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비밀번호 찾기</th>
				<td>
					<button type="submit" >비밀번호 찾기</button>
				</td>
			</tr>
			
		</tbody>
	</table>
</form>






<script>

// 로그인 아이디 찾는 자바스크립트
var findLoginIdForm__submitDone = false;
function findLoginIdForm__submit(form) {
	
	if (findLoginIdForm__submitDone) {
		alert('처리중입니다.');
		return;
	}
	
	form.name.value = form.name.value.trim();
	if ( form.name.value.length == 0 ) {
		alert('이름을 입력해주세요.');
		form.name.focus();
		return;
	}

	form.email.value = form.email.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return;
	}

	
	form.submit();
	findLoginIdForm__submitDone = true;
}


// 로그인 비밀번호 찾는 자바스크립트 
var findLoginPwForm__submitDone = false;
function findLoginPwForm__submit(form) {
	
	if ( findLoginPwForm__submitDone ) {
		alert('처리중입니다.');
		 return;
	}
	
	form.loginId.value = form.loginId.value.trim();
	if ( form.loginId.value.length == 0 ) {
		alert('로그인 아이디를 입력해주세요.');
		form.loginId.focus();
		return;
	}

	form.email.value = form.email.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return;
	}

	form.submit();
	findLoginPwForm__submitDone = true;

}





</script>




<%@ include file="../part/foot.jspf"%>