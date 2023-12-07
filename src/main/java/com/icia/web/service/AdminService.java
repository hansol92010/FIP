package com.icia.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.AdminDao;
import com.icia.web.model.Admin;
import com.icia.web.model.Product;
import com.icia.web.model.ProductSize;
@Service("adminService")
public class AdminService {
	
	Logger logger = LoggerFactory.getLogger(AdminService.class);
	
	@Autowired
	private AdminDao adminDao;
	
	public Admin adminSelect(String adminId)
	{
		Admin admin = null;
		
		try
		{
			admin = adminDao.adminSelect(adminId);
		}
		catch(Exception e)
		{
			logger.error("[AdminService] adminSelect Exception", e);
		}
		
		return admin;
	}
	
	public int productInsert(Product product)
	{	
		int count = 0;
		
//		트랜젝션을 시도하려 했을 때
//		ProductSize productSize = product.getProductSize();
//		productSize.setProductNo(product.getProductNo());
//		
//		adminDao.sizeInStockInsert(product.getProductSize());
		
		try
		{
			count = adminDao.productInsert(product);
		}
		catch(Exception e)
		{
			logger.error("[AdminService] productInsert Exception", e);
		}
		
		return count;
	}
	
	
	public int productSeq(Product product)
	{
		int count = 0;
				
		try
		{
			count = adminDao.productSeq(product);
		}
		catch(Exception e)
		{
			logger.error("[AdminService] productSeq Exception", e);
		}
		return count;
	}
	
	public int sizeInStockInsert(ProductSize productSize)
	{
		int count = 0;
		
		try
		{
			count = adminDao.sizeInStockInsert(productSize);
		}
		catch(Exception e)
		{
			logger.error("[AdminService] sizeInStockInsert Exception", e);
		}
		
		return count;
	}
	
}
