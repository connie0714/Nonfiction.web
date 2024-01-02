package com.project.non.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IProductDao;

@Service
public class ProductService {

	@Autowired
	IProductDao pdao;

	public void getShopList(HashMap<String, Object> paramMap) {
		pdao.getShopList( paramMap );
	}

	public void getProduct(HashMap<String, Object> paramMap) {
		pdao.getProduct( paramMap );
	}

	public void getbestList(HashMap<String, Object> paramMap) {
		pdao.getBestList( paramMap );
	}
}
