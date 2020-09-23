package com.sbs.khr.memome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.MemberDao;
import com.sbs.khr.memome.dto.Article;
import com.sbs.khr.memome.dto.File;
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
	
	@Autowired
	private ArticleService articleService;

	@Value("${custom.siteMainUri}")
	private String siteMainUri;

	@Value("${custom.siteName}")
	private String siteName;


	
	
	// 회원가입 
	public int join(Map<String, Object> param) {
		memberDao.join(param);
		int id = Util.getAsInt(param.get("id"));
		attrService.setValue("member", id, "extra", "lastPasswordUpdateDate", "1", null);
		sendJoinCompleteMail((String) param.get("email"));

		return id;
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
	
	
	// 전화번호 중복 체크 
	public ResultData checkCellphoneNoJoinable(String cellphoneNo) {
		int count = memberDao.getCellphoneNoDupCount(cellphoneNo);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 전화번호 입니다.", "cellphoneNo", cellphoneNo);
		}

		return new ResultData("F-1", "이미 사용중인 전화번호 입니다.", "cellphoneNo", cellphoneNo);

	}



	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}
	
		
	// 회원정보 변경 (업데이트 저장)
	public void memberDataUpdate(Map<String, Object> param) {

		memberDao.memberDataUpdate(param);

		Member member = memberDao.getMemberByEmail(Util.getAsStr(param.get("email")));

	}
	// 비밀번호 변경 (업데이트 저장)
	public void passwordUpdate(Map<String, Object> param) {

		Member member = memberDao.getMemberById(Util.getAsInt(param.get("id")));
		
		if (attrService.getValue("member", member.getId(), "extra", "lastPasswordUpdateDate") != null ) {
			attrService.updateValue("member", member.getId(), "extra", "lastPasswordUpdateDate", "1", null);
		}

		if (attrService.getValue("member__" + member.getId() + "__extra__modifyPrivateAuthCode") != null) {
			attrService.remove("member__" + member.getId() + "__extra__modifyPrivateAuthCode");
		}

		if (param.get("loginPw") != null) {
			setNotUsingTempPassword(member.getId());
		}

		memberDao.passwordUpdate(param);
	}
	
	//public boolean checkLastPasswordUpdateDate

	public Member getMemberByNameAndEmail(Map<String, Object> param) {
		return memberDao.getMemberByNameAndEmail(param);
	}

	public Member getMemberByLoginIdAndEmail(Map<String, Object> param) {

		return memberDao.getMemberByLoginIdAndEmail(param);
	}

	// 임시 비밀번호를 사용하고 있는지 확인하기 위한 메서드
	public boolean isNeedToChangePasswordForTemp(int memberId) {
		return attrService.getValue("member__" + memberId + "__extra__useTempPassword").equals("1");
	}

	public Member getMemberById(int id) {

		return memberDao.getMemberById(id);

	}
	
	// ★★★★★
	// getMemberByIdForSession
	// 로그인한 회원이 있다면 실행되는 메서드
	public Member getMemberByIdForSession(int id) {

		Member member = getMemberById(id);
		System.out.println("loginedMemberId를 왜 불러와????? 7번 회원이 어디서 나와???  " + id);
		boolean isNeedToChangePasswordForTemp = isNeedToChangePasswordForTemp(member.getId());
		
		// ★★★★★
		// Map은 (extra는) null로 시작된다. setExtra를 통해서 new HashMap으로 만들어 사용한다!!!
		if (member.getExtra() == null) {
			member.setExtra(new HashMap<>());
		}

		member.getExtra().put("isNeedToChangePasswordForTemp", isNeedToChangePasswordForTemp);
		
		return member;
	}
	
	// 회원탈퇴 
	public void accountDelete(Map<String, Object> param) {
		
		System.out.println("param 아닌가?? " + param);
		
		int memberId = Util.getAsInt(param.get("memberId"));
		
		System.out.println("memberId가 아닌가?? " + memberId);
		
		List<Article> articles = articleService.getForAccountDeleteArticlesByMemberId(memberId);
		
		System.out.println("뭐야??  :" +   articles );
		
		for ( Article article : articles ) {
			Map<String, Object> newParam = Util.getNewMapOf(param, "memberId");
			System.out.println(newParam);
			newParam.put("id", article.getId());
			articleService.memoDelete(newParam);
		}
		
		
		memberDao.accountDelete(param);
	}
	
	
	// authCode(랜덤코드) 만들어서 return하는 메서드
	public String getCheckPasswordAuthCode(int memberId) {
		// random 코드를 자동으로 만들어준다.
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + memberId + "__extra__modifyPrivateAuthCode", authCode,
				Util.getDateStrLater(60 * 60));

		return authCode;
	}
	
	// 개인정보 변경을 위해 부여한 authCode가 존재(db저장된)하는 코드인지, 아닌지 확인해주는 메서드 
	public ResultData checkValidCheckPasswordAuthCode(int memberId, String checkPasswordAuthCode) {

		if (attrService.getValue("member__" + memberId + "__extra__modifyPrivateAuthCode")
				.equals(checkPasswordAuthCode)) {

			return new ResultData("S-1", "유효한 키 입니다.", "", "");
		}
		return new ResultData("F-1", "유효하지 않은 키 입니다.", "", "");

	}

	// 임시 패스워드를 이메일로 발송
	public ResultData sendTempLoginPwToEmail(Member member) {

		String getTempPassword = Util.getTempPassword(10);

		String mailTitle = String.format("[%s]에 요청하신 [%s]님의 임시 비밀번호를 확인해주세요.", siteName, member.getName());

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>임시 비밀번호로 접속 후 비밀번호 변경하여 사용해주세요.</h1>");
		mailBodySb.append("<h2>== 임시 비밀번호 ==</h2>");
		mailBodySb.append("<strong>" + getTempPassword + "</strong>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

		ResultData sendResultData = mailService.send(member.getEmail(), mailTitle, mailBodySb.toString());

		if (sendResultData.isFail()) {
			return sendResultData;
		}
		
		setTempPassword(member, getTempPassword);

		return new ResultData("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");

	}
	
	// 이메일로 발송한 임시패스워드 저장하는 메서드 
	public void setTempPassword(Member member, String getTempPassword) {

		Map<String, Object> passwordModifyParam = new HashMap<>();
		passwordModifyParam.put("loginPw", Util.sha256(getTempPassword));
		passwordModifyParam.put("loginId", member.getLoginId());
		passwordModifyParam.put("email", member.getEmail());
		System.out.println(passwordModifyParam);

		// 주의할 점 : 필히 먼저 패스워드를 저장한 후에, 임시 패스워드를 사용 중이라고 set해야 한다.
		// 그러지 않으면 임시패스 워드를 사용하고 있는 상태에서 패스워드가 입력되므로 바로 임시패스워드 사용 변수가 remove 된다.
		memberDao.passwordUpdate(passwordModifyParam);

		setUsingTempPassword(member.getId());

	}

	// 임시패스워드를 사용하고 있다고 셋팅
	public void setUsingTempPassword(int id) {
		attrService.setValue("member", id, "extra", "useTempPassword", "1", null);
	}

	// 임시패스워드를 사용하고 있지 않다고 셋팅
	public void setNotUsingTempPassword(int id) {
		attrService.remove("member", id, "extra", "useTempPassword");
	}

	// 임시패스워드를 사용중인지 알려주는 메서드(memberController에서 호출하고 있음)
	public boolean usingTempPassword(int id) {

		String value = attrService.getValue("member", id, "extra", "useTempPassword");

		if (value == null || value.equals("1") == false) {
			return false;
		}
		return true;
	}
	
	// id = memberId
	public String getLastPasswordModify(int id) {
		
		if ( attrService.getValue("member", id, "extra", "lastPasswordUpdateDate") != null ) {
			return attrService.get("member", id, "extra", "lastPasswordUpdateDate").getUpdateDate();
		}
		
		return "";
	}

	public Member getMemberByEmail(String email) {
		return memberDao.getMemberByEmail(email);
	}

	
}
