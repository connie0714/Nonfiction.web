package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IProductDao {

	void getShopList(HashMap<String, Object> paramMap);

	void getProduct(HashMap<String, Object> paramMap);

	void getBestList(HashMap<String, Object> paramMap);
}
