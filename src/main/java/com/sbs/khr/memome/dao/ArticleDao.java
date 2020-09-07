package com.sbs.khr.memome.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Article;
import com.sbs.khr.memome.dto.Board;
import com.sbs.khr.memome.dto.Memo;

@Mapper
public interface ArticleDao {
	
	void write(Map<String, Object> param);

	Board getBoardByCode(@Param("boardCode") String boardCode);

	List<Article> getForPrintArticles(@Param("id") int id);

	Article getForPrintArticleById(@Param("id") int id);

	List<Article> getForPrintArticlesByMemo();

	List<Article> getForPrintArticlesByMemberId(@Param("memberId") int memberId, @Param("boardId") int boardId);

	List<Article> getForPrintAllArticles(@Param("boardId") int boardId);

	void memoModify(Map<String, Object> param);

	void memoDelete(Map<String, Object> newParam);

}
