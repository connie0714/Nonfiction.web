package com.project.non.service;



import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IAdminDao;
import com.project.non.dao.ICustomerDao;
import com.project.non.dto.Paging;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class CustomerService {
	
	@Autowired
	ICustomerDao cdao;
	
	@Autowired
	IAdminDao adao;

	public void listQna(HashMap<String, Object> paramMap) {
		cdao.listQna(paramMap);
		
	}

	public void getQna(HashMap<String, Object> paramMap) {
		cdao.getQna(paramMap);
		
	}

	public HashMap<String, Object> getQnaList(HttpServletRequest request) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
	     HttpSession session = request.getSession();
	     
	     if(request.getParameter("first")!=null) {
	         session.removeAttribute("page");
	         session.removeAttribute("key");
	      }
	      
	      int page=1;
	      if(request.getParameter("page")!=null) {
	         page = Integer.parseInt(request.getParameter("page"));
	         session.setAttribute("page", page);
	      }else if(session.getAttribute("page")!=null) {
	         page = (int)session.getAttribute("page");
	      }else {
	         page = 1;
	         session.removeAttribute("page");
	      }
	      
	      String key = "";
	      if(request.getParameter("key")!=null) {
	         key = request.getParameter("key");
	         session.setAttribute("key", key);
	      }else if(session.getAttribute("key")!=null) {
	         key = (String)session.getAttribute("key");
	      }else {
	         session.removeAttribute("key");
	         key="";
	      }
	      
	      Paging paging=new Paging();
	      paging.setPage(page);
	      paramMap.put("cnt", 0);
	      paramMap.put("tableName", "qna");
	      paramMap.put("key", key);
	      adao.adminGetAllCount(paramMap);
	      int count=Integer.parseInt(paramMap.get("cnt").toString());
	      paging.setTotalCount(count);
	      paging.calPaging();
	      
	      paramMap.put("ref_cursor", null);
	      paramMap.put("startNum", paging.getStartNum());
	      paramMap.put("endNum", paging.getEndNum());
	      paramMap.put("key", key);
	      
	      cdao.getQnaList(paramMap);
	      
	      paramMap.put("paging", paging);
	      
	      return paramMap;
	}



	




}
