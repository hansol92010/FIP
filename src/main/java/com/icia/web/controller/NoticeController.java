package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Notice;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.service.NoticeService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("noticeController")
public class NoticeController 
{
	private static Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	//관리자 쿠키명
	@Value("#{env['auth.cookie.admin.name']}")  
	private String AUTH_COOKIE_ADMIN_NAME;
	
	//유저 쿠키명
	@Value("#{env['auth.cookie.name']}")  
	private String AUTH_COOKIE_NAME;
	
	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;
	
	
	//관리자용공지사항 -민정
	@RequestMapping(value="/admin/adminNoticeList")
	public String adminNoticelist(Model model,HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		int curPage = HttpUtil.get(request, "curPage", 1);
		int totalCount = 0;
		
		List<Notice> list = null;
		Paging paging = null;
		Notice param = new Notice();
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				if(StringUtil.equals(searchType, "1"))
				{
					param.setNboardTitle(searchValue);
				}
				else if(StringUtil.equals(searchType, "2"))
				{
					param.setNboardContent(searchValue);
				}
				else
				{
					searchType = "";
					searchValue="";
				}
			}
			else
			{
				searchType = "";
				searchValue = "";
			}
			
			totalCount = noticeService.NoticeListCount(param);
			
			if(totalCount > 0)
			{
				paging =  new Paging("/admin/adminNoticeList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
						
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				
				param.setStartRow(paging.getStartRow());
				param.setEndRow(paging.getEndRow());
				
				list = noticeService.noticeList(param);
			}
			
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/adminNoticeList";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	
	//관리자 공지사항 게시물 조회 -민정
	@RequestMapping(value="/admin/adminNoticeView")
	public String adminNoticeView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		
		int nboardNo = HttpUtil.get(request, "nboardNo", 0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		int curPage = HttpUtil.get(request, "curPage", 1);
		
		Notice notice = null;
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(nboardNo > 0)
			{
				notice = noticeService.noticeView(nboardNo);
			}
			
			model.addAttribute("nboardNo", nboardNo);
			model.addAttribute("notice", notice);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/adminNoticeView";
		}
		else
		{
			return "/admin/login";
		}
			
	}
	
	//공지사항 글쓰기 이연
	@RequestMapping(value="/admin/noticeWriteForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			Notice notice = noticeService.noticeSelect(cookieAdminId);
			
			model.addAttribute("notice", notice);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/noticeWriteForm";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//공지사항 게시물 등록(Proc)  이연
	@RequestMapping(value="/admin/noticeWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{	
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		String nboardTitle = HttpUtil.get(request, "nboardTitle","");
		String nboardContent = HttpUtil.get(request, "nboardContent" , "");
		int nboardNo = 0; // nboardNo 변수 초기화
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		
		if(!StringUtil.isEmpty(nboardTitle) && !StringUtil.isEmpty(nboardContent))
		{
			Notice notice = new Notice();
			
			notice.setNboardTitle(nboardTitle);
			notice.setNboardContent(nboardContent);
			notice.setAdminId(cookieAdminId);
			notice.setNboardNo(nboardNo);
			
			try 
			{
				if(noticeService.noticeInsert(notice) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			 catch(Exception e)
			{
					logger.error("[NoticeController]noticeWriteProc Exception", e);
					ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "boad request");
		}
		
		return ajaxResponse;
		
	}
	
	//공지사항 삭제
	@RequestMapping(value="/admin/noticeDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> noticeDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		int nboardNo = HttpUtil.get(request, "nboardNo", 0);
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		
		if(nboardNo > 0)
		{
			Notice notice = noticeService.noticeView(nboardNo);
			
			if(notice != null)
			{
				try
				{
					if(noticeService.noticeDelete(notice.getNboardNo()) > 0)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(500, "internal server error");
					}
	
				}
				catch(Exception e)
				{
					logger.error("[NoticeController] noticeDelete Exception", e);
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[NoticeController] /admin/noticeDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	//공지사항 게시물 수정(제목, 내용)
	@RequestMapping(value="/admin/noticeUpdateForm")
	public String noticeUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		int nboardNo = HttpUtil.get(request, "nboardNo", 0);
		String searchType = HttpUtil.get(request, "searchType" ,"");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Notice notice = null;
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(nboardNo > 0)
			{
				notice = noticeService.noticeSelectView(nboardNo);
				
			}
			
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("notice", notice);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/noticeUpdateForm";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//공지사항 게시물 수정
	@RequestMapping(value="/admin/noticeUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> noticeUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		int nboardNo = HttpUtil.get(request, "nboardNo", 0);
		String nboardTitle = HttpUtil.get(request, "nboardTitle", "");
		String nboardContent = HttpUtil.get(request, "nboardContent", "");
		String adminId = HttpUtil.get(request, "adminId", "");
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		
		if(!StringUtil.isEmpty(nboardTitle) && !StringUtil.isEmpty(nboardContent))
		{
			Notice notice = noticeService.noticeView(nboardNo);
			
			if(notice != null)
			{
				notice.setNboardNo(nboardNo);
				notice.setNboardTitle(nboardTitle);
				notice.setNboardContent(nboardContent);
				notice.setAdminId(adminId);
				
				try
				{
					if(noticeService.noticeUpdate(notice) > 0)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(500, "internal server error22");
					}
				}
				catch(Exception e)
				{
					logger.error("[NoticeController] /board/updateProc Exception", e);
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[NoticeController] /board/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
	
	//고객용 - 공지사항
	@RequestMapping(value="/notice/noticeList")
	public String noticeList(Model model,HttpServletRequest request, HttpServletResponse respsonse)
	{
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		int curPage = HttpUtil.get(request, "curPage", 1);
		int totalCount = 0;

		List<Notice> list = null;
		Paging paging = null;
		Notice param = new Notice();
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			if(StringUtil.equals(searchType, "1"))
			{
				param.setNboardTitle(searchValue);
			}
			else if(StringUtil.equals(searchType, "2"))
			{
				param.setNboardContent(searchValue);
			}
			else
			{
				searchType = "";
				searchValue="";
			}
		}
		else
		{
			searchType = "";
			searchValue = "";
		}
		
		totalCount = noticeService.NoticeListCount(param);
		
		if(totalCount > 0)
		{
			paging =  new Paging("/notice/noticeList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
					
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			param.setStartRow(paging.getStartRow());
			param.setEndRow(paging.getEndRow());
			
			list = noticeService.noticeList(param);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/notice/noticeList";
	}
	
	//고객용공지사항 게시물 조회 -민정
	@RequestMapping(value="/notice/noticeView")
	public String noticeView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		int nboardNo = HttpUtil.get(request, "nboardNo", 0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		int curPage = HttpUtil.get(request, "curPage", 1);
		
		
		Notice notice = null;
		
		logger.debug("=======================================");
		logger.debug("nboardNo : " +nboardNo);
		logger.debug("=======================================");
		if(nboardNo > 0)
		{
			notice = noticeService.noticeView(nboardNo);
			
		}
		
		model.addAttribute("nboardNo", nboardNo);
		model.addAttribute("notice", notice);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		
		return "/notice/noticeView";
			
	}
}
