package com.icia.web.model;

import java.io.Serializable;

public class Notice implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private int nboardNo;
	private String adminId;
	private String nboardTitle;
	private String nboardContent;
	private String nboardRegDate;

	//페이징
	private long startRow;
	private long endRow;
	
	//검색 타입(1.제목, 2:내용)
	private String searchType;
	private String searchValue;
	
	
	public Notice()
	{
		nboardNo = 0;
		adminId = "";
		nboardTitle = "";
		nboardContent = "";
		nboardRegDate = "";
		
		//페이징
		startRow = 0;
		endRow = 0;
		
		//검색
		searchType= "";
		searchValue="";
	}


	public int getNboardNo() {
		return nboardNo;
	}


	public void setNboardNo(int nboardNo) {
		this.nboardNo = nboardNo;
	}


	public String getAdminId() {
		return adminId;
	}


	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}


	public String getNboardTitle() {
		return nboardTitle;
	}


	public void setNboardTitle(String nboardTitle) {
		this.nboardTitle = nboardTitle;
	}


	public String getNboardContent() {
		return nboardContent;
	}


	public void setNboardContent(String nboardContent) {
		this.nboardContent = nboardContent;
	}


	public String getNboardRegDate() {
		return nboardRegDate;
	}


	public void setNboardRegDate(String nboardRegDate) {
		this.nboardRegDate = nboardRegDate;
	}


	public long getStartRow() {
		return startRow;
	}


	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}


	public long getEndRow() {
		return endRow;
	}


	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}


	public String getSearchType() {
		return searchType;
	}


	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	public String getSearchValue() {
		return searchValue;
	}


	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	

	
	
	
	
	
}
