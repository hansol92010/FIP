package com.icia.web.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.User;

@Repository("userDao")
public interface UserDao {
	
	//회원 아이디로 회원정보 가져오기
	public User userSelect(String userId);
	
	//닉네임으로 회원정보 가져오기
	public int userNicknameDuplicateCheck(String userNickname);
	
	//이메일로 회원정보 가져오기
	public int userEmailDuplicateCheck(String userEmail);
	
	//회원가입
	public int userReg(User user);
	
	//회원정보변경
	public int userUpdate(User user);
	
	//회원정보삭제
	public int userDelete(String userId);
	
	//@@@@@@@@@@@@@@관리자 회원관리@@@@@@@@@@@@@@@
	//사용자 수 조회 미지
	public long userListCount(User user);
	
	//사용자 리스트 미지
	public List<User> userList(User user);
	
	//회원 조회(userSelect)은 위쪽에
	//public User userSelect(String userId);
	
	//회원정보 수정
	public int adminUserUpdate(User user);

}
