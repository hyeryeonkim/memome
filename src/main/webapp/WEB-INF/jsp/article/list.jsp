<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>

<c:if test="${boardCode eq 'notice' }">
	<h1 class="con ">
		<strong style="color: orange;">${boardCode}</strong>게시판
	</h1>
</c:if>
<c:if test="${boardCode eq 'free' }">
	<h1 class="con ">
		<strong style="color: gold;">${boardCode}</strong>게시판
	</h1>
</c:if>

<c:if test="${boardCode eq 'free' }">
	<div class="free-top-bar con">
		<h1>Story</h1>
		<h2>메모미의 다양한 이야기들을 만나보세요</h2>
	</div>
</c:if>

<style>
.free-top-bar {
	position: absolute;
	top: 130px;
	right: 15%; 
	text-align: right; 
	
}
</style>



<c:if test="${member.id eq 1 && boardCode eq 'notice' }">
	<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
		<button type="button" class="btn black  "
			onclick="location.href='../article/${boardCode}-write'">글쓰기</button>
	</div>
	<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down">
		<button type="button" class="btn black  "
			onclick="location.href='../article/${boardCode}-write'">글쓰기</button>
	</div>
</c:if>
<c:if test="${boardCode eq 'notice' == false }">
	<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
		<button type="button" class="btn black  "
			onclick="location.href='../article/${boardCode}-write'">글쓰기</button>
	</div>
	<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down">
		<button type="button" class="btn black  "
			onclick="location.href='../article/${boardCode}-write'">글쓰기</button>
	</div>
</c:if>

<c:if test="${boardCode eq 'memberPage' == false }">
	<c:if test="${boardCode eq 'notice' }">
		<script>
			$(document).ready(function() {
				$('.search').addClass('margin-top-105');
			});
		</script>
	</c:if>
	<c:if test="${boardCode eq 'notice' && loginedMemberId == 1}">
		<script>
			$(document).ready(function() {
				$('.search').removeClass('margin-top-105');
			});
		</script>
	</c:if>

	<div class="search con flex flex-jc-fe padding-10-0">
		<div class="search-box ">
			<!-- method="get"은 생략 가능하다. 무엇인지 찾아보기. method="get"-->
			<form action="../article/${boardCode}-list" class="flex">
				<input type="hidden" name="page" value="1" />
				<!-- 검색하면 page를 모두 0으로 초기화해야 하니까..? -->
				<input type="hidden" name="searchKeywordType" value="tag" /> <input
					type="hidden" name="boardCode" value="${boardCode}" />
				<div class="tag-box flex flex-jc-sb">
					<input type="text" name="searchKeyword"
						placeholder="검색할 태그를 입력해주세요." value="${param.searchKeyword}"
						class="box" />
					<button type="submit" class="search-button btn black">
						<i style="font-size: 1.2rem;" class="fas fa-search"></i>
					</button>
				</div>
			</form>
		</div>
	</div>
</c:if>

<div class="con" style="font-size: 1.2rem;">총 게시물 수 :
	${totalCount}</div>
<div class="memo-table-list con  ">
		<c:forEach items="${articles}" var="article">
			<c:if test="${article.memberId == loginedMemberId  }">
				<div class="memo-table-list-box "
					onclick="location.href='../memo/${boardCode}-memoModify?id=${article.id}&mode=${param.mode }'">
					<div class="contents-box">
						<div class="title">${article.title }</div>
						<div class="body">
							<c:forEach items="${hashtags}" var="hashtag">
								<c:if test="${article.id == hashtag.relId }">
									<strong><a
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }">
											#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
								</c:if>
							</c:forEach>
						</div>
						<div class="writer-box">
							<div class="writer">${article.extra.writer}</div>
							<div class="regDate">${article.regDate }</div>
						</div>
					</div>
					<div class="file-box">
						<c:set var="fileNo" value="${String.valueOf(3)}" />
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
					</div>
				</div>
			</c:if>
		</c:forEach>
		<c:forEach items="${articles}" var="article">
			<c:if test="${article.memberId != loginedMemberId }">
				<div class="memo-table-list-box"
					onclick="location.href='${article.getDetailLink(board.code)}&memberId=${article.memberId }&mode=${param.mode }'">
					<div class="contents-box">
						<div class="title">${article.title }</div>
						<div class="body">
							<c:forEach items="${hashtags}" var="hashtag">
								<c:if test="${article.id == hashtag.relId }">
									<strong><a
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }">
											#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
								</c:if>
							</c:forEach>
						</div>
						<div class="writer-box">
							<div class="writer">${article.extra.writer}</div>
							<div class="regDate">${article.regDate }</div>
						</div>
					</div>
					<div class="file-box">
						<c:set var="fileNo" value="${String.valueOf(3)}" />
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
					</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
