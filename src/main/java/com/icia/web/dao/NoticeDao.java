package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Notice;

@Repository("noticeDao")
public interface NoticeDao 
{
	//공지사항 게시물 조회
	public int noticeListCount(Notice notice);
	
	//공지사항 게시물 리스트
	public List<Notice> noticeList(Notice notice);
	
	
	//공지사항 게시물 조회 (nboardNo별로)
	public Notice noticeView(int nboardNo);
	
	//공지사항 게시물 조회(adminId별로)
	public Notice noticeSelect(String adminId);
	
	//공지사항 게시물 삭제
	public int noticeDelete(int nboardNo);
	
	//공지사항 글쓰기
	public int noticeInsert(Notice notice);
	
	//공지사항 수정
	public int noticeUpdate(Notice notice);
	

	
}
