<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보 변경" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="modify-page con">
	<div class="form">
		<form method="POST" action="doModify" class=""
			onsubmit="submitMemberDataModify(this); return false;">
			<input type="hidden" name="id" value="${loginedMemberId }" />
			<div class="table-control-box">
				<div class="modify-title">회원정보를 변경해주세요.</div>
			</div>
			<div class="form-control-box flex">
				<div class="title">Sign in date</div>
				<input type="text" name="regDate" value="${loginedMember.regDate}"
					readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">name</div>
				<input type="text" name="name" value="${loginedMember.name}"
					readonly />
			</div>
			<div class="form-control-box flex ">
				<div class="title">
					nickname <strong style="color: red;">(choice)</strong>
				</div>
				<input class="border-red-1" type="text" name="nickname"
					value="${loginedMember.nickname}"
					onkeyup="JoinForm__checkNicknameDup(this);" />
			</div>
			<div class="" >
			<div class="message-msg-1" style="margin-bottom: 10px;"></div>
			</div>
			
			<div class="form-control-box flex">
				<div class="title">
					email <strong style="color: red;">(choice)</strong>
				</div>
				<input class="border-red-1" type="email" name="email"
					value="${loginedMember.email}"
					onkeyup="JoinForm__checkEmailDup(this);" />
			</div>
			<div class="">
			<div class="message-msg-2" style="margin-bottom: 10px;"></div>
			</div>

			<div class="form-control-box flex">
				<div class="title">last updateDate</div>
				<input type="text" name="updateDate"
					value="${loginedMember.updateDate}" readonly />
			</div>
			<div class="form-control-box flex">
				<div class="title">modify</div>
				<button type="submit">modify</button>
			</div>
		</form>
	</div>
</div>

<script>
	function submitMemberDataModify(form) {
		if (isNowLoading()) {
			alert('처리중입니다.')
			return;
		}

		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}

		form.email.value = form.emali.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		form.submit();
		startLoading();

	}

	// 닉네임 중복확인 시작 
	var JoinForm__validNickname = '';
	var checkNicknameDup = _.debounce(function(form) {

		//아작스.  일반 form은 페이지 이동을 통해서 db에 저장을 시키지만 아작스는 페이지 이동 없이 은밀하게 db에 다녀온다.
		$.get('getNicknameDup', //    현재가  /s/member/join 이지만 아작스를 통해서 /s/member/getLoginIdDup 으로 주소가 바뀐다. 폼의 액션과 같다.
		{
			nickname : form.nickname.value
		}, function(data) { //콜백 함수 : `getLoginIdDup`로 db에 다녀오면 실행되는 함수. 응답이 오면 후속 조치.
			var $message = $(".message-msg-1"); // input 로그인 아이디의 동생인 msg...?

			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickname = data.nickname;
				passNickname = true;
			} else {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickname = '';
				passNickname = false;
			}

			if (form.nickname.value.length == 0) {
				$message.empty();
			}

		}, `json`);
	}, 300);

	function JoinForm__checkNicknameDup(input) {
		var form = input.form;

		form.nickname.value = form.nickname.value.trim();

		// 여기에서 입력값이 0이면 return을 해버려서 ajax에서 1개의 문자 입력 후 지웠을 때, div가 없어지지 않음.
		/* if ( form.nickname.value.length == 0 ) {
			return;
		} */

		checkNicknameDup(form);

	}
	// 닉네임 중복확인 끝 

	// 이메일 중복확인 시작 
	var JoinForm__validEmail = '';
	var checkEmailDup = _.debounce(function(form) {

		//아작스.  일반 form은 페이지 이동을 통해서 db에 저장을 시키지만 아작스는 페이지 이동 없이 은밀하게 db에 다녀온다.
		$.get('getEmailDup', //    현재가  /s/member/join 이지만 아작스를 통해서 /s/member/getLoginIdDup 으로 주소가 바뀐다. 폼의 액션과 같다.
		{
			email : form.email.value
		}, function(data) { //콜백 함수 : `getLoginIdDup`로 db에 다녀오면 실행되는 함수. 응답이 오면 후속 조치.
			var $message = $(".message-msg-2"); // input 로그인 아이디의 동생인 msg...?

			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validEmail = data.email;
				passEmail = true;
			} else {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validEmail = '';
				passEmail = false;
			}

			if (form.email.value.length == 0) {
				$message.empty();
			}

		}, `json`);
	}, 300);

	function JoinForm__checkEmailDup(input) {
		var form = input.form;

		form.email.value = form.email.value.trim();

		/* if ( form.email.value.length == 0 ) {
			return;
		} */

		checkEmailDup(form);

	}

	//이메일 중복확인 끝
</script>



<style>

/* 모바일 버전 */
@media ( max-width :1210px) {
	.con {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
}

.modify-page {
	
}

.modify-page .form {
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 200px;
}

.modify-page .modify-title {
	margin-bottom: 30px;
	font-weight: bold;
	font-size: 1.2rem;
}

.modify-page .form .form-control-box {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.modify-page .form .form-control-box  input {
	margin-top: auto;
	margin-bottom: auto;
}

.modify-page .form .form-control-box  .form-control-box-contents {
	width: 100%;
	text-align: left;
	border: 3px solid blue;
	height: 100%;
	padding-bottom: 0;
}

.modify-page .form .message-msg-1, .modify-page .form .message-msg-2 {
	
	text-align:right;
}

.modify-page .form .form-control-box:nth-child(3) input,
	.form-control-box:nth-child(4) input {
	background: #cccccc;
}

.modify-page .form form button {
	background: #fdbe3f;
}

.modify-page .form .form-control-box .title {
	/* font-size: 1.2rem; */
	width: 300px;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}
</style>





<%@ include file="../part/foot.jspf"%>