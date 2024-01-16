package com.project.non.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.non.dao.IDeliveryDao;

@Service
public class DeliveryService {

	@Autowired
	IDeliveryDao ddao;
	
}
