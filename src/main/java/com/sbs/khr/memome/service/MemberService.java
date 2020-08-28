package com.sbs.khr.memome.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.MemberDao;
import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.dto.ResultData;
import com.sbs.khr.memome.util.Util;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MailService mailService;

	@Autowired
	private AttrService attrService;

	@Value("${custom.siteMainUri}")
	private String siteMainUri;

	@Value("${custom.siteName}")
	private String siteName;

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		sendJoinCompleteMail((String) param.get("email"));

		return Util.getAsInt(param.get("id"));
	}

	// 회원가입 완료 메일 발송 메서드
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());

	}

	// 로그인 아이디 중복 체크
	public ResultData checkLoginIdJoinable(String loginId) {

		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	// 닉네임 중복 체크
	public ResultData checkNicknameJoinable(String nickname) {

		int count = memberDao.getNicknameDupCount(nickname);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 닉네임 입니다.", "nickname", nickname);
		}

		return new ResultData("F-1", "이미 사용중인 닉네임 입니다.", "nickname", nickname);
	}

	// 이메일 중복 체크
	public ResultData checkEmailJoinable(String email) {

		int count = memberDao.getEmailDupCount(email);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 이메일 입니다.", "email", email);
		}

		return new ResultData("F-1", "이미 사용중인 이메일 입니다.", "email", email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public void memberDataUpdate(Map<String, Object> param) {
		memberDao.memberDataUpdate(param);
	}

	public void passwordUpdate(Map<String, Object> param) {

		Member member = memberDao.getMemberById(Util.getAsInt(param.get("id")));
		// attrService.setValue2("member__" + member.getId() +
		// "__extra__useTempPassword", "1");

		if (attrService.getValue("member__" + member.getId() + "__extra__useTempPassword") != null) {
			attrService.remove("member__" + member.getId() + "__extra__useTempPassword");
		}

		memberDao.passwordUpdate(param);
	}

	public Member getMemberByNameAndEmail(Map<String, Object> param) {
		return memberDao.getMemberByNameAndEmail(param);
	}

	// 비밀번호 찾기 메서드(입력한 로그인 아이디와 이메일과 일치하는 회원을 찾아오는 메서드)
	public Member getMemberByLoginIdAndEmail(Map<String, Object> param) {

		String email = Util.getAsStr(param.get("email"));

		String sha256TempPassword = Util.sha256(sendTempPasswordMail(email));

		param.put("tempPassword", sha256TempPassword);

		memberDao.saveTempPassword(param);

		Member member = getMemberByLoginId(Util.getAsStr(param.get("loginId")));

		attrService.setValue("member__" + member.getId() + "__extra__useTempPassword", "1", null);

		return memberDao.getMemberByLoginIdAndEmail(param);
	}

	// 임시 비밀번호를 사용하고 있는지 확인하기 위한 메서드
	public boolean isNeedToChangePasswordForTemp(int memberId) {
		return attrService.getValue("member__" + memberId + "__extra__useTempPassword").equals("1");
	}

	public Member getMemberById(int id) {

		return memberDao.getMemberById(id);

	}

	// getMemberByIdForSession
	// 로그인한 회원이 있다면 실행되는 메서드
	public Member getMemberByIdForSession(int id) {

		Member member = getMemberById(id);

		boolean isNeedToChangePasswordForTemp = isNeedToChangePasswordForTemp(member.getId());

		// Map은 (extra는) null로 시작된다. setExtra를 통해서 new HashMap으로 만들어 사용한다!!!
		if (member.getExtra() == null) {
			member.setExtra(new HashMap<>());
		}

		member.getExtra().put("isNeedToChangePasswordForTemp", isNeedToChangePasswordForTemp);
		System.out.println("뭐가 이리 느려?? : " + member.getExtra().get("isNeedToChangePasswordForTemp"));
		return member;
	}

	// 비밀번호를 찾기 위해 임시 비밀번호를 메일로 발송하기 위한 메서드
	private String sendTempPasswordMail(String email) {

		Member member = memberDao.getMemberByEmail(email);

		String getTempPassword = Util.getTempPassword(10);

		String mailTitle = String.format("[%s]에 요청하신 [%s]님의 임시 비밀번호를 확인해주세요.", siteName, member.getName());

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>임시 비밀번호로 접속 후 비밀번호 변경하여 사용해주세요.</h1>");
		mailBodySb.append("<h2>== 임시 비밀번호 ==</h2>");
		mailBodySb.append("<strong>" + getTempPassword + "</strong>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());

		return getTempPassword;

	}

	public void accountDelete(Map<String, Object> param) {
		memberDao.accountDelete(param);
	}

}
