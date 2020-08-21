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

	List<Article> getForPrintArticles(@Param("id") int id);

	Article getForPrintArticleById(@Param("id") int id);
	
}
