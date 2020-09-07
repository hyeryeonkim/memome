<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="My Page" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="myPage-box  con border-red-1 margin-top-50 flex flex-jc-sb">
	<div class="table-box">
		<table>
			<colgroup>
				<col width="110" />
			</colgroup>
			<tbody>
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="id" value="${member.id}" readonly />
					</td>
				</tr>
				<tr>
					<th>회원가입일</th>
					<td><input type="text" name="regDate"
						value="${member.regDate}" readonly /></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" value="${member.name}"
						readonly /></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="nickname"
						value="${member.nickname}" readonly /></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" value="${member.email}"
						readonly /></td>
				</tr>
				<tr>
					<th>마지막 수정일</th>
					<td><input type="text" name="updateDate"
						value="${member.updateDate}" readonly /></td>
				</tr>
				<tr>
					<th>회원정보 변경</th>
					<td><button type="button" class="btn black"
							onclick="location.href='../member/modify?checkPasswordAuthCode=${param.checkPasswordAuthCode}'">회원정보
							변경</button></td>
				</tr>
				<tr>
					<th>비밀번호 변경</th>
					<td><button type="button" class="btn black"
							onclick="location.href='../member/passwordModify?checkPasswordAuthCode=${param.checkPasswordAuthCode}'">비밀번호
							변경</button></td>
				</tr>
				<tr>
					<th>회원탈퇴</th>
					<td><button type="button" class="btn black"
							onclick="location.href='../member/passwordAccountDelete'">회원탈퇴</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="hashtag-box">
		<h1>HASHTAG LIST</h1>
		<div class="hashtag-list">
			<div class="hashtag-contents flex flex-wrap">
				<c:forEach items="${myhashtags }" var="myhashtag">
					<div>${myhashtag}</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>


<style>
.con2 {
	width: 50%;
}

.table-box, .hashtag-box {
	border: 5px solid black;
	width: 400px;
}

.myPage-box .hashtag-box {
	border: 5px solid black;
	width: 600px;
}

.table-box table {
	width: 400px;
}

.table-box table th {
	text-align: center;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}

.myPage-box .hashtag-box .hashtag-list .hashtag-contents > div {
	padding:10px;
	
}

/* 모바일 버전 */
@media ( max-width :1210px) {
	.con {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	.table-box table th {
		
	}
}
</style>


<%@ include file="../part/foot.jspf"%>