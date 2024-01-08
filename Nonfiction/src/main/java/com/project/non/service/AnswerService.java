package com.project.non.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IAnswerDao;

@Service
public class AnswerService {

	@Autowired
	IAnswerDao andao;

	public Object getAnswer() {
		return null;
	}
}
