<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>





<div class="margin-top-300"></div>

<!-- PC 버전 -->
<c:if test="${board.code eq 'unicon'}">
	<h1 class="con visible-on-md-up">
		<strong style="color: orange">${board.code}</strong>
		<div style="font-size: 1.2rem;">특별한 유저에게 단 하나의 메모를 선사해보세요.</div>
	</h1>
</c:if>
<c:if test="${board.code eq 'memoYOU'}">
	<h1 class="con visible-on-md-up" >
		<strong style="color: green">${board.code}</strong>
		<div style="font-size: 1.2rem;">모든 유저의 메모장을 참고해보세요.</div>
	</h1>
</c:if>
<c:if test="${board.code eq 'memoME'}">
	<h1 class="con visible-on-md-up">
		<strong style="color: blue">${board.code}</strong>
		<div style="font-size: 1.2rem;">나만의 메모장을 만들어보세요.</div>
	</h1>
</c:if>

<c:if test="${board.code eq 'memberPage'}">
	<h1 class="con visible-on-md-up">
		<strong style="color: orange">이웃 <strong style="color: green">MEMO</strong>${member.nickname}</strong>
	</h1>
</c:if>

<!-- 모바일 버전 -->
<c:if test="${board.code eq 'unicon'}">
	<h1 class="con visible-on-sm-down">
		<strong style="color: orange">${board.code}</strong>
		<div style="font-size: 1rem;">특별한 유저에게 단 하나의 메모를 선사해보세요.</div>
	</h1>
</c:if>
<c:if test="${board.code eq 'memoYOU'}">
	<h1 class="con visible-on-sm-down">
		<strong style="color: green">${board.code}</strong>
		<div style="font-size: 1rem;">모든 유저의 메모장을 참고해보세요.</div>
	</h1>
</c:if>
<c:if test="${board.code eq 'memoME'}">
	<h1 class="con visible-on-sm-down">
		<strong style="color: blue">${board.code}</strong>
		<div style="font-size: 1rem;">나만의 메모장을 만들어보세요.</div>
	</h1>
</c:if>

<c:if test="${board.code eq 'memberPage'}">
	<h1 class="con visible-on-sm-down">
		<strong style="color: orange">이웃 <strong style="color: green">MEMO</strong><strong style="font-size: 1.3rem;">&nbsp;&nbsp;${member.nickname}</strong></strong>
	</h1>
</c:if>

<style>
.memo-contents-box {
	
}

.memo-contents-box .memo-contents-box-1 {
	width: 300px;
}

.memo-contents-box .memo-contents-box-2 {
	width: 300px;
	height: 100px;
	margin-bottom: 0;
	margin-top: auto;
}

.memo-contents-box .memo-contents-box-2 .total-count {
	margin-bottom: 10px;
}
</style>

