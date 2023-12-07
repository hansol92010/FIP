package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.CouponCase;
import com.icia.web.model.Sboard;

@Repository("myPageDao")
public interface MyPageDao {
	
	//내 쿠폰함 리스트 가져오기
	public List<CouponCase> myCouponCaseList(String userId);
	
	//회원정보 변경 닉네임 중복체크
	public int nicknameDuplicateCheck(String userNickname);

	//내가 쓴 스타일 게시글 COUNT
	public int myStyleCount(String userId);
	
	//내가 쓴 스타일 게시글 리스트 가져오기
	public List<Sboard> myStyleList(Sboard sboard);
	
	//내가 좋아요 누른 스타일 게시글 COUNT
	public int myLikeStyleListCount(String userId);
	
	public List<Sboard> myLikeStyleList(Sboard sboard);
}
