package com.icia.web.model;

import java.io.Serializable;

public class OrderDetail implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int orderDetailNo;			//상세주문번호
	private int orderNo;				//주문번호
	private int productNo;				//상품번호
	private String productName;			//상품명
	private int orderCount;				//주문수량
	private int productPrice;			//상품가격
	private String sizeName;			//상품사이즈
	private int discountPrice;			//할인금액
	private int totalPrice;				//할인적용후 금액
	
	public OrderDetail() {
		orderDetailNo = 0;
		orderNo = 0;
		productNo = 0;
		productName = "";
		orderCount = 0;
		productPrice = 0;
		sizeName = "";
		discountPrice = 0;
		totalPrice = 0;
	}

	public int getOrderDetailNo() {
		return orderDetailNo;
	}

	public void setOrderDetailNo(int orderDetailNo) {
		this.orderDetailNo = orderDetailNo;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

	public int getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(int discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	
}
