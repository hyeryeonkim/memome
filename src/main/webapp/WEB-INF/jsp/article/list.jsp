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
	<div class="search con flex flex-jc-fe padding-10-0">
		<div class="search-box ">
			<!-- method="get"은 생략 가능하다. 무엇인지 찾아보기. method="get"-->
			<form action="../article/${boardCode}-list" class="flex">
				<input type="hidden" name="page" value="1" />
				<!-- 검색하면 page를 모두 0으로 초기화해야 하니까..? -->
				<input type="hidden" name="searchKeywordType" value="tag" />
				<input type="hidden" name="boardCode" value="${boardCode}"/>
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
<div class="con" style="font-size:1.2rem;">총 게시물 수 : ${totalCount}</div>
<div class="table-box con margin-top-10">
	<table >
		<colgroup>
			<col width="80" />
			<col width="200"  />
			<col width="100"  />
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
</div>
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

.table-box {
	/* border:10px solid blue; */
	height:600px;
}

.page-box {
	/* border:10px solid red; */
	margin-bottom:100px;
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
	margin-top:5px;
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





@media ( max-width :800px ) {
	/* PC버전 memo 테이블 관련 */
	h1 {
		text-align:center;
	}
}
</style>



<%@ include file="../part/foot.jspf"%>