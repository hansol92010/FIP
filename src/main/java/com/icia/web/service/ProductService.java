package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.web.dao.ProductDao;
import com.icia.web.model.Product;
import com.icia.web.model.ProductManagementVO;
import com.icia.web.model.ProductSize;
import com.icia.web.model.ProductZzim;
import com.icia.web.util.HttpUtil;

@Service("productService")
public class ProductService {
	
	@Autowired
	ProductDao productDao;
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.product_thum']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.product_detail']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_DETAIL;
	
	private static Logger logger = LoggerFactory.getLogger(ProductService.class);

	//상품 조회
	public long allProductCount(Product product)
	{
		long count = 0;
		
		try
		{
			count = productDao.allProductCount(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] allProductCount Exception", e);
		}
		
		return count;
	}
	
	//모든 상품 조회
	public List<Product> allProductList(Product product)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.allProductList(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] allProductList Exception", e);
		}
		
		return list;
	}
	
	//브랜드 별 상품 수
	public long eachBrandCount(String brandCode)
	{
		long count = 0;
		
		try
		{
			count = productDao.eachBrandCount(brandCode);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] eachBrandCount Exception", e);
		}
		
		return count;
	}
	
	//브랜드 별 상품 조회
	public List<Product> eachBrandSelect(Product product)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.eachBrandSelect(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] eachBrandSelect Exception", e);
		}
		
		return list;
	}
	
	//카테고리 별 상품 수
	public long categoryCount(Product product)
	{
		long count = 0;
		
		try
		{
			count = productDao.categoryCount(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] categoryCount Exception", e);
		}
		
		return count;
	}
	
	//카테고리 별 상품 조회
	public List<Product> categorySelect(Product product)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.categorySelect(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] categorySelect Exception", e);
		}
		
		return list;
	}
	
	//상세 페이지에서의 상품 조회
	public Product detailProduct(int productNo)
	{
		Product product = null;
		
		try
		{
			product = productDao.detailProduct(productNo);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] detailProduct Exception", e);
		}
		
		return product;
	}
	
	//브랜드별 무작위 추출
	public List<Product> brandRandom(String brandCode)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.brandRandom(brandCode);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] brandRandom Exception", e);
		}
		
		return list;
	}
	
	//구매 물품
	public Product selectProduct(int productNo)
	{
		Product product = null;
		
		try
		{
			product = productDao.selectProduct(productNo);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] selectProduct Exception", e);
		}
		
		return product;
	}
	
	//재고 체크
	public int unitsCheck(ProductSize productSize)
	{
		int count = 0;
		
		try
		{
			count = productDao.unitsCheck(productSize);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] unitsCheck Exception", e);
		}
		
		return count;
	}
	
	//판매량 높은 상품 조회		용구
	public List<Product> bestProduct(int count)
	{
		List<Product> list = null;
		try
		{
			list = productDao.bestProduct(count);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] bestItem Exception", e);
		}
			
		return list;
	}
		
	//결제성공후 재고량 DOWN : 양진구
	public int productUnitsRemove(ProductManagementVO pmvo) {
		int count = 0;
			
		try {
			count = productDao.productUnitsRemove(pmvo);
		}catch(Exception e) {
			logger.error("[ProductService] productUnitsRemove Exception", e);
		}
			
		return count;
	}
	
	//결제성공후 판매량 UP : 양진구
	public int productSalesRateAdd(ProductManagementVO pmvo) {
		int count = 0;
		
		try {
			count = productDao.productSalesRateAdd(pmvo);
		}catch(Exception e) {
			logger.error("[productSalesRateAdd] productUnitsRemove Exception", e);
		}
		return count;
	}
	
	//#################################################
	//관리자 페이지에서 사용할 부분
	
	//관리자 페이지 상품목록
	public List<Product> productList(Product product)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.productList(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] bestItem Exception", e);
		}
		
		return list;
	}
	
	//관리자 페이지 재고(사이즈포함)목록
	public List<ProductSize> selectProductSize(int productNo)
	{
		List<ProductSize> list = null;
		
		try
		{
			list = productDao.selectProductSize(productNo);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] selectProductSize Exception", e);
		}
		
		return list;
	}
	
	//관리자 페이지 상품 업데이트
	public int productUpdate(Product product)
	{
		int count = 0;
		
		try
		{
			count = productDao.productUpdate(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] productUpdate Exception", e);
		}
		
		return count;
	}
	
	//관리자 페이지 상품 업데이트
	public int productStockUpdate(ProductSize productSize)
	{
		int count = 0;
		
		try
		{
			count = productDao.productStockUpdate(productSize);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] productStockUpdate Exception", e);
		}
		
		return count;
	}
	
	//관리자 페이지 상품 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int productDelete(int productNo) throws Exception
	{
		int count = 0;
		
		Product product = productDao.selectProduct(productNo);
		
		if(product != null)
		{	
			count = productDao.productDelete(productNo);
			
			if(count > 0)
			{
				List<ProductSize> productSize = productDao.selectProductSize(productNo);
				
				if(productSize != null)
				{
					if(productDao.productSizeDelete(productNo) > 0)
					{
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_THUM + FileUtil.getFileSeparator() + productNo + "_thum.jpg");
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_DETAIL + FileUtil.getFileSeparator() + productNo + "_1.jpg");
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_DETAIL + FileUtil.getFileSeparator() + productNo + "_2.jpg");
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_DETAIL + FileUtil.getFileSeparator() + productNo + "_3.jpg");
						
						logger.debug("servcie==============================================");
						logger.debug("UPLOAD_SAVE_DIR_PRODUCT_THUM : " + UPLOAD_SAVE_DIR_PRODUCT_THUM);
						logger.debug("FileUtil.getFileSeparator() : " + FileUtil.getFileSeparator());
						logger.debug("productNo _thum.jpg : " + productNo + "_thum.jpg");
						logger.debug("=====================================================");
					}
					else
					{
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_THUM + FileUtil.getFileSeparator() + productNo + "_thum.jpg");
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_DETAIL + FileUtil.getFileSeparator() + productNo + "_1.jpg");
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_DETAIL + FileUtil.getFileSeparator() + productNo + "_2.jpg");
						FileUtil.deleteFile(UPLOAD_SAVE_DIR_PRODUCT_DETAIL + FileUtil.getFileSeparator() + productNo + "_3.jpg");
					}
				}
			}
		}
		
		return count;
	}
	
	//관리자 페이지 상품 사이즈 삭제
	public int productSizeDelete(int productNo)
	{
		int count = 0;
		
		try
		{
			count = productDao.productSizeDelete(productNo);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] productSizeDelete Exception", e);
		}
		
		return count;
	}
	
	//관리자 페이지 상품 목록 수
	public long productCount(Product product)
	{
		long count = 0;
		
		try
		{
			count = productDao.productCount(product);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] allProductCount Exception", e);
		}
		
		return count;
	}
	
	
	
	/////////////////////////////////
	//메인 페이지 배너용
	
	//브랜드에 따라 신제품 소개 페이지에 쓰일 예정
	public List<Product> newProduct(String brandCode)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.newProduct(brandCode);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] newProduct Exception", e);
		}
		
		return list;
	}
	
	//@@@@@@@@@@@@@@@찜하기@@@@@@@@@@@@@@@@@@
	//찜 누르면 추가
	public int zzimInsert(ProductZzim productZzim) 
	{
		int count=0;
		
		try
		{
			count= productDao.zzimInsert(productZzim);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] zzimInsert Exception", e);
		}
		
		return count;
	}
	

	
	//원래 눌렀던 찜 누르면 찜 취소
	public int zzimDelete(ProductZzim productZzim)
	{
		int count=0;
		
		try
		{
			count=productDao.zzimDelete(productZzim);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] zzimDelete Exception", e);
		}
		
		return count;
	}
	
	
	
	//찜 체크용
	public int zzimCheck(ProductZzim productZzim)
	{
		int count=0;
		
		try
		{
			count=productDao.zzimCheck(productZzim);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] zzimCheck Exception", e);
		}
		
		return count;
	}
	
	//해당 상품에 눌린 총 찜
	public List<ProductZzim> zzimSelect(ProductZzim productZzim)
	{
		List<ProductZzim> list= null;
		
		try
		{
			list = productDao.zzimSelect(productZzim);
		}	
		catch(Exception e)
		{
			logger.error("[ProductService] zzimSelect Exception", e);
		}
		
		return list;
		
	}
	
	//총 찜 수 
	public int zzimAllCount(String userId)
	{
		int count = 0;
		
		try
		{
			count=productDao.zzimAllCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] zzimAllCount Exception", e);
		}
		
		return count;
	}
		
	//찜 리스트(상품)
	public List<Product> zzimList(String userId)
	{
		List<Product> list = null;
		
		try
		{
			list = productDao.zzimList(userId);
		}	
		catch(Exception e)
		{
			logger.error("[ProductService] zzimSelect Exception", e);
		}
		
		return list;
	}
	
	//찜 리스트에 있는 상품 한개 삭제
	public int deleteZzim(int productNo)
	{
		int count=0;
		
		try
		{
			count= productDao.deleteZzim(productNo);
		}
		catch(Exception e)
		{
			logger.error("[ProductService] zzimAllCount Exception", e);
		}	
		
		
		return count;
	}
}
