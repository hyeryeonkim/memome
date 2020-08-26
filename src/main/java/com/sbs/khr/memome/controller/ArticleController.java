package com.sbs.khr.memome.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.khr.memome.dto.Article;
import com.sbs.khr.memome.dto.Board;
import com.sbs.khr.memome.service.ArticleService;
import com.sbs.khr.memome.util.Util;

@Controller
public class ArticleController {

	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(@RequestParam Map<String, Object> param, Model model,
			@PathVariable("boardCode") String boardCode) {

		Board board = articleService.getBoardByCode(boardCode);
		System.out.println("나는 무슨 보드? : " + board);
		model.addAttribute("board", board);

		List<Article> articles = articleService.getForPrintArticles(board.getId());

		model.addAttribute("articles", articles);

		return "article/list";
	}

	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(Model model, @PathVariable("boardCode") String boardCode) {

		model.addAttribute("boardCode", boardCode);

		return "article/write";
	}

	@RequestMapping("/usr/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, Model model,
			@PathVariable("boardCode") String boardCode, HttpServletRequest request) {

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");

		newParam.put("boardId", board.getId());
		newParam.put("memberId", loginedMemberId);

		int newArticleId = articleService.write(newParam);

		String redirectUri = Util.getAsStr(param.get("redirectUri"));
		redirectUri = redirectUri.replace("#id", newArticleId + "");
				

		if (newArticleId != -1) {
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", newArticleId + "번 게시물이 생성되었습니다.");
			model.addAttribute("redirectUri", redirectUri);
			return "common/redirect";
		}

		return "common/redirect";
	}

	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(@RequestParam Map<String, Object> param, Model model,
			@PathVariable("boardCode") String boardCode) {

		int id = Util.getAsInt(param.get("id"));

		Article article = articleService.getForPrintArticleById(id);

		model.addAttribute("article", article);

		Board board = articleService.getBoardByCode(boardCode);

		model.addAttribute("board", board);

		return "article/detail";
	}

}
