/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.icia.web.model.Product;
import com.icia.web.model.Sboard;
import com.icia.web.service.IndexService;
import com.icia.web.service.ProductService;
import com.icia.web.service.SboardService;




	/**
	 * <pre>
	 * 패키지명   : com.icia.web.controller
	 * 파일명     : IndexController.java
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 인덱스 컨트롤러
	 * </pre>
	 */
	@Controller("indexController")
	public class IndexController
	{
		private static Logger logger = LoggerFactory.getLogger(IndexController.class);

		/**
		 * <pre>
		 * 메소드명   : index
		 * 작성일     : 2021. 1. 21.
		 * 작성자     : daekk
		 * 설명       : 인덱스 페이지 
		 * </pre>
		 * @param request  HttpServletRequest
		 * @param response HttpServletResponse
		 * @return String
		 */
		@Autowired
		private ProductService productService;	
		
		@Autowired
		private SboardService sboardService;
		
		@Autowired
		private IndexService indexService;
		
		@RequestMapping(value="/main/index")
		public String mainIndex(ModelMap model,HttpServletRequest request, HttpServletResponse response) {
			int count = 20;
			List<Product> menBestItems = new ArrayList<Product>();
			List<Product> womenBestItems = new ArrayList<Product>();
			List<Sboard> sboardBestItems = new ArrayList<Sboard>();
			
			menBestItems = indexService.menBestItems(count);
			womenBestItems = indexService.womenBestItems(count);
			sboardBestItems = indexService.sboardBestItems(count);
			
			model.addAttribute("menBestItems", menBestItems);
			model.addAttribute("womenBestItems", womenBestItems);
			model.addAttribute("sboardBestItems", sboardBestItems);
			
			return "/main/index";
		}

	}


