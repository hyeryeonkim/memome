<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="메인" /> --%>
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>


<c:if test="${board.code eq 'memoYOU'}">
	<h1 class="con">
		<strong style="color: green">${board.code}</strong>&nbsp;&nbsp;&nbsp;${searchKeyword} &nbsp;&nbsp;검색 결과
	</h1>
</c:if>
<c:if test="${board.code eq 'memoME'}">
	<h1 class="con">
		<strong style="color: blue">${board.code}</strong>&nbsp;&nbsp;&nbsp;${searchKeyword} &nbsp;&nbsp;검색 결과
	</h1>
</c:if>
<c:if test="${board.code eq 'memberPage'}">
	<h1 class="con">
		<strong style="color: gold">이웃 <strong style="color: skyblue">
				${member.nickname }</strong>
		</strong>&nbsp;&nbsp;&nbsp;${searchKeyword} &nbsp;&nbsp;검색 결과
	</h1>
</c:if>




<c:if
	test="${board.code eq 'memberPage' == false && board.code eq 'notice' == false && board.code eq 'free' == false}">
	<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down ">
		<button type="button" class="btn black"
			onclick="location.href=	'../memo/${board.code}-memoList?mode=${param.mode }'">BACK</button>
	</div>
	<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
		<button type="button" class="btn black"
			onclick="location.href=	'../memo/${board.code}-memoList?mode=${param.mode }'">BACK</button>
	</div>
</c:if>
<c:if test="${board.code eq 'memberPage' }">
	<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down ">
		<button type="button" class="btn black"
			onclick="location.href=	'../memo/${board.code}-memoList?id=${param.id }&mode=${param.mode }'">BACK</button>
	</div>
	<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
		<button type="button" class="btn black"
			onclick="location.href=	'../memo/${board.code}-memoList?id=${param.id }&mode=${param.mode }'">BACK</button>
	</div>
</c:if>
<c:if test="${board.code eq 'notice' || board.code eq 'free'}">
	<div class="con margin-top-50 flex flex-jc-fe visible-on-sm-down ">
		<button type="button" class="btn black"
			onclick="location.href=	'../article/${board.code}-list?mode=${param.mode }'">BACK</button>
	</div>
	<div class="con margin-top-50 flex flex-jc-fe visible-on-md-up">
		<button type="button" class="btn black"
			onclick="location.href=	'../article/${board.code}-list?mode=${param.mode }'">BACK</button>
	</div>
</c:if>




<%-- <div class="con margin-top-20 flex flex-jc-fe border-red-1">
	<button type="button"
		onclick="location.href='../memo/${boardCode}-makeMemoCate'">메모
		폴더 생성</button>
</div> --%>
<script>
	
</script>
<div class="con">총 게시물 수 : ${totalCount}</div>
<c:if test="${boardCode eq 'notice' || boardCode eq 'free' }">
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
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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
<c:if
	test="${param.mode eq 'big'  && boardCode eq 'notice' == false && boardCode eq 'free' == false}">
	<div class="memo-table-box con flex flex-wrap flex-row ">
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
													test="${board.code ne 'memberPage' }">
													<a
														href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
														#${hashtag.tag}</a>
												</c:if> <c:if test="${board.code eq 'memberPage'  }">
													<a
														href="../memo/${boardCode}-tagSearchResult?id=${param.id }&searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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
					onclick="location.href='${article.getDetailLink(board.code)}&mode=${param.mode }'">
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
													test="${board.code ne 'memberPage' }">
													<a
														href="../memo/${board.code}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
														#${hashtag.tag}</a>
												</c:if> <c:if test="${board.code eq 'memberPage'  }">
													<a
														href="../memo/${board.code}-tagSearchResult?id=${param.id }&searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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
<c:if
	test="${param.mode eq '' && boardCode eq 'notice' == false && boardCode eq 'free' == false}">
	<div class="memo-table-box con flex flex-wrap flex-row">
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
													test="${board.code ne 'memberPage' }">
													<a
														href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
														#${hashtag.tag}</a>
												</c:if> <c:if test="${board.code eq 'memberPage'  }">
													<a
														href="../memo/${boardCode}-tagSearchResult?id=${param.id }&searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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
					onclick="location.href='${article.getDetailLink(board.code)}&mode=${param.mode }'">
					<table>
						<colgroup>
							<col width="50" />
							<col width="200" />
						</colgroup>
						<tbody>

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
													test="${board.code ne 'memberPage' }">
													<a
														href="../memo/${board.code}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
														#${hashtag.tag}</a>
												</c:if> <c:if test="${board.code eq 'memberPage'  }">
													<a
														href="../memo/${board.code}-tagSearchResult?id=${param.id }&searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
											#${hashtag.tag}</a>&nbsp;&nbsp;&nbsp;&nbsp;</strong>
								</c:if>
							</c:forEach>
						</div>
						<div class="writer-box">
							<div class="writer">${article.extra.writer}</div>
							<div class="regDate">${article.regDate}</div>
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
										href="../memo/${boardCode}-tagSearchResult?searchKeywordType=tag&searchKeyword=${hashtag.tag }&mode=${param.mode }">
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

.memo-table-list .memo-table-list-box .writer-box .writer, .memo-table-list .memo-table-list-box .writer-box .regDate {
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

<div class="con page-box">
	<ul class="flex flex-jc-c">
		<c:forEach var="i" begin="1" end="${totalPage}" step="1">
			<li class="${i == cPage ? 'current' : ''}"><a
				href="?searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}&id=${param.id}&mode=${param.mode}"
				class="block">${i}</a></li>
		</c:forEach>
	</ul>
</div>




<style>
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
	margin-left: 65px;
	margin-rigth: 85px;
}

.memo-table-list .memo-table-list-box .file-control-box {
	height: 100%;
	width: 30%;
}

.memo-table-list .memo-table-list-box .file-control-box .img-box,
	.memo-table-list .memo-table-list-box .file-control-box .video-box {
	/* border:3px solid blue; */
	max-width: 100%;
	height: 100%;
	overflow: hidden;
}

.memo-table-list .memo-table-list-box .file-control-box img,
	.memo-table-list .memo-table-list-box .file-control-box video {
	/* object-fit: cover; */
	max-width: 100%;
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

.memo-table-box .memo-box .body-box .video-box video, .memo-table-box .memo-box .body-box .img-box img {
	max-width: 100%;
}

html>body .memo-table-box .memo-box td {
	max-width:200px;
	overflow: auto;
}

.memo-table-box .memo-box {
	background-color: #fffff5;
}
</style>



<%@ include file="../part/foot.jspf"%>