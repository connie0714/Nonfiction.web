package com.project.non.controller;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.non.service.AnswerService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AnswerController {

	@Autowired
	AnswerService ans;

	@Autowired
	ServletContext context;

	@PostMapping("/answer")
	@ResponseBody
	public HashMap<String, Object> answer(@RequestParam("kind") HttpServletRequest request, Model model) throws IOException {

		HashMap<String, Object> result = new HashMap<String, Object>();

		try {
			result.put("STATUS", 1);
			result.put("CONTENT", ans.getAnswer());
		} catch (IllegalStateException e) {
			e.printStackTrace();
			result.put("STATUS", 0);
		}

		return result;
	}

}