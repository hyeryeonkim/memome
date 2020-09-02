<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="게시물 내용" /> --%>
<%@ include file="../part/head.jspf"%>

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
				<td>${article.extra.writer}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.body}</td>
			</tr>
			<c:if test="${article.extra.file__common__attachment['1'] != null}">
				<tr>
					<th>첨부 파일 1</th>
					<td>
						<div class="img-box">
							<img
								src="/usr/file/showImg?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"
								alt="image not supported" />
						</div>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>태그</th>
				<td><c:forEach items="${hashtags}" var="hashtag">
				#<strong><a href="#">${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong></c:forEach></td>
			</tr>
		</tbody>
	</table>
</div>

<div class="con margin-top-20 margin-bottom-20">
	<button type="button"
		onclick="location.href='../article/${boardCode}-list'">목록</button>
</div>




<%@ include file="../part/foot.jspf"%>