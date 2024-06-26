package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IOrderDao {

	void insertOrder(HashMap<String, Object> paramMap);

	void insertOrderOne(HashMap<String, Object> paramMap);

	void listOrderByIng(HashMap<String, Object> paramMap);

	void listOrderByOseq(HashMap<String, Object> paramMap);

	void orderEnd(int odseq);

}
