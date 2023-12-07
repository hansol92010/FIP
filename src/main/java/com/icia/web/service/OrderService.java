package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.OrderDao;
import com.icia.web.model.Order;
import com.icia.web.model.OrderDetail;

@Service("orderService")
public class OrderService {
	
	private Logger logger = LoggerFactory.getLogger(OrderService.class);
	
	@Autowired
	private OrderDao orderDao;
	
	//**********************************
	//마이페이지용 내 주문내역리스트 가져오기
	public List<Order> myOrderListSelect(Order order) {
		List<Order> myOrderList = null;
		
		try {
			myOrderList = orderDao.myOrderListSelect(order);
		}catch(Exception e) {
			logger.error("[OrderService] myOrderListSelect Exception", e);
		}
		
		return myOrderList;
	}
	
	//************************************
	//마이페이지용 내 주문내역리스트 카운트
	public int myOrderListCount(String userId) {
		int count = 0;
		
		try {
			count = orderDao.myOrderListCount(userId);
		}catch(Exception e) {
			logger.error("[OrderService] myOrderListCount Exception", e);
		}
		
		return count;
	}
	
	//************************************
	//마이페이지용 내 상세주문리스트 가져오기
	public List<OrderDetail> myOrderDetailList(int orderNo) {
		List<OrderDetail> myOrderDetailList = null;
		
		try {
			myOrderDetailList = orderDao.myOrderDetailList(orderNo);
		}catch(Exception e) {
			logger.error("[OrderService] myOrderDetailList Exception", e);
		}
		return myOrderDetailList;
	}
	
	//************************************
	//마이페이지용 내 주문내역 가져오기
	public Order myOrderSelect(int orderNo) {
		Order order = null;
		
		try {
			order = orderDao.myOrderSelect(orderNo);
		}catch(Exception e) {
			logger.error("[OrderService] myOrderSelect Exception", e);
		}
		
		return order;
	}
	
	//주문내역 생성시 orderNo 생성후 가져오기
	public int tblOrderSeqSelect() {
		int orderNo = 0;
		
		try{
			orderNo = orderDao.tblOrderSeqSelect();
		}catch(Exception e) {
			logger.error("[OrderService] tblOrderSeqSelect Exception", e);
		}
		
		return orderNo;
	}
	
	//카카오페이 성공시 주문내역 insert
	public int orderCreateProc(Order order) {
		int count = 0;
		
		try {
			count = orderDao.orderInsert(order);
		}catch(Exception e){
			logger.error("[KakaoPayService] orderCreateProc Exception", e);
		}
		
		return count;
	}
	
	//주문내역 insert 성공시 상세주문내역 insert
	public int orderDetailCreateProc(OrderDetail orderDetail) {
		int count = 0;
		
		try {
			count = orderDao.orderDetailInsert(orderDetail);
		}catch(Exception e) {
			logger.error("[KakaoPayService] orderDetailCreateProc Exception", e);
		}
		
		return count;
	}
}