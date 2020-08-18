package com.sbs.khr.memome.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String doJoin(@RequestParam Map<String, Object> param) {
			
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		
		
		int newMemberId = memberService.join(param);
		
		
		
		
		String redirectUri = (String)param.get("redirectUri");
		
		
		return "redirect:" + redirectUri;
	}
	
	
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}
	
	
	
}
