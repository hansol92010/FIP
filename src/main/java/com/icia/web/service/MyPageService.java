package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.MyPageDao;
import com.icia.web.model.CouponCase;
import com.icia.web.model.Sboard;

@Service("myPageService")
public class MyPageService {
	
	@Autowired
	private MyPageDao myPageDao;
	
	private Logger logger = LoggerFactory.getLogger(MyPageService.class);
	
	//*********************************
	//내 쿠폰함 리스트 가져오기
	public List<CouponCase> myCouponCaseList(String userId) {
		List<CouponCase> myCouponCaseList = null;
		
		try {
			myCouponCaseList = myPageDao.myCouponCaseList(userId);
		}catch(Exception e) {
			logger.error("[MyPageService] myCouponCaseList Exception", e);
		}
		
		return myCouponCaseList;
	}
	
	//**********************************
	//회원정보수정 닉네임 중복 체크
	public int nicknameDuplicateCheck(String userNickname) {
		int count = 0;
		
		try {
			count = myPageDao.nicknameDuplicateCheck(userNickname);
		}catch(Exception e) {
			logger.error("[MyPageService] nicknameDuplicateCheck Exception", e);
		}
		return count;
	}
	
	//********************************
	//마이페이지 내가 쓴 style 글 COUNT
	public int myStyleCount(String userId) {
		int count = 0;
		
		try {
			count = myPageDao.myStyleCount(userId);
		}catch(Exception e) {
			logger.error("[MyPageService] myStyleCount Exception", e);
		}
		
		return count;
	}
	
	//*************************************
	//마이페이지 내가 쓴 style 리스트
	public List<Sboard> myStyleList(Sboard sboard) {
		List<Sboard> sboardList = null;
		
		try {
			sboardList = myPageDao.myStyleList(sboard);
		}catch(Exception e) {
			logger.error("[MyPageService] myStyleList Exception", e);
		}
		
		return sboardList;
	}
	
	//****************************************
	//내가 좋아요 누른 스타일글 카운트
	public int myLikeStyleListCount(String userId) {
		int count = 0;
		
		try {
			count = myPageDao.myLikeStyleListCount(userId);
		}catch(Exception e) {
			logger.error("[MyPageService] myLikeStyleListCount Exception", e);
		}
		
		return count;
	}
	
	public List<Sboard> myLikeStyleList(Sboard sboard) {
		List<Sboard> myLikeStyleList = null;
		
		try {
			myLikeStyleList = myPageDao.myLikeStyleList(sboard);
		}catch(Exception e) {
			logger.error("[MyPageService] myLikeStyleList Exception", e);
		}
		
		
		logger.debug("=============================");
		logger.debug("=============================");
		logger.debug("[myPageService] myLikeStyleList : " + myLikeStyleList);
		logger.debug("=============================");
		logger.debug("=============================");
		
		return myLikeStyleList;
	}
}
