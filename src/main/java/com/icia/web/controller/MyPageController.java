package com.icia.web.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.CouponCase;
import com.icia.web.model.Order;
import com.icia.web.model.OrderDetail;
import com.icia.web.model.Paging;
import com.icia.web.model.Product;
import com.icia.web.model.Response;
import com.icia.web.model.Sboard;
import com.icia.web.model.User;
import com.icia.web.service.MyPageService;
import com.icia.web.service.OrderService;
import com.icia.web.service.ProductService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("myPageController")
public class MyPageController {
	
	private Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.user_profileImg']}")
	private String USER_PROFILE_IMAGE; 
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;
	
	private static final int STYLE_LIST_COUNT = 6;
	
	
	//******************************************************************
	//마이페이지 메인
	@RequestMapping(value="/myPage/myPageMain")
	public String myPageMain(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = null;
		
		if(StringUtil.isEmpty(userId)) {
			return "/user/loginForm";
		}else {
			
			user = userService.userSelect(userId);
			model.addAttribute("user", user);
			return "/myPage/myPageMain";
		}
	}
	
	
	//**************************************************************
	//회원정보수정 페이지
	@RequestMapping(value="/myPage/userUpdateForm")
	public String userUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = null;
		
		if(!StringUtil.isEmpty(userId)) {
			user = userService.userSelect(userId);
			
			model.addAttribute("user", user);
			return "/myPage/userUpdateForm";
		}
		
