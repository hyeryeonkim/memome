package com.sbs.khr.memome.controller;

import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		System.out.println("member를 못불러오나?: " + member);
		
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
	
	
}
