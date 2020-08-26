<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<h1 class="con"><strong style="color:red;">${boardCode}</strong>게시판<strong style="color:blue;"> 글쓰기</strong></h1>

<form method="POST" action="${boardCode}-doWrite" class="form1 table-box con"
		onsubmit="ArticleWriteForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr"/>
		<input type="hidden" name="redirectUri" value="/usr/article/${board.code}-detail?id=#id"/>
	<table>
	
		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="title" placeholder="제목을 입력해주세요." autofocus maxlength="200"/>
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
				<th>첨부1 이미지</th>
				<td>
					<div class="form-control-box">
						<input type="file" accept="image/*" name="file__article__0__common__attachment__1">
					</div>
				</td>
			</tr>
			<tr>
				<th>등록</th>
				<td>
					<div class="form-control-box">
						<input type="submit" value="등록"/>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form>


<script>
var ArticleWriteForm__submitDone = false;
function ArticleWriteForm__submit(form) {
	if ( ArticleWriteForm__submitDone ) {
		alert('처리중입니다.');
		return;
	}

	form.title.value = form.title.value.trim();
	if ( form.title.value.length == 0 ) {
		alert('제목을 입력해주세요.');
		form.title.focus();
		return;
	}

	form.body.value = form.body.value.trim();
	if ( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요.');
		form.body.focus();
		return;
	}


	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024 // 50MB 

	if (form.file__article__0__common__attachment__1.value) {
		if ( form.file__article__0__common__attachment__1.files[0].size > maxSize ) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			return;
		} 
	}


	var startUploadFiles = function(onSuccess) {

		var needToUpload = form.file__article__0__common__attachment__1.value.length > 0;

		if (!needToUpload) {
			needToUpload = form.file__article__0__common__attachment__2.value.length > 0;
		}

		if (!needToUpload) {
			needToUpload = form.file__article__0__common__attachment__3.value.length > 0;
		}
	
		
		if ( needToUpload == false) {
			onSuccess();
			return;
		}

		var fileUploadFormData = new FormData(form); 

		$.ajax({
			url : './../file/doUploadAjax',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType:"json",
			type : 'POST',
			success : onSuccess
		});
	}
	

	ArticleWriteForm__submitDone = true;

	startUploadFiles(function(data) {
		var fileIdsStr = '';

		if ( data && data.body && data.body.fileIdsStr ) {
			fileIdsStr = data.body.fileIdsStr;
		}

		form.fileIdsStr.value = fileIdsStr;
		form.file__article__0__common__attachment__1.value = '';
		
		form.submit();
	});

}
</script>







<%@ include file="../part/foot.jspf"%>