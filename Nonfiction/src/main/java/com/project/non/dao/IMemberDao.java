package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberDao { 

	void getMember(HashMap<String, Object> paramMap);

	void insertMember(HashMap<String, Object> paramMap);

	void updateMember(HashMap<String, Object> paramMap);

	void deleteMember(HashMap<String, Object> paramMap);

	void joinKakao(HashMap<String, Object> paramMap);

	void getEmail(HashMap<String, Object> paramMap);

	void getPwd(HashMap<String, Object> paramMap);

	

}
