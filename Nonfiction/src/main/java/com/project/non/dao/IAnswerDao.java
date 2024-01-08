package com.project.non.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAnswerDao {

	void getAnswer(HashMap<String, Object> paramMap);
	
}
