package com.sbs.khr.memome.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.sbs.khr.memome.config.AppConfig;
import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.service.MemberService;
import com.sbs.khr.memome.util.Util;

@Component("beforeActionInterceptor") // 컴포넌트 이름 설정
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	@Value("${custom.logoText}")
	private String siteName;

	@Value("${spring.profiles.active}")
	private String activeProfile;

	@Autowired
	private MemberService memberService;

	@Autowired
	private AppConfig appConfig;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 기타 유용한 정보를 request에 담는다.
		Map<String, Object> param = Util.getParamMap(request);
		String paramJson = Util.toJsonStr(param);

		// Uri -> ? 과 &를 포함한 모든 주소(가 아닌가?)
		String requestUri = request.getRequestURI();
		// id=7 이 있으면 /usr/list/detail?id=8을 requestUri로 만드네? 무슨 용도지??
		String queryString = request.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			requestUri += "?" + queryString;
			System.out.println("그럼 queryString은 뭔데 : " + queryString);
		}

		String encodedRequestUri = Util.getUriEncoded(requestUri);

		request.setAttribute("requestUri", requestUri);
		request.setAttribute("encodedRequestUri", encodedRequestUri);

		System.out.println("encodedRequestUri가 뭔데?????" + encodedRequestUri);
		System.out.println("requestUri가 대체 뭔데?????" + requestUri);

		String afterLoginUri = requestUri;

		// 현재 페이지가 이미 로그인 페이지라면, 이 상태에서 로그인 버튼을 눌렀을 때 기존 param의 redirectUri가 계속 유지되도록
		// 한다.
		if (requestUri.contains("/usr/member/login") || requestUri.contains("/usr/member/join")
				|| requestUri.contains("/usr/member/findLoginId") || requestUri.contains("/usr/member/findLoginPw")) {
			afterLoginUri = Util.getString(request, "redirectUri", "");
		}

		String encodedAfterLoginUri = Util.getUriEncoded(afterLoginUri);

		request.setAttribute("afterLoginUri", afterLoginUri);
		request.setAttribute("encodedAfterLoginUri", encodedAfterLoginUri);
		request.setAttribute("param", param);
		request.setAttribute("paramJson", paramJson);

		System.out.println("param은 뭔데? : " + param);
		System.out.println("paramJson은 뭔데? : " + paramJson);

		// 해당 요청이 ajax 요청인지 아닌지 체크
		boolean isAjax = requestUri.endsWith("Ajax");

		if (isAjax == false) {
			if (param.containsKey("ajax") && param.get("ajax").equals("Y")) {
				isAjax = true;
			}
		}

		if (isAjax == false) {
			if (requestUri.contains("/get")) {
				isAjax = true;
			}
		}

		request.setAttribute("isAjax", isAjax);

		// 설정 파일에 있는 정보를 request에 담는다.
		request.setAttribute("logoText", this.siteName);
		HttpSession session = request.getSession();

		// 로그인 여부에 관련된 정보를 request에 담는다.
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			System.out.println("이 session 뭔데?????? " + session);
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			isLogined = true;
			System.out.println("loginedMemberId를 왜 불러와????? 7번 회원이 어디서 나와???  " + loginedMemberId);
			loginedMember = memberService.getMemberByIdForSession(loginedMemberId);

		}

		request.setAttribute("loginedMemberId", loginedMemberId);
		request.setAttribute("isLogined", isLogined);
		request.setAttribute("loginedMember", loginedMember);

		request.setAttribute("appConfig", appConfig);

		request.setAttribute("activeProfile", activeProfile);

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
