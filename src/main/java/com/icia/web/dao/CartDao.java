package com.icia.web.dao;

import java.util.List;

import com.icia.web.model.Cart;

public interface CartDao {
	
	
	//장바구니 리스트 수 카운트
	public int cartListCount(String userId);
	
	//장바구니 리스트 조회 
	public List<Cart> cartList(String userId); 
	
	//장바구니에 추가
	public int addCart(Cart cart);
	
	//장바구니에 추가시 같은 상품이 있나 확인
	public int cartCheck(Cart cart);
	
	//장바구니에 추가시 같은 상품 있으면 수량 +1
	public int cartUpdate(Cart cart); 
	
	//장바구니에서 삭제(상품1개)
	public int deleteCart(int cartNo);
	
	//전체상품 삭제
	public int deleteAllCart(String userId);
	
	//전체상품 주문
	public List<Cart> orderAllCart(String userId);
	

}
