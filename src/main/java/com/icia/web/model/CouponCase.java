package com.icia.web.model;

import java.io.Serializable;

public class CouponCase implements Serializable{

	private static final long serialVersionUID = 1L;

	private String couponName;
	private String couponStatus;
	private String expirationDate;
	
	public CouponCase() {
		couponName = "";
		couponStatus = "";
		expirationDate = "";
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponStatus() {
		return couponStatus;
	}

	public void setCouponStatus(String couponStatus) {
		this.couponStatus = couponStatus;
	}

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationRate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	
}