		return "/main/index";
	}
	
	//**************************************************************
	//회원정보수정
	@RequestMapping(value="/myPage/userUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		User user = null;
		String userId = HttpUtil.get(request, "userId");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userNickname = HttpUtil.get(request, "userNickname");
		String userPhoneNo = HttpUtil.get(request, "userPhoneNo");
		String userAddress = HttpUtil.get(request, "userAddress");
		int userPostcode = HttpUtil.get(request, "userPostcode", 0);
		String userDetailAddress = HttpUtil.get(request, "userDetailAddress", "");
		String userExtraAddress = HttpUtil.get(request, "userExtraAddress", "");
		User myUser = userService.userSelect(cookieUserId);
		String myUserNickname = myUser.getUserNickname();
		
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(userNickname) && !StringUtil.isEmpty(userPhoneNo) && !StringUtil.isEmpty(userAddress)
				&& !StringUtil.isEmpty(userPostcode) &&!StringUtil.isEmpty(userDetailAddress) &&!StringUtil.isEmpty(userExtraAddress)) 
		{
			FileData fileData = HttpUtil.getFile(request, "btn_profile_img_change", USER_PROFILE_IMAGE, cookieUserId, "userProfile");

			if(myPageService.nicknameDuplicateCheck(userNickname) > 0) {
				
				if(StringUtil.equals(myUserNickname, userNickname)) {
					user = userService.userSelect(cookieUserId);
					user.setUserNickname(userNickname);
					user.setUserPhoneNo(userPhoneNo);
					user.setUserAddress(userAddress);
					user.setUserPostcode(userPostcode);
					user.setUserDetailAddress(userDetailAddress);
					user.setUserExtraAddress(userExtraAddress);
					
					if(userService.userUpdate(user) > 0) {
						res.setResponse(0, "Success");
					}else {
						res.setResponse(-1, "Fail");
					}
				}else {
					
					res.setResponse(-2, "User Nickname Duplicate");
				}
			}else {
				user = userService.userSelect(cookieUserId);
				user.setUserNickname(userNickname);
				user.setUserPhoneNo(userPhoneNo);
				user.setUserAddress(userAddress);
				user.setUserPostcode(userPostcode);
				user.setUserDetailAddress(userDetailAddress);
				user.setUserExtraAddress(userExtraAddress);
				
				if(userService.userUpdate(user) > 0) {
					res.setResponse(0, "Success");
				}else {
					res.setResponse(-1, "Fail");
				}
			}
			
		}else {
			res.setResponse(400, "Bad Request");
		}
		
		return res;
	}
	
	//**************************************************
	//회원탈퇴 페이지
	@RequestMapping(value="/myPage/myDeleteForm")
	public String myDeleteForm(HttpServletRequest request, HttpServletResponse response) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(StringUtil.isEmpty(userId)) {
			return "/main/index";
		}else {
			return "/myPage/myDeleteForm";
		}
	}
	
	//****************************************************
	//회원탈퇴
	@RequestMapping(value="/myPage/userDeleteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userDeleteProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userPwd = HttpUtil.get(request, "userPwd");
		User user = null;
		
		if(!StringUtil.isEmpty(userId)) {
			user = userService.userSelect(userId);
			
			if(StringUtil.equals(user.getUserPwd(), userPwd)) {
				
				if(userService.userDelete(userId) > 0) {
					res.setResponse(0, "Success");
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				}else {
					res.setResponse(-1, "Fail");
				}
			}else {
				res.setResponse(404, "Password MissMatch");
			}
		}else {
			res.setResponse(400, "Bad Request");
		}
		
		return res;
	}
	
	//*****************************************
	//주문내역페이지
	@RequestMapping(value="/myPage/myOrderForm")
	public String myOrderForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<Order> myOrderList = null;
		Order order = new Order();
		Paging paging = null;
		long totalCount = 0;
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		if(!StringUtil.isEmpty(userId)) {
			
			totalCount = orderService.myOrderListCount(userId);
			
			if(totalCount > 0) {
				paging = new Paging("/myPage/myOrderForm", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				paging.addParam("curPage", curPage);
				order.setUserId(userId);
				order.setStartRow(paging.getStartRow());
				order.setEndRow(paging.getEndRow());
				
				myOrderList = orderService.myOrderListSelect(order);
			}
			
			model.addAttribute("myOrderList", myOrderList);
			model.addAttribute("paging", paging);
			model.addAttribute("curPage", curPage);
			
			return "/myPage/myOrderForm";
			
		}else {
			return "/user/loginForm";
		}
	}
	
	//*************************************
	//상세주문페이지 불러오기
	@RequestMapping(value="/myPage/myOrderDetailForm")
	public String myOrderDetailForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
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
			return "/myPage/myOrderDetailForm";
			
		}else {
			
			return "/user/loginForm";
		}
	}
	
	//**************************
	//쿠폰함 Form
	@RequestMapping(value="/myPage/myCouponForm")
	public String myCouponForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<CouponCase> myCouponCaseList = null;
		
		if(!StringUtil.isEmpty(userId)) {
			myCouponCaseList = myPageService.myCouponCaseList(userId);
			
			model.addAttribute("myCouponCaseList", myCouponCaseList);
			
			return "/myPage/myCouponForm";
			
		}else {
			return "/user/loginForm";
		}
	}
	
	//***************************
	//내가 쓴 style 글 Form
	@RequestMapping(value="/myPage/myStyleList")
	public String myStyleList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<Sboard> sboardList = null;
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		Paging paging = null;
		int listTotalCount = 0;
		Sboard sboard = new Sboard();
		
		if(!StringUtil.isEmpty(userId)) {
			listTotalCount = myPageService.myStyleCount(userId);
			if(listTotalCount > 0) {
				paging = new Paging("/myPage/myStyleList", listTotalCount, STYLE_LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				paging.addParam("curPage", curPage);
				sboard.setUserId(userId);
				sboard.setStartRow(paging.getStartRow());
				sboard.setEndRow(paging.getEndRow());
				
				sboardList = myPageService.myStyleList(sboard);
			}
			
			model.addAttribute("sboardList", sboardList);
			model.addAttribute("paging", paging);
			model.addAttribute("curPage", curPage);
			
			return "/myPage/myStyleList";
			
		}else {
			return "/user/loginForm";
		}
		
	}
	
	//*******************************************
	//내가 좋아요 누른 style글 list
	@RequestMapping(value="/myPage/myLikeStyleList")
	public String myLikeStyleList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<Sboard> sboardList = null;
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		Paging paging = null;
		int listTotalCount = 0;
		Sboard sboard = new Sboard();
		
		if(!StringUtil.isEmpty(userId)) {
			listTotalCount = myPageService.myLikeStyleListCount(userId);
			
			logger.debug("============================");
			logger.debug("============================");
			logger.debug("listTotalCount : " + listTotalCount);
			logger.debug("============================");
			logger.debug("============================");
			
			if(listTotalCount > 0) {
				paging = new Paging("/myPage/myLikeStyleList", listTotalCount, STYLE_LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				paging.addParam("curPage", curPage);
				sboard.setUserId(userId);
				sboard.setStartRow(paging.getStartRow());
				sboard.setEndRow(paging.getEndRow());
				
				sboardList = myPageService.myLikeStyleList(sboard);
			}
			
			model.addAttribute("sboardList", sboardList);
			model.addAttribute("paging", paging);
			model.addAttribute("curPage", curPage);
			
			logger.debug("=======================================");
			logger.debug("=======================================");
			logger.debug("[myPageController]sboardList : " + sboardList);
			logger.debug("=======================================");
			logger.debug("=======================================");
			
			return "/myPage/myLikeStyleList";
			
		}else {
			return "/user/loginForm";
		}
		
	}
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@찜찜찜@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		//찜 리스트 미지
		@RequestMapping(value="/myPage/myZzimList")
		public String zzimList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
				String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME,"");
				String productName = HttpUtil.get(request, "productName", "");
				int productPrice = HttpUtil.get(request, "productPrice", 0);
				
				List<Product> list = null;
				
				int totalCount = 0;
				
				if(!StringUtil.isEmpty(cookieUserId))
				{
					totalCount = productService.zzimAllCount(cookieUserId);
							
					if(totalCount > 0)
					{
						list = productService.zzimList(cookieUserId);
						
					}
					
					model.addAttribute("list", list);
					model.addAttribute("productName", productName);
					model.addAttribute("productPrice", productPrice);
					
					return "/myPage/myZzimList";
				 }
				 else  //쿠키유저 아이디 없을때 
				 {
					return "/user/loginForm";
				 }

		}
		
		//찜 리스트에서 찜 1개 삭제 미지
		@RequestMapping(value="/myPage/deleteZzim", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> deleteZzim(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			int productNo = HttpUtil.get(request, "productNo", 0);

			if(productService.zzimAllCount(cookieUserId) > 0)
			{
				if(productNo > 0)
				{
					if(productService.deleteZzim(productNo) > 0)
					{
						ajaxResponse.setResponse(0, "success");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "empty zzim");
			}
			
			return ajaxResponse;
		}
}