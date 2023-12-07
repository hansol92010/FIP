package com.icia.web.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.IndexDao;
import com.icia.web.model.Product;
import com.icia.web.model.Sboard;

@Service("indexService")
public class IndexService {

	private static Logger logger = LoggerFactory.getLogger(ProductService.class);
	
	@Autowired
	IndexDao indexDao;
	
	public List<Product> menBestItems(int cnt) {
		List<Product> menBestItems = new ArrayList<Product>();
		
		try {
			menBestItems = indexDao.menBestItems(cnt);
		}catch(Exception e) {
			logger.error("[IndexService] menBestItems Exception e", e);
		}
		
		return menBestItems;
	}
	
	
	public List<Product> womenBestItems(int cnt) {
		List<Product> womenBestItems = new ArrayList<Product>();
		
		try {
			womenBestItems = indexDao.womenBestItems(cnt);
		}catch(Exception e) {
			logger.error("[IndexService] womenBestItems Exception e", e);
		}
		
		return womenBestItems;
	}
	
	public List<Sboard> sboardBestItems(int cnt) {
		List<Sboard> sboardBestItems = new ArrayList<Sboard>();
		
		try {
			sboardBestItems = indexDao.sboardBestItems(cnt);
		}catch(Exception e) {
			logger.error("[IndexService] sboardBestItems Exception e", e);
		}
		
		return sboardBestItems;
	}
}
