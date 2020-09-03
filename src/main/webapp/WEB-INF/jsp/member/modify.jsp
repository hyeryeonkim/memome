<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form method="POST" action="doModify" class="form1 table-box con"
	onsubmit="submitMemberDataModify(this); return false;">
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>회원번호</th>
				<td><input type="text" name="id" value="${loginedMember.id}" readonly />
				</td>
			</tr>
			<tr>
				<th>회원가입일</th>
				<td><input type="text" name="regDate" value="${loginedMember.regDate}"
					readonly /></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" value="${loginedMember.name}"
					readonly /></td>
			</tr>
			<tr>
				<th>닉네임(선택)</th>
				<!-- 가능 -->
				<td><input class="border-red-1" type="text" name="nickname"
					value="${loginedMember.nickname}" /></td>
			</tr>
			<tr>
				<th>이메일(선택)</th>
				<!-- 가능 -->
				<td><input class="border-red-1" type="email" name="email"
					value="${loginedMember.email}" /></td>
			</tr>
			<tr>
				<th>마지막 회원정보 변경일</th>
				<td><input type="text" name="updateDate"
					value="${loginedMember.updateDate}" readonly /></td>
			</tr>
			<tr>
				<th>회원정보 변경</th>
				<td>
				<input class="btn black" type="submit" value="변경"/>
				</td>
			</tr>
			<tr>
				<th>취소</th>
				<td>
				<button type="button" class="btn black" onclick="location.href='../member/myPage'">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<script>

function submitMemberDataModify(form) {
	if ( isNowLoading() ) {
		alert('처리중입니다.')
		return;
	}


	form.nickname.value = form.nickname.value.trim();
	if ( form.nickname.value.length == 0 ) {
		alert('닉네임을 입력해주세요.');
		form.nickname.focus();
		return;
	}

	form.email.value = form.emali.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return;
	}

	form.submit();
	startLoading();

	

}
</script>



<style>
.btn {
	padding:0 25px;
	font-size:1rem;
}
</style>





<%@ include file="../part/foot.jspf"%>