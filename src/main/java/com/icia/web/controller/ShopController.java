package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Cart;
import com.icia.web.model.Paging;
import com.icia.web.model.Product;
import com.icia.web.model.ProductSize;
import com.icia.web.model.ProductZzim;
import com.icia.web.model.Response;
import com.icia.web.service.CartService;
import com.icia.web.service.ProductService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("shopController")
public class ShopController {

	private static Logger logger = LoggerFactory.getLogger(ShopController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.product_thum']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.product_detail']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_DETAIL;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CartService cartService;
	
	private static final int LIST_COUNT = 20;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	//상품 메인 페이지
	@RequestMapping(value="/shop/goods")
	public String shopView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String mainCategoryCode = HttpUtil.get(request, "mainCategoryCode", ""); 
		String subCategoryCode = HttpUtil.get(request, "subCategoryCode", "");
		String brandCode = HttpUtil.get(request, "brandCode", "");
		String optionSelect = HttpUtil.get(request, "optionSelect", "1");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		long totalCount = 0;
		Paging paging = null;
		List<Product> list = null;
		Product product = new Product();
		
		if(!StringUtil.isEmpty(optionSelect))
		{
			product.setOptionSelect(optionSelect);
		}
		
		if(StringUtil.isEmpty(brandCode) && StringUtil.isEmpty(mainCategoryCode) && StringUtil.isEmpty(subCategoryCode))
		{
			//어떠한 값도 들어오지 않은 상태(shop의 첫 메인 화면)
			
			product.setBrandCode(brandCode);
			product.setMainCategoryCode(mainCategoryCode);
			product.setSubCategoryCode(subCategoryCode);
			product.setOptionSelect(optionSelect);
			
			System.out.println("");
			
			totalCount = productService.allProductCount(product);
			
			if(totalCount > 0)
			{
				paging = new Paging("/shop/productsSearch",totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				paging.addParam("curPage", curPage);
				paging.addParam("mainCategoryCode", mainCategoryCode);
				paging.addParam("subCategoryCode", subCategoryCode);
				paging.addParam("brandCode", brandCode);
				paging.addParam("optionSelect", optionSelect);
				
				product.setStartRow(paging.getStartRow());
				product.setEndRow(paging.getEndRow());
				
				list = productService.allProductList(product);
			}
		}
		else
		{	
			//brandCode나 maincategory와 subcategory 중 하나라도 값이 들어온 경우
			
			product.setBrandCode(brandCode);
			product.setMainCategoryCode(mainCategoryCode);
			product.setSubCategoryCode(subCategoryCode);
			product.setOptionSelect(optionSelect);
			
			if(!StringUtil.isEmpty(mainCategoryCode) && !StringUtil.isEmpty(subCategoryCode))
			{
				//main과 sub 카테고리가 들어온 경우
				
				totalCount = productService.categoryCount(product);
				
				if(totalCount > 0)
				{
					paging = new Paging("/shop/goodsSearch",totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
					
					paging.addParam("curPage", curPage);
					paging.addParam("mainCategoryCode", mainCategoryCode);
					paging.addParam("subCategoryCode", subCategoryCode);
					paging.addParam("brandCode", brandCode);
					paging.addParam("optionSelect", optionSelect);
					
					product.setStartRow(paging.getStartRow());
					product.setEndRow(paging.getEndRow());
					
					list = productService.categorySelect(product);
				}
			}
			else	
			{
				//brandCode가 들어온 경우
				
				totalCount = productService.eachBrandCount(brandCode);
				
				if(totalCount > 0)
				{
					paging = new Paging("/shop/goodsSearch",totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
					
					paging.addParam("curPage", curPage);
					paging.addParam("mainCategoryCode", mainCategoryCode);
					paging.addParam("subCategoryCode", subCategoryCode);
					paging.addParam("brandCode", brandCode);
					paging.addParam("optionSelect", optionSelect);
					
					product.setStartRow(paging.getStartRow());
					product.setEndRow(paging.getEndRow());
					
					list = productService.eachBrandSelect(product);
				}
			}	
		}
		
		//model에 값 담기
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("curPage", curPage);
		model.addAttribute("mainCategoryCode", mainCategoryCode);
		model.addAttribute("subCategoryCode", subCategoryCode);
		model.addAttribute("brandCode", brandCode);
		model.addAttribute("optionSelect", optionSelect);
		
		return "/shop/goods";
	}
	
	//상품 상세페이지
	@RequestMapping(value="/shop/detail")
	public String detailView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		int productNo = HttpUtil.get(request, "productNo", (int)0);
		
		Product product = null;
		List<Product> list = null;
		
		//찜
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME); 
		ProductZzim productZzim = new ProductZzim();
		List<ProductZzim> list2 = null;
		
		if(productNo > 0)
		{
			product = productService.detailProduct(productNo);
			
			//찜
			productZzim.setUserId(cookieUserId);
			productZzim.setProductNo(productNo);
			list2 = productService.zzimSelect(productZzim);
			
			if(product != null)
			{
				list = productService.brandRandom(product.getBrandCode());
			}
			
		}
		
		model.addAttribute("product", product);
		model.addAttribute("list", list);
		//찜
		model.addAttribute("list2", list2);
		
		return "/shop/detail";
	}
		
