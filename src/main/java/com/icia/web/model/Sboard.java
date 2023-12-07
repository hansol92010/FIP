package com.icia.web.model;

import java.io.Serializable;

public class Sboard implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int sboardNo;
	private String userId;
	private String sboardTitle;
	private String sboardContent;
	private int readCount;
	private int likeCount;
	private String brandCode;
	private String sboardRegDate;
	
	private long startRow;      //시작 rownum
	private long endRow;        //끝 rownum
	
	private String searchType;   //검색타입(1.이름, 2.제목 , 3.내용)
	private String searchValue;   //검색 값
	
	//스타일 옵션(최신순1,인기순2 )조회
	private String optionSelect;
	
	//회원 닉네임
	private String userNickName;
	
	
	public Sboard()
	{
		sboardNo = 0;
		userId = "";
		sboardTitle = "";
		sboardContent = "";
		readCount = 0;
		likeCount = 0;
		brandCode = "";
		sboardRegDate = "";
		
		optionSelect= "";
		
		userNickName="";
		
		startRow=0;
		endRow=0;
		searchType="";
		searchValue="";
		

	}


	public int getSboardNo() {
		return sboardNo;
	}


	public void setSboardNo(int sboardNo) {
		this.sboardNo = sboardNo;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getSboardTitle() {
		return sboardTitle;
	}


	public void setSboardTitle(String sboardTitle) {
		this.sboardTitle = sboardTitle;
	}


	public String getSboardContent() {
		return sboardContent;
	}


	public void setSboardContent(String sboardContent) {
		this.sboardContent = sboardContent;
	}


	public int getReadCount() {
		return readCount;
	}


	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}


	public int getLikeCount() {
		return likeCount;
	}


	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}


	public String getBrandCode() {
		return brandCode;
	}


	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}


	public String getSboardRegDate() {
		return sboardRegDate;
	}


	public void setSboardRegDate(String sboardRegDate) {
		this.sboardRegDate = sboardRegDate;
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


	public String getOptionSelect() {
		return optionSelect;
	}


	public void setOptionSelect(String optionSelect) {
		this.optionSelect = optionSelect;
	}


	public String getUserNickName() {
		return userNickName;
	}


	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	

	
	
	
	
	
	

}
