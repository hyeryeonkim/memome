<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form action="doJoin" method="POST" class="table-box con form1 margin-top-50"
	onsubmit="MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="loginPwReal" /> <input type="hidden"
		name="redirectUri" value="../member/login" />
	<table>
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>로그인 아이디</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="loginId" placeholder="로그인 아이디를 입력해주세요."
							onkeyup="JoinForm__checkLoginIdDup(this);" maxlength="30"
							autofocus />
						<div class="message-msg"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>로그인 비밀번호</th>
				<td>
					<div class="form-control-box">
						<input type="password" name="loginPw"
							placeholder="로그인 비밀번호를 입력해주세요." maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<div class="form-control-box">
						<input type="password" name="loginPwConfirm"
							placeholder="비밀번호 확인을 입력해주세요." maxlength="50" />
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="name" placeholder="이름을 입력해주세요."
							maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="nickname" placeholder="닉네임을 입력해주세요."
							onkeyup="JoinForm__checkNicknameDup(this);" maxlength="30" />
						<div class="message-msg"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" name="email" placeholder="이메일을 입력해주세요."
							onkeyup="JoinForm__checkEmailDup(this);" maxlength="50"
							style="ime-mode: inactive;" />
						<div class="message-msg"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td>
					<div class="form-control-box">
						<input type="tel" name="cellphoneNo" onkeyup="JoinForm__checkCellphoneNoDup(this);"
							placeholder="휴대전화 번호를 -없이 입력해주세요." maxlength="11" />
							<div class="message-msg"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>가입</th>
				<td><input type="submit" class=" btn black" value="가입" /> <!-- 					<button type="submit" >가입</button> -->
				</td>
			</tr>

		</tbody>
	</table>
</form>





<script>

var passLoginId = false;
var passNickname = false;
var passEmail = false;
var passCellphoneNo = false;


