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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.icia.common.util.StringUtil;
import com.icia.web.model.KakaoPayApprove;
import com.icia.web.model.KakaoPayOrder;
import com.icia.web.model.KakaoPayReady;
import com.icia.web.model.Order;
import com.icia.web.model.OrderDetail;
import com.icia.web.model.Response;
import com.icia.web.service.KakaoPayService;
import com.icia.web.service.OrderService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController {
	private Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@Autowired
	private OrderService orderService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//썸네일 저장 경로
	@Value("#{env['upload.save.product_thum']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_THUM;

	//상세 이미지 저장 경로
	@Value("#{env['upload.save.product_detail']}")
	private String UPLOAD_SAVE_DIR_PRODUCT_DETAIL;
	
	
	@RequestMapping("/kakao/payReady")
	@ResponseBody
	public Response<Object> payReady(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String orderId = StringUtil.uniqueValue();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String itemCode = HttpUtil.get(request, "itemCode", "");
		String itemName = HttpUtil.get(request, "itemName");
		int quantity = HttpUtil.get(request, "quantity", 0);
		int totalAmount = HttpUtil.get(request, "totalAmount", 0);
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", 0);
		int vatAmount = HttpUtil.get(request, "vatAmount", 0);
		
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setItemCode(itemCode);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
		
		if(kakaoPayReady != null)
		{
			logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
			
			kakaoPayOrder.settId(kakaoPayReady.getTid());
			
			JsonObject json = new JsonObject();
			
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayReady.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
			
			res.setResponse(0, "success", json);
		}
		else
		{
			res.setResponse(-1, "fail", null);
		}
		
		return res;
	}
	
	@RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		String pcUrl = HttpUtil.get(request, "pcUrl", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		model.addAttribute("pcUrl", pcUrl);
		model.addAttribute("orderId", orderId);
		model.addAttribute("tId", tId);
		model.addAttribute("userId", userId);
		
		return "/kakao/payPopUp";
	}
	
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		KakaoPayApprove kakaoPayApprove = null;
		
		String pgToken = HttpUtil.get(request, "pg_token", "");
		
		model.addAttribute("pgToken", pgToken);
		
		
		
		return "/kakao/paySuccess";
	}
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String pgToken = HttpUtil.get(request, "pgToken", "");
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.settId(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
		
		model.addAttribute("kakaoPayApprove", kakaoPayApprove);
		
		
		return "/kakao/payResult";
	}
	
	
	//*************************************
	//결제성공시 주문내역 생성
	@RequestMapping(value="/kakao/orderCreateProc")
	@ResponseBody
	public Response<Object> orderCreateProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int totalAmount = HttpUtil.get(request, "totalAmount", 0);
		String shoppingAddress1 = HttpUtil.get(request, "shoppingAddress1");
		String shoppingAddress2 = HttpUtil.get(request, "shoppingAddress2");
		
		int orderNo = 0;
		
		
		if(totalAmount > 0 && !StringUtil.isEmpty(userId)) {
			orderNo = orderService.tblOrderSeqSelect();
			Order order = new Order();
			
			if(orderNo > 0) {
				order.setOrderNo(orderNo);
				order.setUserId(userId);
				order.setTotalOrderPrice(totalAmount);
				order.setShoppingAddress(shoppingAddress1 + " " + shoppingAddress2);
				
				if(orderService.orderCreateProc(order) > 0) {
					res.setResponse(0, "OrderInsert Success", orderNo);
				}else {
					res.setResponse(-1, "Order Insert Fail");
				}
			}else {
				res.setResponse(405, "OrderNo Not Found");
			}
		}else {
			res.setResponse(400, "Bad Request");
		}
		
		return res;
	}
	
	//**************************************
	//결제 성공 -> 주문내역 생성 -> 상세주문 생성
	@RequestMapping(value="/kakao/orderDetailCreateProc")
	@ResponseBody
	public Response<Object> orderDetailCreateProc(@RequestParam(value="itemsNameList") List<String> itemsNameList,@RequestParam(value="itemsNoList") List<Integer> itemsNoList ,
									@RequestParam(value="itemsPriceList") List<Integer> itemsPriceList, @RequestParam(value="itemsQuantityList") List<Integer> itemsQuantityList,
									@RequestParam(value="itemsSizeNameList") List<String> itemsSizeNameList, HttpServletRequest request, HttpServletResponse response) {
		
		Response<Object> res = new Response<Object>();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int orderNo = HttpUtil.get(request, "orderNo", 0);
		
		//장바구니 , 단건결제시 리스트로 받아와 반복문으로 product객체에 담아 insert해준다
		if(!StringUtil.isEmpty(userId) && orderNo > 0) {
			for(int i=0; i < itemsNameList.size(); i++) {
				OrderDetail orderDetail = new OrderDetail();
				
				orderDetail.setOrderNo(orderNo);
				orderDetail.setProductName(itemsNameList.get(i));
				orderDetail.setProductNo(itemsNoList.get(i));
				orderDetail.setProductPrice(itemsPriceList.get(i));
				orderDetail.setOrderCount(itemsQuantityList.get(i));
				orderDetail.setSizeName(itemsSizeNameList.get(i));
				
				orderService.orderDetailCreateProc(orderDetail);
			}
			
			res.setResponse(0, "OrderDetailInsert Success");
		}else {
			res.setResponse(400, "Bad Request");
		}
		
		
		return res;
	}
	
}
