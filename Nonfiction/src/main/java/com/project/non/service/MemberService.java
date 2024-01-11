package com.project.non.service;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IMemberDao;


@Service
public class MemberService {
	
	@Autowired
	IMemberDao mdao; 

	public void getMember(HashMap<String, Object> paramMap) {
		mdao.getMember(paramMap);
		
	} 

	public void insertMember(HashMap<String, Object> paramMap) {
		mdao.insertMember(paramMap);
		
	}

	public void updateMember(HashMap<String, Object> paramMap) {
		mdao.updateMember(paramMap);
		
	}

	public void deleteMember(HashMap<String, Object> paramMap) {
		mdao.deleteMember(paramMap);
		
	}

	public void joinKakao(HashMap<String, Object> paramMap) {
		mdao.joinKakao(paramMap);
		
	}







}




