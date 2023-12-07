package com.icia.web.model;

import java.io.Serializable;

public class SboardProductInfoNo implements Serializable
{

	//스타일 게시글 등록시 선택한 상품정보 저장을 위한 model
	
	private static final long serialVersionUID = 1L;

	private int sboardNo;
	private int productNo;
	
	public SboardProductInfoNo() 
	{
		sboardNo = 0;
		productNo = 0;
	}

	public int getSboardNo() {
		return sboardNo;
	}

	public void setSboardNo(int sboardNo) {
		this.sboardNo = sboardNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	
	

	
}
