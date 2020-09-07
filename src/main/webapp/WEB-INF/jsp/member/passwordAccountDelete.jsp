<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원탈퇴" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>




<form method="POST" action="accountDelete" class="table-box con margin-top-50"
	onsubmit="submitAccountDeleteForm(this); return false;">
	<input type="hidden" name="memberId" value="${loginedMemberId}"/>
	<table>
		<colgroup>
			<col width="80" />
		</colgroup>
		<tbody>
			<tr>
				<th>비밀번호 입력</th>
				<td><input type="password" name="loginPw" placeholder="회원탈퇴 후 사이트 활동이 어려우므로 신중이 결정해주세요."autofocus/></td>
			</tr>
			<tr>
				<th>회원탈퇴</th>
				<td><input type="submit" class="btn black" value="탈퇴" onclick="if ( confirm('탈퇴하시겠습니까?') == false) return false;"/></td>
			</tr>
		</tbody>
	</table>
</form>


<script>
function submitAccountDeleteForm(form) {
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

.con {
	width:50%;
}
.table-box table th {
	text-align:center;
	
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
}

</style>






<%@ include file="../part/foot.jspf"%>