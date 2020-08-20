<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<h1 class="con"><strong style="color:red;">${boardCode}</strong>게시판<strong style="color:blue;"> 글쓰기</strong></h1>

<form method="POST" action="${boardCode}-doWrite" class="form1 table-box con"
		onsubmit="ArticleWriteForm__submit(this); return false;">
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

	form.submit();
	ArticleWriteForm__submitDone = true;
}
</script>







<%@ include file="../part/foot.jspf"%>