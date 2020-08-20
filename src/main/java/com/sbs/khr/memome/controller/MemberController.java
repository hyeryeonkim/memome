package com.sbs.khr.memome.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.dto.ResultData;
import com.sbs.khr.memome.service.MemberService;
import com.sbs.khr.memome.util.Util;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;


	@RequestMapping("/usr/member/join")
	public String showMain() {
		return "member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
			
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkLoginIdJoinableResultData = memberService.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));
		
		if ( checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		// param에 id가 들어있다?????????? 샘한테 질문하기.
		int newMemberId = memberService.join(param);
		
		String nickname = Util.getAsStr(param.get("nickname"));
		model.addAttribute("alertMsg", nickname + "님, 회원가입을 감사드립니다.");
		
		String redirectUri = (String)param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		
		
		return "common/redirect";
	}
	
	
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		
		
		System.out.println("param에 왜 로그인 아이디가 없지? : " + param);
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		
		Member member = memberService.getMemberByLoginId(Util.getAsStr(param.get("loginId")));
		
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}
		
		String loginPw = Util.getAsStr(param.get("loginPw"));
		
		if ( member.getLoginPw().equals(loginPw) == false ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		session.setAttribute("loginedMemberId", member.getId());
		
		String redirectUri = Util.getAsStr(param.get("redirectUri"));
		
		if ( redirectUri == null || redirectUri.length() == 0 ) {
			redirectUri = "/usr/home/main";
		}
		
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/logout")
	public String doLogout(HttpSession session, Model model) {
		
		session.removeAttribute("loginedMemberId");
		
		String redirectUri = "/usr/home/main";
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/myPage")
	public String showMyPage(HttpSession session, Model model, HttpServletRequest request) {
		
		
		Member member = memberService.getMemberById(Util.getAsInt(request.getAttribute("loginedMemberId")));
		
		model.addAttribute("member", member);
		
		
		
		return "member/myPage";
	}

	@RequestMapping("/usr/member/memberDataPrivate")
	public String showMemberDataPrivate(HttpSession session, Model model, HttpServletRequest request) {
		
		Member member = memberService.getMemberById(Util.getAsInt(request.getAttribute("loginedMemberId")));
		
		model.addAttribute("member", member);
		
		return "member/memberDataPrivate";
	}
	
	@RequestMapping("/usr/member/passwordPrivate")
	public String showPasswordPrivate(HttpSession session, Model model, HttpServletRequest request) {
		
		Member member = memberService.getMemberById(Util.getAsInt(request.getAttribute("loginedMemberId")));
		
		model.addAttribute("member", member);
		
		return "member/passwordPrivate";
	}
	
	@RequestMapping("/usr/member/modify")
	public String showModify(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		
		
		Member member = memberService.getMemberById(Util.getAsInt(request.getAttribute("loginedMemberId")));
		
		if ( member.getLoginPw().equals(Util.getAsStr(param.get("loginPw"))) == false ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		model.addAttribute("member", member);
		
		
		
		return "member/modify";
	}
	
	@RequestMapping("/usr/member/passwordModify")
	public String showPasswordModify(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		
		
		Member member = memberService.getMemberById(Util.getAsInt(request.getAttribute("loginedMemberId")));
		
		if ( member.getLoginPw().equals(Util.getAsStr(param.get("loginPw"))) == false ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		model.addAttribute("member", member);
		
		
		
		return "member/passwordModify";
	}
	
	
	
	
	
	@RequestMapping("/usr/member/doModify")
	public String doModify(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		
		System.out.println("param에 email이없니????: " + param);
		
		
		memberService.memberDataUpdate(param);
		
		
		
		
		String redirectUri = "/usr/member/myPage";
		
		model.addAttribute("redirectUri", redirectUri);
		
		
		return "common/redirect";
	}
	
	

	
	@RequestMapping("/usr/member/doPasswordModify")
	public String doPasswordModify(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		memberService.passwordUpdate(param);
		
		String redirectUri = "/usr/member/myPage";
		
		model.addAttribute("redirectUri", redirectUri);
		
		
		return "common/redirect";
	}
	

	
	@RequestMapping("/usr/member/findAccount")
	public String showFindAccount(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		return "member/findAccount";
	}
	
	
	@RequestMapping("/usr/member/doFindLoginId")
	public String doFindLoginId(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		
		Member member = memberService.getMemberByNameAndEmail(param);
		
		if ( member != null ) {
			model.addAttribute("redirectUri", "/usr/member/login");
			model.addAttribute("alertMsg", "찾으시는 아이디는 " + member.getLoginId() + " 입니다.");
		}
		
		
		return "common/redirect";
	}
	
	
}
