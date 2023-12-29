package com.project.non.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductController {
	
	@GetMapping("/")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		//ㅎㅇzz
		mav.setViewName("index");
		return mav;
	}
}
