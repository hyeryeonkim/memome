package com.sbs.khr.memome.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
		
		// 로그인 아이디 중복 체크 
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}
		// 닉네임 중복 체크 
		ResultData checkNicknameJoinableResultData = memberService.checkNicknameJoinable(Util.getAsStr(param.get("nickname")));

		if (checkNicknameJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkNicknameJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		// 이메일 중복 체크 
		ResultData checkEmailJoinableResultData = memberService.checkEmailJoinable(Util.getAsStr(param.get("email")));

		if (checkEmailJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkEmailJoinableResultData.getMsg());
			return "common/redirect";
		}

		// param에 id가 들어있다?????????? 샘한테 질문하기.
		int newMemberId = memberService.join(param);

		String nickname = Util.getAsStr(param.get("nickname"));
		model.addAttribute("alertMsg", nickname + "님, 회원가입을 감사드립니다.");

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	public String doLogin(@RequestParam Map<String, Object> param, Model model, HttpSession session) {

		Util.changeMapKey(param, "loginPwReal", "loginPw");

		Member member = memberService.getMemberByLoginId(Util.getAsStr(param.get("loginId")));

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		String loginPw = Util.getAsStr(param.get("loginPw"));

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());

		String redirectUri = Util.getAsStr(param.get("redirectUri"));

		if (redirectUri == null || redirectUri.length() == 0) {
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

		if (member.getLoginPw().equals(Util.getAsStr(param.get("loginPw"))) == false) {
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

		if (member.getLoginPw().equals(Util.getAsStr(param.get("loginPw"))) == false) {
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

		if (member != null) {
			model.addAttribute("redirectUri", "/usr/member/login");
			model.addAttribute("alertMsg", "찾으시는 아이디는 " + member.getLoginId() + " 입니다.");
		}

		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public String getLoginIdDup(HttpServletRequest request) {
		
		String loginId = request.getParameter("loginId");
		
		System.out.println("된다 : " + loginId);
		
		ResultData checkLoginIdJoinableResultData = memberService.checkLoginIdJoinable(loginId);
		
		boolean valid = checkLoginIdJoinableResultData.isFail();
		System.out.println("나는 boolean " + valid);
		
		// 필히 \을 붙여주어야 한다.
		// 기존 blog에서 구현한 것과는 다르게 return "json:" 을 빼주었더니 되었음. 
		// @ResponseBody 어노테이션도 입력해주었음.
		if (valid) {
				System.out.println("으아아아아악 왜 안되니 false야 ");
			return "{\"msg\":\"이미 사용중인 아이디 입니다.\", \"resultCode\": \"F-1\", \"loginId\":\"" + loginId + "\"}";
		}
		else {
			System.out.println("중복은 확인하나???? 나는 hong");
			return "{\"msg\":\"사용할 수 있는 아이디 입니다.\", \"resultCode\": \"S-1\", \"loginId\":\"" + loginId + "\"}";
		}
		
	}
	
	@RequestMapping("/usr/member/getNicknameDup")
	@ResponseBody
	public String getNicknameDup(HttpServletRequest request) {
		
		String nickname = request.getParameter("nickname");
		
		ResultData checkNicknameJoinableResultData = memberService.checkNicknameJoinable(nickname);
		
		boolean valid = checkNicknameJoinableResultData.isFail();
		
		if (valid) {
			return "{\"msg\":\"이미 사용중인 닉네임 입니다.\", \"resultCode\": \"F-1\", \"nickname\":\"" + nickname + "\"}";
		}
		else {
			return "{\"msg\":\"사용할 수 있는 닉네임 입니다.\", \"resultCode\": \"S-1\", \"nickname\":\"" + nickname + "\"}";
		}
		
	}
	
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public String getEmailDup(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		ResultData checkEmailJoinableResultData = memberService.checkEmailJoinable(email);
		
		boolean valid = checkEmailJoinableResultData.isFail();
		
		if (valid) {
			return "{\"msg\":\"이미 사용중인 이메일 입니다.\", \"resultCode\": \"F-1\", \"email\":\"" + email + "\"}";
		}
		else {
			return "{\"msg\":\"사용할 수 있는 이메일 입니다.\", \"resultCode\": \"S-1\", \"email\":\"" + email + "\"}";
		}
		
	}
}
