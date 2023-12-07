package com.icia.web.model;

import java.io.Serializable;

public class Product implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int productNo;
	private String mainCategoryCode;
	private String subCategoryCode;
	private String productName;
	private int productPrice;
	private String productRegDate;
	private int salesRate;
	private String brandCode;
	
	private String brandName;
	
	//상품 조회(최신순: 1, 판매인기순: 2, 높은가격순: 3, 낮은가격순:4)
	private String optionSelect;
	
	private long startRow;				
	private long endRow;
	
	private String searchType;			//검색타입(1:이름, 2:제목, 3:내용)
	private String searchValue;			//검색 값
	
	public Product() 
	{
		productNo = 0;
		mainCategoryCode = "";
		subCategoryCode = "";
		productName = "";
		productPrice = 0;
		productRegDate = "";
		salesRate = 0;
		brandCode = "";
		
		brandName = "";
		
		optionSelect = "";
		
		startRow = 0;
		endRow = 0;
		
		searchType = "";
		searchValue = "";
		
	}
	

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getMainCategoryCode() {
		return mainCategoryCode;
	}

	public void setMainCategoryCode(String mainCategoryCode) {
		this.mainCategoryCode = mainCategoryCode;
	}

	public String getSubCategoryCode() {
		return subCategoryCode;
	}

	public void setSubCategoryCode(String subCategoryCode) {
		this.subCategoryCode = subCategoryCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductRegDate() {
		return productRegDate;
	}

	public void setProductRegDate(String productRegDate) {
		this.productRegDate = productRegDate;
	}

	public int getSalesRate() {
		return salesRate;
	}

	public void setSalesRate(int salesRate) {
		this.salesRate = salesRate;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
	
	public String getOptionSelect() {
		return optionSelect;
	}

	public void setOptionSelect(String optionSelect) {
		this.optionSelect = optionSelect;
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


	public String getBrandName() {
		return brandName;
	}


	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	
}
