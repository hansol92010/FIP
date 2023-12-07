package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.web.service.MailSendService;
import com.icia.web.util.HttpUtil;

@Controller("mailCheckController")
public class MailCheckController {
	
	Logger logger = LoggerFactory.getLogger(MailCheckController.class);
	
	@Autowired
	private MailSendService mailSendService;
	
	@RequestMapping(value="/mail/mailCheck")
	@ResponseBody
	public String mailCheck(HttpServletRequest request, HttpServletResponse response) {
		
		String emailRequest = HttpUtil.get(request, "emailRequest");
		
		logger.debug("=======================================");
		logger.debug("=======================================");
		logger.debug("인증요청 이메일 : " + emailRequest);
		logger.debug("=======================================");
		logger.debug("=======================================");
		
		return mailSendService.joinMail(emailRequest);
	}
}
