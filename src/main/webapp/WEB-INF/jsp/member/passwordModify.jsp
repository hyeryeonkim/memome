<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form method="POST" action="doPasswordModify" class="form1 table-box con con2 margin-top-50"
	onsubmit="SubmitPasswordModify(this); return false;">
	<input type="hidden" name="loginPwReal"/>
	<input type="hidden" name="id" value="${loginedMemberId }"/>
	<input type="hidden" name="loginId" value="${loginedMember.loginId}"/>
	<input type="hidden" name="email" value="${loginedMember.email}"/>
	
	<table>
		<colgroup>
			<col width="110" />
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
				<td><input type="submit"  class="btn black" value="변경"/></td>
			</tr>
		</tbody>
	</table>
</form>

<script>

function SubmitPasswordModify(form) {
	if ( isNowLoading() ) {
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
	startLoading();

	

}
</script>





<style>
.btn {
	padding:0 25px;
	font-size:1rem;
}

.con2 {
	width:50%;
	
}
.table-box table th {
	text-align:center;
	
}

.table-box {
	border:5px solid black;
}

/* 모바일 버전 */

@media (max-width :1210px)  {
    .con {
    	width:80%;
    	margin-left:auto;
    	margin-right:auto;
    }
    .btn {
    
    }
}
</style>












<%@ include file="../part/foot.jspf"%>