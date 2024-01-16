package com.project.non.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.project.non.service.DeliveryService;

@Controller
public class DeliveryController {

	 @Autowired
	 DeliveryService ds;
	
}
