package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Product;
import com.icia.web.model.Sboard;

@Repository("indexDao")
public interface IndexDao {
	
	public List<Product> menBestItems(int cnt);
	
	public List<Product> womenBestItems(int cnt);
	
	public List<Sboard> sboardBestItems(int cnt);
}
