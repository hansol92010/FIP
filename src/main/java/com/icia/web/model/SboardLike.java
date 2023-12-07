package com.icia.web.model;

import java.io.Serializable;

public class SboardLike implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int sboardNo;  //좋아요 누른 게시물
	private String userId;  //좋아요 누른 회원번호
	private int likeNo;  //좋아요 번호
	
	public SboardLike()
	{
		sboardNo = 0;
		userId = "";
		likeNo = 0;
	}

	public int getSboardNo() {
		return sboardNo;
	}

	public void setSboardNo(int sboardNo) {
		this.sboardNo = sboardNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getLikeCount() {
		return likeNo;
	}

	public void setLikeCount(int likeCount) {
		this.likeNo = likeCount;
	}


	
	

}
