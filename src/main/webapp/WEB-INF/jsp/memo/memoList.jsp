<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>


<c:if test="${board.code eq 'memoYOU'}">
	<h1 class="con">
		<strong style="color: green">${board.code}</strong> 모두의 메모장
	</h1>
</c:if>
<c:if test="${board.code eq 'memoME'}">
	<h1 class="con">
		<strong style="color: blue">${board.code}</strong> 나만의 메모장
	</h1>
</c:if>

<div class="con margin-top-50 flex flex-jc-fe">
	<button type="button" class="btn black"
		onclick="location.href='../article/${boardCode}-write'">MEMO</button>
<%-- 	<a href="../article/${boardCode}-write" class="btn black">MEMO</a> --%>
</div>
<%-- <div class="con margin-top-20 flex flex-jc-fe border-red-1">
	<button type="button"
		onclick="location.href='../memo/${boardCode}-makeMemoCate'">메모
		폴더 생성</button>
</div> --%>
<div class="memo-table-box con flex flex-jc-sb flex-wrap">
	<c:forEach items="${articles}" var="article">
		<div class="memo-box  flex flex-jc-sa "
			onclick="location.href='${article.getDetailLink(board.code)}'"">

			<table>
				<colgroup>
					<col width="48" />
					<col width="200" />
				</colgroup>
				<tbody>
					<%-- <tr>
						<th>작성자</th>
						<td><a href="../memo/${article.extra.writer}-memoMemberPage?id=${article.memberId}">${article.extra.writer}</a></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${article.updateDate}</td>
					</tr> --%>
					<tr class="title">
						<th>제목</th>
						<td>${article.title}
							<div class="border-title"></div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th></th>
						<td></td>
					</tr>
					<tr class="body-tr">
						<th>메모</th>
						<td><div class="body-box" style="height: 250px;">${article.body}<c:if
									test="${article.extra.file__common__attachment['1'] != null}">
									<div class="img-box">
										<img
											src="/usr/file/showImg?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"
											alt="image not supported" />
									</div>
								</c:if>
							</div></td>
					</tr>
					<tr>
						<th></th>
					</tr>

					<tr>
						<th>태그</th>
						<td><c:forEach items="${hashtags}" var="hashtag">
								<c:if test="${article.id == hashtag.relId }">
									<strong style="font-size: 0.8rem;"><a href="#">#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
								</c:if>
							</c:forEach></td>
					</tr>
				</tbody>
			</table>

		</div>
	</c:forEach>
</div>



<style>
table {
	border-collapse: collapse;
}

html>body .memo-table-box .memo-box {
	overflow: hidden;
}

.memo-table-box .memo-box {
	padding-top: 20px;
	margin-top:40px;
	
}

.memo-table-box .memo-box th {
	text-align: center;
}

.memo-table-box  .memo-box  tr:nth-child(2) th {
	padding: 5px;
}

.memo-table-box  .memo-box  tr:nth-child(3) {
	border: 2px solid black;
	width: 400px;
}

.memo-table-box  .memo-box  tr:nth-child(4) th {
	padding: 20px;
}

.memo-table-box  .memo-box  tr:nth-child(5) th {
	vertical-align: top;
}

.memo-table-box  .memo-box  tr:nth-child(5) td {
	vertical-align: top;
}

.memo-table-box .memo-box th, .memo-table-box .memo-box td {
	border: none;
}

.memo-table-box .memo-box td img {
	width: 100%;
}

html>body .memo-table-box .memo-box td {
	backtground-color: red;
	overflow: auto;
}
</style>



<%@ include file="../part/foot.jspf"%>