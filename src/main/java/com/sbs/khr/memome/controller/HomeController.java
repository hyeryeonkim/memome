package com.sbs.khr.memome.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.khr.memome.util.Util;

@Controller
public class HomeController {
	
	@RequestMapping("/usr/home/main")
	//@RequestMapping("/usr/home/main2")
	public String showMain() {
		return "home/main";
		//return "home/main2";
	}
	
	@RequestMapping("/")
	public String showIndex() {
		return "redirect:/usr/home/main";
		//return "redirect:/usr/home/main2";
	}
	
	
	
	

	@RequestMapping("/usr/home/mainTest")
	public String showIndex2() {
		return "home/mainTest";
	}
	
}
