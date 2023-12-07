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

import com.icia.common.util.StringUtil;
import com.icia.web.model.Cart;
import com.icia.web.model.Product;
import com.icia.web.model.User;
import com.icia.web.service.CartService;
import com.icia.web.service.ProductService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;

@Controller("orderController")
public class OrderController {
	
	private static Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.product_thum']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.product_detail']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_DETAIL;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CartService cartService;
	
	
	   @RequestMapping(value="/payment/buyForm")
	   public String buyForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      
	      Product product = null;
	      User user = null;
	      List<Cart> list = new ArrayList<Cart>();

	      if(!StringUtil.isEmpty(cookieUserId))
	      {
	         user = userService.userSelect(cookieUserId);
	         list = cartService.cartList(cookieUserId);
	      }
	      
	      model.addAttribute("user", user);
	      model.addAttribute("list", list);
	      
	      return "/payment/buyForm";
	      
	   }

}
