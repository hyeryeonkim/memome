<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<c:if test="${boardCode ne 'memoYOU'  && boardCode ne 'memoME' }">
	<h1 class="con">
		<strong style="color: red;">${boardCode}</strong>게시판<strong
			style="color: blue;"> 글쓰기</strong>
	</h1>
</c:if>
<c:if test="${boardCode eq 'memoYOU' || boardCode eq 'memoME'}">
	<h1 class="con">
		<strong style="color: black;">${boardCode}</strong><strong
			style="color: blue;"> MEMO MODIFY</strong>
	</h1>
</c:if>

<form method="POST" action="${boardCode}-doMemoModify?mode=${mode}"
	class="form1 table-box con"
	onsubmit="ArticleWriteForm__submit(this); return false;">
	<input type="hidden" name="relTypeCode" value="article" /> <input
		type="hidden" name="fileIdsStr" /> <input type="hidden" name="id"
		value="${param.id}" /> <input type="hidden" name="body" />
	<table>
		<colgroup>
			<col width="150" />
		</colgroup>
		<tbody>
			<tr>
				<th>메모 번호</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="id" placeholder="제목을 입력해주세요." readonly
							autofocus maxlength="200" value="${article.id}" />
					</div>
				</td>
			</tr>
			<c:if test="${boardCode ne 'unicon' }">
				<tr>
					<th>공개여부</th>
					<td>
						<div class="form-control-box select">
							<select name="displayStatus" id="">
								<option value="1">공개</option>
								<option value="0">비공개</option>
							</select>
						</div>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>제목</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="title" placeholder="제목을 입력해주세요."
							autofocus maxlength="200" value="${article.title}" />
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div class="form-control-box">
						<script type="text/x-template">${article.body}</script>
						<div data-relTypeCode="article" data-relId="${article.id}"
							class="toast-editor input-body"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>태그(최대 10개)</th>
				<td>
					<div class="form-control-box tag" id="tag">
						<c:forEach items="tagBits" var="tag">
							<%-- 							<c:if test="${tag.length() eq 0 == false }"> --%>
							<input type="text" name="tag" placeholder="#태그 입력"
								class="input-tag" value="${tagBits}" />
							<%-- 							</c:if> --%>
						</c:forEach>
					</div>
				</td>
			</tr>
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="file"
					value="${article.extra.file__common__attachment[fileNo]}" />
				<tr>
					<th>첨부파일 ${fileNo}
						${appConfig.getAttachmentFileExtTypeDisplayName('article', i)}</th>
					<td>
						<div class="form-control-box">
							<input type="file"
								accept="${appConfig.getAttachemntFileInputAccept('article', i)}"
								name="file__article__${article.id}__common__attachment__${fileNo}">
						</div> <c:if test="${file != null && file.fileExtTypeCode == 'video'}">
							<div class="video-box">
								<video controls
									src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}">
								</video>
							</div>
						</c:if> <c:if test="${file != null && file.fileExtTypeCode == 'img'}">
							<div class="img-box img-box-auto">
								<img
									src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}">
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>첨부파일 ${fileNo} 삭제</th>
					<td>
						<div class="form-control-box">
							<label><input type="checkbox"
								name="deleteFile__article__${article.id}__common__attachment__${fileNo}"
								value="Y" /> 삭제 </label>
						</div>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<th>등록</th>
				<td>
					<div class="form-control-box">
						<input type="submit" value="등록" class="btn black" />
					</div>
				</td>
			</tr>
			<tr>
				<th>삭제</th>
				<td>
					<div class="form-control-box">
						<button type="button" class="btn black"
							onclick="if( confirm('삭제하시겠습니까?') == false ) return false; location.href='/usr/memo/${boardCode}-doDelete?id=${param.id}' ">삭제</button>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form>



