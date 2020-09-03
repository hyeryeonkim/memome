<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<c:if test="${boardCode eq 'notice' }">
	<h1 class="con "><strong style="color:orange;">${boardCode}</strong>게시판</h1>
</c:if>
<c:if test="${boardCode eq 'free' }">
	<h1 class="con "><strong style="color:gold;">${boardCode}</strong>게시판</h1>
</c:if>



<div class="con margin-top-50 flex flex-jc-fe">
	<button type="button" class="btn black" onclick="location.href='../article/${boardCode}-write'">글쓰기</button>
</div>
<div class="table-box con margin-top-10">
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





<%@ include file="../part/foot.jspf"%>