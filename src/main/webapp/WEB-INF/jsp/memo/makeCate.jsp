<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메모 폴더 생성" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<form action="${boardCode }-doMakeMemoCate" method="POST" class="table-box con form1"
	onsubmit="MakeMemoCateForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="../memo/${boardCode }-memoList" />
	<input type="hidden" name="id" value="${loginedMemberId }"/>
	<table>
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>폴더명</th>
				<td>
					<div class="form-control-box">
						<input type="text" name="name" placeholder="폴더명을 입력해주세요." maxlength="30" autofocus />
					</div>
				</td>
			</tr>
				<tr>
				<th>생성</th>
				<td><input type="submit" value="생성" /> 
				</td>
			</tr>
		</tbody>
	</table>
</form>





<script>


function MakeMemoCateForm__submit(form) {

	
	if (isNowLoading()) {
		alert('처리중입니다.');
		return;
	}

	form.name.value = form.loginId.value.trim();
	form.name.value = form.loginId.value.replaceAll('-', '');
	form.name.value = form.loginId.value.replaceAll('_', '');
	form.name.value = form.loginId.value.replaceAll(' ', '');
	alert(form.loginId.value);

	
	if ( form.name.value.length == 0 ) {
		alert('폴더명을 입력해주세요.');
		return;
		form.name.focus();
	}


	if ( form.name.value.length < 4 || form.name.value.length > 12 ) {
		alert('폴더명을 4~12자까지 입력해주세요.');
		form.name.focus();
		return;
	}

	form.submit();
	startLoading();	
}		

	



</script>




<%@ include file="../part/foot.jspf"%>