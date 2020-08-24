package com.sbs.khr.memome.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.khr.memome.util.Util;

@Controller
public class TestController {
	
	@RequestMapping("/usr/test/test")
	@ResponseBody
	public String showMain() {
		String getTempPassword = Util.getTempPassword(10);
		System.out.println(getTempPassword);
		return "<h1>TestController 입니다.</h1>";
	}
	
}
