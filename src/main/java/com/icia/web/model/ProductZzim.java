package com.icia.web.model;

import java.io.Serializable;

public class ProductZzim implements Serializable {
	private static final long serialVersionUID = 1L;


	private int zzimNo;  //찜번호(시퀀스)
	private int productNo;  //찜한 상품번호
	private String userId;  //찜 누른 아이디
	
	public ProductZzim()
	{
		zzimNo = 0;
		productNo = 0;
		userId = "";
	}

	public int getZzimNo() {
		return zzimNo;
	}

	public void setZzimNo(int zzimNo) {
		this.zzimNo = zzimNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
		
}
