package com.project.non.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.ICartDao;

@Service
public class CartService {

	@Autowired
	ICartDao cadao;

	public void insertCart(HashMap<String, Object> paramMap) {
		cadao.insertCart(paramMap);		
	}

	public void listCart(HashMap<String, Object> paramMap) {
		cadao.listCart(paramMap);		
		
		
		ArrayList<HashMap<String, Object>> list
			=(ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		int cartCount = 0;
		
		for(int i=0;i<=list.size();i++) {
			cartCount++;
		}
		paramMap.put("cartCount", cartCount-1);
		System.out.println(cartCount-1);
				
		int totalPrice = 0;
		for( HashMap<String , Object> cart : list) {
			totalPrice +=	Integer.parseInt( cart.get("QUANTITY").toString() )
					* Integer.parseInt( cart.get("PRICE2").toString() );
		}
		
		paramMap.put("totalPrice", totalPrice );
		
	}

	public void deleteCart(HashMap<String, Object> paramMap) {
		
		// 카트 번호 배열을 해시맵에서 꺼내고
		String [] cseqArr = (String [])paramMap.get("cseqArr");
		
		// 배열에서 카트번호를 하나씩 다시 꺼내서 해시맵에 넣고 삭제메서드를 호출합니다
		for( String cseq : cseqArr) {
			paramMap.put("cseq", cseq);
			cadao.deleteCart(paramMap);
		}
		
		
	}
}
