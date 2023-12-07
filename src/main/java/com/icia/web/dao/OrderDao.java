package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Order;
import com.icia.web.model.OrderDetail;

@Repository("orderDao")
public interface OrderDao {
	
	//주문번호 생성후 가져오기
	public int tblOrderSeqSelect();
	
	//주문생성
	public int orderInsert(Order order);
	
	//주문 업데이트
	public int orderUpdate(Order order);
	
	//주문 삭제
	public int orderDelete(int orderNo);
	
	//마이페이지 주문정보리스트 가져오기
	public List<Order> myOrderListSelect(Order order);

	//마이페이지 주문정보 가져오기 (단일 건)
	public Order myOrderSelect(int orderNo);
	
	//마이페이지 주문정보리스트 갯수 가져오기
	public int myOrderListCount(String userId);
	
	//상세주문생성
	public int orderDetailInsert(OrderDetail order);
	
	//상세주문 업데이트
	public int orderDetailUpdate(Order order);
	
	//상세주문 삭제
	public int orderDetailDelete(int orderDetailNo);
	
	//마이페이지 상세주문리스트 가져오기
	public List<OrderDetail> myOrderDetailList(int orderNo);
	
}