function MemberJoinForm__submit(form) {

	
	
	if (isNowLoading()) {
		alert('처리중입니다.');
		return;
	}

	form.loginId.value = form.loginId.value.trim();
	form.loginId.value = form.loginId.value.replaceAll('-', '');
	form.loginId.value = form.loginId.value.replaceAll('_', '');
	form.loginId.value = form.loginId.value.replaceAll(' ', '');

	
	if ( form.loginId.value.length == 0 ) {
		alert('로그인 아이디를 입력해주세요.');
		return;
		form.loginId.focus();
	}


	if ( form.loginId.value.length < 4 || form.loginId.value.length > 12 ) {
		alert('아이디를 4~12자까지 입력해주세요.');
		form.loginId.focus();
		return;
	}

	
	if(CheckLoginId(form.loginId.value) == false) {

		alert('아이디를 영문소문자와 숫자의 조합으로 입력해주세요.');
		form.loginId.focus();
		return false;
	}
	
	if ( passLoginId == false) {
		alert('사용중인 로그인 아이디 입니다.');
		form.loginId.focus();
		return;
	}
	
		
	/* 
	if ( form.loginId.value.indexOf(' ') != -1 ) {
		alert('아이디를 영문소문자와 숫자의 조합으로 입력해주세요.');
		form.loginId.focus();
		return;
	} */
	
	
	form.loginPw.value = form.loginPw.value.trim();
	
	
	if ( form.loginPw.value.length == 0 ) {
		alert('비밀번호를 입력해주세요.');
		return;
		form.loginPw.focus();
	}

	if ( form.loginPw.value.length < 4 || form.loginPw.value.length > 12 ) {
		alert('로그인 비밀번호를 4~12자까지 입력해주세요.');
		form.loginPw.value = "";
		form.loginPwConfirm.value = "";
		form.loginPw.focus();
		return;
	}
	
	form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
	if ( form.loginPwConfirm.value.length == 0 ) {
		alert('비밀번호 확인을 입력해주세요.');
		return;
		form.loginPwConfirm.focus();
	}

	
	if ( form.loginPw.value != form.loginPwConfirm.value) {
		alert('비밀번호 확인이 일치하지 않습니다.');
		return;
		form.loginPw.focus();
	}

	
	form.name.value = form.name.value.trim();
	if ( form.name.value.length == 0 ) {
		alert('이름을 입력해주세요.');
		form.name.focus();
		return;
	}

	if ( form.name.value.length < 2 ) {
		alert('이름을 2자 이상 입력해주세요.');
		form.name.focus();
		return;
	}
	

	form.nickname.value = form.nickname.value.trim();
	if ( form.nickname.value.length == 0 ) {
		alert('닉네임을 입력해주세요.');
		form.nickname.focus();
		return;
	}

	if ( form.nickname.value.length < 2 ) {
		alert('닉네임을 2자 이상 입력해주세요.');
		form.nickname.focus();
		return;
	}
	
	if ( passNickname == false ) {
		alert('사용중인 닉네임 입니다.');
		form.nickname.focus();
		return;
	}


	
	form.email.value = form.email.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return;
	}

	if ( passEmail == false ) {
		alert('사용중인 이메일 입니다.');
		form.email.focus();
		return;
	}
	

	form.cellphoneNo.value = form.cellphoneNo.value.trim();
	form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
	form.cellphoneNo.value = form.cellphoneNo.value.replaceAll(' ', '');


	
	// ↑ 위의 replaceAll은 샘이 'String.prototype.replaceAll(org, dest) 라는 함수를 js파일에 만들어 놓으셔서 가능한 것임.
	
	/*  [ 참고사항 ]      
	자바스크립트에는 replaceAll 이라는 함수는 없다고 한다.
	form.cellphoneNo.value = form.cellphoneNo.value.replaceAll('-', '');
	 */


	 
	/* [ 참고사항 ] 
	★★★★★ 자바스크립트 replace 정규 표현식 ★★★★★ 
	form.cellphoneNo.value = form.cellphoneNo.value.replace(/-/g, "");
	form.cellphoneNo.value = form.cellphoneNo.value.replace(/ /gi, ""); 
	 */

	
	if ( form.cellphoneNo.value.length == 0 ) {
		alert('휴대폰번호를 입력해주세요.');
		form.cellphoneNo.focus();
		return;
	}

	if ( form.cellphoneNo.value.length < 8 ) {
		alert('휴대폰번호를 8자 이상 입력해주세요.');
		form.cellphoneNo.focus();
		return;
	}

	if (isCellphoneNo(form.cellphoneNo.value) == false) {
		form.cellphoneNo.focus();
		alert('휴대전화번호를 정확히 입력해주세요.');
		return;
	}

	if ( passCellphoneNo == false ) {
		alert('사용중인 전화번호 입니다.');
		form.cellphoneNo.focus();
		return;
	}
	
	form.loginPwReal.value = sha256(form.loginPw.value);
	form.loginPw.value = '';
	form.loginPwConfirm.value = '';

	
	form.submit();
	startLoading();
	
}



