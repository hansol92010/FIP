package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.icia.web.dao.CartDao;
import com.icia.web.dao.ProductDao;
import com.icia.web.model.Cart;

@Service("cartService")
public class CartService {
	
	private static Logger logger = LoggerFactory.getLogger(CartService.class);
	
	@Autowired
	private CartDao cartDao;

	
	//썸네일 저장 경로
	@Value("#{env['upload.save.dir1']}")
	private String UPLOAD_SAVE_DIR_THUM;

	//장바구니 총 리스트 수 
	public int cartListCount(String userId)
	{
		int count = 0;
		
		try
		{
			count = cartDao.cartListCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[CartDao]cartListCount Exception", e);
		}	
		
		return count;
	}
	
	//장바구니 리스트 조회
	public List<Cart> cartList(String userId)
	{
		List<Cart> cartList = null;
		
		try
		{
			cartList = cartDao.cartList(userId);
		}
		catch(Exception e)
		{
			logger.error("[CartService] cartList Exception", e);
		}
		
		
		return cartList;
	}
	
	//장바구니에 추가
	public int addCart(Cart cart)
	{
		int count = 0;
				
		try
		{
			count = cartDao.addCart(cart);
		}
		catch(Exception e)
		{
			logger.error("[CartService] addCart Exception", e);
		}
				
		return count;
	}
	
	//장바구니에 추가시 같은 상품이 있나 확인
	public int cartCheck(Cart cart)
	{
		int count = 0;
		
		try
		{
			count = cartDao.cartCheck(cart);
		}
		catch(Exception e)
		{
			logger.error("[CartService] cartCheck Exception", e);
		}
				
		return count;
	}
	
	//장바구니에 추가시 같은 상품 있으면 수량 +1
	public int cartUpdate(Cart cart)
	{
		int count = 0;
		
		try
		{
			count = cartDao.cartUpdate(cart);
		}
		catch(Exception e)
		{
			logger.error("[CartService] cartUpdate Exception", e);
		}
				
		return count;
	}
	
	//장바구니에서 삭제
	public int deleteCart(int cartNo)
	{
		int count = 0;
		
		try
		{
			count = cartDao.deleteCart(cartNo);
		}
		catch(Exception e)
		{
			logger.error("[CartService] deleteCart Exception", e);
		}

		return count;
	}
	
	//전체상품 삭제
	public int deleteAllCart(String userId)
	{
		int count = 0;
		
		try
		{
			count = cartDao.deleteAllCart(userId);
		}
		catch(Exception e)
		{
			logger.error("[CartService] deleteAllCart Exception", e);
		}
		
		return count;
		
	}
	
	//전체상품 주문
	public List<Cart> orderAllCart(String userId)
	{
		List<Cart> cartList = null;
		
		try
		{
			cartList = cartDao.orderAllCart(userId);
		}
		catch(Exception e)
		{
			logger.error("[CartService] orderAllCart Exception", e);
		}

		return cartList;
	}
	
	
}
