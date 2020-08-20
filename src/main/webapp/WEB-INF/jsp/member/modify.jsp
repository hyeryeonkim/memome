<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form method="POST" action="doModify" class="form1 table-box con"
	onsubmit="submitMemberDataModify(this); return false;">
	<input type="hidden" name="id" value="${member.id}"/>
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>회원번호</th>
				<td><input type="text" name="id" value="${member.id}" readonly />
				</td>
			</tr>
			<tr>
				<th>회원가입일</th>
				<td><input type="text" name="regDate" value="${member.regDate}"
					readonly /></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" value="${member.name}"
					readonly /></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<!-- 가능 -->
				<td><input class="border-red-1" type="text" name="nickname"
					value="${member.nickname}" /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<!-- 가능 -->
				<td><input class="border-red-1" type="email" name="email"
					value="${member.email}" /></td>
			</tr>
			<tr>
				<th>마지막 회원정보 변경일</th>
				<td><input type="text" name="updateDate"
					value="${member.updateDate}" readonly /></td>
			</tr>
			<tr>
				<th>회원정보 변경</th>
				<td>
				<input type="submit" value="변경"/>
				</td>
			</tr>
			<tr>
				<th>취소</th>
				<td>
				<button type="button" onclick="location.href='../member/myPage'">취소</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<script>

var submitMemberDataModifyDone = false;
function submitMemberDataModify(form) {
	if ( submitMemberDataModifyDone ) {
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
	submitMemberDataModifyDone = true;

	

}
</script>







<%@ include file="../part/foot.jspf"%>