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
import com.sbs.khr.memome.dto.ResultData;
import com.sbs.khr.memome.service.ArticleService;
import com.sbs.khr.memome.service.HashtagService;
import com.sbs.khr.memome.service.MemberService;
import com.sbs.khr.memome.util.Util;

@Controller
public class ArticleController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private HashtagService hashtagService;
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(@RequestParam Map<String, Object> param, Model model,
			@PathVariable("boardCode") String boardCode, HttpServletRequest request) {
		int page = 1;

		if (param.get("page") != null) {
			page = Util.getAsInt(param.get("page"));
		}
		
		String searchKeyword = Util.getAsStr(param.get("searchKeyword"));

		Board board = articleService.getBoardByCode(boardCode);
		System.out.println("나는 무슨 보드? : " + board);
		model.addAttribute("board", board);

		int itemsInAPage = 5;
		int limitFrom = (page - 1) * itemsInAPage;
		int totalCount = articleService.getForPrintListArticlesCount(board.getId()) - 1;

		List<Article> articles = null;
		
		if ( searchKeyword.length() == 0 ) {
			articles = articleService.getForPrintArticles(board.getId(), itemsInAPage, limitFrom);
			System.out.println("널임" + searchKeyword);
		}
		
		if ( searchKeyword.length() > 0 ) {
			System.out.println("널아님"+ searchKeyword);
			articles = articleService.getForPrintArticleContainsTags(board.getId(), itemsInAPage, searchKeyword, limitFrom);
			List<Article> articles2  = articleService.getForPrintArticlesSearchCount(board.getId(), searchKeyword);
			
			totalCount = articles2.size();
			
		}
		
		
		
		
		
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("cPage", page);

		model.addAttribute("articles", articles);

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		Member member = memberService.getMemberById(loginedMemberId);

		model.addAttribute("member", member);

		return "article/list";
	}

	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(Model model, @PathVariable("boardCode") String boardCode, String memoId) {

		model.addAttribute("boardCode", boardCode);
		model.addAttribute("memoId", memoId);

		return "article/write";
	}

	@RequestMapping("/usr/article/{boardCode}-fork")
	public String showFork(Model model, @PathVariable("boardCode") String boardCode, String memoId) {

		model.addAttribute("boardCode", boardCode);
		model.addAttribute("memoId", memoId);

		return "article/write";
	}

	@RequestMapping("/usr/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, Model model,
			@PathVariable("boardCode") String boardCode, HttpServletRequest request) {

		ResultData resultData = hashtagService.getChechTagDup(Util.getAsStr(param.get("tag")));

		if (resultData.isFail()) {
			model.addAttribute("alertMsg", resultData.getMsg());
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");

		newParam.put("boardId", board.getId());
		newParam.put("memberId", loginedMemberId);

		int newArticleId = articleService.write(newParam);

		String tag = Util.getAsStr(param.get("tag"));
		String relTypeCode = Util.getAsStr(param.get("relTypeCode"));
		hashtagService.tagWrite(newArticleId, tag, loginedMemberId, relTypeCode);

		String redirectUri = Util.getAsStr(param.get("redirectUri"));
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		if (boardCode.contains("memo")) {
			redirectUri = "/usr/memo/" + boardCode + "-memoList";
		}

		else {
			redirectUri = "./" + boardCode + "-list";
		}

		if (newArticleId != -1) {
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", newArticleId + "번 게시물이 생성되었습니다.");
			return "common/redirect";
		}

		return "common/redirect";
	}

	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model,
			@PathVariable("boardCode") String boardCode, String listUrl) {
		if (listUrl == null) {
			listUrl = "./" + boardCode + "-list";
		}

		model.addAttribute("listUrl", listUrl);

		int id = Util.getAsInt(param.get("id"));

		Member member = memberService.getMemberById((int) request.getAttribute("loginedMemberId"));

		Article article = articleService.getForPrintArticleById(member, id);
		model.addAttribute("article", article);

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		String relTypeCode = "article";
		List<Hashtag> hashtags = hashtagService.getForPrintHashtags(article.getId(), relTypeCode);
		model.addAttribute("hashtags", hashtags);

		return "article/detail";
	}

	@RequestMapping("/usr/article/{boardCode}-modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req,
			@PathVariable("boardCode") String boardCode, String listUrl) {
		// model.addAttribute("listUrl", listUrl);

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		int id = Integer.parseInt((String) param.get("id"));

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		String tagBits = hashtagService.getForPrintHashtagsByRelId(id);
		tagBits.toString();
		model.addAttribute("tagBits", tagBits);

		return "article/modify";
	}

	@RequestMapping("/usr/article/{boardCode}-doModify")
	public String doMemoModify(@RequestParam Map<String, Object> param, @PathVariable("boardCode") String boardCode,
			Model model, HttpServletRequest request) {

		ResultData resultData = hashtagService.getChechTagDup(Util.getAsStr(param.get("tag")));

		if (resultData.isFail()) {
			model.addAttribute("alertMsg", resultData.getMsg());
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");
		Map<String, Object> newParam = Util.getNewMapOf(param, "relTypeCode", "fileIdsStr", "id", "title", "body",
				"tag");
		articleService.articleModify(newParam, loginedMemberId);

		String redirectUri = "./" + boardCode + "-detail?id=" + param.get("id");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

}
