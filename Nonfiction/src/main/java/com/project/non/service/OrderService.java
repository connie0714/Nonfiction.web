package com.project.non.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IOrderDao;

@Service
public class OrderService {

	@Autowired
	IOrderDao odao;

	public void insertOrder(HashMap<String, Object> paramMap) {
		odao.insertOrder( paramMap );
	}

	public void listOrderByOseq(HashMap<String, Object> paramMap) {
		odao.listOrderByOseq( paramMap );
		ArrayList<HashMap<String, Object>> list
			=(ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		int totalPrice = 0;
		for( HashMap<String , Object> ovo : list) 
			totalPrice +=	Integer.parseInt( ovo.get("QUANTITY").toString() )
									* Integer.parseInt( ovo.get("PRICE2").toString() );
		paramMap.put("totalPrice", totalPrice );		
		paramMap.put("orderDetail", list.get(0) );  // order Detail 페이지에서만 사용할 예정
	}

	public void insertOrderOne(HashMap<String, Object> paramMap) {
		odao.insertOrderOne( paramMap );	
	}
	
}
