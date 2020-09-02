package com.sbs.khr.memome.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.khr.memome.dto.Article;
import com.sbs.khr.memome.dto.Board;
import com.sbs.khr.memome.dto.Memo;
import com.sbs.khr.memome.service.ArticleService;
import com.sbs.khr.memome.service.MemoService;
import com.sbs.khr.memome.util.Util;

@Controller
public class MemoController {

	@Autowired
	private MemoService memoService;
	
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/memo/{boardCode}-memoList")
	public String showMemoList(@PathVariable("boardCode") String boardCode, Model model, HttpServletRequest request) {
		Board board = memoService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int loginedMemberId = (int)request.getAttribute("loginedMemberId");
		
		List<Article> articles = null;
		
		if ( boardCode.equals("memome")) {
			articles = articleService.getForPrintArticlesByMemberId(loginedMemberId);
		}
		
		
		if ( boardCode.equals("memoyou")) {
			articles = articleService.getForPrintAllArticles();
		}
			
		// memo를 관리할 폴더 관련 코드를 없애서 관련 코드는 사용하지 않음.  검토해서 관련 코드 다 삭제하기.
		//List<Article> articles = articleService.getForPrintArticlesByMemo();
		
		model.addAttribute("articles", articles);

		return "memo/memoList";
	}

	@RequestMapping("/usr/memo/{boardCode}-memoWrite")
	public String showMemoWrite(@PathVariable("boardCode") String boardCode, Model model) {
		model.addAttribute("boardCode", boardCode);
		return "article/write";
	}
	
	
	
	@RequestMapping("/usr/memo/{boardCode}-makeMemoCate")
	public String showMakeMemoCate(@PathVariable("boardCode") String boardCode, Model model) {
		Board board = memoService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		return "memo/makeCate";
	}
	
	@RequestMapping("/usr/memo/{boardCode}-doMakeMemoCate")
	public String doMakeMemoCate(@RequestParam Map<String, Object> param, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = memoService.getBoardByCode(boardCode);
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "id", "name");
		newParam.put("boardId", board.getId());
		
		int newMemoFolderId = memoService.makeMemoCate(newParam);
		String redirectUri = Util.getAsStr(param.get("redirectUri"));
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	

}
