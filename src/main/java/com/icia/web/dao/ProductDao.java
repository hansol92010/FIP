package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Product;
import com.icia.web.model.ProductManagementVO;
import com.icia.web.model.ProductSize;
import com.icia.web.model.ProductZzim;

@Repository("productDao")
public interface ProductDao {

	//총 상품 수
	public long allProductCount(Product product);
	
	//모든 상품 조회
	public List<Product> allProductList(Product product);
	
	//브랜드 별 상품 수
	public long eachBrandCount(String brandCode);
	
	//브랜드 별 상품 조회
	public List<Product> eachBrandSelect(Product product);
	
	//카테고리 별 상품 수
	public long categoryCount(Product product);
	
	//카테고리 별 상품 조회
	public List<Product> categorySelect(Product product);
	
	//상세페이지에서의 상품 조회
	public Product detailProduct(int productNo);
	
	//브랜드별 무작위 추출
	public List<Product> brandRandom(String brandCode);
	
	//특정 상품 구매
	public Product selectProduct(int productNo);
	
	//재고 체크
	public int unitsCheck(ProductSize productSize);
	
	//판매량 높은 상품  조회	 용구
	public List<Product> bestProduct(int mainItemListCount);
	
	//결제후 재고량 DOWN
	public int productUnitsRemove(ProductManagementVO pmvo);
	
	//결제후 판매량 UP
	public int productSalesRateAdd(ProductManagementVO pmvo);
	
	///////////////////////////////////////////////////////////////
	//관리자 페이지용
	
	//상품 별 사이즈와 재고 체크(관리자 페이지에서 사용)
	public List<ProductSize> selectProductSize(int productNo);
	
	//관리자 페이지 상품 목록
	public List<Product> productList(Product product);
	
	//관리자 페이지 상품 업데이트
	public int productUpdate(Product product);
	
	//관리자 페이지 상품 재고 업데이트
	public int productStockUpdate(ProductSize productSize);
	
	//관리자 페이지 상품 삭제
	public int productDelete(int productNo);
	
	//관리자 페이지 상품 사이즈 삭제
	public int productSizeDelete(int productNo);
	
	//관리자 페이지 상품 목록
	public long productCount(Product product);
	
	/////////////////////////////////
	//메인 페이지 배너용
	
	//브랜드에 따라 신제품 소개 페이지에 쓰일 예정
	public List<Product> newProduct(String brandCode);
	
	//@@@@@@@@@@@@@@@찜하기@@@@@@@@@@@@@@@@@@
	//찜 누르면 추가
	public int zzimInsert(ProductZzim productZzim);
	
	//찜 누르면 찜 취소
	public int zzimDelete(ProductZzim productZzim);
	
	//찜 체크용
	public int zzimCheck(ProductZzim productZzim);
	
	//해당 상품을 내가 누른적 있는지 확인용 (상품상세 조회시 리스트에 담을용)
	public List<ProductZzim> zzimSelect(ProductZzim productZzim);
	
	//내가 담은 총 찜 수 
	public int zzimAllCount(String userId);
	
	//찜 리스트(상품)
	public List<Product> zzimList(String userId);
	
	//찜 리스트에 있는 상품 한개 삭제
	public int deleteZzim(int productNo);
}