<div class="memo-contents-box con flex flex-jc-sb">

	<div class="memo-contents-box-2">
		<c:if test="${isLogined == false && totalCount != 0  }">
			<div class="total-count con">총 게시물 수 : ${totalCount}</div>
		</c:if>
		<c:if test="${isLogined && totalCount != 0  }">
			<div class="total-count  con">총 게시물 수 : ${totalCount}</div>
		</c:if>


		<%-- <c:if test="${totalCount != 0 }"> --%>
			<c:if test="${boardCode ne 'memberPage' && totalCount != 0  }">
				<c:if test="${param.mode eq 'big' || param.mode eq ''}">
					<div class="con from-button">
						<input class="onclick-list-small btn " type="button"
							onclick="click__small();  location.replace('${boardCode}-memoList?mode=small'); "
							value="제목으로" />
					</div>
				</c:if>
				<c:if test="${param.mode eq 'small' && totalCount != 0 }">
					<div class="con from-button">
						<input class="onclick-list-big btn" type="button"
							onclick="click__big(); location.replace('${boardCode}-memoList?mode=big'); "
							value="내용으로" />
					</div>
				</c:if>
			</c:if>
			<c:if test="${boardCode eq 'memberPage' && totalCount != 0 }">
				<c:if test="${param.mode eq 'big' || param.mode eq ''}">
					<div class="con from-button">
						<input class="onclick-list-small btn " type="button"
							onclick="click__small();  location.replace('${boardCode}-memoList?mode=small&id=${param.id }'); "
							value="제목으로" />
					</div>
				</c:if>
				<c:if test="${param.mode eq 'small'&& totalCount != 0 }">
					<div class="con  from-button">
						<input class="onclick-list-big btn" type="button"
							onclick="click__big(); location.replace('${boardCode}-memoList?mode=big&id=${param.id }'); "
							value="내용으로" />
					</div>
				</c:if>
			</c:if>
		<%-- </c:if> --%>
	</div>
	<!-- <div class="memo-color-page">
		<div class="color-box">
			파랑<input id="checkbox_id" type="checkbox" value="1"/>
			노랑<input id="checkbox_id" type="checkbox" value="2"/>
			녹색<input id="checkbox_id" type="checkbox" value="3"/>
		</div>
	</div> -->
	<div class="memo-contents-box-1">
		<c:if test="${isLogined   }">
			<div
				class="con margin-top-50 flex flex-jc-fe visible-on-sm-down mobile-memo-button ">
				<button type="button" class="btn black"
					onclick="location.href='../article/${boardCode}-write?mode=${param.mode }'">MEMO</button>
			</div>
			<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
				<button type="button" class="btn black"
					onclick="location.href='../article/${boardCode}-write?mode=${param.mode }'">MEMO</button>
			</div>
		</c:if>
	<%-- 	<c:if test="${isLogined == false && boardCode eq 'unicon' }">
			<div
				class="con  flex flex-jc-fe visible-on-sm-down mobile-memo-unicon-button">
				<button type="button" class="btn black"
					onclick="location.href='../article/${boardCode}-write?mode=${param.mode }'">MEMO</button>
			</div>
			<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
				<button type="button" class="btn black"
					onclick="location.href='../article/${boardCode}-write?mode=${param.mode }'">MEMO</button>
			</div>
		</c:if> --%>
		<c:if test="${isLogined == false && boardCode ne 'unicon' }">
			<div
				class="con margin-top-50 flex flex-jc-fe visible-on-sm-down mobile-memo-button">
				<button type="button" class="btn black"
					onclick="location.href='../article/${boardCode}-write?mode=${param.mode }'">MEMO</button>
			</div>
			<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
				<button type="button" class="btn black"
					onclick="location.href='../article/${boardCode}-write?mode=${param.mode }'">MEMO</button>
			</div>
		</c:if>
		
		
		<%-- <div class="con margin-top-20 flex flex-jc-fe border-red-1">
	<button type="button"
		onclick="location.href='../memo/${boardCode}-makeMemoCate'">메모
		폴더 생성</button>
</div> --%>


		<c:if test="${boardCode eq 'memberPage' == false && isLogined && totalCount != 0}">
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
								class="box" /> <input type="hidden" name="mode"
								value="${param.mode }" />
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
		<c:if
			test="${boardCode eq 'memberPage' == false && isLogined == false && totalCount != 0 }">
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
								value="${param.searchKeyword}" class="box" /> <input
								type="hidden" name="mode" value="${param.mode }" />
							<button type="submit" class="search-button btn black">
								<i style="font-size: 1.2rem;" class="fas fa-search"></i>
							</button>
						</div>
					</form>
				</div>
			</div>
		</c:if>

		<c:if test="${boardCode eq 'memberPage' && isLogined && totalCount != 0 }">
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
								value="${param.searchKeyword}" class="box" /> <input
								type="hidden" name="mode" value="${param.mode }" />
							<button type="submit" class="search-button btn black">
								<i style="font-size: 1.2rem;" class="fas fa-search"></i>
							</button>
						</div>
					</form>
				</div>
			</div>
		</c:if>
	</div>
</div>

<c:if test="${isLogined == false && board.code eq 'unicon' }">
	<div class="mobile-unicon-intro-box  visible-on-sm-down ">

		<div class="unicon-title">
			소중한 지인들과 <span>소소한 추억</span>을 쌓아보세요.
		</div>
		<div class="unicon-serve-title">메모를 공유하고 싶은 지인을 초대해보세요.</div>
		<div class="unicon-serve-title2">UNICON에 작성한 메모는 모두에게 공개되지 않습니다.</div>
		<div class="unicon-login">
			<button type="button" class="btn black"
				onclick="location.href='/usr/member/login'">로그인이동</button>
		</div>
	</div>
</c:if>




<c:if test="${totalCount == 0 && boardCode eq 'unicon' && isLogined }">
	<div
		class="mobile-unicon-login-intro-box mobile-unicon-login-box visible-on-sm-down ">
		<div class="unicon-login-title1">
			아직 작성하신 <span>UNICON</span>이 없으시네요.
		</div>
		<div class="unicon-login-title2 margin-top-50">
			소중한 지인들과 <span>소소한 추억</span>을 쌓아보세요.
		</div>
		<div class="unicon-login-serve-title1">메모를 공유하고 싶은 지인을 초대해보세요.</div>
		<div class="unicon-login-serve-title2">UNICON에 작성하신 메모는 초대한 지인
			외에는 공개되지 않습니다.</div>
	</div>
