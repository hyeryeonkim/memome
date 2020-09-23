<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>








<c:if test="${board.code eq 'unicon'}">
	<h1 class="con">
		<strong style="color: blue">${board.code}</strong> 특★한 메모장
	</h1>
</c:if>
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

<c:if test="${board.code eq 'memberPage'}">
	<h1 class="con">
		<strong style="color: orange">이웃 <strong style="color: green">MEMO</strong>${member.nickname}</strong>
	</h1>
</c:if>




<c:if test="${isLogined}">
	<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down ">
		<button type="button" class="btn black"
			onclick="location.href='../article/${boardCode}-write'">MEMO</button>
	</div>
	<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
		<button type="button" class="btn black"
			onclick="location.href='../article/${boardCode}-write'">MEMO</button>
	</div>
</c:if>
<%-- <div class="con margin-top-20 flex flex-jc-fe border-red-1">
	<button type="button"
		onclick="location.href='../memo/${boardCode}-makeMemoCate'">메모
		폴더 생성</button>
</div> --%>
<script>
	
</script>
<c:if test="${boardCode eq 'memberPage' == false && isLogined}">
	<div class="search con flex flex-jc-fe padding-10-0">
		<div class="search-box ">
			<!-- method="get"은 생략 가능하다. 무엇인지 찾아보기. method="get"-->
			<form action="../memo/${boardCode}-tagSearchResult" class="flex">
				<input type="hidden" name="page" value="1" />
				<!-- 검색하면 page를 모두 0으로 초기화해야 하니까..? -->
				<input type="hidden" name="searchKeywordType" value="tag" />
				<div class="tag-box flex flex-jc-sb">
					<input type="text" name="searchKeyword"
						placeholder="검색할 태그를 입력해주세요." value="${param.searchKeyword}"
						class="box" />
					<button type="submit" class="search-button btn black">
						<i style="font-size: 1.2rem;" class="fas fa-search"></i>
					</button>
				</div>
			</form>
			<!-- <script>
					form.searchKeyword.value = '';
				</script> -->
		</div>
	</div>
</c:if>

<c:if test="${boardCode eq 'memberPage' && isLogined}">
	<div class="search con flex flex-jc-fe padding-10-0">
		<div class="search-box ">
			<!-- method="get"은 생략 가능하다. 무엇인지 찾아보기. method="get"-->
			<form action="../memo/${boardCode}-tagSearchResult" class="flex">
				<!-- <input type="hidden" name="page" value="1" /> -->
				<!-- 검색하면 page를 모두 0으로 초기화해야 하니까..? -->
				<input type="hidden" name="id" value="${param.id}" /> <input
					type="hidden" name="searchKeywordType" value="tag" />
				<div class="tag-box flex flex-jc-sb">
					<input type="text" name="searchKeyword" placeholder="검색할 태그 입력"
						value="${param.searchKeyword}" class="box" />
					<button type="submit" class="search-button btn black">
						<i style="font-size: 1.2rem;" class="fas fa-search"></i>
					</button>
				</div>
			</form>
		</div>
	</div>
</c:if>


<c:if test="${isLogined == false && boardCode eq 'memoYOU'}">
<div class="con" style="font-size:1.2rem;">총 게시물 수 : ${totalCount}</div>
</c:if>
<c:if test="${isLogined && totalCount != 0}">
<div class="con" style="font-size:1.2rem;">총 게시물 수 : ${totalCount}</div>
</c:if>



<c:if test="${isLogined == false && board.code eq 'unicon'}">
	<div class="unicon-intro-box con">
		<div class="unicon-title">소중한 지인들과 소소한 추억을 쌓아보세요.</div>
		<div class="unicon-serve-title">메모를 공개하고 싶은 지인을 초대해서 메모를 공유해보세요.</div>
		<div class="unicon-serve-title2">UNICON에 작성한 메모는 모두에게 공개되지 않습니다.</div>
		<div class="unicon-login">
			<button type="button" class="btn black"
				onclick="location.href='/usr/member/login'">로그인이동</button>
		</div>
	</div>
</c:if>


<c:if test="${totalCount == 0 && boardCode eq 'unicon' && isLogined }">
	<div class="unicon-login-intro-box con">
		<div class="unicon-login-title">아직 작성하신 UNICON이 없으시네요.</div>
		<div class="unicon-login-title margin-top-50">소중한 지인들과 소소한 추억을 쌓아보세요.</div>
		<div class="unicon-login-serve-title">메모를 공개하고 싶은 지인을 초대해서 메모를
			공유해보세요.</div>
		<div class="unicon-login-serve-title2">UNICON에 작성하신 메모는 초대한 지인 외에는 공개되지
			않습니다.</div>
	</div>
</c:if>


<c:if test="${totalCount == 0 && boardCode eq 'unicon' == false && boardCode eq 'memoME'}">
	<div class="unicon-login-intro-box con">
		<div class="unicon-login-title">아직 작성하신 MEMO가 없으시네요.</div>
		<div class="unicon-login-title margin-top-50">나만의 메모를 작성해서 잊지 못할 순간들을 기록해보세요.</div>
	</div>
</c:if>