<%-- <div class="table-box con margin-top-10">
	<table>
		<colgroup>
			<col width="80" />
			<col width="200" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>작성자</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>${article.regDate}</td>
					<td>${article.extra.writer}</td>
					<td><a href="${article.getDetailLink(board.code)}">${article.title}</a>
					</td>

				</tr>
			</c:forEach>
		</tbody>
	</table>
</div> --%>
<div class="con page-box ">
	<ul class="flex flex-jc-c">
		<c:forEach var="i" begin="1" end="${totalPage}" step="1">
			<li class="${i == cPage ? 'current' : ''}"><a
				href="?searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}"
				class="block">${i}</a></li>
		</c:forEach>
	</ul>

</div>


<style>
.memo-table-list {
}

.table-box {
	/* border:5px solid red; */
	
}

.table-box table {
	border: 5px solid black;
}

.page-box {
	/* border:10px solid red; */
	margin-bottom: 100px;
	margin-top:100px;
}

input[type="submit"] {
	font-family: FontAwesome;
}

.search .search-box button {
	padding: 0 20px;
}

.search .search-box form .tag-box {
	padding: 10px 0;
	width: 240px;
	font-size: 1.5rem;
}

.search .search-box form .tag-box input {
	padding: 5px;
	margin-top: 5px;
	border: 1px solid black;
}

.page-box>ul>li>a {
	padding: 0 10px;
	text-decoration: underline;
	color: #787878;
}

.page-box>ul>li:hover>a {
	color: black;
}

.page-box>ul>li.current>a {
	color: red;
}

.table-box>table th, .table-box>table td {
	border: 1px solid black;
	padding: 10px;
	text-align: center;
}




.memo-table-list .memo-table-list-box .file-box {
	height: 100%;
	width: 20%;
}

.memo-table-list .memo-table-list-box {
	/* border: 3px solid red; */
	height: 160px;
	display: flex;
	padding-bottom: 10px;
	border-bottom: 3px solid black;
	margin-top: 20px;
}

.memo-table-list .memo-table-list-box:hover {
	cursor: pointer;
}

.memo-table-list .memo-table-list-box:first-child {
	margin-top: 50px;
}

.memo-table-list .memo-table-list-box .contents-box {
	/* border: 3px solid blue; */
	height: 100%;
	width: 80%;
}

.memo-table-list .memo-table-list-box .contents-box .title {
	/* border: 3px solid gold; */
	height: 60px;
	width: 100%;
	font-size: 2.5rem;
}

/* body를 태그로 바꿔서 사용중....  */
.memo-table-list .memo-table-list-box .contents-box .body {
	/* border: 3px solid orange; */
	height: 50px;
	width: 100%;
	font-size: 1.2rem;
	opacity: 0.7;
}

.memo-table-list .memo-table-list-box .writer-box {
	/* border: 3px solid black; */
	height: 30px;
	display: flex;
	margin-top: 20px;
}

.memo-table-list .memo-table-list-box .writer-box .writer, .regDate {
	/* border: 3px solid green; */
	width: 200px;
	height: 30px;
	text-align: left;
}


@media ( max-width :800px ) {
	/* PC버전 memo 테이블 관련 */
	h1 {
		text-align: center;
	}
}
</style>



<%@ include file="../part/foot.jspf"%>