</c:if>

<c:if test="${isLogined == false && board.code eq 'unicon'}">
	<div class="unicon-intro-box  visible-on-md-up">
		<div class="unicon-title">
			소중한 지인들과 <span>소소한 추억</span>을 쌓아보세요.
		</div>
		<div class="unicon-serve-title">메모를 공유하고 싶은 지인을 초대해보세요.</div>
		<div class="unicon-serve-title2">UNICON에 작성한 메모는 모두에게 공개되지 않습니다.</div>
		<div class="unicon-login">
			<button type="button" class="btn black"
				onclick="location.href='/usr/member/login'">로그인이동</button>
		</div>
	</div>
</c:if>


<c:if test="${totalCount == 0 && boardCode eq 'unicon' && isLogined }">
	<div class="unicon-login-intro-box unicon-login-box visible-on-md-up">
		<div class="unicon-login-title1">
			아직 작성하신 <span>UNICON</span>이 없으시네요.
		</div>
		<div class="unicon-login-title2 margin-top-50">
			소중한 지인들과 <span>소소한 추억</span>을 쌓아보세요.
		</div>
		<div class="unicon-login-serve-title">메모를 공개하고 싶은 지인을 초대해서 메모를
			공유해보세요.</div>
		<div class="unicon-login-serve-title2">UNICON에 작성하신 메모는 초대한 지인
			외에는 공개되지 않습니다.</div>
	</div>
</c:if>


<c:if
	test="${totalCount == 0 && boardCode eq 'unicon' == false && boardCode eq 'memoME'}">
	<div class="unicon-login-intro-box unicon-intro-box visible-on-md-up">
		<div class="back-img">
			<img src="/resource/img/memo-list.PNG" alt="" />
		</div>
		<div class="unicon-login-title1">아직 작성하신 MEMO가 없으시네요.</div>
		<div class="unicon-login-title2 margin-top-50">나만의 메모를 작성해서 잊지
			못할 순간들을 기록해보세요.</div>
	</div>
</c:if>


<c:if
	test="${totalCount == 0 && boardCode eq 'unicon' == false && boardCode eq 'memoME'}">
	<div class="mobile-unicon-login-box mobile-unicon-intro-box visible-on-sm-down">
		<div class="unicon-login-title1">아직 작성하신 MEMO가 없으시네요.</div>
		<div class="unicon-login-title2 margin-top-50">나만의 메모를 작성해서 잊지
			못할 순간들을 기록해보세요.</div>
	</div>
</c:if>











<script>
	var boardCode = "${boardCode}";

	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
				.exec(location.search);
		return results === null ? "" : decodeURIComponent(results[1].replace(
				/\+/g, " "));
	}

	var sch = location.search;

	var params = new URLSearchParams(sch);

	var sch__keyword = params.get('mode');

	function click__big() {
		//if (getParameterByName("mode") == 'small') {
		$(".memo-table-box").removeClass("memo-table-box-none");
		$(".onclick-list-big").removeClass("onclick-list-big-block");
		$(".onclick-list-small").removeClass("onclick-list-small-none");
		$(".memo-table-list").removeClass("memo-table-list-block");
		//	}

		//}
		//location.replace(boardCode + '-memoList?mode=big');
	};

	function click__small() {
		//		if (getParameterByName("mode") == 'big') {
		$(".memo-table-box").addClass("memo-table-box-none");
		$(".onclick-list-big").addClass("onclick-list-big-block");
		$(".onclick-list-small").addClass("onclick-list-small-none");
		$(".memo-table-list").addClass("memo-table-list-block");
		//params.set('mode', 'small');
		//	}
		//location.replace(boardCode + '-memoList?mode=small');
		//}

	};
