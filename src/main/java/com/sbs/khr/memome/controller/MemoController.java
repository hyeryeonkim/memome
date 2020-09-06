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
import com.sbs.khr.memome.service.FileService;
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
	@Autowired
	private FileService fileService;
	
	
	@RequestMapping("/usr/memo/{boardCode}-memoModify")
	public String showMemoModify(@PathVariable("boardCode") String boardCode, Model model, HttpServletRequest request, int id) {
		
		Article article = articleService.getForPrintArticleById(id);
		model.addAttribute("article", article);
		
		int loginedMemberId = (int)request.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		model.addAttribute("member", member);
		
		
		String tagBits = hashtagService.getForPrintHashtagsByRelId(id);
		tagBits.toString();
		model.addAttribute("tagBits", tagBits);
		System.out.println("tagBits : " + tagBits);

		return "memo/memoModify";
	}
	

	@RequestMapping("/usr/memo/{boardCode}-doMemoModify")
	public String doMemoModify(@RequestParam Map<String, Object> param, @PathVariable("boardCode") String boardCode, Model model, HttpServletRequest request) {
		
		ResultData resultData = hashtagService.getChechTagDup(Util.getAsStr(param.get("tag")));
		
		if ( resultData.isFail() ) {
			model.addAttribute("alertMsg", resultData.getMsg());
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		int loginedMemberId = (int)request.getAttribute("loginedMemberId");
		Map<String, Object > newParam = Util.getNewMapOf(param, "relTypeCode", "fileIdsStr", "id", "title", "body", "tag");
		System.out.println("param file수정 시작 : " + param);
		System.out.println("newParam file수정 시작 : " + newParam);
		articleService.memoModify(newParam, loginedMemberId);
		
		
		String redirectUri = "/usr/home/main";
		model.addAttribute("redirectUri", redirectUri);
		
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/memo/{boardCode}-doDelete")
	public String doDelete(@RequestParam Map<String, Object> param, @PathVariable("boardCode") String boardCode, Model model, HttpServletRequest request) {
		
		
		int memberId = (int)request.getAttribute("loginedMemberId");
		Map<String, Object> newParam = Util.getNewMapOf(param, "id");
		newParam.put("memberId", memberId);
		hashtagService.hashtagDelete(newParam);  // hashtag를 먼저 지우니까 삭제가 되네.... 흠...
		articleService.memoDelete(newParam);
		
		fileService.deleteFiles("article", Util.getAsInt(newParam.get("id")));
		
		
		// 게시물 삭제
		// 태그 삭제
		// 파일 삭제
		
		System.out.println("newParam 테스트 고고 : " + newParam);
		
		return "home/main";
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
