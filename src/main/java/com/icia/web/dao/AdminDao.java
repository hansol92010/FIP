package com.icia.web.dao;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Admin;
import com.icia.web.model.Product;
import com.icia.web.model.ProductSize;

@Repository("adminDao")
public interface AdminDao {
	
	public Admin adminSelect(String adminId);

	public int productInsert(Product product);
	
	public int sizeInStockInsert(ProductSize productSize);
	
	public int productSeq(Product product);
	
}
