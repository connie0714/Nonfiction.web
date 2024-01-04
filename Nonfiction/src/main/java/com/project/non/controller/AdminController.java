package com.project.non.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.non.service.AdminService;
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
	
}
