<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="My Page" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<div class="table-box con">
	<table>
		<colgroup>
			<col width="200"/>
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
				<td><input type="text" name="nickname" value="${member.nickname}"
					readonly  /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" name="email" value="${member.email}"
					readonly /></td>
			</tr>
			<tr>
				<th>마지막 회원정보 변경일</th>
				<td><input type="text" name="updateDate" value="${member.updateDate}"
					readonly /></td>
			</tr>
			<tr>
				<th>회원정보 변경</th>
				<td><button type="button" onclick="location.href='../member/modify?checkPasswordAuthCode=${param.checkPasswordAuthCode}'">회원정보 변경</button></td>
			</tr>
			<tr>
				<th>비밀번호 변경</th>
				<td><button type="button" onclick="location.href='../member/passwordModify?checkPasswordAuthCode=${param.checkPasswordAuthCode}'">비밀번호 변경</button></td>
			</tr>
			<tr>
				<th>회원탈퇴</th>
				<td><button type="button" onclick="location.href='../member/passwordAccountDelete'">회원탈퇴</button></td>
			</tr>
		</tbody>
	</table>
</div>













<%@ include file="../part/foot.jspf"%>