package com.sbs.khr.memome.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Article;
import com.sbs.khr.memome.dto.Board;

@Mapper
public interface ArticleDao {
	
	void write(Map<String, Object> param);

	Board getBoardByCode(@Param("boardCode") String boardCode);

	List<Article> getForPrintArticles(@Param("id") int id, @Param("itemsInAPage") int itemsInAPage, @Param("limitFrom") int limitFrom);

	Article getForPrintArticleById(@Param("id") int id);

	List<Article> getForPrintArticlesByMemo();

	List<Article> getForPrintArticlesByMemberId(@Param("memberId") int memberId, @Param("boardId") int boardId, @Param("itemsInAPage") int itemsInAPage, @Param("limitFrom") int limitFrom);

	List<Article> getForPrintAllArticles(@Param("boardId") int boardId, @Param("memberId") int memberId, @Param("itemsInAPage") int itemsInAPage, @Param("limitFrom") int limitFrom);

	void memoModify(Map<String, Object> param);

	void memoDelete(Map<String, Object> newParam);

	Article getForPrintArticleByRelId(@Param("relId") int relId, @Param("memberId") int memberId);

	List<Article> getArticlesContainsTagSearchResultByMemberId(@Param("memberId") int memberId, @Param("tag") String searchKeyword, @Param("itemsInAPage") int itemsInAPage, @Param("limitFrom") int limitFrom);

	List<Article> getArticlesContainsTagSearchResultByMemberIdForMemoYou(@Param("memberId") int memberId, @Param("tag") String searchKeyword, @Param("itemsInAPage") int itemsInAPage, @Param("limitFrom") int limitFrom);

	void articleModify(Map<String, Object> param);

	List<Article> getForPrintArticleContainsTags(@Param("boardId") int boardId, @Param("itemsInAPage") int itemsInAPage, @Param("limitFrom") int limitFrom, @Param("tag") String searchKeyword);

	int getForPrintListArticlesCount(@Param("boardId") int boardId);

	//List<Article> getarticlescontainsTagBoardSearchResult(@Param("tag") String searchKeyword);

	List<Article> getForPrintArticlesSearchCount(@Param("boardId") int boardId, @Param("tag") String searchKeyword);

	int getForPrintMemoMeAndYouListArticlesCount();

	int getForPrintListArticlesCountFromMemberId(@Param("boardId") int boardId, @Param("memberId") int memberId);

	//int getForPrintMemoFromBoardId(@Param("boardId") int boardId);

	int getForPrintListArticlesCountRemoveMe(@Param("memberId") int memberId);

	List<Article> getForPrintArticlesSearchCountFromMemoYou(@Param("memberId") int memberId, @Param("tag") String searchKeyword);

	int getForPrintArticlesByMemberIdFromBoardIdYouAndMe(@Param("memberId") int memberId);

	List<Article> getForPrintArticlesSearchCountFromOtherMember(@Param("memberId") Integer memberId, @Param("tag") String searchKeywordType);

	Board getBoardByBoardId(@Param("boardId") int boardId);

	List<Article> getForPrintAllArticlesByBoardId(@Param("boardId") int id);

	List<Article> getForAccountDeleteArticlesByMemberId(@Param("memberId") int memberId);

	//List<Article> getForPrintAllArticleContainsTags(@Param("boardId") int id, @Param("tag") String searchKeyword);



}
