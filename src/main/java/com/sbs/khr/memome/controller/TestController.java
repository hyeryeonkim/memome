package com.sbs.khr.memome.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.khr.memome.dto.Member;
import com.sbs.khr.memome.service.MemberService;
import com.sbs.khr.memome.util.Util;

@Controller
public class TestController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/test/test")
	@ResponseBody
	public String showMain() {
		String getTempPassword = Util.getTempPassword(10);
		System.out.println(getTempPassword);
		return "<h1>TestController 입니다.</h1>";
	}

	/*
	 * @RequestMapping("/usr/test2/test2")
	 * 
	 * @ResponseBody public String showTest() {
	 * 
	 * Calendar cal = Calendar.getInstance();
	 * 
	 * cal.setTime(new Date());
	 * 
	 * DateFormat current = new SimpleDateFormat("yyyy-MM-dd");
	 * 
	 * //String currentStr = current + "";
	 * 
	 * 
	 * 
	 * //System.out.println("current: " + current.format(cal.getTime()));
	 * System.out.println("currentStr: " + currentStr);
	 * 
	 * cal.add(Calendar.MONTH, 3);
	 * 
	 * //String after = current.format(cal.getTime()); //String after =
	 * "2020-08-28";
	 * 
	 * DateFormat after = new SimpleDateFormat(current.format(cal.getTime()));
	 * 
	 * String afterStr = after + "";
	 * 
	 * System.out.println("after: " + current.format(cal.getTime()));
	 * 
	 * System.out.println("afterStr를 출력해봅시다! : " + after);
	 * 
	 * if ( currentStr.equals(afterStr)) { System.out.println("3개월이 경과되었습니다!!!!! ");
	 * }
	 * 
	 * 
	 * 
	 * 
	 * return "<h1>TestController 입니다.</h1>"; }
	 * 
	 */
	@RequestMapping("/usr/test3/test3")
	@ResponseBody
	public String showTest3() {

		Member member = memberService.getMemberById(1);

		//String updateDateStr = member.getUpdateDate();
		
		// 1번 [ member의 마지막 updateDate를 String으로 뽑아온다. ] 
		//String updateDateStr = "2020-05-28 10:11:11";
		String updateDateStr = "2020-05-28";
		
		// 2번 [ 날짜를 출력할 폼을 지정한다. ]
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		// 3번 [ 마지막으로 변경한 패스워드 변경일을 String에서 date 타입으로 형변환을 한다. ]
		Date updateDate = null;
		try {
			updateDate = transFormat.parse(updateDateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 4번 [ updateDateStr을 0000-00-00 형태로 날짜를 출력한다. ]
		// 그러나 updateDate는 형태가 date이므로 Thu May 28 00:00:00 KST 2020 이런값을 출력한다.
		System.out.println("updateDateStr : " + updateDateStr);
		System.out.println("updateDate (String을 Date로 형변환) 결과  : " + updateDate);

		
		// 5번 [ 캘린더로 날짜를 가져오기 위한 메서드를 입력한다. ] 
		Calendar cal = Calendar.getInstance();
		
		// 6번 [ 날짜를 가져오기 위한 캘린더에 date형태로 형변환한 updateDate를 셋팅한다. ] 
		cal.setTime(updateDate);
		
		
		// 7번 [ date형태로 날짜를 셋팅한 캘린더에 셋팅한 날짜로부터 3개월이 경과되는 코드를 입력한다. ]
		cal.add(Calendar.MONTH, 3);
		
		
		// 8번 [ 캘린더에서 현재 날짜를 얻어와 String 형태로 변환한다. ] 
		// 경과한 날짜를 비교하기 쉽도록 (String.equlas(String))을 하기 위해서.
		String currentStr = transFormat.format(cal.getTime());	
		
		// 9 번 [ updateDateStr은 마지막으로 패스워드를 변경한 날짜를 String으로 불러온다. ]
		System.out.println("마지막으로 updateDate 한 날짜 : " + updateDateStr);
		
		
		// 10번 [ currentStr은 3개월이 경과한 날짜(Date)를 String으로 형변환한 값을 가져온다. ] 
		System.out.println("3개월이 경과 한 날짜 : " + currentStr);
		
		
		// 11번 [ 마지막으로 패스워드를 변경한 날짜와(String으로 형변환한 값)  
		// if ( updatedateStr.equals(currentStr)) { ~~~~ 
		if ( "2020-08-28".equals(currentStr)) {
			System.out.println("오늘은 3개월이 경과한 날입니다.");
		}
		
		
		
		return "<h1>TestController 입니다.</h1>";
	}

}
