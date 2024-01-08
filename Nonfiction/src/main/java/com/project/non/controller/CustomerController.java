package com.project.non.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.non.service.CustomerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerController {
	
	@Autowired
	CustomerService cs;
	
	
	@GetMapping("/customer")
	public String customer() {
		return "customer/qnaList";
	}
	
	
	@GetMapping("qnaList")
	public ModelAndView qnaList( HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		if( session.getAttribute("loginUser")==null) 
			mav.setViewName("member/login");
		else {
			HashMap<String, Object> resultMap  = cs.getQnaList( request);
			
			mav.addObject("qnaList",resultMap.get("ref_cursor") );
			mav.addObject("paging", resultMap.get("paging") );
			mav.addObject("key",resultMap.get("key") );
			mav.setViewName("customer/qnaList"); 
		}
		return mav;
	}
	
	@GetMapping("/qnaView")
	public ModelAndView qna_view(@RequestParam("qseq") int qseq	) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq", qseq );
		paramMap.put("ref_cursor", null);
		cs.getQna( paramMap );
		
		ArrayList<HashMap<String, Object>> list 
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		mav.addObject("qnaVO", list.get(0) );		
		mav.setViewName("customer/qnaView");
		
		return mav;
	}
	
	
	@GetMapping("/qnaWriteForm")
	public String qnawritreform( HttpServletRequest request) {
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) return "member/login";
	    return "customer/qnaWrite";
	}
	
	@PostMapping("/qnaWrite")
	public ModelAndView  qnaWrite(
			HttpServletRequest request,
			@RequestParam(value="secret", required=false, defaultValue="N" ) String secret,
			@RequestParam(value="pass", required=false, defaultValue="" ) String pass, 
			@RequestParam("subject") String subject,
			@RequestParam("content") String content  ) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) 
			mav.setViewName("member/login");
		else {
			// subject 와 content 를 밸리데이션하고   게시물을 레코드로 추가하세요
			if( subject == null || subject.equals("") )
				mav.setViewName("member/login");
			else if(content == null || content.equals("") )
				mav.setViewName("member/login");
			else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userid", loginUser.get("USERID") );
				paramMap.put("secret", secret);
				paramMap.put("pass", pass);
				paramMap.put("subject", subject);
				paramMap.put("content", content);
				
				cs.insertQna( paramMap );
				mav.setViewName("redirect:/qnaList");
			}
		}
		return mav;
	}
	

}
