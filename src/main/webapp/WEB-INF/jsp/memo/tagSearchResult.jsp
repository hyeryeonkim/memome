<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>


<c:if test="${board.code eq 'memoYOU'}">
	<h1 class="con">
		<strong style="color: green">${board.code}</strong> 태그 검색 결과
	</h1>
</c:if>
<c:if test="${board.code eq 'memoME'}">
	<h1 class="con">
		<strong style="color: blue">${board.code}</strong> 태그 검색 결과
	</h1>
</c:if>
<c:if test="${board.code eq 'memberPage'}">
	<h1 class="con">
		<strong style="color: gold">이웃 <strong style="color: skyblue">
				${member.nickname }</strong>
		</strong> 태그 검색 결과
	</h1>
</c:if>



<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down ">
	<button type="button" class="btn black"
		onclick="history.back();">BACK</button>
</div>
<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
	<button type="button" class="btn black"
		onclick="history.back();">BACK</button>
</div>
<%-- <div class="con margin-top-20 flex flex-jc-fe border-red-1">
	<button type="button"
		onclick="location.href='../memo/${boardCode}-makeMemoCate'">메모
		폴더 생성</button>
</div> --%>
<script>
	
</script>


<div class="memo-table-box con flex flex-jc-sb flex-wrap">
	<c:forEach items="${articles}" var="article">
		<c:if test="${article.memberId == loginedMemberId}">
			<div class="memo-box  flex flex-jc-sa "
				onclick="location.href='../memo/${boardCode}-memoModify?id=${article.id}'">
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
										<strong style="font-size: 0.8rem;"> <c:if
												test="${board.code ne 'memberPage' }">
												<a
													href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }">
													#${hashtag.tag}</a>
											</c:if> <c:if test="${board.code eq 'memberPage'  }">
												<a
													href="../memo/${boardCode}-tagSearchResult?id=${param.id }&searchKeywordType=tag&searchKeyword=${hashtag.tag }">
													#${hashtag.tag}</a>
											</c:if> &nbsp;&nbsp;&nbsp;&nbsp;
										</strong>
									</c:if>
								</c:forEach></td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:if>
		<c:if test="${article.memberId != loginedMemberId}">
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
										<strong style="font-size: 0.8rem;"> <c:if
												test="${board.code ne 'memberPage' }">
												<a
													href="../memo/${board.code}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }">
													#${hashtag.tag}</a>
											</c:if> <c:if test="${board.code eq 'memberPage'  }">
												<a
													href="../memo/${board.code}-tagSearchResult?id=${param.id }&searchKeywordType=tag&searchKeyword=${hashtag.tag }">
													#${hashtag.tag}</a>
											</c:if> &nbsp;&nbsp;&nbsp;&nbsp;
										</strong>
									</c:if>
								</c:forEach></td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:if>
	</c:forEach>
</div>



<style>
input[type="submit"] {
	font-family: FontAwesome;
}

.search .search-box button {
	padding: 0 20px;
}

.search .search-box form .tag-box {
	padding: 10px 0;
	width: 280px;
	font-size: 1.5rem;
}

.search .search-box form .tag-box input {
	padding: 5px;
	border: 1px solid black;
}

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