package com.project.non.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.non.service.CartService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {

	@Autowired
	CartService cs;
	
	@PostMapping("/cartInsert")
	public String cartInsert(
		@RequestParam("pseq") int pseq,
		@RequestParam("quantity") int quantity,
		HttpServletRequest request, Model model
	){
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			return "member/login";
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userid", loginUser.get("USERID") );
			paramMap.put("pseq", pseq);
			paramMap.put("quantity", quantity);
			cs.insertCart( paramMap );
		}
		return "redirect:/cartList";
	}
	
	
	@GetMapping("/cartList")
	public ModelAndView cartList( HttpServletRequest request  ) {	
		ModelAndView mav = new ModelAndView();
		// 로그인 된 상태에서 로그인 유저의 아이디로 카트리스트를 조회해서 jsp로 이동합니다
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			=  (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null  ) {
			mav.setViewName("member/login");
		}else {
			HashMap<String , Object> paramMap = new HashMap<String , Object>();
			paramMap.put("userid", loginUser.get("USERID"));
			paramMap.put("ref_cursor", null);
			cs.listCart( paramMap );
			ArrayList<HashMap<String, Object>> list
				=(ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			mav.addObject("totalPrice", (Integer) paramMap.get("totalPrice") );	
			mav.addObject("cartList", list);
		}
		mav.setViewName("cart/cartList");
		return mav;
	}
	
	
	@PostMapping("/cartDelete")
	public String cartDelete( HttpServletRequest request,
			@RequestParam("cseq") String [] cseqArr ) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cseqArr", cseqArr);
		
		cs.deleteCart( paramMap );
		
		return "redirect:/cartList";
	}
}