</script>
<style>
.memo-table-list {
	/* display: none;
} */ .memo-table-list-block { display:block;
	
}

.onclick-list-big {
	display: none;
}

.memo-table-box-none {
	display: none;
}

.onclick-list-big-block {
	display: block;
}

.onclick-list-small-none {
	display: none;
}

.memo-table-box-block {
	display: block;
}

.onclick-list-small-block {
	display: block;
}

.onclick-list-big-none {
	display: none;
}
</style>




<c:if test="${param.mode eq 'small' }">
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
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode}">
											#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
								</c:if>
							</c:forEach>
						</div>
						<div class="writer-box">
							<div class="writer">${article.extra.writer}</div>
							<div class="regDate">${article.regDate }</div>
						</div>
					</div>
					<div class="file-control-box">
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
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode}">
											#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
								</c:if>
							</c:forEach>
						</div>
						<div class="writer-box">
							<div class="writer">${article.extra.writer}</div>
							<div class="regDate">${article.regDate }</div>
						</div>
					</div>
					<div class="file-control-box">
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
</c:if>





<style>
.memo-table-list .memo-table-list-box .file-control-box {
	height: 100%;
	width: 30%;
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
	margin-top: 30px;
	height: 30px;
	width: 100%;
	font-size: 1.1rem;
	opacity: 0.7;
}

.memo-table-list .memo-table-list-box .writer-box {
	/* border: 3px solid black; */
	height: 30px;
	display: flex;
	margin-top: 20px;
}

.memo-table-list .memo-table-list-box .file-control-box .img-box,
	.memo-table-list .memo-table-list-box .file-control-box .video-box {
	/* border:3px solid blue;  */
	max-width: 100%;
	height: 100%;
	overflow: hidden;
}

.memo-table-list .memo-table-list-box .file-control-box img,
	.memo-table-list .memo-table-list-box .file-control-box video {
	/* object-fit: cover; */
	max-width: 100%;
}

.memo-table-list .memo-table-list-box .writer-box .writer, .regDate {
	/* border: 3px solid green; */
	width: 200px;
	height: 30px;
	text-align: left;
}

@media ( max-width :800px ) {
	.memo-table-list .memo-table-list-box .contents-box .title {
		font-size: 1.6rem;
	}

	/* body를 태그로 바꿔서 사용중....  */
	.memo-table-list .memo-table-list-box .contents-box .body {
		font-size: 1rem;
		opacity: 0.7;
	}
}
</style>





<c:if test="${param.mode eq 'big' || param.mode eq ''}">
	<div class="memo-table-box con flex flex-wrap flex-row ">
		<c:forEach items="${articles}" var="article">
			<c:if test="${article.memberId == loginedMemberId}">
				<div class="memo-box  flex flex-jc-sa "
					onclick="location.href='../memo/${boardCode}-memoModify?id=${article.id}&mode=${param.mode }'">
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
										<script type="text/x-template">${article.getBodyForXTemplate()}</script>
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
												href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode}">
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
					onclick="location.href='${article.getDetailLink(board.code)}&memberId=${article.memberId }&mode=${param.mode }'">
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
										<script type="text/x-template">${article.getBodyForXTemplate()}</script>
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
														href="../memo/${board.code}-tagSearchResult?id=${member.id}&searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode}">
														#${hashtag.tag}</a>
												</c:if> <c:if test="${board.code eq 'memberPage' == false }">
													<a
														href="../memo/${board.code}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode}">
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
</c:if>
<%-- <c:if test="${isLogined}"> --%>
<c:if test="${boardCode eq 'memberPage' == false }">
	<div class="con page-box">
		<ul class="flex flex-jc-c">
			<c:forEach var="i" begin="1" end="${totalPage}" step="1">
				<li class="${i == cPage ? 'current' : ''}"><a
					href="?searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}
					&mode=${param.mode}"
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
					href="?searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}&id=${param.id}&mode=${param.mode}"
					class="block">${i}</a></li>
			</c:forEach>
		</ul>
	</div>
</c:if>



<style>
.total-count {
	font-size: 1.2rem;
}

.memo-table-box .memo-box .img-box img, .memo-table-box .memo-box  .video-box video
	{
	max-width: 100%;
}

.unicon-intro-box {
	margin-top: 40px;
	text-align: center;
	text-align: center;
	width: 100%;
	padding: 50px 0;
	/* background-color:#fff5f5; */
}

.unicon-intro-box .unicon-title {
	font-size: 2.4rem;
	font-weight: bold;
	/* border:3px solid red; */
	opacity: 0.7;
}

.unicon-intro-box .unicon-title:hover {
	opacity: 1;
	cursor: pointer;
}

.unicon-intro-box .unicon-serve-title {
	margin-top: 50px;
	font-size: 1.7rem;
	font-weight: bold;
	/* border:3px solid red; */
	opacity: 0.7;
}

.unicon-intro-box .unicon-serve-title:hover {
	opacity: 1;
	cursor: pointer;
}

