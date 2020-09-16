<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <c:set var="pageTitle" value="게시물 내용" /> --%>
<c:set var="boardCode" value="${boardCode }" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>


<h1 class="con">
	<strong style="color: red;">${boardCode}</strong>게시물 내용
</h1>

<div class="table-box con margin-top-50">
	<table>
		<colgroup>
			<%-- 			<col width="200"/> --%>
			<col class="table-first-col">
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${article.id }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><a
					href="../memo/memberPage-memoList?id=${article.memberId}">${article.extra.writer}</a></td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<%--<td>${article.body}</td> --%>
				<td>
				    <script type="text/x-template">${article.body}</script>
                    <div class="toast-editor toast-editor-viewer"></div>
				</td>
			</tr>
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="file"
					value="${article.extra.file__common__attachment[fileNo]}" />
				<c:if test="${file != null}">
					<tr>
						<th>첨부파일 ${fileNo}</th>
						<td><c:if test="${file.fileExtTypeCode == 'video'}">
								<div class="video-box">
									<video controls
										src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
								</div>
							</c:if> <c:if test="${file.fileExtTypeCode == 'img'}">
								<div class="img-box img-box-auto">
									<img
										src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}"
										alt="" />
								</div>
							</c:if></td>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<th>태그</th>
				<td><c:forEach items="${hashtags}" var="hashtag">
				#<strong><a href="#">${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
					</c:forEach></td>
			</tr>
		</tbody>
	</table>
</div>

<div class="con margin-top-20 margin-bottom-20 button-box">
	<button type="button" class="btn black" onclick="location.href=	'${listUrl}'">List</button>
	<c:if test="${fn:contains(boardCode, 'memo') }">
		<button type="button" class="btn black"
			onclick="location.href='../memo/${boardCode}-fork?id=${param.id}'">Fork</button>
	</c:if>

	<c:if test="${fn:contains(boardCode, 'memo') == false && article.extra.memberCanModify}">
		<button type="button" class="btn black"
			onclick="location.href='../article/${boardCode}-modify?id=${param.id}'">Modify</button>
	</c:if>
</div>
<style>
.table-box {
	
}

.table-box table th {
	text-align: center;
}

.btn {
	padding: 0 25px;
	font-size: 1rem;
}
</style>




<%@ include file="../part/foot.jspf"%>