package com.icia.web.model;

import java.io.Serializable;

public class ProductManagementVO implements Serializable{

	private static final long serialVersionUID = 1L;

	private int productNo;
	private int productQuantity;
	private String productSizeName;
	
	public ProductManagementVO() {
		productNo = 0;
		productQuantity = 0;
		productSizeName = "";
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}

	public String getProductSizeName() {
		return productSizeName;
	}

	public void setProductSizeName(String productSizeName) {
		this.productSizeName = productSizeName;
	}
	
	
}