//★★★★★debounce 사용법★★★★★
//로그인 아이디 중복확인 시작
var JoinForm__validLoginId = '';
var checkLoginIdDup = _.debounce(function(form) {
	

	//아작스.  일반 form은 페이지 이동을 통해서 db에 저장을 시키지만 아작스는 페이지 이동 없이 은밀하게 db에 다녀온다.
	$.get(  
		'getLoginIdDup',  //    현재가  /s/member/join 이지만 아작스를 통해서 /s/member/getLoginIdDup 으로 주소가 바뀐다. 폼의 액션과 같다.
		{
			loginId: form.loginId.value 
		},
		function(data) {   //콜백 함수 : `getLoginIdDup`로 db에 다녀오면 실행되는 함수. 응답이 오면 후속 조치.
			var $message = $(form.loginId).next();   // input 로그인 아이디의 동생인 msg...?
			
			//checkLoginIdDup(data);
			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				$message.empty().append('<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validLoginId = data.loginId;
				passLoginId = true;
			}
											
			else {
				$message.empty().append('<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validLoginId = '';
				passLoginId = false;
			}

			if ( form.loginId.value.length == 0 ) {
				$message.empty().append('<div style="display:none;"></div>');
			}
			
			

			
	},`json`);
	
}, 1000);

function JoinForm__checkLoginIdDup(input) {
	var form = input.form;

	form.loginId.value = form.loginId.value.trim();

	// 여기에서 입력값이 0이면 return을 해버려서 ajax에서 1개의 문자 입력 후 지웠을 때, div가 없어지지 않음.
		/* if ( form.loginId.value.length == 0 ) {
		return;
	} */

	checkLoginIdDup(form);
}

//로그인 아이디 중복확인 끝 


// 닉네임 중복확인 시작 
var JoinForm__validNickname = '';
var checkNicknameDup = _.debounce(function(form) {

	//아작스.  일반 form은 페이지 이동을 통해서 db에 저장을 시키지만 아작스는 페이지 이동 없이 은밀하게 db에 다녀온다.
	$.get(  
		'getNicknameDup',  //    현재가  /s/member/join 이지만 아작스를 통해서 /s/member/getLoginIdDup 으로 주소가 바뀐다. 폼의 액션과 같다.
		{
			nickname: form.nickname.value 
		},
		function(data) {   //콜백 함수 : `getLoginIdDup`로 db에 다녀오면 실행되는 함수. 응답이 오면 후속 조치.
			var $message = $(form.nickname).next();   // input 로그인 아이디의 동생인 msg...?

			 
			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				$message.empty().append('<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickname = data.nickname;
				passNickname = true;
			}								
			else {
				$message.empty().append('<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickname = '';
				passNickname = false;
			}

			if ( form.nickname.value.length == 0 ) {
				$message.empty();
			}

			
	}, `json`);
}, 1000);


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
	$.get(  
		'getEmailDup',  //    현재가  /s/member/join 이지만 아작스를 통해서 /s/member/getLoginIdDup 으로 주소가 바뀐다. 폼의 액션과 같다.
		{
			email: form.email.value 
		},
		function(data) {   //콜백 함수 : `getLoginIdDup`로 db에 다녀오면 실행되는 함수. 응답이 오면 후속 조치.
			var $message = $(form.email).next();   // input 로그인 아이디의 동생인 msg...?

			 
			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				$message.empty().append('<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validEmail = data.email;
				passEmail = true;
			}								
			else {
				$message.empty().append('<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validEmail = '';
				passEmail = false;
			}

			if ( form.email.value.length == 0 ) {
				$message.empty();
			}
			
	}, `json`);
}, 1000);


function JoinForm__checkEmailDup(input) {
	var form = input.form;

	form.email.value = form.email.value.trim();

	/* if ( form.email.value.length == 0 ) {
		return;
	} */

	checkEmailDup(form);
	
}

//이메일 중복확인 끝 



// 전화번호 중복확인 시작
var JoinForm__validCellphoneNo = '';
 
var checkCellphoneNoDup = _.debounce(function(form) {

	//아작스.  일반 form은 페이지 이동을 통해서 db에 저장을 시키지만 아작스는 페이지 이동 없이 은밀하게 db에 다녀온다.
	$.get(  
		'getCellphoneNoDup',  //    현재가  /s/member/join 이지만 아작스를 통해서 /s/member/getLoginIdDup 으로 주소가 바뀐다. 폼의 액션과 같다.
		{
			cellphoneNo: form.cellphoneNo.value 
		},
		function(data) {   //콜백 함수 : `getLoginIdDup`로 db에 다녀오면 실행되는 함수. 응답이 오면 후속 조치.
			var $message = $(form.cellphoneNo).next();   // input 로그인 아이디의 동생인 msg...?

			 
			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				$message.empty().append('<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validCellphoneNo = data.cellphoneNo;
				passCellphoneNo = true;
			}								
			else {
				$message.empty().append('<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validCellphoneNo = '';
				passCellphoneNo = false;
			}

			if ( form.cellphoneNo.value.length == 0 ) {
				$message.empty();
			}
			
	}, `json`);
}, 500);


function JoinForm__checkCellphoneNoDup(input) {
	var form = input.form;

	form.cellphoneNo.value = form.cellphoneNo.value.trim();

/* 	if ( form.cellphoneNo.value.length == 0 ) {
		return;
	} */
	checkCellphoneNoDup(form);
	
}
// 전화번호 중복확인 끝 

</script>


<style>
.con {
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
}





</style>





<%@ include file="../part/foot.jspf"%>