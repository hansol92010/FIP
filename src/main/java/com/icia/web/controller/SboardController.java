package com.icia.web.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Order;
import com.icia.web.model.OrderDetail;
import com.icia.web.model.Paging;
import com.icia.web.model.Product;
import com.icia.web.model.Response;
import com.icia.web.model.Sboard;
import com.icia.web.model.SboardComment;
import com.icia.web.model.SboardLike;
import com.icia.web.model.SboardProductInfoNo;
import com.icia.web.model.User;
import com.icia.web.service.OrderService;
import com.icia.web.service.ProductService;
import com.icia.web.service.SboardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;


@Controller("sboardController")
public class SboardController 
{
	
	private static Logger logger = LoggerFactory.getLogger(SboardController.class);
	

	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private SboardService sboardService;
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.dir1']}")
	private String UPLOAD_SAVE_DIR_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.dir2']}")
	private String UPLOAD_SAVE_DIR_DETAIL;
	
	//리스트 이미지 저장 경로
	@Value("#{env['upload.save.dir3']}")
	private String UPLOAD_SAVE_DIR_LIST;
	
	@Value("#{env['auth.cookie.name']}")  
	private String AUTH_COOKIE_NAME;
	
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductService productService;
	
	private static final long LIST_COUNT = 5;
	private static final long PAGE_COUNT = 5;
	
	
	
	//스타일 게시판 리스트
	@RequestMapping("/style/styleList")
	public String styleList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String brandCode = HttpUtil.get(request, "brandCode", "");
		String optionSelect = HttpUtil.get(request, "optionSelect", "1");
		
		int totalCount = 0;
		List<Sboard> list = null;
		Sboard sboard = new Sboard();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		//로그인여부
		String loginCheck = "N";
		
		if(cookieUserId != null)
		{
			loginCheck ="Y";
		}
		
		
		//brandCode가 비어있을때(값이 없을때)
		if(StringUtil.isEmpty(brandCode))
		{
			
			sboard.setBrandCode(brandCode);
			
			//옵션(최신순,좋아요순)이 비어있지 않을때
			if(!StringUtil.isEmpty(optionSelect))
			{
				sboard.setOptionSelect(optionSelect);
			}
			
			
			totalCount = sboardService.allStyleCount(sboard);
			
			if(totalCount > 0)
			{
				list = sboardService.allStyleList(sboard);
				
			}
			
		}
		//brandCode가 있을 경우
		else
		{
			sboard.setBrandCode(brandCode);
			
			//옵션(최신순,좋아요순)이 비어있지 않을때
			if(!StringUtil.isEmpty(optionSelect))
			{
				sboard.setOptionSelect(optionSelect);
			}
			
			totalCount = sboardService.styleBrandCount(brandCode);
			
			if(totalCount > 0)
			{
				list = sboardService.styleBrandSelect(sboard);
			}
		}
		
		
		//리스트,브랜드코드,옵션(최신순,좋아요순).
		model.addAttribute("list", list);
		model.addAttribute("brandCode", brandCode);
		model.addAttribute("optionSelect", optionSelect);
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("loginCheck", loginCheck);
		
