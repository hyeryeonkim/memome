<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>




<form method="POST" action="doCheckPassword" class="table-box con margin-top-50 con2" 
	onsubmit="MemberCheckPasswordForm__submit(this); return false;">
	<input type="hidden" name="loginPwReal"/>
	<input type="hidden" name="redirectUri" value="${param.redirectUri}"/>
	<table>
		<colgroup>
			<col width="130" />
		</colgroup>
		<tbody>
			<tr>
				<th>비밀번호 입력</th>
				<td><input type="password" name="loginPw" autofocus/></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td class="mobile-btn flex">
					<button type="submit" class="btn black">확인</button>
					<button type="button" class="btn black" onclick="location.href='/usr/home/main'">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>


<script>
function MemberCheckPasswordForm__submit(form) {
	if ( isNowLoading() ) {
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
	startLoading();
	
}
</script>


<style>
.con2 {
	width:50%;
	
}
.table-box table th {
	text-align:center;
	
}

.table-box {
	border:5px solid black;
}
.btn {
	padding:0 25px;
	font-size:1rem;
}


/* 모바일 버전 */

@media (max-width :1210px)  {
    .con {
    	width:80%;
    	margin-left:auto;
    	margin-right:auto;
    }
    .btn {
    	padding: 5px 20px;
    }
}






</style>






<%@ include file="../part/foot.jspf"%>