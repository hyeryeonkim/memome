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
import org.springframework.web.client.HttpServerErrorException;

import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.dto.ResultData;
import com.sbs.khr.memome.service.MemberService;
import com.sbs.khr.memome.util.Util;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	// 회원가입
	@RequestMapping("/usr/member/join")
	public String showMain() {
		return "member/join";
	}

	// 회원가입
	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {

		Util.changeMapKey(param, "loginPwReal", "loginPw");

		// param에 id가 들어있다?????????? 샘한테 질문하기.
		int newMemberId = memberService.join(param);

		String nickname = Util.getAsStr(param.get("nickname"));
		model.addAttribute("alertMsg", nickname + " 님, 회원가입을 감사드립니다.");

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 로그인
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}

	// 로그인
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(@RequestParam Map<String, Object> param, Model model, HttpSession session) {

		Util.changeMapKey(param, "loginPwReal", "loginPw");

		Member member = memberService.getMemberByLoginId(Util.getAsStr(param.get("loginId")));

		if (member == null || member.isDelStatus() == true) {
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

		boolean usingTempPassword = memberService.usingTempPassword(member.getId());

		if (usingTempPassword) {
			redirectUri = "/usr/member/checkPassword?redirectUri=%2Fusr%2Fmember%2FmyPage";
			model.addAttribute("alertMsg", String.format("%s 님. 현재 임시 패스워드를 사용하고 있습니다.", member.getNickname()));
		} else {
			model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));
		}

		boolean getDateForpasswordModify = Util.getDateForpasswordModify("2020-05-28");

		// alert을 줄바꿈하고 싶어서 \n을 사용했는데 적용되지 않았음.
		// \n을 사용하기 위해 혹시 \앞에 \을 1개 더 입력했더니 원하는대로 작동하였음.
		if (getDateForpasswordModify) {
			System.out.println("이게 실행이 안되나????????");
			model.addAttribute("alertMsg2", "비밀번호를 변경하지 않은지 3개월이 경과하였습니다.\\n개인정보 보호를 위하여 비밀번호를 변경해주세요.");
		}

		System.out.println("악 이거 뭐야!!!! 왜 안되는데?? : " + Util.getUriEncoded("/usr/member/myPage"));

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 로그아웃
	@RequestMapping("/usr/member/logout")
	public String doLogout(HttpSession session, Model model) {

		session.removeAttribute("loginedMemberId");

		String redirectUri = "/usr/home/main";
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 회원정보(개인정보)
	@RequestMapping("/usr/member/myPage")
	public String showMyPage(HttpSession session, Model model, HttpServletRequest request,
			String checkPasswordAuthCode) {

		Member member = memberService.getMemberById(Util.getAsInt(request.getAttribute("loginedMemberId")));

		model.addAttribute("member", member);

		String checkValid = checkValidAuthCodeResultData(checkPasswordAuthCode, model, member.getId()).trim();

		// != null 이 아니면 실행하는 조건은 실행되지 않음. String은 무조건 null과 관련될 수 없나봄.
		if (checkValid.length() > 0) {
			return "common/redirect";
		}
		return "member/myPage";
	}

	// 개인정보 변경
	@RequestMapping("/usr/member/modify")
	public String showModify(Model model, HttpServletRequest request, String checkPasswordAuthCode) {

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		String checkValid = checkValidAuthCodeResultData(checkPasswordAuthCode, model, loginedMemberId).trim();

		if (checkValid.length() > 0) {
			return "common/redirect";
		}

		return "member/modify";
	}

	// 개인정보 변경
	@RequestMapping("/usr/member/doModify")
	public String doModify(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {

		memberService.memberDataUpdate(param);

		String redirectUri = "/usr/home/main";

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 비밀번호 변경
	@RequestMapping("/usr/member/passwordModify")
	public String showPasswordModify(String checkPasswordAuthCode, Model model, HttpServletRequest request) {

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		String checkValid = checkValidAuthCodeResultData(checkPasswordAuthCode, model, loginedMemberId).trim();

		if (checkValid.length() > 0) {
			return "common/redirect";
		}

		return "member/passwordModify";

	}

	// 비밀번호 변경
	@RequestMapping("/usr/member/doPasswordModify")
	public String doPasswordModify(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {

		Util.changeMapKey(param, "loginPwReal", "loginPw");
		memberService.passwordUpdate(param);

		String redirectUri = "/usr/home/main";

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// authCode가 유효한지 확인해주는 메서드(2번 중복되는 내용을 메서드로 만들어서 활용했음)
	public String checkValidAuthCodeResultData(String checkPasswordAuthCode, Model model, int loginedMemberId) {

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService
				.checkValidCheckPasswordAuthCode(loginedMemberId, checkPasswordAuthCode);

		if (checkPasswordAuthCode == null || checkPasswordAuthCode.length() == 0) {

			model.addAttribute("redirectUri", "/usr/member/checkPassword");
			model.addAttribute("alertMsg", "비밀번호 체크 인증코드가 없습니다.");

			return "common/redirect";

		}

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			model.addAttribute("redirectUri", "/usr/member/checkPassword");
			model.addAttribute("alertMsg", checkValidCheckPasswordAuthCodeResultData.getMsg());
			return "common/redirect";
		}

		return "";
	}

	// 로그인아이디, 비밀번호 찾기 페이지로 이동
	@RequestMapping("/usr/member/findAccount")
	public String showFindAccount(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		return "member/findAccount";
	}

	// 로그인 아이디 찾기
	@RequestMapping("/usr/member/doFindLoginId")
	public String doFindLoginId(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {

		Member member = memberService.getMemberByNameAndEmail(param);

		if (member != null) {
			model.addAttribute("redirectUri", "/usr/member/login");
			model.addAttribute("alertMsg", "찾으시는 아이디는 " + member.getLoginId() + " 입니다.");
		} else {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "일치하는 회원정보가 존재하지 않습니다.");
		}

		return "common/redirect";
	}

	// 로그인 패스워드 찾기
	@RequestMapping("/usr/member/doFindLoginPw")
	public String doFindLoginPw(@RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {

		Member member = memberService.getMemberByLoginIdAndEmail(param);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "해당 회원이 존재하지 않습니다.");
			return "common/redirect";
		}

		if (member.getEmail().equals(Util.getAsStr(param.get("email"))) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "이메일이 올바르지 않습니다.");
			return "common/redirect";
		}

		ResultData sendTempLoginPwToEmailResultData = memberService.sendTempLoginPwToEmail(member);

		if (sendTempLoginPwToEmailResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", sendTempLoginPwToEmailResultData.getMsg());
			return "common/redirect";
		}

		model.addAttribute("redirectUri", Util.getAsStr(param.get("redirectUri")));
		model.addAttribute("alertMsg", sendTempLoginPwToEmailResultData.getMsg());

		return "common/redirect";
	}

	// ajax loginId 중복 확인
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(HttpServletRequest request) {

		String loginId = request.getParameter("loginId");

		return memberService.checkLoginIdJoinable(loginId);

	}

	// ajax nickname 중복 확인
	// 사용중인 닉네임 입니다 등 중복으로 고쳤으면 좋겠음..ㅠㅠ
	@RequestMapping("/usr/member/getNicknameDup")
	@ResponseBody
	public ResultData getNicknameDup(HttpServletRequest request) {

		String nickname = request.getParameter("nickname");

		return memberService.checkNicknameJoinable(nickname);

	}

	// ajax email 중복 확인
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(HttpServletRequest request) {

		String email = request.getParameter("email");

		return memberService.checkEmailJoinable(email);

	}

	@RequestMapping("/usr/member/passwordAccountDelete")
	public String passwordAccountDelete() {
		return "member/passwordAccountDelete";
	}

	@RequestMapping("/usr/member/accountDelete")
	public String doAccountDelete(Model model, HttpSession session, @RequestParam Map<String, Object> param) {

		memberService.accountDelete(param);

		session.removeAttribute("loginedMemberId");

		String redirectUri = "/usr/home/main";

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 회원정보 페이지 이동하기 전에 비밀번호 입력하기 위한 메서드
	@RequestMapping("/usr/member/checkPassword")
	public String checkPassword(Model model, HttpSession session, @RequestParam Map<String, Object> param) {

		return "member/checkPassword";
	}

	@RequestMapping("/usr/member/doCheckPassword")
	public String doCheckPassword(Model model, String redirectUri, String loginPwReal, HttpServletRequest request) {

		String loginPw = loginPwReal;
		Member loginedMember = (Member) request.getAttribute("loginedMember");

		if (loginedMember.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		String authCode = memberService.getCheckPasswordAuthCode(loginedMember.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			// authCode를 정확하게 입력하지 않았을 때, 비밀번호 확인을 누르면
			// main으로 돌아가기에 myPage로 이동하도록 수정했음.
			// redirectUri = "/usr/home/main";
			redirectUri = "/usr/member/myPage";
		}

		redirectUri = Util.getNewUri(redirectUri, "checkPasswordAuthCode", authCode);

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

}
