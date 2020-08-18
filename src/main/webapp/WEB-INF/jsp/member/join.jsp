<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form action="doJoin" method="POST" class="table-box con form1"
	onsubmit="MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="loginPwReal"/>
	<input type="hidden" name="redirectUri" value="../member/login"/>
	<table>
		<colgroup>
			<col width="200"/>
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="loginId" placeholder="로그인 아이디를 입력해주세요."
						maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비밀번호</th>
				<td>
					<div class="form-control-box">
						<input type="password" name="loginPw" placeholder="로그인 비밀번호를 입력해주세요."
						maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비밀번호 확인</th>
				<td>
					<div class="form-control-box">
						<input type="password" name="loginPwConfirm" placeholder="로그인 비밀번호 확인을 입력해주세요."
						maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="name" placeholder="이름을 입력해주세요."
						maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="nickname" placeholder="닉네임을 입력해주세요."
						maxlength="30" />
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
<!-- 			<tr> -->
<!-- 				<th>휴대전화</th> -->
<!-- 				<td> -->
<!-- 					<div class="form-control-box"> -->
<!-- 						<input type="tel" name="cellphoneNo" placeholder="휴대전화 번호를 입력해주세요." maxlength="12" /> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<th>가입</th>
				<td>
					<button type="submit" >가입</button>
				</td>
			</tr>
			
		</tbody>
	</table>
</form>





<script>
var MemberJoinForm__submitDone = false;
function MemberJoinForm__submit(form) {
	
	if (MemberJoinForm__submitDone) {
		alert('처리중입니다.');
		return;
	}

	form.loginId.value = form.loginId.value.trim();
	if ( form.loginId.value.length == 0 ) {
		alert('로그인 아이디를 입력해주세요.');
		return;
		form.loginId.focus();
	}

	if ( form.loginId.value.length < 4 ) {
		alert('로그인 아이디를 4자 이상 입력해주세요.');
		return;
		form.loginId.focus();
	}

	
	
	form.loginPw.value = form.loginPw.value.trim();
	
	if ( form.loginPw.value.length == 0 ) {
		alert('비밀번호를 입력해주세요.');
		return;
		form.loginPw.focus();
	}

	if ( form.loginPw.value.length < 5 ) {
		alert('비밀번호를 5자 이상 입력해주세요.');
		return;
		form.loginPw.focus();
	}
	
	
	
	form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
	if ( form.loginPwConfirm.value.length == 0 ) {
		alert('비밀번호 확인을 입력해주세요.');
		return;
		form.loginPwConfirm.focus();
	}

	
	if ( form.loginPw.value != form.loginPwConfirm.value) {
		alert('비밀번호 확인이 일치하지 않습니다.');
		return;
		form.loginPw.focus();
	}

	
	form.name.value = form.name.value.trim();
	if ( form.name.value.length == 0 ) {
		alert('이름을 입력해주세요.');
		form.name.focus();
		return;
	}

	form.nickname.value = form.nickname.value.trim();
	if ( form.nickname.value.length == 0 ) {
		alert('닉네임을 입력해주세요.');
		form.nickname.focus();
		return;
	}
	
	form.email.value = form.email.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return;
	}

	/* form.cellphoneNo.value = form.cellphoneNo.value.trim();
	form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
	form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');
	
	alert(form.cellphoneNo.value);

	
	if ( form.cellphoneNo.value.length == 0 ) {
		alert('휴대폰번호를 입력해주세요.');
		form.cellphoneNo.focus();
		return;
	}

	if ( form.cellphoneNo.value.length < 8 ) {
		alert('휴대폰번호를 8자 이상 입력해주세요.');
		form.cellphoneNo.focus();
		return;
	}

	if (isCellphoneNo(form.cellphoneNo.value)) {
		form.cellphoneNo.focus();
		alert('휴대전화번호를 정확히 입력해주세요.');
		return;
	} */
	
	form.loginPwReal.value = sha256(form.loginPw.value);
	alert(form.loginPwReal.value);
	form.loginPw.value = '';
	form.loginPwConfirm.value = '';

	
	form.submit();
	MemberJoinForm__submitDone = true;
	
	
}


</script>




<%@ include file="../part/foot.jspf"%>