package com.project.non.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.non.service.OrderService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {

	@Autowired
	OrderService os;
	
	@PostMapping("/orderInsert") 
	public String orderInsert( HttpServletRequest request ) {
		int oseq=0;
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			return "member/login";
		}else {
			
			// 1. 카트테이블에서 로그인 유저의 장바구니 목록 조회
			// 2. 상품목록을 orders 테이블과 order_detail 에 추가
			// 3. 카트에서 주문한 목록 삭제
			// 4. oseq 주분번호 리턴
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userid", loginUser.get("USERID") );
			paramMap.put("oseq", 0 );
			
			os.insertOrder( paramMap );
			oseq = Integer.parseInt( paramMap.get("oseq").toString() );
		}
		return "redirect:/orderList?oseq="+oseq;
	}
	
	@GetMapping( "/orderList")
	public ModelAndView orderList( @RequestParam("oseq") int oseq,
			HttpServletRequest request ) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {	
			HashMap<String , Object> paramMap = new HashMap<String , Object>();
			paramMap.put("oseq", oseq);
			paramMap.put("ref_cursor", null);
			os.listOrderByOseq( paramMap );
			
			mav.addObject("orderList", paramMap.get("ref_cursor") );
			mav.addObject("totalPrice", paramMap.get("totalPrice") );
			mav.setViewName("mypage/orderList");
		}
		return mav;
	}
	
}
