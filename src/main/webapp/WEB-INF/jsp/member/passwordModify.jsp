<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form method="POST" action="doPasswordModify" class="form1 table-box con"
	onsubmit="SubmitPasswordModify(this); return false;">
	<input type="hidden" name="loginPwReal"/>
	<input type="hidden" name="id" value="${loginedMemberId }"/>
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>비밀번호 입력</th>
				<!-- 가능 -->
				<td><input type="password" name="loginPw" autofocus /></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="loginPwConfirm"  autofocus /></td>
			</tr>
			<tr>
				<th>회원정보 변경</th>
				<td><input type="submit" value="변경"/></td>
			</tr>
		</tbody>
	</table>
</form>

<script>

var SubmitPasswordModifyDone = false;
function SubmitPasswordModify(form) {
	if ( SubmitPasswordModifyDone ) {
		alert('처리중입니다.')
		return;
	}


	form.loginPw.value = form.loginPw.value.trim();
	if ( form.loginPw.value.length == 0 ) {
		alert('비밀번호를 입력해주세요.');
		form.loginPw.focus();
		return;
	}

	form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
	if ( form.loginPwConfirm.value.length == 0 ) {
		alert('비밀번호 확인을 입력해주세요.');
		form.loginPwConfirm.focus();
		return;
	}

	if ( form.loginPw.value != form.loginPwConfirm.value ) {
		alert('비밀번호가 일치하지 않습니다.');
		form.loginPw.focus();
		return;
	}

	form.loginPwReal.value = sha256(form.loginPw.value);
	form.loginPw.value = '';
	form.loginPwConfirm.value = '';

	

	form.submit();
	SubmitPasswordModifyDone = true;

	

}
</script>
















<%@ include file="../part/foot.jspf"%>