.unicon-intro-box .unicon-serve-title2 {
	margin-top: 50px;
	font-size: 1.3rem;
	font-weight: bold;
	/* border:3px solid red; */
	opacity: 0.7;
}

.unicon-intro-box .unicon-serve-title2:hover {
	opacity: 1;
	cursor: pointer;
}

.unicon-intro-box .unicon-login {
	margin-top: 100px;
}

.unicon-intro-box .unicon-login .btn {
	width: 300px;
}

.unicon-login-box {
	margin-top: 40px;
	text-align: center;
	text-align: center;
	width: 100%;
	padding: 50px 0;
	/* background-color: #fff5f5; */
}

/* 로그인 후 UNICON __ 게시물 0개일때 시작  */
.unicon-login-intro-box {
	text-align: center;
	margin-bottom: 200px;
}

.unicon-intro-box {
	margin-top: 40px;
	text-align: center;
	text-align: center;
	width: 100%;
	padding: 50px 0;
	/* background-color:#fff5f5; */
}

.unicon-login-intro-box .back-img img {
	position: absolute;
	width: 100%;
	height: 400px;
	top: 45%;
	left: 0;
	z-index: -1;
}

.unicon-login-intro-box .unicon-login-title1 {
	margin-top: 100px;
	font-size: 2.4rem;
	font-weight: bold;
	opacity: 0.7;
}

.unicon-login-intro-box .unicon-login-title1 span {
	margin-left: 10px;
	margin-right: 10px;
	/* opacity:0; */
}

.unicon-login-intro-box .unicon-login-title1:hover {
	opacity: 1;
	cursor: pointer;
}

.unicon-login-intro-box .unicon-login-title1:hover  span {
	border-bottom: 5px solid red;
	/* opacity:1;
	transition: opacity 0.7s; */
}

.unicon-login-intro-box .unicon-login-title2 {
	font-size: 2.4rem;
	font-weight: bold;
	opacity: 0.7;
}

.unicon-login-intro-box .unicon-login-title2 span {
	margin-left: 10px;
	margin-right: 10px;
}

.unicon-login-intro-box .unicon-login-title2:hover {
	opacity: 1;
	cursor: pointer;
}

.unicon-login-intro-box .unicon-login-title2:hover  span {
	border-bottom: 5px solid red;
	/* opacity:1;
	transition: opacity 0.7s; */
}

.unicon-login-intro-box .unicon-login-serve-title {
	margin-top: 50px;
	font-size: 1.7rem;
	font-weight: bold;
	opacity: 0.7;
}

.unicon-login-intro-box .unicon-login-serve-title:hover {
	opacity: 1;
	cursor: pointer;
}

.unicon-login-intro-box .unicon-login-serve-title2 {
	margin-top: 50px;
	font-size: 1.3rem;
	font-weight: bold;
	opacity: 0.7;
}

.unicon-login-intro-box .unicon-login-serve-title2:hover {
	opacity: 1;
	cursor: pointer;
}

/* 로그인 후 UNICON __ 게시물 0개일때 끝 */
.page-box {
	margin-bottom: 100px;
	margin-top: 50px;
}

.page-box>ul>li>a {
	padding: 0 10px;
	text-decoration: underline;
	color: #787878;
	margin-bottom: 30px;
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
	margin-top: 5px;
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
	max-width: 200px;
}

