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
import com.sbs.khr.memome.dto.Hashtag;
import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.service.ArticleService;
import com.sbs.khr.memome.service.HashtagService;
import com.sbs.khr.memome.service.MemberService;
import com.sbs.khr.memome.service.MemoService;
import com.sbs.khr.memome.util.Util;

@Controller
public class MemoController {

	@Autowired
	private MemoService memoService;
	
	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private HashtagService hashtagService;
	
	@Autowired
	private MemberService memberService;
	
	
	@RequestMapping("/usr/memo/{boardCode}-memoModify")
	public String showMemoModify(@PathVariable("boardCode") String boardCode, Model model, HttpServletRequest request, int id) {
		
		Article article = articleService.getForPrintArticleById(id);
		model.addAttribute("article", article);
		
		int loginedMemberId = (int)request.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		model.addAttribute("member", member);
		
		
		List<Hashtag> hashtags = hashtagService.getForPrintHashtagsByRelId(id);
		model.addAttribute("hashtags", hashtags);

		return "memo/memoModify";
	}
	
	
	
	@RequestMapping("/usr/memo/{writer}-memoMemberPage")
	public String showMemoPage(@PathVariable("writer") String writer, Model model, HttpServletRequest request, int id) {
		
		List<Article> articles = articleService.getForPrintArticlesByMemberId(id);
		model.addAttribute("articles", articles);
		
		
		Member member = memberService.getMemberById(id);
		model.addAttribute("member", member);
		
		
		List<Hashtag> hashtags = hashtagService.getForPrintAllHashtags();
		model.addAttribute("hashtags", hashtags);

		return "memo/memoMemberPage";
	}
	
	@RequestMapping("/usr/memo/{boardCode}-memoList")
	public String showMemoList(@PathVariable("boardCode") String boardCode, Model model, HttpServletRequest request) {
		Board board = memoService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int loginedMemberId = (int)request.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		
		
		
		List<Article> articles = null;
		
		if ( boardCode.equals("memoME")) {
			articles = articleService.getForPrintArticlesByMemberId(loginedMemberId);
		}
		
		
		else if ( boardCode.equals("memoYOU")) {
			articles = articleService.getForPrintAllArticles();
		}
			
		// memo를 관리할 폴더 관련 코드를 없애서 관련 코드는 사용하지 않음.  검토해서 관련 코드 다 삭제하기.
		//List<Article> articles = articleService.getForPrintArticlesByMemo();
		
		model.addAttribute("articles", articles);
		model.addAttribute("member", member);
		
		
		List<Hashtag> hashtags = hashtagService.getForPrintAllHashtags();
		model.addAttribute("hashtags", hashtags);

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
