package com.icia.web.service;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.NoticeDao;
import com.icia.web.model.Notice;



@Service("noticeService")
public class NoticeService 
{
	private static Logger logger = LoggerFactory.getLogger(NoticeService.class);
	
	@Autowired
	private NoticeDao noticeDao;
	
	//공지사항 게시물 수 조회
	public int NoticeListCount(Notice notice)
	{
		int count = 0;
		
		try
		{
			count = noticeDao.noticeListCount(notice);
		}
		catch(Exception e)
		{
			logger.error("[NoticeService] NoticeListCount Exception", e);
		}
		
		return count;
	}
	
	//공지사항 리스트 조회
	public List<Notice> noticeList(Notice notice)
	{
		List<Notice> list = null;
		
		try
		{
			list = noticeDao.noticeList(notice);
		}
		catch(Exception e)
		{
			logger.error("[NoticeService] noticeList Exception", e);
		}
		
		return list;
	}
	
	//공지사항 게시물 보기(nboardNO별로)
	public Notice noticeView(int nboardNo)
	{
		Notice notice = null;
		
		try
		{
			notice = noticeDao.noticeView(nboardNo);
			
		}
		catch(Exception e)
		{
			logger.error("[NoticeService] noticeView Exception", e);
		}
		
		return notice;
	}
	
	//공지사항 게시물 보기(userId별로)
	public Notice noticeSelect(String adminId)
	{
		Notice notice = null;
		
		try
		{
			notice = noticeDao.noticeSelect(adminId);
		}
		catch(Exception e)
		{
			logger.error("[NoticeService] noticeSelect Exception", e);
		}
		return notice;
	}
	
	//공지사항 게시물 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int noticeDelete(int nboardNo) throws Exception
	{
		int count = 0;
		
		Notice notice = noticeDao.noticeView(nboardNo);
		
		if(notice != null)
		{
			count = noticeDao.noticeDelete(nboardNo);
		}
		
		return count;
	}
	
	//공지사항 글쓰기
	public int noticeInsert(Notice notice) throws Exception
	{
		int count = noticeDao.noticeInsert(notice);
		
		return count;
	}
	
	//공지사항 수정페이지 화면
	public Notice noticeSelectView(int nboardNo)
	{
		Notice notice = new Notice();
		
		try
		{
			notice = noticeDao.noticeView(nboardNo);
		}
		catch(Exception e)
		{
			logger.error("[NoticeService] noticeSelectView Exception", e);
		}
		
		return notice;
	}
	
	//공지사항 수정 
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int noticeUpdate(Notice notice)
	{
		int count = noticeDao.noticeUpdate(notice);
		
		return count;
	}
}