		logger.debug("============================================================");
		logger.debug("list :" + list);
		logger.debug("============================================================");
		
		
		return "/style/styleList";
	}
			
			
			
	   //스타일 게시물 조회 민정
	   @RequestMapping(value="/style/styleView")
	   public String styleView(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	   {
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      int sboardNo = HttpUtil.get(request, "sboardNo", 0);
	      
	      //본인 글 여부
	      String boardMe = "N";
	      
	      Sboard sboard = null;
	      
	      //댓글 리스트
	      List<SboardComment> list = null;
	      
	      //댓글
//	      int sboardCommentNo = HttpUtil.get(request, "sboardCommentNo", 0);
//	      String commentContent = HttpUtil.get(request, "commentContent","");
//	      String commentUserId = HttpUtil.get(request, "commentUserId", "");
	      
	      List<User> commentUser = new ArrayList<User>();
	      
	      //좋아요
	      SboardLike sboardLike = new SboardLike();
	      List<SboardLike> list2 = null;
	      
	      //상품불러오기
	      SboardProductInfoNo sboardProductInfoNo = new SboardProductInfoNo();
	      int productNo = HttpUtil.get(request, "productNo", 0);
	      List<SboardProductInfoNo> list3 = null;
	      List<Product> listpro = new ArrayList<Product>();
	         
	      if(sboardNo > 0)
	      {
	         sboard = sboardService.sboardView(sboardNo);
	         list = sboardService.styleReplyList(sboardNo);
	         
	         for(int i=0; i<list.size(); i++)
	         {
	            User user = userService.userSelect(list.get(i).getCommentUserId());
	            commentUser.add(i, user);
	            
	            logger.debug("==================================================");
	            logger.debug(commentUser.get(i).getUserId());
	            logger.debug("==================================================");
	            
	            
	         }
	         
	         
	         //좋아요
	         sboardLike.setUserId(cookieUserId);
	         sboardLike.setSboardNo(sboardNo);
	         
	         list2 = sboardService.likeSelect(sboardLike);
	         
	         //상품불러오기
	         /* sboardProductInfoNo.setProductNo(productNo); */
	         list3 = sboardService.sboardProductSelect(sboardNo);
	         
	         
	         for(int i = 0; i< list3.size(); i++ ) {
	            Product pro = new Product();
	            pro = productService.selectProduct(list3.get(i).getProductNo());
	            /* pro = sboardService.sboardProductSelect(list3.get(i)); */
	            logger.debug("========================");
	            logger.debug("========================");
	            logger.debug("pro.getProductNo() : " + pro.getProductNo());
	            logger.debug("========================");
	            logger.debug("========================");
	            listpro.add(pro);
	         }
	      
	         
	         //로그인한 아이디랑 같을떄 :본인글
	         if(sboard != null && StringUtil.equals(sboard.getUserId(), cookieUserId))
	         {
	            boardMe = "Y";
	         }
	   
	          
	      }

	      model.addAttribute("list", list);
	      model.addAttribute("sboardNo", sboardNo);
	      model.addAttribute("cookieUserId", cookieUserId);
	      model.addAttribute("sboard", sboard);
	      model.addAttribute("boardMe", boardMe);
	      
	      //댓글 내용
//	      model.addAttribute("commentContent", commentContent);
//	      model.addAttribute("commentUserId", commentUserId);
	      
	      model.addAttribute("commentUser", commentUser);
	      
	      //좋아요
	      model.addAttribute("list2", list2);
	      //스타일상세 상품불러오기
	      model.addAttribute("listpro", listpro);
	      
//	      logger.debug("==================================================");
//	      logger.debug("commentUserId : " +commentUserId);
//	      logger.debug("==================================================");
	      
	      return "/style/styleView";
	   }
		
		
			
	//게시물 삭제 민정
	@RequestMapping(value="/style/styleDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> styleDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int sboardNo = HttpUtil.get(request, "sboardNo", 0);
		
		if(sboardNo > 0)
		{
			Sboard sboard = sboardService.sboardSelect(sboardNo);
			
			if(sboard != null)
			{
				//내글이면 삭제
				if(StringUtil.equals(sboard.getUserId(), cookieUserId))
				{
					try
					{ 
						
						if(sboardService.sboardDelete(sboardNo) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "internal server error2");
						}
					}
					catch(Exception e)
					{
						logger.error("[SboardController] styledelete Exception",e);
						ajaxResponse.setResponse(500, "inter server error1");
					}
					
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found2");
				}
					
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found1");
			}
			
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[SboardController] /style/styleDelete\n" +JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
			
		//<스타일 글쓰기게시판>Form 이연
		@RequestMapping(value="/style/writeForm")
		public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
		{
			
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			User user = userService.userSelect(cookieUserId);
			model.addAttribute("user", user);
			
			return "/style/writeForm";
		}
			
		//게시물 등록Proc<스타일글쓰기 게시판> 이연
		@RequestMapping(value="/style/writeProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
		{	
				Response<Object> ajaxResponse = new Response<Object>();
				String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
				String sboardTitle = HttpUtil.get(request, "sboardTitle", "");
				String sboardContent = HttpUtil.get(request, "sboardContent", "");
				String brandCode = HttpUtil.get(request, "brandCode", "");
				Sboard sboard1 = new Sboard();
				
				//시퀀스 부터 조회
				int sboardNo = sboardService.styleSeq(sboard1);
				
				
				
				FileData fileData = HttpUtil.getFile(request, "sboardFile", UPLOAD_SAVE_DIR_THUM, sboardNo, "style");

				logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
				logger.debug("sboardTitle :" + sboardTitle);
				logger.debug("sboardContent: " + sboardContent);
				logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
				
				
				if(!StringUtil.isEmpty(sboardTitle) &&!StringUtil.isEmpty(sboardContent))
				{
					Sboard sboard = new Sboard();
					
					sboard.setUserId(cookieUserId);  
					sboard.setSboardTitle(sboardTitle);
					sboard.setSboardContent(sboardContent);
					sboard.setBrandCode(brandCode);
					
					sboard.setSboardNo(sboardNo);
				
					try
					{
							if(sboardService.boardInsert(sboard) > 0)  
							{
								ajaxResponse.setResponse(0, "Success", sboardNo);
							}
							else
							{
								ajaxResponse.setResponse(500, "internal server error");
							}
					}
				    catch(Exception e)
					{
							logger.error("[SboardController]/style/writeProc Exception", e);
							ajaxResponse.setResponse(500, "internal server error");
					}
					
				} 
				else
				{
					ajaxResponse.setResponse(400, "boad request");
				}
				
				return ajaxResponse;
				
		}
		
				
				
		//댓글 등록
		@RequestMapping(value="/style/styleReplyWriteProc", method= RequestMethod.POST)
		@ResponseBody
		public Response<Object> styleReplyWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			String commentContent = HttpUtil.get(request, "commentContent");
			int sboardNo = HttpUtil.get(request, "sboardNo", 0);
			
			if(!StringUtil.isEmpty(commentContent))
			{
				SboardComment sboardComment = new SboardComment();
				
				sboardComment.setCommentUserId(cookieUserId);
				sboardComment.setCommentContent(commentContent);
				sboardComment.setSboardNo(sboardNo);
				
				if(sboardService.styleReplyInsert(sboardComment) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
			
			return ajaxResponse;
			
		}
			
		//댓글 삭제
		@RequestMapping(value="/style/styleReplyDelete", method = RequestMethod.POST)
		@ResponseBody
		public Response<Object> styleReplyDelete(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			int sboardCommentNo = HttpUtil.get(request, "sboardCommentNo", 0);
			
			if(sboardCommentNo > 0)
			{
				SboardComment sboardComment = sboardService.styleReplySelect(sboardCommentNo);
				
				if(sboardComment != null)
				{
					if(StringUtil.equals(sboardComment.getCommentUserId(), cookieUserId))
					{
						try
						{
							if(sboardService.styleReplyDelete(sboardCommentNo) > 0)
							{
								ajaxResponse.setResponse(0, "success");
							}
							else
							{
								ajaxResponse.setResponse(500, "internal server error22");
							}
							
						}
						catch(Exception e)
						{
							logger.error("[HiBoardController] /board/delete Exception", e);
							ajaxResponse.setResponse(500, "internal server error");
						}
					}
					else
					{
						ajaxResponse.setResponse(400, "not found");
					}
						
				}
				else
				{
					ajaxResponse.setResponse(404, "bad request");
				}
				
				if(logger.isDebugEnabled())
				{
					logger.debug("[SboardController] /style/styleReplyDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
				}	
			}
				return ajaxResponse;
		}
			
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
		
	    @RequestMapping(value="/style/likeProc",method=RequestMethod.POST)
	    @ResponseBody
		public Response<Object> likeInsertProc(MultipartHttpServletRequest request, HttpServletResponse response)
		{
	    	Response<Object> ajaxResponse = new Response<Object>();
	    	//필요한거 선언해줘
	    	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	    	int sboardNo = HttpUtil.get(request, "sboardNo", 0);
	    	int totalCount = 0;
	    	
	    	SboardLike sboardLike = new SboardLike();
	    	
	    	sboardLike.setSboardNo(sboardNo);
	    	sboardLike.setUserId(cookieUserId);
	    	
	    	totalCount = sboardService.likeCheck(sboardLike);
	    	
	    	if(totalCount == 0) //좋아요를 누른적이 없으면 좋아요 추가
	    	{
	    		//좋아요 추가
	    		int likeInsert = sboardService.likeInsert(sboardLike);
	    		try 
	    		{	
	    			if(likeInsert > 0)
		    		{
		    			//좋아요 +1
		    			int likeUp = sboardService.likeUpUpdate(sboardNo);
		    			
		    			if(likeUp > 0)
		    			{
		    				ajaxResponse.setResponse(0, "seccess");
		    			}
		    			else 
		    			{
		    				ajaxResponse.setResponse(500, "internal server error");
						}
		    		}
	    			else 
	    			{
	    				ajaxResponse.setResponse(400, "Not Found");
	    			}
	    		}
	    		catch(Exception e)
	    		{
	    			logger.error("[SboardController]/style/likeInsertProc Exception", e);
	    			ajaxResponse.setResponse(404, "Bad request");
	    		}
	    	}
	    	else //좋아요 누른적이 있으면 좋아요 삭제
	    	{
	    		int likeDelete = sboardService.likeDelete(sboardLike);
	    		try 
	    		{	
	    			if(likeDelete > 0)
		    		{
		    			//좋아요 -1
		    			int likeDown = sboardService.likeDownUpdate(sboardNo);
		    			
		    			if(likeDown > 0)
		    			{
		    				ajaxResponse.setResponse(0, "seccess");
		    			}
		    			else 
		    			{
		    				ajaxResponse.setResponse(500, "internal server error");
						}
		    		}
	    			else 
	    			{
	    				ajaxResponse.setResponse(400, "Not Found");
	    			}
	    		}
	    		catch(Exception e)
	    		{
	    			logger.error("[SboardController]/style/likeDeleteProc Exception", e);
	    			ajaxResponse.setResponse(404, "Bad request");
	    		}
			}
	    	return ajaxResponse;  
		}



	//스타일 writeForm 내 주문내역 선택 : 양진구
		@RequestMapping(value="/style/styleOrderSelect")
		public String styleOrderSelect(ModelMap model,HttpServletRequest request, HttpServletResponse response) {
			String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			List<Order> myOrderList = null;
			Order order = new Order();
			Paging paging = null;
			long totalCount = 0;
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			
			if(!StringUtil.isEmpty(userId)) {
				
				totalCount = orderService.myOrderListCount(userId);
				
				logger.debug("=====================================");
				logger.debug("totalCount : " + totalCount);
				logger.debug("=====================================");
				
				
				
				if(totalCount > 0) {
					paging = new Paging("/style/styleOrderSelect", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
					paging.addParam("curPage", curPage);
					order.setUserId(userId);
					order.setStartRow(paging.getStartRow());
					order.setEndRow(paging.getEndRow());
					
					myOrderList = orderService.myOrderListSelect(order);
				}
				
				model.addAttribute("myOrderList", myOrderList);
				model.addAttribute("paging", paging);
				model.addAttribute("curPage", curPage);
				
				return "/style/styleOrderSelect";
				
			}else {
				return "/user/loginForm";
			}
			
		}
		
		//스타일 writeForm 내주문내역 -> 상세내역	: 양진구
		@RequestMapping(value="/style/styleOrderDetailSelect")
		public String styleOrderDetailSelect(ModelMap model,HttpServletRequest request, HttpServletResponse response) {
			String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			int orderNo = HttpUtil.get(request, "orderViewNo", 0);
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			List<OrderDetail> myOrderDetailList = null;
			Order order = null;
			
			if(!StringUtil.isEmpty(userId) && orderNo > 0) {
				
				myOrderDetailList = orderService.myOrderDetailList(orderNo);
				order = orderService.myOrderSelect(orderNo);
				
				model.addAttribute("curPage", curPage);
				model.addAttribute("order", order);
				model.addAttribute("myOrderDetailList", myOrderDetailList);
				return "/style/styleOrderDetailSelect";
				
			}else {
				
				return "/user/loginForm";
			}
		}
		
		//스타일 게시판 등록후 상품정보 db에 insert : 양진구
		@RequestMapping(value="/style/styleProInfoInsert")
		@ResponseBody
		public Response<Object> styleProInfoInsert(@RequestParam(value="productInfoNo") List<Integer> productInfoNo, HttpServletRequest request, HttpServletResponse response) {
			Response<Object> res = new Response<Object>();
			int count = 0;
			int sboardNo = HttpUtil.get(request, "sboardNo", 0);
			logger.debug("==============================");
			logger.debug("==============================");
			logger.debug("sboardNo : " + sboardNo);
			logger.debug("==============================");
			logger.debug("==============================");
			if(!StringUtil.isEmpty(sboardNo)) {
				for(int i=0; i<productInfoNo.size();i++) {
				
					SboardProductInfoNo sboardProductInfoNo = new SboardProductInfoNo();
					
					sboardProductInfoNo.setSboardNo(sboardNo);
					sboardProductInfoNo.setProductNo(productInfoNo.get(i));
					count = sboardService.sboardProductInfoNo(sboardProductInfoNo);
				}
				res.setResponse(0, "Success");
			}else {
				res.setResponse(400, "Bad Request");
			}
			
			
			return res;
		}
}