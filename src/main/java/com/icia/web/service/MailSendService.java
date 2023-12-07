package com.icia.web.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
@Service("mailSendService")
public class MailSendService {

	Logger logger = LoggerFactory.getLogger(MailSendService.class);
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int authNumber = 0;
	
	public void makeRandomNumber() {
		Random random = new Random();
		int checkNumber = random.nextInt(888888) + 111111;
		
		logger.debug("=================================");
		logger.debug("=================================");
		logger.debug("checkNumber : " + checkNumber);
		logger.debug("=================================");
		logger.debug("=================================");
		
		authNumber = checkNumber;
	}
	
	public String joinMail(String email) {
		makeRandomNumber();
		
		String setFrom = "yangj9project@gmail.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성  
                "<br><br>" + 
			    "인증 번호는 <span style = 'color:red; font-size:20px;'>" + authNumber + "</span>입니다." + 
			    "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		logger.debug("=============================");
		logger.debug("=============================");
		logger.debug("setFrom : " +setFrom);
		logger.debug("toMail : " + toMail);
		logger.debug("title : " + title);
		logger.debug("content : " + content);
		logger.debug("=============================");
		logger.debug("=============================");
		
		mailSend(setFrom, toMail, title, content);
		
		
		
		logger.debug("==============================");
		logger.debug("==============================");
		logger.debug("==============================");
		logger.debug("authNumber : " + Integer.toString(authNumber));
		logger.debug("==============================");
		logger.debug("==============================");
		
		return Integer.toString(authNumber);
	}
	
	public void mailSend(String setFrom, String toMail, String title, String content) {
		
		MimeMessage message = mailSender.createMimeMessage();
	
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
			
			logger.debug("=============================");
			logger.debug("=============================");
			logger.debug("=============================");
			logger.debug("mailSender Success");
			logger.debug("=============================");
			logger.debug("=============================");
		}catch(MessagingException e) {
			
			logger.debug("=============================");
			logger.debug("=============================");
			logger.debug("=============================");
			logger.debug("mailSender Fail");
			logger.debug("=============================");
			logger.debug("=============================");
			
			
			logger.debug("[MailSendService] mailSend Exception e", e);
		}
		
		
	}

}
