package com.project.non.dto;

import lombok.Data;

@Data
public class ProductVO {

	private Integer pseq; 		// 상품번호
	private String name;		// 상품이름
	private Integer price2;		// 판매가
	private String image;		// 상품사진
	
	/* 카테고리 */
	private String shop;		// shop 매뉴
	private String bestyn;		// 인기상품
	private String holidayyn;	// 이벤트상품
	private String acc;			// 기타상품
	
}
