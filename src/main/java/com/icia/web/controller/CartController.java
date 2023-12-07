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

import com.icia.common.util.StringUtil;
import com.icia.web.model.Cart;
import com.icia.web.model.Product;
import com.icia.web.model.ProductManagementVO;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.CartService;
import com.icia.web.service.ProductService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("cartController")
public class CartController {
private static Logger logger = LoggerFactory.getLogger(CartController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")  
	private String AUTH_COOKIE_NAME;  
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.product_thum']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_THUM;
	
	@Autowired
	private CartService cartService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductService productService;
	
	//메인에서 장바구니 버튼 누르면 보여지는 장바구니 리스트
	   @RequestMapping(value="/cart/cart")
	   public String cartList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      
	      int productNo = HttpUtil.get(request, "productNo", (int)0);
	      String sizeName = HttpUtil.get(request,  "sizeName", "");
	      int orderCount = HttpUtil.get(request, "orderCount", (int)0);
	      
	      Product product = null;
	      User user = null;
	      List<Cart> list = new ArrayList<Cart>();
	      
	      if(!StringUtil.isEmpty(cookieUserId))
	      {
	         user = userService.userSelect(cookieUserId);

	         if(productNo > 0 && orderCount > 0 && !StringUtil.isEmpty(sizeName))
	         {
	            product = productService.selectProduct(productNo);
	            
	            list.add(new Cart(cookieUserId, productNo, orderCount, product.getProductPrice(), sizeName, product.getProductName()));
	            
	            model.addAttribute("user", user);
	            model.addAttribute("list", list);
	               
	            return "/payment/buyForm";
	         }
	         else
	         {
	            List<Cart> cartList = cartService.cartList(cookieUserId);
	            
	            model.addAttribute("cartList", cartList); 
	            model.addAttribute("userId", cookieUserId);
	            
	            return "/cart/cart";
	         }         
	      }
	      else
	      {
	         return "/user/loginForm";
	      }
	   }
	
	//장바구니에서 선택 삭제
	@RequestMapping(value="/cart/deleteCart", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteCart(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int cartNo = HttpUtil.get(request, "cartNo", 0);
		
		logger.debug("#######################################");
		logger.debug("cartNo :" + cartNo);
		logger.debug("#######################################");

		if(cartService.cartListCount(cookieUserId) > 0)
		{
			
			if(cartNo > 0)
			{
				if(cartService.deleteCart(cartNo) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
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
			ajaxResponse.setResponse(400, "empty cart");
		}
		
		return ajaxResponse;
	}

	//전체상품 삭제
	@RequestMapping(value="/cart/deleteAllCart", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteAllCart(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		cartService.cartListCount(cookieUserId);
	
		if(cartService.cartListCount(cookieUserId) > 0)
		{
			if(cartService.deleteAllCart(cookieUserId) > 0)
			{
				ajaxResponse.setResponse(0, "success");
			}
			else
			{
				ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "empty cart");
		}
		
		return ajaxResponse;
		
	}	
		
	//전체상품 주문-> 리스트에 보여지는 상품들을 담아서 주문페이지로 넘겨
	@RequestMapping(value="/cart/orderProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> orderAllCart(HttpServletRequest request, HttpServletResponse response)
	{ 
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(cartService.cartListCount(cookieUserId) > 0)
		{
			
			ajaxResponse.setResponse(0, "success");
		}
		else
		{
			ajaxResponse.setResponse(400, "empty Cart");
		}

		return ajaxResponse;
	}
	
	//*****************************************************
	//결제성공 -> 주문내역 생성 -> 상세주문생성 후 각 상품의 판매량 UP, 사이즈 재고량을 찾아 DOWN, 장바구니 삭제
	@RequestMapping(value="/cart/productManagement")
	@ResponseBody
	public Response<Object> productManagement(@RequestParam(value="itemsNoList") List<Integer> itemsNoList, @RequestParam(value="itemsQuantityList") List<Integer> itemsQuantityList, 
												@RequestParam(value="itemsSizeNameList") List<String> itemsSizeNameList, HttpServletRequest request, HttpServletResponse response) {
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		Response<Object> res = new Response<Object>();
		
		int productUnitsRemoveCheck = 0;
		int productSalesRateAddCheck = 0;
		int cartDeleteCheck = 0;
		
		
		for(int i = 0; i < itemsNoList.size(); i++) {
			ProductManagementVO pmvo = new ProductManagementVO();
			pmvo.setProductNo(itemsNoList.get(i));
			pmvo.setProductQuantity(itemsQuantityList.get(i));
			pmvo.setProductSizeName(itemsSizeNameList.get(i));
			
			productUnitsRemoveCheck = productService.productUnitsRemove(pmvo);
			
			if(productUnitsRemoveCheck > 0) {
				productSalesRateAddCheck = productService.productSalesRateAdd(pmvo);
			}else {
				res.setResponse(-1, "Update Fail");
			}
		}
		
		if(productSalesRateAddCheck > 0) {
			cartDeleteCheck = cartService.deleteAllCart(userId);
		}else {
			res.setResponse(-1, "UpdateFail 2");
		}
		
		return res;
	}
}	
