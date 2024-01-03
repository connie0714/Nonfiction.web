package com.project.non.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IAdminDao;

@Service
public class AdminService {

	@Autowired
	IAdminDao adao;
}
