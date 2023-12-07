package com.icia.web.model;

import java.io.Serializable;

public class SboardComment implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private int sboardCommentNo;
	private int sboardNo;
	private String commentUserId;
	private String commentContent;
	private String commentRegDate;
	
	public SboardComment()
	{
		sboardCommentNo = 0;
		sboardNo = 0;
		commentUserId ="";
		commentContent ="";
		commentRegDate = "";
	}

	public int getSboardCommentNo() {
		return sboardCommentNo;
	}

	public void setSboardCommentNo(int sboardCommentNo) {
		this.sboardCommentNo = sboardCommentNo;
	}

	public int getSboardNo() {
		return sboardNo;
	}

	public void setSboardNo(int sboardNo) {
		this.sboardNo = sboardNo;
	}

	public String getCommentUserId() {
		return commentUserId;
	}

	public void setCommentUserId(String commentUserId) {
		this.commentUserId = commentUserId;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getCommentRegDate() {
		return commentRegDate;
	}

	public void setCommentRegDate(String commentRegDate) {
		this.commentRegDate = commentRegDate;
	}

	
	
	
	
	
	
}
