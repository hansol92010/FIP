package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.UserDao;
import com.icia.web.model.User;

@Service("userService")
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	
	//회원정보 검색==================================================================
	
	//회원아이디를 받아와 회원정보 가져와서 User객체로 넘겨준다.
	public User userSelect(String userId) {
		User user = null;								
			
		try {
			user = userDao.userSelect(userId);
		}catch(Exception e) {
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}
	
	//이메일로 회원 존재여부 확인
	public int userEmailDuplicateCheck(String userEmail) {
		int count = 0;
		
		try {
			count = userDao.userEmailDuplicateCheck(userEmail);
		}catch(Exception e) {
			logger.error("[UserService] userEmailSelect Exception", e);
		}
		
		return count;
	}
	
	//닉네임으로 회원 존재여부 확인
	public int userNicknameDuplicateCheck(String userNickname) {
		int count = 0;
		
		try {
			count = userDao.userNicknameDuplicateCheck(userNickname);
		}catch(Exception e) {
			logger.error("[UserService] userEmailSelect Exception", e);
		}
		
		return count;
	}
	
	//회원등록
	public int userReg(User user) {
		int count = 0;
		
		try {
			count = userDao.userReg(user);
		}catch(Exception e){
			logger.error("[UserService] userReg Exception", e);
		}
		
		
		return count;
	}
	
	//회원정보변경
	public int userUpdate(User user) {
		int count = 0;
		
		try {
			count = userDao.userUpdate(user);
		}catch(Exception e) {
			logger.error("[UserService] userUpdate Exception", e);
		}
		
		return count;
	}
	
	//회원삭제
	public int userDelete(String userId) {
		int count = 0;
		
		try {
			count = userDao.userDelete(userId);
		}catch(Exception e) {
			logger.error("[UserService] userDelete Exception", e);
		}
		
		return count;
	}
	
	//==================관리자 회원관리 미지================
	//회원 수 조회
	public long userListCount(User user)
	{
		long count = 0;
		
		try				
		{
			 count = userDao.userListCount(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userListCount Exception", e);
		}
		return count;
	}
	
	//회원 리스트
	public List<User> userList(User user)
	{
		List<User> list = null;
		
		try
		{
			list = userDao.userList(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userList Exception", e);
		}

		return list;
	}
	
	//회원 조회(userSelect 위쪽에)
	
	//회원정보 수정
	public int adminUserUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.adminUserUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userUpdate Exception", e);
		}
		
		return count;
		
	}
	

	
}
