package com.project.non.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.non.dto.MemberVO;
import com.project.non.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MemberController {
	
	@Autowired
	MemberService ms;
	

	@GetMapping("/loginForm")
	public String loginForm() {
		return "member/login";
	}

	@PostMapping("/login")
	public String login( @ModelAttribute("dto") @Valid MemberVO membervo, 
			BindingResult result, HttpServletRequest request , Model model ) {
		
		String url="member/login";
		if( result.getFieldError("userid")!=null)
			model.addAttribute("message", result.getFieldError("userid").getDefaultMessage() );
		else if( result.getFieldError("pwd")!=null)
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
		else {
			HashMap<String, Object> paramMap  = new HashMap<String, Object>();
			paramMap.put("userid", membervo.getUserid() );
			paramMap.put("ref_cursor", null );
			ms.getMember( paramMap );

			ArrayList< HashMap<String, Object> > list
				= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor");
		
			if( list==null || list.size() == 0 ) {
				model.addAttribute("message" , "아이디가 없습니다");
				return "member/login";
			}
			HashMap<String, Object> memberMap = list.get(0);
			
			if( memberMap.get("USEYN").equals("N") )
				model.addAttribute("message" , "회원탈퇴 이력이 있습니다. 고객센터에 문의 바랍니다");
			else if( !memberMap.get("PWD").equals( membervo.getPwd() ) )
				model.addAttribute("message" , "비밀번호가 맞지 않습니다");
			else if( memberMap.get("PWD").equals( membervo.getPwd() ) ) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", memberMap);
				url = "redirect:/";
			}
		}
		return url;
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@GetMapping("/contract")
	public String contract() {
		return "member/contract";
	}
	
	@PostMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	@GetMapping("/idCheckForm")
	public ModelAndView idCheckForm( @RequestParam("userid") String userid ) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userid", userid);
		paramMap.put("ref_cursor", null);
		ms.getMember(paramMap);  
		
		ArrayList< HashMap<String, Object> > list 
			= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor");
		
		if( list==null || list.size() == 0) mav.addObject("result" , -1);
		else mav.addObject("result", 1);		
		
		mav.addObject("userid", userid);
		mav.setViewName("member/idcheck");
		
		return mav;
	}
	
	@PostMapping("/join")
	public String join(
			@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value="reid", required=false) String reid,
			@RequestParam(value="pwdCheck", required=false) String pwdCheck,
			Model model
	) {
		String url = "member/joinForm";
		if( result.getFieldError("userid")!=null)
			model.addAttribute("message", result.getFieldError("userid").getDefaultMessage());
		else if( result.getFieldError("pwd")!=null)
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
		else if( result.getFieldError("name")!=null)
			model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
		else if( result.getFieldError("phone")!=null)
			model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
		else if( result.getFieldError("email")!=null)
			model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
		else if( reid == null || ( !reid.equals(membervo.getUserid() ) ) )
			model.addAttribute("message", "아이디 중복체크를 하지 않으셨습니다");
		else if( pwdCheck == null || !pwdCheck.equals( membervo.getPwd() ) )
			model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다");
		else {
			HashMap<String , Object> paramMap = new HashMap<String, Object>();
			String userid = membervo.getUserid();
			paramMap.put("userid", userid);
			paramMap.put("pwd", membervo.getPwd() );
			paramMap.put("name", membervo.getName() );
			paramMap.put("email", membervo.getEmail() );
			paramMap.put("phone", membervo.getPhone() );
			paramMap.put("zip_num", membervo.getZip_num() );
			paramMap.put("address1", membervo.getAddress1() );
			paramMap.put("address2", membervo.getAddress2() );
			paramMap.put("address3", membervo.getAddress3() );
			ms.insertMember( paramMap );
			model.addAttribute("message", "회원가입이 완료되었습니다");
			url = "member/login";
		}		
		return url;
	}
	
	@GetMapping("/loginCancle")
	public String cancle() {
		return "member/login";
	}
	
	@RequestMapping("/memberUpdate")
	public String memberUpdate(
			@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value="pwdCheck", required=false) String pwdCheck,
			Model model, HttpServletRequest request
	) {
		String url="member/memberUpdate";
		
			
		if( result.getFieldError("pwd") != null )
				model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
		else if( result.getFieldError("name") != null )
				model.addAttribute("message", result.getFieldError("name").getDefaultMessage() );
		else if( result.getFieldError("email") != null )
				model.addAttribute("message", result.getFieldError("email").getDefaultMessage() );
		else if( result.getFieldError("phone") != null )
				model.addAttribute("message", result.getFieldError("phone").getDefaultMessage() );
		else if( pwdCheck == null || ( !pwdCheck.equals(membervo.getPwd() ) ) ) 
				model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다");
		else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("USERID", membervo.getUserid() );   
				paramMap.put("PWD", membervo.getPwd() );
				paramMap.put("NAME", membervo.getName() );
				paramMap.put("EMAIL", membervo.getEmail() );
				paramMap.put("PHONE", membervo.getPhone() );
				paramMap.put("ZIP_NUM", membervo.getZip_num() );
				paramMap.put("ADDRESS1", membervo.getAddress1() );
				paramMap.put("ADDRESS2", membervo.getAddress2() );
				paramMap.put("ADDRESS3", membervo.getAddress3() );
				ms.updateMember( paramMap );
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", paramMap);
				url = "redirect:/";
		}
		return url;
	}
	
}
