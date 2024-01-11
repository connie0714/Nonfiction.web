package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {

	void getAdmin(HashMap<String, Object> paramMap);

	void getProductList(HashMap<String, Object> paramMap);

	void adminGetAllCount(HashMap<String, Object> paramMap);

	void getQnaList(HashMap<String, Object> paramMap);

	void updateQna(HashMap<String, Object> paramMap);

	void getMemberList(HashMap<String, Object> paramMap);

	void memberReinsert(HashMap<String, Object> paramMap);

	void getBannerList(HashMap<String, Object> paramMap);

	void insertBanner(HashMap<String, Object> paramMap);
		
}
