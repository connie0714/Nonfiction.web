package com.project.non.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.ModelAndView;


import com.google.gson.Gson;
import com.project.non.dto.EmailCheckReq;
import com.project.non.dto.KakaoProfile;
import com.project.non.dto.KakaoProfile.KakaoAccount;
import com.project.non.dto.KakaoProfile.KakaoAccount.Profile;
import com.project.non.dto.MemberVO;
import com.project.non.dto.OAuthToken;
import com.project.non.service.CartService;
import com.project.non.service.EmailService;
import com.project.non.service.MemberService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MemberController {

   @Autowired
   MemberService ms;

   @Autowired
   EmailService es;
   

   @GetMapping("/loginForm")
   public String loginForm() {
	   return "member/login";
   }
  
   @PostMapping("/login")
   public String login(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
         HttpServletRequest request, Model model) {
	
      String url = "member/login";
      if (result.getFieldError("userid") != null)
         model.addAttribute("message", result.getFieldError("userid").getDefaultMessage());
      else if (result.getFieldError("pwd") != null)
         model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
      else {
         HashMap<String, Object> paramMap = new HashMap<String, Object>();
         paramMap.put("userid", membervo.getUserid());
         paramMap.put("ref_cursor", null);
         ms.getMember(paramMap);

         ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

         if (list == null || list.size() == 0) {
            model.addAttribute("message", "아이디가 없습니다");
            return "member/login";
         }
         HashMap<String, Object> memberMap = list.get(0);

         if (memberMap.get("USEYN").equals("N"))
            model.addAttribute("message", "회원탈퇴 이력이 있습니다. 고객센터에 문의 바랍니다");
         else if (!memberMap.get("PWD").equals(membervo.getPwd()))
            model.addAttribute("message", "비밀번호가 맞지 않습니다");
         else if (memberMap.get("PWD").equals(membervo.getPwd())) {
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

	@GetMapping("/kakaostart")
   public @ResponseBody String kakaostart() {

      String a = "<script type='text/javascript'>" + "location.href='https://kauth.kakao.com/oauth/authorize?"
            + "client_id=8ff5ea79e1ba676b9ff4efb6647881e3" + "&redirect_uri=http://localhost:8070/kakaoLogin"
            + "&response_type=code';" + "</script>";
      return a;
   }

   @RequestMapping("/kakaoLogin")
   public String loginKakao(HttpServletRequest request) throws UnsupportedEncodingException, IOException {

      String code = request.getParameter("code");
      String endpoint = "https://kauth.kakao.com/oauth/token";
      URL url = new URL(endpoint);
      String bodyData = "grant_type=authorization_code&";
      bodyData += "client_id=8ff5ea79e1ba676b9ff4efb6647881e3&";
      bodyData += "redirect_uri=http://localhost:8070/kakaoLogin&";
      bodyData += "code=" + code;

      HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // import java.net.HttpURLConnection;
      conn.setRequestMethod("POST");
      conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
      conn.setDoOutput(true);
      BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
      bw.write(bodyData);
      bw.flush();
      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
      String input = "";
      StringBuilder sb = new StringBuilder();
      while ((input = br.readLine()) != null) {
         sb.append(input);
         System.out.println(input);
      }
      Gson gson = new Gson();
      OAuthToken oAuthToken = gson.fromJson(sb.toString(), OAuthToken.class);
      String endpoint2 = "https://kapi.kakao.com/v2/user/me";
      URL url2 = new URL(endpoint2);

      HttpsURLConnection conn2 = (HttpsURLConnection) url2.openConnection();
      conn2.setRequestProperty("Authorization", "Bearer " + oAuthToken.getAccess_token());
      conn2.setDoOutput(true);
      BufferedReader br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
      String input2 = "";
      StringBuilder sb2 = new StringBuilder();
      while ((input2 = br2.readLine()) != null) {
         sb2.append(input2);
         System.out.println(input2);
      }

      Gson gson2 = new Gson();
      KakaoProfile kakaoProfile = gson2.fromJson(sb2.toString(), KakaoProfile.class);
      KakaoAccount ac = kakaoProfile.getAccount();
      Profile pf = ac.getProfile();

      HashMap<String, Object> paramMap = new HashMap<String, Object>();
      paramMap.put("userid", kakaoProfile.getId());
      paramMap.put("ref_cursor", null);
      ms.getMember(paramMap);

      ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

      if (list == null || list.size() == 0) {

         paramMap.put("userid", kakaoProfile.getId());
         paramMap.put("email", "kakao");
         paramMap.put("name", pf.getNickname());
         System.out.println("99" + pf.getNickname());
         paramMap.put("provider", "kakao");
         paramMap.put("phone", "kakao");
         ms.joinKakao(paramMap);

         paramMap.put("ref_cursor", null);
         ms.getMember(paramMap);
         list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
      }

      HashMap<String, Object> memberMap = list.get(0);
      HttpSession session = request.getSession();
      session.setAttribute("loginUser", memberMap);
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
   public ModelAndView idCheckForm(@RequestParam("userid") String userid) {
      ModelAndView mav = new ModelAndView();

      HashMap<String, Object> paramMap = new HashMap<String, Object>();
      paramMap.put("userid", userid);
      paramMap.put("ref_cursor", null);
      ms.getMember(paramMap);

      ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

      if (list == null || list.size() == 0)
         mav.addObject("result", -1);
      else
         mav.addObject("result", 1);

      mav.addObject("userid", userid);
      mav.setViewName("member/idcheck");

      return mav;
   }

   @PostMapping("/join")
   public String join(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
         @RequestParam(value = "reid", required = false) String reid,
         @RequestParam(value = "pwdCheck", required = false) String pwdCheck, Model model) {
      String url = "member/joinForm";
      if (result.getFieldError("userid") != null)
         model.addAttribute("message", result.getFieldError("userid").getDefaultMessage());
      else if (result.getFieldError("pwd") != null)
         model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
      else if (result.getFieldError("name") != null)
         model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
      else if (result.getFieldError("phone") != null)
         model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
      else if (result.getFieldError("email") != null)
         model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
      else if (reid == null || (!reid.equals(membervo.getUserid())))
         model.addAttribute("message", "아이디 중복체크를 하지 않으셨습니다");
      else if (pwdCheck == null || !pwdCheck.equals(membervo.getPwd()))
         model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다");
      else {
         HashMap<String, Object> paramMap = new HashMap<String, Object>();
         String userid = membervo.getUserid();
         paramMap.put("userid", userid);
         paramMap.put("pwd", membervo.getPwd());
         paramMap.put("name", membervo.getName());
         paramMap.put("email", membervo.getEmail());
         paramMap.put("phone", membervo.getPhone());
         paramMap.put("zip_num", membervo.getZip_num());
         paramMap.put("address1", membervo.getAddress1());
         paramMap.put("address2", membervo.getAddress2());
         paramMap.put("address3", membervo.getAddress3());
         ms.insertMember(paramMap);
         model.addAttribute("message", "회원가입이 완료되었습니다");
         url = "member/login";
      }
      return url;
   }

   @ResponseBody
   @PostMapping("/emailCheck")
   public String EmailCheck(@RequestBody EmailCheckReq emailCheckReq)
         throws MessagingException, UnsupportedEncodingException {
      String authCode = es.sendEmail(emailCheckReq.getEmail());
      return authCode;
   }

   @GetMapping("/loginCancle")
   public String cancle() {
      return "member/login";
   }

   @GetMapping("/memberEditForm")
   public ModelAndView memberEditForm(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();

      MemberVO dto = new MemberVO(); // 저장용 객체
      HttpSession session = request.getSession();
      HashMap<String, Object> loginUser = (HashMap<String, Object>) session.getAttribute("loginUser");

      dto.setUserid((String) loginUser.get("USERID"));
      dto.setName((String) loginUser.get("NAME"));
      dto.setEmail((String) loginUser.get("EMAIL"));
      dto.setPhone((String) loginUser.get("PHONE"));
      dto.setZip_num((String) loginUser.get("ZIP_NUM"));
      dto.setAddress1((String) loginUser.get("ADDRESS1"));
      dto.setAddress2((String) loginUser.get("ADDRESS2"));
      dto.setAddress3((String) loginUser.get("ADDRESS3"));

      mav.addObject("dto", dto);

      mav.setViewName("member/memberUpdate");
      return mav;
   }

   @PostMapping("/memberUpdate")
   public String memberUpdate(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
         @RequestParam(value = "pwdCheck", required = false) String pwdCheck, Model model,
         HttpServletRequest request) {
      String url = "member/memberUpdate";

      if (result.getFieldError("pwd") != null)
         model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
      else if (result.getFieldError("name") != null)
         model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
      else if (result.getFieldError("email") != null)
         model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
      else if (result.getFieldError("phone") != null)
         model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
      else if (pwdCheck == null || (!pwdCheck.equals(membervo.getPwd())))
         model.addAttribute("message", "비밀번호 확인이 일치하지 않습니다");
      else {
         HashMap<String, Object> paramMap = new HashMap<String, Object>();
         paramMap.put("USERID", membervo.getUserid());
         paramMap.put("PWD", membervo.getPwd());
         paramMap.put("NAME", membervo.getName());
         paramMap.put("EMAIL", membervo.getEmail());
         paramMap.put("PHONE", membervo.getPhone());
         paramMap.put("ZIP_NUM", membervo.getZip_num());
         paramMap.put("ADDRESS1", membervo.getAddress1());
         paramMap.put("ADDRESS2", membervo.getAddress2());
         paramMap.put("ADDRESS3", membervo.getAddress3());
         ms.updateMember(paramMap);
         HttpSession session = request.getSession();
         session.setAttribute("loginUser", paramMap);
         url = "redirect:/";
      }
      return url;
   }

   @RequestMapping("/deleteMember")
   public String withdrawal(HttpServletRequest request, Model model) {

      HttpSession session = request.getSession();
      HashMap<String, Object> mvo = (HashMap<String, Object>) session.getAttribute("loginUser");
      String userid = (String) mvo.get("USERID");
      HashMap<String, Object> paramMap = new HashMap<String, Object>();
      paramMap.put("userid", userid);
      ms.deleteMember(paramMap);
      model.addAttribute("message", "회원탈퇴가 정상적으로 처리되었습니다");
      return "member/login";
   }
	
	@GetMapping("/idSearch")
	public String idSearch() {
		return "member/idSearch";
	}
	@PostMapping("/Searchid")
	public String Searchid(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value = "email", required = false) String email, Model model) {
		
		String url="member/idSearch";
		if( result.getFieldError("email") !=null)
			model.addAttribute("email", result.getFieldError("email").getDefaultMessage() );
		else {
			HashMap<String, Object> paramMap  = new HashMap<String, Object>();
			paramMap.put("email", membervo.getEmail() );
			paramMap.put("ref_cursor", null );
			ms.getEmail( paramMap );
			
			ArrayList< HashMap<String, Object> > list
			= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor");
			
			if( list==null || list.size() == 0 ) {
				model.addAttribute("message" , "해당 이메일에 등록된 아이디가 없습니다.");
				return "member/idSearch";
			}
			HashMap<String, Object> searchMap = list.get(0);
			
			if( searchMap.get("EMAIL").equals( membervo.getEmail() ) ) {
				model.addAttribute("message" , "고객님의 아이디는" + searchMap.get("USERID") + "입니다.");
			}
		}
		return url;
	}

	@GetMapping("/pwdSearch")
	public String pwdSearch() {
		return "member/pwdSearch";
		}
	
	@PostMapping("/Searchpwd")
	public String Searchpwd(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "userid", required = false) String userid,Model model) {
		
		String url="member/pwdSearch";
		if( result.getFieldError("email") !=null) {
			model.addAttribute("email", result.getFieldError("email").getDefaultMessage() );
		}else if( result.getFieldError("userid") != null) {
			model.addAttribute("userid", result.getFieldError("userid").getDefaultMessage() ); 
		}else {
			HashMap<String, Object> paramMap  = new HashMap<String, Object>();
			paramMap.put("email", membervo.getEmail() );
			paramMap.put("userid", membervo.getUserid() );
			paramMap.put("ref_cursor", null );
			ms.getPwd( paramMap );
			
			ArrayList< HashMap<String, Object> > list
			= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor");
			
			if( list==null || list.size() == 0 ) {
				model.addAttribute("message" , "아이디와 이메일을 확인해주세요.");
				return "member/pwdSearch";
			}
			HashMap<String, Object> searchMap = list.get(0);
			
			if( searchMap.get("EMAIL").equals( membervo.getEmail() ) || searchMap.get("USERID").equals( membervo.getUserid() ) ) {
				model.addAttribute("message" , "고객님의 비밀번호는" + searchMap.get("PWD") + "입니다.");
			}
		}
		return url;
	}
}
