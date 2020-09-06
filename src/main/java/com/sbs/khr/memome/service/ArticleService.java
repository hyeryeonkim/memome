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
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());

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

	public List<Article> getForPrintArticles(int id) {
		return articleDao.getForPrintArticles(id);
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

	public List<Article> getForPrintArticlesByMemberId(int memberId) {

		List<Article> articles = articleDao.getForPrintArticlesByMemberId(memberId);

		for (Article article : articles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);

		}
		return articles;
	}

	// 내가 쓴것과 상관없이 모든 사람의 memo(article)를 불러오는 메서드
	public List<Article> getForPrintAllArticles() {

		List<Article> articles = articleDao.getForPrintAllArticles();

		for (Article article : articles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);

		}
		
		
		

		return articles;
	}

	public void memoModify(Map<String, Object> param, int memberId) {
		articleDao.memoModify(param);
		hashtagService.hashtagModify(param, memberId);
		
		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.startsWith(",")) {
				fileIdsStr = fileIdsStr.substring(1);
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}
	}

	public void memoDelete(Map<String, Object> newParam) {
			articleDao.memoDelete(newParam);
	}
}
