package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICustomerDao {

	void listQna(HashMap<String, Object> paramMap);
	void getQna(HashMap<String, Object> paramMap);
	void getQnaList(HashMap<String, Object> paramMap);
	void insertQna(HashMap<String, Object> paramMap);


}
