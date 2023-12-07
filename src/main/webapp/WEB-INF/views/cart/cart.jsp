<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>  
<script type="text/javascript">
$(document).ready(function() {
	
	
});

//상품사진 누르면 상품상세페이지로
function goDetail(productNo)
{
	document.productForm.productNo.value = productNo;
	document.productForm.action = "/shop/detail";
	document.productForm.submit();	
}

//선택 삭제
function deleteCart(cartNo) {
	if(confirm("선택하신 상품을 삭제하시겠습니까?") == true)
	{
		//장바구니 삭제버튼 누르면
		$.ajax({
			type:"POST",
			url:"/cart/deleteCart",
			data:{
				cartNo:cartNo
			},
			dataType:"JSON",
			beforeSend:function(xhr){
		   		xhr.setRequestHeader("AJAX", "true");
		   	},
		   	success:function(response)
		   	{
		   		if(response.code == 0)
		   		{
		   			alert("선택한 상품이 삭제되었습니다.");
		   			location.href = "/cart/cart";
		   		}
		   		else if(response.code == 404)
		   		{
		   			alert("상품을 찾을 수 없습니다.");
		   			location.href = "/cart/cart";
		   		}
		   		else if(response.code == 400)
		   		{
		   			alert("장바구니 안에 상품이 존재하지 않습니다");
		   		}
		   		else
		   		{
		   			alert("상품 삭제 중 오류가 발생하였습니다.");
		   		}	
		   	},
		   	error:function(xhr, status, error)
		   	{
		   		icia.common.error(error);
		   	}
		});
	}
	else
	{
		location.href;
	}
};

//전체 삭제
function deleteAllCart(userId) 
{
	if(confirm("전체 상품을 삭제하시겠습니까?") == true)
	{
		$.ajax({
			type:"POST",
			url:"/cart/deleteAllCart",
			data:{
				userId : userId
			},
			dataType:"JSON",
			beforeSend:function(xhr){
		   		xhr.setRequestHeader("AJAX", "true");
		   	},
		   	success:function(response)
		   	{
		   		if(response.code == 0)
		   		{
		   			alert("전체 상품이 삭제되었습니다.");
		   			location.href = "/cart/cart";
		   		}
		   		else if(response.code == -999)
		   		{
		   			alert("로그인된 회원이 아닙니다");
		   		}
		   		else if(response.code == 400)
		   		{
		   			alert("장바구니 안에 상품이 존재하지 않습니다");
		   		}
		   		else
		   		{
		   			alert("상품 삭제 중 오류가 발생하였습니다.");
		   		}	
		   	},
			error:function(xhr, status, error)
		   	{
		   		icia.common.error(error);
		   	}
		});
	}
	else
	{
		location.href;
	}
}

//전체상품 주문
function orderAllCart(userId) 
{
	if(confirm("상품을 주문하시겠습니까?"))
	{
		$.ajax({
			type:"POST",
			url:"/cart/orderProc",
			data:{
				userId : userId,
			},
			dataType:"JSON",
			beforeSend:function(xhr){
		   		xhr.setRequestHeader("AJAX", "true");
		   	},
		   	success:function(response)
		   	{
		   		if(response.code == 0)
		   		{
		   			location.href = "/payment/buyForm";
		   		}
		   		else if(response.code == -999)
		   		{
		   			alert("로그인된 회원이 아닙니다");
		   		}
		   		else
		   		{
		   			alert("장바구니 안에 주문할 상품이 존재하지 않습니다");
		   		}
		   	},
		   	error:function(xhr, status, error)
		   	{
		   		icia.common.error(error);
		   	}
		});
	}
	else
	{
		location.href;
	}
}

function shopping() {
	location.href = "/shop/goods"
}

</script>
<link rel="stylesheet" href="/resources/css/cart/cart.css">
</head>
<body>
<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>


	<!--장바구니 메인-->
	<div class="cart_container">
    
		<!--장바구니 상품-->
		<div class="cart_product">
			<h2><strong>CART</strong></h2>	
			<table class="cartList">
				<thead>
					<tr class="cart-head">
						<!-- <th>체크박스 전체 여부</th> -->
						<th scope="col" style="width: 20%">상품사진</th>
						<th scope="col" style="width: 35%">상품명</th>
						<th scope="col" style="width: 10%">사이즈</th>
						<th scope="col" style="width: 10%">가격</th>
						<th scope="col" style="width: 10%">수량</th>
						<th scope="col" style="width: 15%">선택</th>
					</tr>
				</thead>
				
				
				
				<!--상품이 추가되면 여기부터 반복 시작-->
				<tbody>
					<c:if test="${!empty cartList}">
					<c:forEach var="cartList" items="${cartList}" varStatus="status">
					<tr class="cart-item">
						<!-- <td><input type="checkbox" class="individual_cart_checkbox" checked /></td> -->

						<!--상품이미지-->
						<td><img class="cart_item_img" src="/resources/upload/productImage/thum/${cartList.productNo}_thum.jpg" onclick="goDetail('${cartList.productNo}')"></td>
						<!--상품이름-->
						<td>${cartList.productName}</td>
						<!-- 상품사이즈 -->
						<td>${cartList.sizeName}</td>
						<!--상품가격-->
						<td id="product_price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cartList.productPrice}" />원</td>
						<!--수량조절버튼-->
						<td id="product_price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cartList.orderCount}"/></td>
						<!--삭제버튼-->
						<td class="del">
							<button type="button" class="btn_delete" id="btn_delete" onclick="deleteCart('${cartList.cartNo}')">선택 삭제</button>
						</td>
					</tr>
					<c:set var="sum" value="${sum + (cartList.productPrice * cartList.orderCount)}" />
					</c:forEach>
					</c:if>
	
					<!-- 상품 추가되면 반복 끝 -->
<!-- 					<tr>
						<td colspan="6"></td>
					</tr>	 -->
				</tbody>
				<tfoot>
					<tr class="cart-item">
						<td colspan="5"></td>
						<td><p><button type="button" class="btn_allDelete" id="btn_allDelete" onclick="deleteAllCart('${userId}')">전체 삭제</button></p></td>
					</tr>
				</tfoot>
			</table>
		</div>
    
		<!--주문금액이랑 주문버튼-->
		<div class="order">
			<p id="total_price">총 주문금액<br>: <fmt:formatNumber type="number" maxFractionDigits="3" value="${sum}" />원</p>
			<!-- <p>배송비 : 3000원</p>
			<p>총 주문합계 : 200,000원</p>  -->
			<p><button type="button" class="btn_shopping" id="btn_shopping" onclick="shopping()">계속 쇼핑하기</button></p>
			<p><button type="button" class="btn_allOrder" id="btn_allOrder" onclick="orderAllCart('${userId}')">상품 주문하기</button></p>
		</div>
	</div>
	
<!-- 상세 상품 불러오기 -->
	<form name="productForm" id="productForm" method="post">
		<input type="hidden" name="productNo" value="${productNo}" /> 
	</form>  	

<%@ include file="/WEB-INF/views/include/footer.jsp" %> 
</body>
</html>