	//상품 상세페이지에서 장바구니 추가
	@RequestMapping(value="/shop/addCart",  method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> addCart(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int productNo = HttpUtil.get(request, "productNo", (int)0);
		String sizeName = HttpUtil.get(request,  "sizeName", "");
		int orderCount = HttpUtil.get(request, "orderCount", (int)0);
		int cartNo = HttpUtil.get(request, "cartNo", 0);
		
		Product product = new Product();
		ProductSize productSize = new ProductSize();
		Cart cart = new Cart();
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			if(!StringUtil.isEmpty(sizeName) && orderCount > 0)
			{
				if(productNo > 0)
				{
					productSize.setSizeName(sizeName);
					productSize.setProductNo(productNo);
					
					//재고 부족은 체크해봐야 함!!!!
					if(productService.unitsCheck(productSize) > orderCount)
					{
						product = productService.selectProduct(productNo);
						
						if(product != null)
						{
							cart.setUserId(cookieUserId);
							cart.setProductNo(productNo);
							cart.setSizeName(sizeName);
							cart.setOrderCount(orderCount); 
							cart.setProductName(product.getProductName());
							cart.setProductPrice(product.getProductPrice());
							
							if(cartService.cartCheck(cart) > 0) //상품번호,사이즈 동일 상품 있으면
							{
								cartService.cartUpdate(cart);//수량 없데이트하고 리턴해버려
								ajaxResponse.setResponse(100, "Success");
								
								//return ajaxResponse;
							}
							else
							{
								if(cartService.addCart(cart) > 0)//동일상품 없으면 장바구니에 추가
								{
									
									ajaxResponse.setResponse(0, "Success");
								}
								else 
								{
									ajaxResponse.setResponse(500, "internal server error1");
								}			
							}
						}
						else
						{
							ajaxResponse.setResponse(400, "not Found");
						}
					}
					else
					{
						ajaxResponse.setResponse(-998, "out of stock");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
		}
		else
		{
			ajaxResponse.setResponse(-997, "Not Login");
		}
		
		return ajaxResponse;
	}
	
	
	//상세 페이지에서 바로 구매
	@RequestMapping(value="/shop/goBuy", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> goBuy(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int productNo = HttpUtil.get(request, "productNo", (int)0);
		String sizeName = HttpUtil.get(request, "sizeName", "");
		int orderCount = HttpUtil.get(request, "orderCount", (int)0);
		
		Product product = new Product();
		ProductSize productSize = new ProductSize();
			
		logger.debug("==================================");
		logger.debug("cookieUserId : " + cookieUserId);
		logger.debug("==================================");
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			if(!StringUtil.isEmpty(sizeName) && orderCount > 0)
			{
				if(productNo > 0)
				{
					productSize.setSizeName(sizeName);
					productSize.setProductNo(productNo);
					
					//재고 부족은 체크해봐야 함!!!!
					if(productService.unitsCheck(productSize) > orderCount)
					{
						product = productService.selectProduct(productNo);
					
						if(product != null)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(-999, "Internal Server Error");
						}
					}
					else
					{
						ajaxResponse.setResponse(-998, "out of stock");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
		}
		else
		{
			ajaxResponse.setResponse(-997, "Not Login");
		}
		
		return ajaxResponse;
	}	
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@찜@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//찜 누르면 추가  찜 다시 누르면 찜취소
	@RequestMapping(value="/shop/zzimProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> zzimProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int productNo = HttpUtil.get(request, "productNo", 0);
		
		int totalCount = 0;
		ProductZzim productZzim = new ProductZzim();
			
		if(!StringUtil.isEmpty(cookieUserId))
		{
			productZzim.setProductNo(productNo);
			productZzim.setUserId(cookieUserId);

			totalCount = productService.zzimCheck(productZzim);
			
			if(totalCount > 0) //찜 누른적 있으면
			{
				int zzimDelete = productService.zzimDelete(productZzim);
				
				if(zzimDelete > 0)
				{
					ajaxResponse.setResponse(0, "seccess");
				}
				else 
				{
					ajaxResponse.setResponse(400, "Not Found"); //찜 삭제 안됨
				}
			}
			else //찜 누른적 없으면
			{
				int zzimInsert = productService.zzimInsert(productZzim);
				
				if(zzimInsert > 0)
				{
					ajaxResponse.setResponse(0, "seccess");
				}
				else 
				{
					ajaxResponse.setResponse(400, "Not Found"); //찜 추가 안됨
				}
			}
		}
		else
		{
			ajaxResponse.setResponse(-998, "Not login");
		}
		
		return ajaxResponse;
	}
	
	
}