<div class="memo-table-box con flex flex-wrap flex-row">
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
							<th>Date</th>
				<%-- 회원번호${member.id},	게시물회원번호${article.memberId} --%>
							<td>${article.updateDate}
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
							<td>
								<div class=" body-box " style="height: 250px;">
									<%-- <c:if test="${article.delStatus eq 1}">
									<h1>삭제된 메모입니다.</h1>
									</c:if> --%>
									<script type="text/x-template">${article.body}</script>
									<div class="toast-editor toast-editor-viewer"></div>
									<%-- 								<div class="body-box" style="height: 250px;">${article.body} --%>
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
								</div>
							</td>
						</tr>
						<tr>
							<th></th>
						</tr>

						<tr>
							<th>태그</th>
							<td><c:forEach items="${hashtags}" var="hashtag">
									<c:if test="${article.id == hashtag.relId }">
										<strong style="font-size: 0.8rem;"><a
											href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }">
												#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
									</c:if>
								</c:forEach></td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:if>
		<c:if test="${article.memberId != loginedMemberId}">
			<div class="memo-box  flex flex-jc-sa "
				onclick="location.href='${article.getDetailLink(board.code)}&memberId=${article.memberId }'">
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
							<th>Date</th>
							<%-- 회원번호${member.id},
									게시물회원번호${article.memberId} --%>
							<td>${article.updateDate}
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
							<td>
								<div class=" body-box " style="height: 250px;">
									<script type="text/x-template">${article.body}</script>
									<div class="toast-editor toast-editor-viewer"></div>
									<%-- 								<div class="body-box" style="height: 250px;">${article.body} --%>
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
								</div>
							</td>
						</tr>
						<tr>
							<th></th>
						</tr>

						<tr>
							<th>태그</th>
							<td><c:forEach items="${hashtags}" var="hashtag">
									<c:if test="${article.id == hashtag.relId }">
										<strong style="font-size: 0.8rem;"> <c:if
												test="${board.code eq 'memberPage' }">
												<a
													href="../memo/${board.code}-tagSearchResult?id=${member.id}&searchKeywordType=tag&searchKeyword=${hashtag.tag }">
													#${hashtag.tag}</a>
											</c:if> <c:if test="${board.code eq 'memberPage' == false }">
												<a
													href="../memo/${board.code}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }">
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
<%-- <c:if test="${isLogined}"> --%>
	<c:if test="${boardCode eq 'memberPage' == false }">
		<div class="con page-box">
			<ul class="flex flex-jc-c">
				<c:forEach var="i" begin="1" end="${totalPage}" step="1">
					<li class="${i == cPage ? 'current' : ''}"><a
						href="?searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}"
						class="block">${i}</a></li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<c:if test="${boardCode eq 'memberPage' }">
		<div class="con page-box">
			<ul class="flex flex-jc-c">
				<c:forEach var="i" begin="1" end="${totalPage}" step="1">
					<li class="${i == cPage ? 'current' : ''}"><a
						href="?searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}&id=${param.id}"
						class="block">${i}</a></li>
				</c:forEach>
			</ul>
		</div>
	</c:if>



<style>
.unicon-intro-box {
	margin-top: 100px;
	text-align: center;
	text-align: center;
}

.unicon-intro-box .unicon-title {
	font-size: 2.4rem;
	font-weight: bold;
}

.unicon-intro-box .unicon-serve-title {
	margin-top: 50px;
	font-size: 1.7rem;
	font-weight: bold;
}

.unicon-intro-box .unicon-serve-title2 {
	margin-top: 50px;
	font-size: 1.3rem;
	font-weight: bold;
}

.unicon-intro-box .unicon-login {
	margin-top: 100px;
}

.unicon-intro-box .unicon-login .btn {
	width: 300px;
}

/* 로그인 후 UNICON __ 게시물 0개일때 시작  */
.unicon-login-intro-box {
	text-align: center;
	margin-bottom:200px;
}

.unicon-login-intro-box .unicon-login-title {
	font-size: 2.4rem;
	font-weight: bold;
}

.unicon-login-intro-box .unicon-login-serve-title {
	margin-top: 50px;
	font-size: 1.7rem;
	font-weight: bold;
}

.unicon-login-intro-box .unicon-login-serve-title2 {
	margin-top: 50px;
	font-size: 1.3rem;
	font-weight: bold;
}

/* 로그인 후 UNICON __ 게시물 0개일때 끝 */

.page-box {
	margin-bottom:100px;
	margin-top:50px;
}



.page-box>ul>li>a {
	padding: 0 10px;
	text-decoration: underline;
	color: #787878;
	margin-bottom:30px;	
}

.page-box>ul>li:hover>a {
	color: black;
}

.page-box>ul>li.current>a {
	color: red;
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

table {
	border-collapse: collapse;
	
}

.memo-table-box {
}


html>body .memo-table-box .memo-box {
	overflow: hidden;
	
}

.memo-table-box .memo-box {
	padding-top: 20px;
	margin-top: 40px;
	margin-left: 65px;
	margin-rigth: 85px;
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
	overflow: auto;
}


@media ( max-width :800px ) {
	/* PC버전 memo 테이블 관련 */
	.memo-table-box .memo-box {
		border: 7px solid black;
		width: 350px;
		height: 400px;
		/* margin: 10px 0; */
		margin-left:auto;
		margin-right:auto;
		margin-top:5px;
	}
	h1 {
		text-align:center;
	}
}


</style>



<%@ include file="../part/foot.jspf"%>