<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<h1 class="con"><strong style="color:red;">${boardCode}</strong>게시판</h1>

<div class="table-box con">
	<table>
		<colgroup>
			<col class="table-first-col"/>
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>
						${article.regDate}
					</td>
					<td>
					<a href="${article.getDetailLink(board.code)}">${article.title}</a>
					</td>	
						<%-- <br />
						작성 : ${article.extra.writer} --%>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="con margin-top-50">
	<button type="button" onclick="location.href='../article/${boardCode}-write'">글쓰기</button>
</div>





<%@ include file="../part/foot.jspf"%>