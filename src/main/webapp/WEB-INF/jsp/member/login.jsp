<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<form action="doLogin" method="POST" class="form1 table-box con"
	onsubmit="MemberLoginForm__submit(this); return false;">
	<input type="hidden" name="loginPwReal"/>
	<input type="hidden" name="redirectUri" value="../home/main"/>
	<table>
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input name="loginId" type="text" placeholder="로그인 아이디를 입력해주세요." autofocus maxlength="30"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비밀번호</th>
				<td>
					<div class="form-control-box">
						<input name="loginPw" type="password" placeholder="비밀번호를 입력해주세요." maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인</th>
				<td>
					<input type="submit" value="로그인" />
<!-- 					<button type="submit">로그인</button> -->
				</td>
			</tr>
			<tr>
				<th>아이디, 비밀번호 찾기</th>
				<td>
					<input type="button" onclick="location.href='../member/findAccount'" value="찾기"/>
				</td>
			</tr>
		</tbody>
	</table>
</form>



<script>
var MemberLoginForm__submitDone = false;
function MemberLoginForm__submit(form) {
	
	if ( MemberLoginForm__submitDone ) {
		alert('처리중입니다.');
		return;
	}

	form.loginId.value = form.loginId.value.trim();
	if ( form.loginId.value.length == 0 ) {
		alert('로그인 아이디를 입력해주세요.');
		form.loginId.focus();
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
	MemberLoginForm__submitDone = true;
	
	
}
</script>







<%@ include file="../part/foot.jspf"%>