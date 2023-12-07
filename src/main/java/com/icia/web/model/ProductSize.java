package com.icia.web.model;

import java.io.Serializable;

public class ProductSize implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int productNo;
	private String sizeName;
	private int units;
	
	public ProductSize()
	{
		productNo = 0;
		sizeName = "";
		units = 0;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getSizeName() {
		return sizeName;
	}

	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

	public int getUnits() {
		return units;
	}

	public void setUnits(int units) {
		this.units = units;
	}

}
