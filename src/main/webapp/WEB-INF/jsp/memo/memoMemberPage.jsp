<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<h1 class="con " style="text-align: right;">
	<strong style="color: red;">${member.nickname}</strong>&nbsp;Memo
</h1>
<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down">
	<button type="button" class="btn black"
		onclick="location.href='../article/${boardCode}-write'">메모 작성</button>
</div>
<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
	<button type="button" class="btn black"
		onclick="location.href='../article/${boardCode}-write'">메모 작성</button>
</div>
<%-- <div class="con margin-top-20 flex flex-jc-fe border-red-1">
	<button type="button"
		onclick="location.href='../memo/${boardCode}-makeMemoCate'">메모
		폴더 생성</button>
</div> --%>
<div class="memo-table-box con flex flex-jc-sb flex-wrap">
	<c:forEach items="${articles}" var="article">
		<div class="memo-box  flex flex-jc-sa "
			onclick="location.href='${article.getDetailLink(board.code)}'">
			<table>
				<colgroup>
					<col width="50" />
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
							<div class="border-title">회원번호${member.id},
								게시물회원번호${article.memberId}</div>
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
						<td><div class="body-box" style="height: 250px;">${article.body}
								<c:forEach var="i" begin="1" end="3" step="1">
									<c:set var="fileNo" value="${String.valueOf(i)}" />
									<c:set var="file"
										value="${article.extra.file__common__attachment[fileNo]}" />
									<c:if test="${file != null}">
										<c:if test="${file.fileExtTypeCode == 'video'}">
											<div class="video-box">
												<video controls
													src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
											</div>
										</c:if>
										<c:if test="${file.fileExtTypeCode == 'img'}">
											<div class="img-box img-box-auto">
												<img
													src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}"
													alt="" />
											</div>
										</c:if>
									</c:if>
								</c:forEach>
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
	margin-top: 40px;
}

.memo-table-box .memo-box .video-box video, .memo-table-box .memo-box .img-box img
	{
	width: 100%;
}

.memo-table-box .memo-box:hover {
	cursor: pointer;
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