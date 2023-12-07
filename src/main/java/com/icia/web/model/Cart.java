package com.icia.web.model;

import java.io.Serializable;

public class Cart implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String userId;  //사용자아이디
	private int productNo; //상품번호
	private int orderCount; //상품수량
	private int productPrice; //상품가격
	private String sizeName; //사이즈이름
	private String productName; //상품이름
	
	private int cartNo;  //장바구니 번호(개별상품당)
	
	public Cart() {
		userId = "";
		productNo = 0;
		orderCount = 0;
		productPrice = 0;
		sizeName = "";
		productName = "";
		
		cartNo=0;
	}
	
	//buyForm에 데이터를 보내기 위해 생성자를 따로 만듦
	public Cart(String userId, int productNo, int orderCount, int productPrice, String sizeName, String productName)
	{
		this.userId = userId;
		this.productNo = productNo;
		this.orderCount = orderCount;
		this.productPrice = productPrice;
		this.sizeName = sizeName;
		this.productName = productName;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getSizeName() {
		return sizeName;
	}

	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}	
	
	
	
}