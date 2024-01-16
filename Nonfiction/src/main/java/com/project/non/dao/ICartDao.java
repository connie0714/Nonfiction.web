package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICartDao {

	void insertCart(HashMap<String, Object> paramMap);

	void listCart(HashMap<String, Object> paramMap);

	void deleteCart(HashMap<String, Object> paramMap);

	void cartcntup(HashMap<String, Object> paramMap);

	void cartcntdown(HashMap<String, Object> paramMap);
	

	
	

}
