package com.project.non.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IAdminDao;
import com.project.non.dto.Paging;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class AdminService { 

	@Autowired
	IAdminDao adao;

	public void getAdmin(HashMap<String, Object> paramMap) {
		adao.getAdmin( paramMap );
	}

	public void getProductList(HashMap<String, Object> paramMap) {
		HttpServletRequest request = (HttpServletRequest) paramMap.get("request");
		HttpSession session = request.getSession();
		
		int page=1;
		if( request.getParameter("page") != null ) {
			page = Integer.parseInt( request.getParameter("page") );
			session.setAttribute("page", page);
		}else if( session.getAttribute("page") != null) {
			page = (Integer) session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}
		
		String key = "";
		if( request.getParameter("key") != null ) {
			key = request.getParameter("key");
			session.setAttribute("key", key);
		}else if(session.getAttribute("key") != null) {
			key = (String) session.getAttribute("key");
		}else {
			session.removeAttribute("key");
		}
		
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		paramMap.put("key", key);
		paramMap.put("tableName", "product");
		adao.adminGetAllCount( paramMap );
		int count = Integer.parseInt( paramMap.get("cnt").toString() );
		paging.setTotalCount(count);
		paging.calPaging();
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("key", key);
		adao.getProductList( paramMap );
		
		paramMap.put("paging", paging);
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
	      
	      adao.getQnaList(paramMap);
	      
	      paramMap.put("paging", paging);
	      
	      return paramMap;
	}

	public void updateQna(HashMap<String, Object> paramMap) {
		adao.updateQna(paramMap);
		
	}

	public HashMap<String, Object> getMemberList(HttpServletRequest request) {
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
	      paramMap.put("tableName", "members");
	      paramMap.put("key", key);
	      adao.adminGetAllCount(paramMap);
	      int count=Integer.parseInt(paramMap.get("cnt").toString());
	      paging.setTotalCount(count);
	      paging.calPaging();
	      
	      paramMap.put("ref_cursor", null);
	      paramMap.put("startNum", paging.getStartNum());
	      paramMap.put("endNum", paging.getEndNum());
	      paramMap.put("key", key);
	      
	      adao.getMemberList(paramMap);
	      
	      paramMap.put("paging", paging);
	      
	      return paramMap;
	}

	public void memberReinsert(HashMap<String, Object> paramMap) {
		adao.memberReinsert(paramMap);
		
	}
}
