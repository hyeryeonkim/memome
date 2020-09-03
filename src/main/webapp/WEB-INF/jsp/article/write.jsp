<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<h1 class="con">
	<strong style="color: red;">${boardCode}</strong>게시판<strong
		style="color: blue;"> 글쓰기</strong>
</h1>

<form method="POST" action="${boardCode}-doWrite"
	class="form1 table-box con"
	onsubmit="ArticleWriteForm__submit(this); return false;">
	<input type="hidden" name="fileIdsStr" /> <input type="hidden"
		name="redirectUri" value="/usr/article/${board.code}-detail?id=#id" />
	<input type="hidden" name="relTypeCode" value="article" />
	<table>
		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="title" placeholder="제목을 입력해주세요."
							autofocus maxlength="200" />
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="form-control-box">
						<textarea name="body" placeholder="내용을 입력해주세요." maxlength="2000"></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<th>태그(최대 10개)</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="tag" placeholder="#태그 입력"
							class="input-tag" />
					</div>
				</td>
			</tr>
			<tr>
			<tr>
				<th>첨부1 이미지</th>
				<td>
					<div class="form-control-box">
						<input type="file" accept="image/*"
							name="file__article__0__common__attachment__1" />
					</div>
				</td>
			</tr>
			<tr>
				<th>등록</th>
				<td>
					<div class="form-control-box">
						<input type="submit" value="등록" />
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form>


<script>
	/* 	var input__tag = '';
	 var input__tagWrited = false;
	 $(document).ready(function() {

	 $(".input-tag").keydown(function(key) {
	 if (key.keyCode == 13) {
	 alert("엔터키를 눌렀습니다.");
	 input__tag = $('.input-tag').val();
	 alert(input__tag + '를 찾았습니다.');
	 input__tagWrited = true;
	 }
	 });
	 });

	 if (input__tagWrited) {

	 } */
	function ArticleWriteForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return;
		}

		form.tag.value = form.tag.value.trim();
		form.tag.value = form.tag.value.replaceAll('-', '');
		form.tag.value = form.tag.value.replaceAll('_', '');
		form.tag.value = form.tag.value.replaceAll(' ', '');

		// 자바스크립트 특수 문자 일치 정규식
		var temp = form.tag.value;
		var count = (temp.match(/#/g) || []).length;

		var textCount = temp.split('#');
		textCount = textCount-1;
		
		console.log(textCount);
		if (count > 10) {
			alert('해시태그를 10개 이하로 입력해주세요.');
			form.tag.focus();
			return;
		}
		

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 // 50MB 

		if (form.file__article__0__common__attachment__1.value) {
			if (form.file__article__0__common__attachment__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		// 실행순서 1번 
		// ★ 만약 needToUpload == false라면 다음꺼를 바로 실행시키고 꺼버린다.

		var startUploadFiles = function(onSuccess) {
			alert('안되나?');
			var needToUpload = form.file__article__0__common__attachment__1.value.length > 0;

			if (!needToUpload) {
				needToUpload = form.file__article__0__common__attachment__2.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = form.file__article__0__common__attachment__3.value.length > 0;
			}

			// ★ false라면 다음꺼인 onSuccess();를 실행하고 꺼버린다. 	
			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			// 실행순서 2번 ajax 호출 시작 
			// 예) 실행시간 오후 1시
			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			//-> 얘는 '함수'이다! 
			// -> onSuccess는 실행순서 1번의 function(onSuccess)의 onSuccess를 의미
			// ★★★★★ onSuccess는 3번보다 먼저 실행되지 않는다.
			// 실행순서 3번보다 위에 있어서 먼저 실행될 것 같지만 그렇지 않다.
			// ajax로 파일을 업로드 한 후, 한참 있다가 실행될 '예약 걸어놓은 함수'이다.
			// 예) 실행시간 오후 1시로부터 1년 뒤
			});
			// 실행순서 3번 ajax 호출 끝
			// 예) 실행시간 오후 2시
		}

		startLoading();
		// 실행순서 4번 
		// 다음꺼는 (function(data)부터 form.submit()까지이다.)
		startUploadFiles(function(data) {
			//'onSuccess는 startUploadfiles ajax 호출 결과 도착'을 의미한다.
			var fileIdsStr = '';

			// ★ 먼저 upload한 file의 id를 게시물 작성하면서 같이 보낸다.
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			// 실행순서 5번 
			// 마지막에 file 번호들을 가지고 form의 정보를 전송한다.

			form.fileIdsStr.value = fileIdsStr;
			form.file__article__0__common__attachment__1.value = '';

			form.submit();

		});
		/* 
		 맨처음 실행되는 것은 startUploadFiles 함수이다.
		 위의 함수를 실행하면 옆에 function이 실행되는게 아니라 
		 실행순서 1번의 var startUploadFiles = ~~~ { 이게 실행된다. ! }
		 */
	}
</script>







<%@ include file="../part/foot.jspf"%>