@media ( max-width :800px ) {
	/* PC버전 memo 테이블 관련 */
	.memo-table-box .memo-box {
		border: 7px solid black;
		width: 350px;
		height: 400px;
		/* margin: 10px 0; */
		margin-left: auto;
		margin-right: auto;
		margin-top: 5px;
	}
	h1 {
		text-align: left;
	}
	.from-button input {
		width: 100px;
		font-size: 1rem;
	}
	.memo-contents-box {
		 margin-top: 80px; 
		margin-bottom: 30px;
	}
	.memo-contents-box .memo-contents-box-2 {
		/* flex-direction: column-reverse; */
		/* flex-direction:row;   */
		display: flex;
		margin-bottom: 50px;
		width: 100%;
		height: 50px;
	}
	.memo-contents-box .memo-contents-box-2 .total-count {
		font-size: 1rem;
		height: 30px;
		margin-top: 10px;
		width: 150px;
		margin-left: 0;
	}
	.memo-contents-box .memo-contents-box-2 .from-button {
		margin-right: 0;
	}
	.memo-contents-box {
		display: block;
	}
	.mobile-memo-button {
		margin-right: 0;
		width: 109%;
		margin-top: 10px;
	}
	.search {
		margin-right: 0;
		width: 109%;
	}

	/* 제목으로 모바일모드 시작 */
	.search {
		margin-right: 1.3px;
	}
	.search .search-box button {
		padding: 0 20px;
	}
	.search .search-box form .tag-box {
		width: 220px;
		font-size: 1.5rem;
	}
	.total-box {
		width: 50%;
		margin-right: 0;
		margin-top: 20px;
		text-align: right;
	}
	.memo-table-list {
		margin-top: 80px;
	}
	.memo-table-list .memo-table-list-box .contents-box .title {
		font-size: 1.3rem;
		width: 95%;
	}
	.memo-table-list .memo-table-list-box .file-control-box {
		height: 38%;
	}
	.memo-table-list .memo-table-list-box .file-control-box img {
		height: 100%;
		width: 100%;
	}
	.memo-table-list .memo-table-list-box {
		height: 145px;
	}

	/* body를 태그로 바꿔서 사용중....  */
	.memo-table-list .memo-table-list-box .contents-box .body {
		width: 124%;
		height: 50px;
		font-size: 0.8rem;
		opacity: 0.7;
		margin-top: 10px;
		/* word-break: keep-all; */
	}
	.memo-table-list .memo-table-list-box .writer-box {
		display: flex;
		font-size: 0.9rem;
	}
	.free-top-bar-mobile {
		position: absolute;
		top: 100px;
		left: 4%;
		font-weight: bold;
	}
	.free-top-bar-mobile .title {
		font-size: 1.8rem;
	}
	.free-top-bar-mobile .body {
		font-size: 1.3rem;
	}
	.write-btn {
		margin-top: 250px;
		margin-bottom: 0;
	}
	.memo-table-list .memo-table-list-box .writer-box {
		margin-top: 0px;
		height: 20px;
	}
	.memo-table-list .memo-table-list-box .writer-box .writer, .regDate {
		/* border: 3px solid green; */
		width: 280px;
		height: 0;
	}
	.memo-table-box
		 
		.memo-box {
		background-color: #fffff5;
	}
	
	
	.mobile-unicon-intro-box {
		text-align: center;
		text-align: center;
		width: 100%;
		/* padding: 50px 0; */
		
	}
	.mobile-unicon-intro-box .unicon-title {
		font-size: 1.1rem;
		font-weight: bold;
		opacity: 0.7;
	}
	.mobile-unicon-intro-box .unicon-title:hover {
		opacity: 1;
		cursor: pointer;
	}
	.mobile-unicon-intro-box .unicon-serve-title {
		margin-top: 50px;
		font-size: 0.9rem;
		font-weight: bold;
		/* border:3px solid red; */
		opacity: 0.7;
	}
	.mobile-unicon-intro-box .unicon-serve-title:hover {
		opacity: 1;
		cursor: pointer;
	}
	.mobile-unicon-intro-box .unicon-serve-title2 {
		margin-top: 50px;
		font-size: 0.9rem;
		font-weight: bold;
		/* border:3px solid red; */
		opacity: 0.7;
	}
	.mobile-unicon-intro-box .unicon-serve-title2:hover {
		opacity: 1;
		cursor: pointer;
	}
	.mobile-unicon-intro-box .unicon-login {
		margin-top: 50px;
	}
	.mobile-unicon-intro-box .unicon-login .btn {
		width: 300px;
	}
	.mobile-unicon-login-box {
		text-align: center;
		text-align: center;
		width: 100%;
		padding: 20px 0;
		background-color: #fff5f5;
		
	}
	.mobile-unicon-login-box .unicon-login-title1 {
		font-size: 1.3rem;
		font-weight: bold;
		opacity: 0.7;
	}
	
	.mobile-unicon-login-box .unicon-login-title2 {
		font-size: 1.1rem;
		font-weight: bold;
		opacity: 0.7;
		margin-top:20px;
	}
	
	.mobile-unicon-login-box .unicon-login-serve-title1 {
		font-size: 1.1rem;
		opacity: 0.7;
		margin-top:20px;
	}
	
	.mobile-unicon-login-box .unicon-login-serve-title2 {
		font-size: 1.1rem;
		opacity: 0.7;
		margin-top:20px;
	}
	
	.mobile-memo-unicon-button {
		 margin-top:-80px; 	
	}
}

.memo-table-box .memo-box {
	background-color: #fffff5;
}
</style>



<%@ include file="../part/foot.jspf"%>