package com.project.non.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	         url="redirect:/productList";
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
	 
	 
	 @GetMapping("/adminBannerList")
		public ModelAndView adminBannerList( ) {
			ModelAndView mav = new ModelAndView();
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ref_cursor", null);
			as.getBannerList(paramMap);
			mav.addObject("bannerList",  paramMap.get("ref_cursor") );
			mav.setViewName("admin/banner/bannerList");
			return mav;
		}
		
		
		@GetMapping("/newBannerWrite")
		public String newBannerWrite() {
			return "admin/banner/writeBanner";
		}
		
		
		@PostMapping("/bannerWrite" )
		public String bannerWrite( HttpServletRequest request	) {		
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("subject", request.getParameter("subject") );
			paramMap.put("order_seq", request.getParameter("order_seq") );
			paramMap.put("image", request.getParameter("image") );
			
			if( request.getParameter("order_seq").equals("6") ) paramMap.put("useyn", "N" );
			else paramMap.put("useyn", "Y" );
			
			as.insertBanner( paramMap );
			return "redirect:/adminBannerList";
		}
		
		@PostMapping("/fileup")
		@ResponseBody    // 자신을 호출하는 곳으로 "리턴되는 데이터"를 갖고 이동하여 페이지에 표시하라는 뜻
		public HashMap<String, Object> fileup( 
				@RequestParam("fileimage") MultipartFile file, 
				HttpServletRequest request, Model model ) {
				
			String path = context.getRealPath("/product_images");
			Calendar today = Calendar.getInstance();
	 		long t = today.getTimeInMillis();
	 		
	 		String filename = file.getOriginalFilename();
	 		String fn1 = filename.substring(0, filename.indexOf(".") );  // 파일이름과 확장장 분리
	 		String fn2 = filename.substring(filename.indexOf(".") );
	 		String uploadPath = path + "/" + fn1 + t + fn2;
	 		System.out.println("파일 저장 경로 = " + uploadPath);
	 		
	 		HashMap<String, Object> result = new HashMap<String, Object>();
	 		try {
				file.transferTo( new File(uploadPath) );
				result.put("STATUS", 1);  // 파일 전송 상태
				result.put("FILENAME", fn1 + t +  fn2 );
			} catch (IllegalStateException e) { 
				e.printStackTrace();  result.put("STATUS", 0); 
			} catch (IOException e) { 
				e.printStackTrace();  result.put("STATUS", 0); 
			}  
			return result;
		}
		
	}
	