<script>
	/* var tag = "${tagBits}";
	tag = tag.split('#'); */

	function ArticleWriteForm__submit(form) {
		if (isNowLoading()) {
			alert('처리중입니다.');
			return;
		}

		var fileInput1 = form["file__article__" + param.id
				+ "__common__attachment__1"];
		var fileInput2 = form["file__article__" + param.id
				+ "__common__attachment__2"];
		var fileInput3 = form["file__article__" + param.id
				+ "__common__attachment__3"];

		var deleteFileInput1 = form["deleteFile__article__" + param.id
				+ "__common__attachment__1"];
		var deleteFileInput2 = form["deleteFile__article__" + param.id
				+ "__common__attachment__2"];
		var deleteFileInput3 = form["deleteFile__article__" + param.id
				+ "__common__attachment__3"];

		if (fileInput1 && deleteFileInput1) {
			if (deleteFileInput1.checked) {
				fileInput1.value = '';
			}
		}

		if (fileInput2 && deleteFileInput2) {
			if (deleteFileInput2.checked) {
				fileInput2.value = '';
			}
		}

		if (fileInput3 && deleteFileInput3) {
			if (deleteFileInput3.checked) {
				fileInput3.value = '';
			}
		}

		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}

		var bodyEditor = $(form).find('.toast-editor.input-body').data(
				'data-toast-editor');

		var body = bodyEditor.getMarkdown().trim();

		if (body.length == 0) {
			alert('내용을 입력해주세요.');
			bodyEditor.focus();
			return;
		}

		form.body.value = body;

		form.tag.value = form.tag.value.trim();
		form.tag.value = form.tag.value.replaceAll('-', '');
		form.tag.value = form.tag.value.replaceAll('_', '');
		form.tag.value = form.tag.value.replaceAll(' ', '');

		// 자바스크립트 특수 문자 일치 정규식
		var temp = form.tag.value;
		var count = (temp.match(/#/g) || []).length;

		var textCount = temp.split('#');
		textCount = textCount - 1;

		console.log(textCount);
		if (count > 10) {
			alert('해시태그를 10개 이하로 입력해주세요.');
			form.tag.focus();
			return;
		}

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 // 50MB 

		if (fileInput1 && fileInput1.value) {
			if (fileInput1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (fileInput2 && fileInput2.value) {
			if (fileInput2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (fileInput3 && fileInput3.value) {
			if (fileInput3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		// 실행순서 1번 
		// ★ 만약 needToUpload == false라면 다음꺼를 바로 실행시키고 꺼버린다.

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;
			if (!needToUpload) {
				needToUpload = fileInput1 && fileInput1.value.length > 0;
			}
			if (!needToUpload) {
				needToUpload = deleteFileInput1 && deleteFileInput1.checked;
			}
			if (!needToUpload) {
				needToUpload = fileInput2 && fileInput2.value.length > 0;
			}
			if (!needToUpload) {
				needToUpload = deleteFileInput2 && deleteFileInput2.checked;
			}
			if (!needToUpload) {
				needToUpload = fileInput3 && fileInput3.value.length > 0;
			}
			if (!needToUpload) {
				needToUpload = deleteFileInput3 && deleteFileInput3.checked;
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

			if (bodyEditor.inBodyFileIdsStr) {
				form.fileIdsStr.value += bodyEditor.inBodyFileIdsStr;
			}

			if (fileInput1) {
				fileInput1.value = '';
			}

			if (fileInput2) {
				fileInput2.value = '';
			}

			if (fileInput3) {
				fileInput3.value = '';
			}

			form.submit();
		});
		/* 
		 맨처음 실행되는 것은 startUploadFiles 함수이다.
		 위의 함수를 실행하면 옆에 function이 실행되는게 아니라 
		 실행순서 1번의 var startUploadFiles = ~~~ { 이게 실행된다. ! }
		 */
	}
</script>

<style>
.table-box {
	margin-top: 50px;
}

.table-box table th {
	text-align: center;
}

.table-box {
	border: 5px solid black;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}

.table-box .form-control-box .img-box img {
	width: 30px;
}
</style>







<%@ include file="../part/foot.jspf"%>