package com.project.non.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.non.service.ProductService;

@Controller
public class ProductController{

	@Autowired
	ProductService ps;
	
	/*
	 * @GetMapping("/") public String index() { return "index.jsp"; }
	 */
	
	@GetMapping("/category")
	public ModelAndView category( @RequestParam("shop") String shop  ) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("shop", shop);
		paramMap.put("ref_cursor", null);
		ps.getShopList( paramMap );
		ArrayList< HashMap<String, Object> > list 
			= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor"); 
		mav.addObject("productShopList" , list); 		
		mav.setViewName( "product/productShop");
		
		return mav;
	}
	
	@GetMapping("/bestCategory")
	public ModelAndView bestCategory( @RequestParam("bestyn") String bestyn) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bestyn", bestyn);
		paramMap.put("ref_cursor", null);
		ps.getbestList( paramMap );
		ArrayList< HashMap<String, Object> > list 
			= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor"); 
		mav.addObject("productShopList" , list); 		
		mav.setViewName( "product/productShop");
		
		return mav;
	}
	
	@GetMapping("/productDetail")
	public ModelAndView productDetail( @RequestParam("pseq") int pseq ) {
				
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pseq", pseq);
		paramMap.put("ref_cursor", null);
		ps.getProduct( paramMap );
		ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		HashMap<String, Object> resultMap = list.get(0);
		mav.addObject("productVO" , resultMap);
		mav.setViewName("product/productDetail");
		return mav;
	}
	
	
}
