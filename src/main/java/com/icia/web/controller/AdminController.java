package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Admin;
import com.icia.web.model.Paging;
import com.icia.web.model.Product;
import com.icia.web.model.ProductSize;
import com.icia.web.model.Response;
import com.icia.web.model.Sboard;
import com.icia.web.model.User;
import com.icia.web.service.AdminService;
import com.icia.web.service.ProductService;
import com.icia.web.service.SboardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("adminController")
public class AdminController {
	
	private static Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Value("#{env['auth.cookie.admin.name']}")  
	private String AUTH_COOKIE_ADMIN_NAME;
	
	@Value("#{env['auth.cookie.name']}")  
	private String AUTH_COOKIE_NAME;
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.product_thum']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.product_detail']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_DETAIL;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private SboardService sboardService;
	
	private static final int LIST_COUNT = 10;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	//관리자 페이지 로그인
	@RequestMapping(value="/admin/login", method=RequestMethod.GET)
	public String adminLogin(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			model.addAttribute("adminId", cookieAdminId);
			return "/admin/userList";
		}
		else
		{
			return "/admin/login";
		}
		
	}

	//관리자 페이지 메인
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public String main(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			model.addAttribute("adminId", cookieAdminId);
			return "/admin/main";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//관리자 페이지 로그인 ajax
	@RequestMapping(value="/admin/loginProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> admingLoginProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();

		String adminId = HttpUtil.get(request, "adminId");
		String adminPwd = HttpUtil.get(request, "adminPwd");
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		
		Admin admin = null;
		
		logger.debug("======================================");
		logger.debug("adminId : " + adminId);
		logger.debug("adminPwd : " + adminPwd);
		logger.debug("======================================");

		if(!StringUtil.isEmpty(adminId) && !StringUtil.isEmpty(adminPwd))
		{
			admin = adminService.adminSelect(adminId);
			
			if(admin != null)
			{
				if(StringUtil.equals(admin.getAdminPwd(), adminPwd))
				{	
					//관리자 정보를 가져와 비밀번호가 일치하면 쿠키아이디 생성 후 로그인
					CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_ADMIN_NAME, CookieUtil.stringToHex(adminId));
					ajaxResponse.setResponse(0, "Login Success");
				}
				else
				{
					//패스워드 불일치 로그인 실패
					ajaxResponse.setResponse(-1, "Bad Password");
				}
			}
			else
			{
				//회원정보 존재하지않음 로그인 실패
				ajaxResponse.setResponse(404, "Not Found User");
			}
		}else
		{
			//회원아이디, 비밀번호가 넘어오지않아 로그인실행불가
			ajaxResponse.setResponse(400, "Bad Parameter");
		}

		return ajaxResponse;
	}
	
	//관리자 페이지 로그아웃
	@RequestMapping(value="/admin/logout", method=RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response)
	{
		if(CookieUtil.getCookie(request, AUTH_COOKIE_ADMIN_NAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_ADMIN_NAME);
		}
		
		return "redirect:/admin/login";
	}
	
	//관리자 페이지 상품 관리(상품목록)
	@RequestMapping(value="/admin/productList", method=RequestMethod.GET)
	public String productList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue",  "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		long totalCount = 0;
		Paging paging = null;
		
		List<Product> list = null;
		Product product = new Product();
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				product.setSearchType(searchType);
				product.setSearchValue(searchValue);
			}
			
			totalCount = productService.productCount(product);
			
			if(totalCount > 0)
			{
				 paging = new Paging("/admin/productlist", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
				 paging.addParam("searchType", searchType);
				 paging.addParam("searchValue", searchValue);
				 paging.addParam("curPage", curPage);
				 
				 product.setStartRow(paging.getStartRow());
				 product.setEndRow(paging.getEndRow());
				 
				 list = productService.productList(product);
				 
			}
		
			//jsp에서 쓸 이름을 list로 list 값을 넘긴다? --> model에 넘긴 값들로 list.jsp 다시 작성하기
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/productList";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//관리자 페이지 상품관리(상품등록)
	@RequestMapping(value="/admin/productReg", method=RequestMethod.GET)
	public String productReg(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}

		if(!StringUtil.isEmpty(cookieAdminId))
		{
			model.addAttribute("adminId", cookieAdminId);
			return "/admin/productReg";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//관리자 페이지 상품등록ajax
	@RequestMapping(value="/admin/productRegProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> productRegProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//int productNo = HttpUtil.get(request, "productNo", 0);
		
		String productName = HttpUtil.get(request, "productName", "");
		String brandCode = HttpUtil.get(request, "brandCode", "");
		String mainCategoryCode = HttpUtil.get(request, "mainCategoryCode", "");
		String subCategoryCode = HttpUtil.get(request, "subCategoryCode", "");
		int productPrice = HttpUtil.get(request, "productPrice", 0);
		
		int totalCount = 0;
		Product product1 = new Product();
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		
		int productSeqNo = adminService.productSeq(product1);
		
		//FileData fileData = HttpUtil.getFile(request, "productThumImg", UPLOAD_SAVE_DIR_PRODUCT_THUM, productNo, "product", "productName");
		//List<FileData> list = HttpUtil.getFiles(request, "productDetailImg", UPLOAD_SAVE_DIR_PRODUCT_DETAIL, productNo);
		
		FileData fileData = HttpUtil.getFile(request, "productThumImg", UPLOAD_SAVE_DIR_PRODUCT_THUM, productSeqNo, "product", "productName");
		List<FileData> list = HttpUtil.getFiles(request, "productDetailImg", UPLOAD_SAVE_DIR_PRODUCT_DETAIL, productSeqNo);
		
		if(productSeqNo > 0 && !StringUtil.isEmpty(productName) && !StringUtil.isEmpty(brandCode) && !StringUtil.isEmpty(mainCategoryCode) && !StringUtil.isEmpty(subCategoryCode) && productPrice > 0)
		{
			Product product = new Product();
			
			product.setProductNo(productSeqNo);
			product.setProductName(productName);
			product.setBrandCode(brandCode);
			product.setMainCategoryCode(mainCategoryCode);
			product.setSubCategoryCode(subCategoryCode);
			product.setProductPrice(productPrice);
			
			totalCount = adminService.productInsert(product);
			
			if(totalCount > 0)
			{
				logger.debug("############################################");
				logger.debug("totalCount : " + totalCount);
				logger.debug("############################################");

				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				logger.debug("############################################");
				logger.debug("totalCount : " + totalCount);
				logger.debug("############################################");
				ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
	
		return ajaxResponse;
	
	}
	
	//관리자 페이지 재고등록
	@RequestMapping(value="/admin/stockReg", method=RequestMethod.GET)
	public String stockReg(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		int productNo = HttpUtil.get(request, "productNo", 0);
		
		Product product = new Product();
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(productNo > 0)
			{
				//Product.xml 참고
				product = productService.selectProduct(productNo);
				
				logger.debug("======================================");
				logger.debug("productNo : " + product.getProductNo());
				logger.debug("======================================");
				
				model.addAttribute("product", product);
				model.addAttribute("productNo", productNo);
				model.addAttribute("adminId", cookieAdminId);
				
			}
			
			return "/admin/stockReg";
			
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//관리자페이지 재고등록 ajax
	@RequestMapping(value="/admin/stockRegProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> stockRegProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		int productNo = HttpUtil.get(request, "productNo", 0);
		String[] sizeName_ = request.getParameterValues("sizeName");
		String[] units_ = request.getParameterValues("units");
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		
		List<ProductSize> list = productService.selectProductSize(productNo);

		for(int i=0; i<sizeName_.length; i++)
		{
			String sizeName = sizeName_[i];
			int units = Integer.parseInt(units_[i]);
			
			ProductSize productSize = new ProductSize();
			
			if(productNo > 0 && !StringUtil.isEmpty(sizeName) && units >= 0)
			{
				productSize.setProductNo(productNo);
				productSize.setSizeName(sizeName);
				productSize.setUnits(units);
				
				if(list.size() <= 0)
				{
					if(adminService.sizeInStockInsert(productSize) > 0)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(500, "internal server error");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "bad request");
			}
		}
		
		return ajaxResponse;
	}
	
	//관리자페이지 상품 상세 목록(수정, 삭제까지 가능하도록 만든 jsp)
	@RequestMapping(value="/admin/productDetail", method=RequestMethod.GET)
	public String productDetail(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		int productNo = HttpUtil.get(request, "productNo", 0);
		
		Product product = null;
		List<ProductSize> list = null;
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(productNo > 0)
			{
				product = productService.selectProduct(productNo);
				list = productService.selectProductSize(productNo);
			}
			
			model.addAttribute("product", product);
			model.addAttribute("list", list);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/productDetail";
		}
		else
		{
			return "/admin/login";
		}
	}

	//상품 목록 수정 ajax
	@RequestMapping(value="/admin/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> res = new Response<Object>();
		
		int productNo = HttpUtil.get(request, "productNo", 0);
		String productName = HttpUtil.get(request, "productName", "");
		String brandCode = HttpUtil.get(request, "brandCode", "");
		int productPrice = HttpUtil.get(request, "productPrice", 0);
		String mainCategoryCode = HttpUtil.get(request, "mainCategoryCode", "");
		String subCategoryCode = HttpUtil.get(request, "subCategoryCode", "");
		
		logger.debug("=============================");
		logger.debug("" + productNo);
		logger.debug(productName);
		logger.debug(brandCode);
		logger.debug("" + productPrice);
		logger.debug(mainCategoryCode);
		logger.debug(subCategoryCode);
		logger.debug("=============================");
		
		/*
		//유저가 로그인되어 있을 시
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			res.setResponse(-998, "user exits");
		}
		*/
		
		if(productNo > 0 && productPrice > 0 && !StringUtil.isEmpty(productName) && !StringUtil.isEmpty(brandCode) && !StringUtil.isEmpty(mainCategoryCode) && !StringUtil.isEmpty(subCategoryCode))
		{
			Product product = productService.selectProduct(productNo);
			
			if(product != null)
			{
				product.setProductName(productName);
				product.setProductPrice(productPrice);
				product.setMainCategoryCode(mainCategoryCode);
				product.setSubCategoryCode(subCategoryCode);
				product.setBrandCode(brandCode);
				
				if(productService.productUpdate(product) > 0)
				{
					res.setResponse(0, "Success");
				}
				else
				{
					res.setResponse(500, "internal server error1");
				}
			}
			else
			{
				res.setResponse(404, "bad found");
			}
		}
		else
		{
			res.setResponse(400, "bad request");
		}
		
		return res;
	}
	
	//상품 목록 삭제 ajax
	@RequestMapping(value="/admin/deleteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> res = new Response<Object>();
		
		int productNo = HttpUtil.get(request, "productNo", 0);
		
		/*
		//유저가 로그인되어 있을 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			res.setResponse(-998, "user exits");
		}
		*/
		
		if(productNo > 0)
		{
			Product product = productService.selectProduct(productNo);
			
			if(product != null)
			{
				try
				{
					if(productService.productDelete(productNo) > 0)
					{
						res.setResponse(0, "Success");
					}
					else
					{
						res.setResponse(500, "internal server error1");
					}
				}
				catch(Exception e)
				{
					logger.error("[productService] /admin/deleteProc Exception", e);
					res.setResponse(500, "internal server error2");
				}
			}
			else
			{
				res.setResponse(404, "not found");
			}
		}
		else
		{
			res.setResponse(400, "bad request");
		}
			
		return res;
	}
	
	//상품 재고 수정
	@RequestMapping(value="/admin/stockUpdate", method=RequestMethod.GET)
	public String stockUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		int productNo = HttpUtil.get(request, "productNo", 0);
		
		Product product = new Product();
		
		//유저가 로그인되어 있을 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(productNo > 0 )
			{
				product = productService.selectProduct(productNo);
				
				if(product != null)
				{
					model.addAttribute("product", product);
				}
				
			}
			
			return "/admin/stockUpdate";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//상품 재고 수정 ajax
	@RequestMapping(value="/admin/stockUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> stockUpdateProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> res = new Response<Object>();
		
		int productNo = HttpUtil.get(request, "productNo", 0);
		String[] sizeName_ = request.getParameterValues("sizeName");
		String[] units_ = request.getParameterValues("units");
		
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			res.setResponse(-998, "user exits");
		}
		*/

		for(int i=0; i<sizeName_.length; i++)
		{
			String sizeName = sizeName_[i];
			int units = Integer.parseInt(units_[i]);
			
			ProductSize productSize = new ProductSize();
			
			logger.debug("=============================");
			logger.debug("sizeName : " + sizeName);
			logger.debug("units : " + units);
			logger.debug("=============================");
			
			if(productNo > 0 && !StringUtil.isEmpty(sizeName) && units >= 0)
			{
				productSize.setProductNo(productNo);
				productSize.setSizeName(sizeName);
				productSize.setUnits(units);
				
				if(productService.productStockUpdate(productSize) > 0)
				{
					res.setResponse(0, "Success");
				}
				else
				{
					res.setResponse(500, "internal server error");
				}
			}
			else
			{
				res.setResponse(400, "bad request");
			}
		}
		
		return res;
	}
	//@@@@@@@@@@@@@@@@@@@@@@@@관리자 회원관리 미지@@@@@@@@@@@@@@@@@@@@@
	
	//관리자 - 회원관리리스트
	@RequestMapping(value="/admin/userList")
	public String userList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		
		//유저 아이디가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			String userStatus = HttpUtil.get(request, "userStatus", "");
			String searchType = HttpUtil.get(request, "searchType", "");
			String searchValue = HttpUtil.get(request, "searchValue", "");
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			long totalCount = 0;
			Paging paging = null;
			List<User> list = null;
			User user = new User();
			
			user.setUserStatus(userStatus);
			
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				if(StringUtil.equals(searchType,  "1"))
				{
					user.setUserId(searchValue);
				}
				else if(StringUtil.equals(searchType, "2"))
				{
					user.setUserName(searchValue);
				}
				else
				{
					searchType = "";
					searchValue = "";
				}
			}
			else 
			{
				searchType = "";
				searchValue = "";
			}
			
			totalCount = userService.userListCount(user);
			
			logger.debug("=======================================");
			logger.debug("totalCount : " + totalCount);
			logger.debug("=======================================");
			
			if(totalCount > 0)
			{
				paging = new Paging("/admin/userList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				user.setStartRow(paging.getStartRow());
				user.setEndRow(paging.getEndRow());
				
				list = userService.userList(user);
			}
			
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("userStatus", userStatus);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("adminId", cookieAdminId);
		
			return "/admin/userList";
		}
		else
		{
			return "/admin/login";
		}
	}
	
	//관리자- 아이디버튼 눌러서 정보조회 미지
	@RequestMapping(value="/admin/userUpdate")
	public String update(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		
		
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		String userId = HttpUtil.get(request, "userId");
		
		//유저 아이디가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(!StringUtil.isEmpty(userId))
			{
				User user = userService.userSelect(userId);
				
				if(user != null)
				{
					model.addAttribute("adminId", cookieAdminId);
					model.addAttribute("user", user);   //jsp에서는 "user" 쓰고, 넘길거는 user객체 넘겨
				}
			}
			
			return "/admin/userUpdate";
		}
		else
		{
			return "/admin/login";
		}
	}
		
	//관리자- 회원정보 수정 미지
	@RequestMapping(value="/admin/userUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> UserUpdateProc(HttpServletRequest request, HttpServletResponse response)
	{	
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId"); 
		String userName = HttpUtil.get(request, "userName");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userNickname = HttpUtil.get(request, "userNickname");
		String userPhoneNo = HttpUtil.get(request, "userPhoneNo");
		String userAddress = HttpUtil.get(request, "userAddress");
		int userPostcode = HttpUtil.get(request, "userPostcode", 0);
		String userDetailAddress = HttpUtil.get(request, "userDetailAddress", "");
		String userExtraAddress = HttpUtil.get(request, "userExtraAddress", "");
		String userStatus = HttpUtil.get(request, "userStatus");
		
		/*
		//유저 아이디가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			res.setResponse(-998, "user exits");
		}
		*/
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userName) 
				&& !StringUtil.isEmpty(userNickname) && !StringUtil.isEmpty(userPhoneNo) && !StringUtil.isEmpty(userAddress) && 
				!StringUtil.isEmpty(userPostcode) &&!StringUtil.isEmpty(userDetailAddress) &&!StringUtil.isEmpty(userExtraAddress)) 
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				user.setUserNickname(userNickname);
				user.setUserPhoneNo(userPhoneNo);
				user.setUserAddress(userAddress);
				user.setUserPostcode(userPostcode);
				user.setUserDetailAddress(userDetailAddress);
				user.setUserExtraAddress(userExtraAddress);
				user.setUserStatus(userStatus);
				
				if(userService.adminUserUpdate(user) > 0)   //다 가져왔으니까 이제 업데이트쳐야지 //한건이상 업데이트 됐으면
				{
					res.setResponse(0, "success");
				}
				else
				{
					res.setResponse(-1, "fail"); //업데이트하다가 오류
				}
			}
			else
			{
				res.setResponse(404, "not found"); //아이디가없어서?
			}
		}
		else //공백이 하나라도 있으면
		{
			res.setResponse(400, "bad request");  //파라미터오류
		}
		
		//리턴전에 로그에 디버그 찍어주는거
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /admin/userUpdateProc response\n" + JsonUtil.toJsonPretty(res));
		}
		
		return res;	
	}
    //스타일 관리자 리스트 이연
	@RequestMapping(value="/admin/styleAdminList")
	public String styleAdminList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue",  "");
		long curPage = HttpUtil.get(request, "curPage", 1);
		long totalCount = 0;
		List<Sboard> list = null;
		Paging paging = null;
		Sboard search = new Sboard();
		
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			return "/admin/login";
		}
		
		logger.debug("===========================");
		logger.debug("===========================");
		logger.debug("searchType : " + searchType);
		logger.debug("searchValue : " + searchValue);
		logger.debug("===========================");
		logger.debug("===========================");
		
		
		if(!StringUtil.isEmpty(cookieAdminId))
		{
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				search.setSearchType(searchType);
				search.setSearchValue(searchValue);
			}
			
			totalCount =  sboardService.boardListCount(search);
			
			if(totalCount > 0)
			{
				paging = new Paging("/admin/styleAdminList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				
				list = sboardService.boardList(search); 
			}
			
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("adminId", cookieAdminId);
			
			return "/admin/styleAdminList";
		}
		else
		{
			return "/admin/login";
		}
	}
		
		
	//관리자 게시물 삭제 이연
	@RequestMapping(value="/admin/adminDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> adminDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
	
		int sboardNo = HttpUtil.get(request, "sboardNo", 0);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("sboardNo : " + sboardNo);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		 
		/*
		//유저가 로그인된 경우
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_ADMIN_NAME);
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			ajaxResponse.setResponse(-998, "user exits");
		}
		*/
		 
		if(sboardNo > 0)
		{
			Sboard sboard = sboardService.sboardSelect(sboardNo);
			
			if(sboard != null)
			{
				try
				{
					if(sboardService.sboardDelete(sboard.getSboardNo()) > 0)
					{
						 ajaxResponse.setResponse(0, "success");
					}
					else
					{
						 ajaxResponse.setResponse(500, "internal server error22");
					}
				}
				catch(Exception e)
				{
					logger.error("[HiBoardController] /board/delete Exception", e);
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(404, "not found22");
		}
			 
		if(logger.isDebugEnabled())
		{
			logger.debug("[SboardController] /board/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
	 
		return ajaxResponse;
	}

}