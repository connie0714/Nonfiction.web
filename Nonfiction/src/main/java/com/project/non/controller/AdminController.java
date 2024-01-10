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

import com.project.non.service.AdminService;
import com.project.non.service.CustomerService;
import com.project.non.service.MemberService;
import com.project.non.service.ProductService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	AdminService as;
	
	@Autowired
	ProductService ps;
	
	@Autowired
	ServletContext context;
	
	@Autowired
	MemberService ms;
	
	@Autowired
	CustomerService cs;
	
	@GetMapping("/admin")
	public String admin() {
		return "admin/adminLoginForm";
	}
	
	@PostMapping("/adminLogin")
	public String adminLogin( @RequestParam(value="adminid", required=false) String adminid,
							  @RequestParam(value="adminpwd", required=false) String adminpwd,
							  HttpServletRequest request, Model model) {
		String url="admin/adminLoginForm";
		 if(adminid==null || adminid.equals("")) {
	         model.addAttribute("message", "아이디를 입력하세요");
	      }else if(adminpwd==null || adminpwd.equals("")) {
	         model.addAttribute("message", "비밀번호를 입력하세요");
	      }else {
	      HashMap<String, Object> paramMap = new HashMap<String, Object>();
	      paramMap.put("adminid", adminid);
	      paramMap.put("ref_cursor", null);
	      as.getAdmin(paramMap);
	      
	      ArrayList< HashMap<String, Object> > list 
	      = (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor");
	      
	      if(list==null || list.size()==0) {
	         model.addAttribute("message","아이디가 없습니다.");
	         return "admin/adminLoginForm";
	      }
	      HashMap<String,Object> resultMap=list.get(0);
	      if(!adminpwd.equals((String)resultMap.get("PWD")))
	         model.addAttribute("message","비밀번호가 맞지 않습니다");
	      else if(adminpwd.equals((String)resultMap.get("PWD"))) {
	         HttpSession session=request.getSession();
	         session.setAttribute("loginAdmin", resultMap);
	         url="admin/sub_menu";
	      }
	     }
		return url;
	}
	
	
	
	
	 @GetMapping("/productList")
	   public ModelAndView productList( HttpServletRequest request ) {
	      ModelAndView mav = new ModelAndView();
	      HttpSession session = request.getSession();
	      if( session.getAttribute("loginAdmin")==null) 
	         mav.setViewName("admin/adminLoginForm");
	      else {
	         HashMap<String, Object> paramMap = new HashMap<String, Object>();
	         paramMap.put("request", request);
	         paramMap.put( "ref_cursor", null );
	         as.getProductList( paramMap );
	         
	         // HashMap<String, Object> paramMap = as.getProductList( request );

	         mav.addObject("productList", paramMap.get("ref_cursor"));
	         mav.addObject("paging", paramMap.get("paging") );
	         mav.addObject("key", paramMap.get("key") );
	      
	         mav.setViewName("admin/product/productList");
	      }
	      return mav;
	   }
	 
	 
	 @GetMapping("/adminQnaList")
		public ModelAndView adminQnaList( HttpServletRequest request ) {
			ModelAndView mav = new ModelAndView();
			
			HttpSession session = request.getSession();
			if( session.getAttribute("loginAdmin")==null) 
				mav.setViewName("admin/adminLoginForm");
			else {
				HashMap<String, Object> resultMap  = as.getQnaList( request );
				
				mav.addObject("qnaList",resultMap.get("ref_cursor") );
				mav.addObject("paging", resultMap.get("paging") );
				mav.addObject("key",resultMap.get("key") );
				mav.setViewName("admin/qna/adminQnaList");
			}
			return mav;
		}
	 
	 @GetMapping("/adminQnaView")
		public ModelAndView adminQnaView(@RequestParam("qseq")int qseq) {
			ModelAndView mav = new ModelAndView();
			
				HashMap<String , Object>paramMap = new HashMap<String, Object>();
				paramMap.put("qseq", qseq);
				paramMap.put("ref_cursor", null);
				cs.getQna(paramMap);
				ArrayList< HashMap<String , Object> > list
					=(ArrayList< HashMap<String , Object> >) paramMap.get("ref_cursor");
				
				HashMap<String , Object> qvo = list.get(0);
				mav.addObject("qnaVO", qvo);
				mav.setViewName("admin/qna/adminQnaView");
				
				return mav;	
	 }
	 
	 @PostMapping("/adminQnaRepSave")
		public String adminQnaRepSave(@RequestParam("qseq")int qseq,@RequestParam("reply")String reply) {
			HashMap<String , Object>paramMap = new HashMap<String, Object>();
			paramMap.put("qseq", qseq);
			paramMap.put("reply", reply);
			as.updateQna(paramMap);
			return "redirect:/adminQnaView?qseq="+qseq;
			
		}
	 
	 
	 @GetMapping("/memberList")
		public ModelAndView memberList( HttpServletRequest request ) {
			ModelAndView mav = new ModelAndView();
			
			HttpSession session = request.getSession();
			if( session.getAttribute("loginAdmin")==null) 
				mav.setViewName("admin/adminLoginForm");
			else {
				HashMap<String, Object> resultMap  = as.getMemberList( request );
				
				mav.addObject("memberList",resultMap.get("ref_cursor") );
				mav.addObject("paging", resultMap.get("paging") );
				mav.addObject("key",resultMap.get("key") );
				mav.setViewName("admin/member/memberList");
			}
			return mav;
	 }
	 
	 @GetMapping("/memberReinsert")
		public String memberReinsert(@RequestParam("userid")String userid, @RequestParam("useyn")String useyn) {
			
			if(useyn.equals("Y"))useyn="N";
			else useyn="Y";
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userid", userid);				
			paramMap.put("useyn", useyn);
			
			as.memberReinsert(paramMap);
			return "redirect:/memberList";
		}
	
}
