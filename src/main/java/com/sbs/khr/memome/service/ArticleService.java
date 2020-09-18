package com.sbs.khr.memome.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.ArticleDao;
import com.sbs.khr.memome.dao.MemoDao;
import com.sbs.khr.memome.dto.Article;
import com.sbs.khr.memome.dto.Board;
import com.sbs.khr.memome.dto.File;
import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.util.Util;

@Service
public class ArticleService {

	@Autowired
	private ArticleDao articleDao;

	@Autowired
	private FileService fileService;

	@Autowired
	private HashtagService hashtagService;

	@Autowired
	private MemoDao memoDao;

	public int write(Map<String, Object> param) {
		articleDao.write(param);

		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.startsWith(",")) {
				fileIdsStr = fileIdsStr.substring(1);
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.equals(",")) {
				fileIdsStr = "";
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}

		return id;
	}

	public Board getBoardByCode(String boardCode) {
		return articleDao.getBoardByCode(boardCode);
	}

	public List<Article> getForPrintArticles(int id, int itemsInAPage, int limitFrom) {
		return articleDao.getForPrintArticles(id, itemsInAPage, limitFrom);
	}

	public Article getForPrintArticleById(int id) {

		Article article = articleDao.getForPrintArticleById(id);

		List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");

		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);
		return article;
	}

	public List<Article> getForPrintArticlesByMemo() {
		return articleDao.getForPrintArticlesByMemo();
	}

	public List<Article> getForPrintArticlesByMemberId(int memberId, int boardId, int itemsInAPage, int limitFrom) {

		List<Article> articles = articleDao.getForPrintArticlesByMemberId(memberId, boardId, itemsInAPage, limitFrom);

		List<Article> getArticlesPutFiles = getArticlesPutFiles(articles);

		return getArticlesPutFiles;
	}

	// 내가 쓴것과 상관없이 모든 사람의 memo(article)를 불러오는 메서드
	public List<Article> getForPrintAllArticles(int boardId, int memberId, int itemsInAPage, int limitFrom) {

		List<Article> articles = articleDao.getForPrintAllArticles(boardId, memberId, itemsInAPage, limitFrom);

		List<Article> getArticlesPutFiles = getArticlesPutFiles(articles);

		return getArticlesPutFiles;
	}

	// articles 를 불러올 때, articleId로 files를 얻어서 extra에 담는 메서드
	public List<Article> getArticlesPutFiles(List<Article> articlesNotHaveFiles) {

		for (Article article : articlesNotHaveFiles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);

		}

		return articlesNotHaveFiles;
	}

	public void memoModify(Map<String, Object> param, int memberId) {
		articleDao.memoModify(param);
		hashtagService.hashtagModify(param, memberId);

	}

	public void memoDelete(Map<String, Object> newParam) {
		articleDao.memoDelete(newParam);
	}

	public Article getforprintArticleByRelId(int relId, int memberId) {
		return articleDao.getForPrintArticleByRelId(relId, memberId);
	}

	// 태그 검색 결과를 얻어오는 메서드(memoME용)
	public List<Article> getArticlesContainsTagSearchResultByMemberId(int memberId, String searchKeyword, int itemsInAPage, int limitFrom) {

		List<Article> articles = articleDao.getArticlesContainsTagSearchResultByMemberId(memberId, searchKeyword, itemsInAPage, limitFrom);
		List<Article> getArticlesPutFiles = getArticlesPutFiles(articles);

		return getArticlesPutFiles;
	}

	// 태그 검색 결과를 얻어오는 메서드(memoYOU용)
	public List<Article> getArticlesContainsTagSearchResultByMemberIdForMemoYou(int memberId, String searchKeyword, int itemsInAPage, int limitFrom) {

		List<Article> articles = articleDao.getArticlesContainsTagSearchResultByMemberIdForMemoYou(memberId,
				searchKeyword, itemsInAPage, limitFrom);
		List<Article> getArticlesPutFiles = getArticlesPutFiles(articles);

		return getArticlesPutFiles;
	}

	public Article getForPrintArticleById(Member member, int id) {
		Article article = articleDao.getForPrintArticleById(id);

		updateForPrintInfo(member, article);

		List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");

		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);

		return article;
	}

	private void updateForPrintInfo(Member member, Article article) {
		Util.putExtraVal(article, "memberCanDelete", memberCanDelete(member, article));
		Util.putExtraVal(article, "memberCanModify", memberCanModify(member, article));
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	public boolean memberCanModify(Member member, Article article) {
		return member != null && member.getId() == article.getMemberId() ? true : false;
	}

	// 액터가 해당 댓글을 삭제할 수 있는지 알려준다.
	public boolean memberCanDelete(Member member, Article article) {
		return memberCanModify(member, article);
	}

	public void articleModify(Map<String, Object> param, int memberId) {
		articleDao.articleModify(param);
		hashtagService.hashtagModify(param, memberId);

	}

	public List<Article> getForPrintArticleContainsTags(int boardId, int itemsInAPage, String searchKeyword,
			int limitFrom) {
		
		List<Article> articles = articleDao.getForPrintArticleContainsTags(boardId, itemsInAPage, limitFrom, searchKeyword);
		List<Article> getArticlesPutFiles = getArticlesPutFiles(articles);

		return getArticlesPutFiles;
	}

	public int getForPrintListArticlesCount(int boardId) {
		return articleDao.getForPrintListArticlesCount(boardId);
	}

	/*
	 * public List<Article> getarticlescontainsTagBoardSearchResult(String
	 * searchKeyword) { List<Article> articles =
	 * articleDao.getarticlescontainsTagBoardSearchResult(searchKeyword);
	 * List<Article> getArticlesPutFiles = getArticlesPutFiles(articles);
	 * 
	 * return getArticlesPutFiles; }
	 */

	public List<Article> getForPrintArticlesSearchCount(int boardId, String searchKeyword) {
		return articleDao.getForPrintArticlesSearchCount(boardId,searchKeyword);
	}

	public int getForPrintMemoMeAndYouListArticlesCount() {
		return articleDao.getForPrintMemoMeAndYouListArticlesCount();
	}

	public int getForPrintListArticlesCountFromMemberId(int boardId, int memberId) {
		return articleDao.getForPrintListArticlesCountFromMemberId(boardId, memberId);
	}

	public int getForPrintListArticlesCountRemoveMe(int memberId) {
		return articleDao.getForPrintListArticlesCountRemoveMe(memberId);
	}

	public List<Article> getForPrintArticlesSearchCountFromMemoYou(int memberId, String searchKeyword) {
		return articleDao.getForPrintArticlesSearchCountFromMemoYou(memberId, searchKeyword);
	}

	public int getForPrintArticlesByMemberIdFromBoardId34(int memberId) {
		return articleDao.getForPrintArticlesByMemberIdFromBoardIdYouAndMe(memberId);
	}

	// memberId = 사용자 1인 페이지로 이동했을 때, 그 회원의 정보를 찾아오는 메서드
	public List<Article> getForPrintArticlesSearchCountFromOtherMember(Integer memberId, String searchKeywordType) {
		return articleDao.getForPrintArticlesSearchCountFromOtherMember(memberId, searchKeywordType);
	}





}
