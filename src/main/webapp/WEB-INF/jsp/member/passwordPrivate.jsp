<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>




<form method="POST" action="passwordModify" class="table-box con"
	onsubmit="submitModifyForm(this); return false;">
	<input type="hidden" name="loginPwReal"/>
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>비밀번호 입력</th>
				<td><input type="password" name="loginPw" autofocus/></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="submit" value="확인"/></td>
			</tr>
		</tbody>
	</table>
</form>


<script>
var submitModifyFormDone = false;
function submitModifyForm(form) {
	if ( submitModifyFormDone ) {
		alert('처리중입니다.');
		return;
	}

	
	form.loginPw.value = form.loginPw.value.trim();
	if ( form.loginPw.value.length == 0 ) {
		alert('비밀번호를 입력해주세요.');
		form.loginPw.focus();
		return;
	}

	form.loginPwReal.value = sha256(form.loginPw.value);
	form.loginPw.value = '';

	form.submit();
	submitModifyFormDone = true;

	
}
</script>







<%@ include file="../part/foot.jspf"%>