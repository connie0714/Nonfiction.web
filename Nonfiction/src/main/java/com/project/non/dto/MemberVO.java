package com.project.non.dto;

import java.sql.Timestamp;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class MemberVO {
	
	@NotEmpty(message="아이디를 입력하세요")
	private String userid;
	@NotEmpty(message="비밀번호를 입력하세요")
    private String pwd;     
	@NotEmpty(message="이름을 입력하세요")
    private String name;
	@NotEmpty(message="이메일을 입력하세요")
    private String email;
	@NotEmpty(message="전화번호를 입력하세요")
	private String phone;
	
    private String zip_num;
    private String address1;
    private String address2;
    private String address3;
    private Timestamp indate;
   
    

}
