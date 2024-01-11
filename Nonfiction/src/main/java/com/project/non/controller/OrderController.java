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

	
	@GetMapping("/orderList")
	public ModelAndView orderList( HttpServletRequest request ) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {	
			HashMap<String , Object> paramMap = new HashMap<String , Object>();
			paramMap.put("userid", loginUser.get("USERID"));
			paramMap.put("ref_cursor", null);
			os.listOrderByOseq( paramMap );
			
			mav.addObject("orderList", paramMap.get("ref_cursor") );
			mav.addObject("totalPrice", paramMap.get("totalPrice") );
			mav.setViewName("mypage/orderList");
		}
		return mav;
	}
<<<<<<< HEAD
	

=======
	
>>>>>>> branch 'main' of https://github.com/connie0714/Nonfiction.web.git
	@PostMapping("/orderInsertOne")
	public String orderInsertOne(
			@RequestParam("pseq") int pseq,
			@RequestParam("quantity") int quantity,
			HttpServletRequest request ) {
		int oseq = 0;
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
		= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			return "member/login";
		}else {
			// userid, pseq, quantity 전송
			// oseq 수신   
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userid", loginUser.get("USERID") );
			paramMap.put("pseq", pseq);
			paramMap.put("quantity", quantity);
			paramMap.put("oseq", 0); 
			
			os.insertOrderOne( paramMap );
			oseq = (Integer) paramMap.get("oseq");
		}
		return "redirect:/orderList?oseq="+oseq;
		
	}	
	
	@GetMapping( "/orderList")
	public ModelAndView mypage( HttpServletRequest request ) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {
			// 로그인한 사람의 아이디를 보내서, 현재 진행중인 주문내역을  "XXX 상품 포함 X건" 형태의 리스트로 정리해서 리턴
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userid",  loginUser.get("USERID") );
			paramMap.put("ref_cursor", null);
			os.orderList(paramMap);
			
			mav.addObject("orderList", paramMap.get("finalList"));		
			mav.addObject("title", " 진행중인 주문내역");
			mav.setViewName("mypage/orderList");
		}
		return mav;
	}
	
	
	
	@GetMapping("/orderDetail")
	public ModelAndView orderDetail( 
			HttpServletRequest request, 
			@RequestParam("oseq") int oseq ) {
		
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
			os.listOrderByOseq(paramMap);
			mav.addObject("totalPrice", paramMap.get("totalPrice"));
			mav.addObject("orderList", paramMap.get("ref_cursor") );
			// service에서 넣어준 리스트의 첫번째객체
			mav.addObject("orderDetail", paramMap.get("orderDetail") ); 
			mav.setViewName("mypage/orderDetail");
		}
		return mav;
	}
	
	@GetMapping("/orderEnd")
	public String orderEnd( @RequestParam("odseq") int odseq,
			@RequestParam("oseq") int oseq ) {
		
		os.orderEnd( odseq );
		
		return "redirect:/orderDetail?oseq=" + oseq;
	}
	
}
