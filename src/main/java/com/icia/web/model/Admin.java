package com.icia.web.model;

import java.io.Serializable;

public class Admin implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String adminId;
	private String adminPwd;
	private String adminName;
	private String adminStatus;
	private String adminRegDate;
	
	public Admin()
	{
		adminId = "";
		adminPwd = "";
		adminName = "";
		adminStatus = "";
		adminRegDate = "";
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAdminPwd() {
		return adminPwd;
	}

	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminStatus() {
		return adminStatus;
	}

	public void setAdminStatus(String adminStatus) {
		this.adminStatus = adminStatus;
	}

	public String getAdminRegDate() {
		return adminRegDate;
	}

	public void setAdminRegDate(String adminRegDate) {
		this.adminRegDate = adminRegDate;
	}

}
