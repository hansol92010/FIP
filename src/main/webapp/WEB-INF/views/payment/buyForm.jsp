<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<link rel="stylesheet" href="/resources/css/payment/buyForm.css">
	<script>
		var itemsNameList = new Array();
		var itemsNoList = new Array();
		var itemsPriceList = new Array();
		var itemsQuantityList = new Array();
		var itemsSizeNameList = new Array();
		
		function fn_itemsNameList(itemsName) {
			itemsNameList.push(itemsName);
		}
		function fn_itemsNoList(itemsNo) {
			itemsNoList.push(itemsNo);
		}
		function fn_itemsPriceList(itemsPrice) {
			itemsPriceList.push(itemsPrice);
		}
		function fn_itemsQuantityList(itemsQuantity) {
			itemsQuantityList.push(itemsQuantity);
		}
		function fn_itemsSizeNameList(itemsSize){
			itemsSizeNameList.push(itemsSize);
		}
		
		function fn_orderCreate(){			//카카오페이 결제 성공시 주문내역, 상세주문내역 INSERT 함수
			
			$.ajax({
				type:"POST",
				url:"/kakao/orderCreateProc",
				data:{
					totalAmount:$("#totalAmount").val(),
					shoppingAddress1:$("#address1").val(),
					shoppingAddress2:$("#address2").val()
				},
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code == 0) {
						// 주문내역 생성 성공시 상세주문내역 INSERT AJAX
						$("#orderNo").val(response.data);
						
						$.ajax({
							type:"POST",
							url:"/kakao/orderDetailCreateProc",
							dataType:"JSON",
							data:{
								orderNo:$("#orderNo").val(),
								itemsNameList:$("#itemsNameList").val(),
								itemsNoList:$("#itemsNoList").val(),
								itemsPriceList:$("#itemsPriceList").val(),
								itemsQuantityList:$("#itemsQuantityList").val(),
								itemsSizeNameList:$("#itemsSizeNameList").val()
							},
							beforeSend:function(xhr){
						   		xhr.setRequestHeader("AJAX", "true");
						   	},
						   	success:function(response) {
						   		//상세주문내역 생성 성공시 판매량 UP 재고량 DOWN 장바구니 CLEAR. AJAX
						   		if(response.code == 0) {
						   			$.ajax({
						   				type:"POST",
						   				url:"/cart/productManagement",
						   				data:{
						   					itemsNoList:$("#itemsNoList").val(),
						   					itemsQuantityList:$("#itemsQuantityList").val(),
						   					itemsSizeNameList:$("#itemsSizeNameList").val()
						   				},beforeSend:function(xhr){
									   		xhr.setRequestHeader("AJAX", "true");
									   	},
									   	success:function(response) {
									   		if(response.code == 0) {
									   			alert("주문이 완료되었습니다.");
									   			location.href = "myPage/myOrderForm";
									   		}
									   	},
									   	error:function(xhr, status, error) {
									   		icia.common.error(error);
									   	}
						   			});
						   		}else if(response.code == 400) {
						   			alert("파라미터값 오류");
						   		}else {
						   			alert("알수없는 오류");
						   		}
						   	},
						   	error:function(xhr, status, error) {
						   		icia.common.error(error);
						   	}//상세주문내역 생성 성공시 판매량 UP 재고량 DOWN 장바구니 CLEAR. AJAX 끝
						});//상세주문내역 생성 AJAX 끝
						
					}else if(response.code == -1) {
						alert("주문생성 실패");
					}else if(response.code == 405) {
						alert("주문번호 가져오기 실패");
					}else if(response.code == 400) {
						alert("파라미터값 오류");
					}else {
						alert("알수없는 오류")
					}
				},
				error:function(xhr, status, error) {
					icia.common.error(error);
				}
			});	
		}// 카카오페이 결제 성공시 주문내역, 상세주문내역 INSERT 끝	
			
		function movePage() {	//카카오페이 결제성공시 내 주문내역으로 이동 함수
			location.href = "/myPage/myOrderForm";
		}
		
		//다음 우편API
		function execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var addr = ''; // 주소 변수
		            var extraAddr = ''; // 참고항목 변수
		
		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }
		
		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }       
		            }
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById("address1").value = data.zonecode;
		            document.getElementById("address2").value = addr;
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById("address2").focus();
		        }
		    }).open();
		}
		

		$(document).ready(function(){
			$("#itemsNameList").val(itemsNameList);
			$("#itemsNoList").val(itemsNoList);
			$("#itemsPriceList").val(itemsPriceList);
			$("#itemsQuantityList").val(itemsQuantityList);
			$("#itemsSizeNameList").val(itemsSizeNameList);
			
			
			$("#kakaoPayment").on("click", function(){
				
				if($.trim($("#address1").val()).length <= 0) {
					alert("주소를 입력해주세요");
					return;
				}
				
				if($.trim($("#address2").val()).length <= 0) {
					alert("상세주소를 입력해주세요");
					return;
				}
				icia.ajax.post({
			        url: "/kakao/payReady",
			        data: {itemName:$("#itemName").val(), quantity:$("#quantity").val(), totalAmount:$("#totalAmount").val(),itemCode:$("#itemCode").val()},
			        success: function (response) 
			        {
			        	icia.common.log(response);
			        	
			        	if(response.code == 0)
			        	{
			        		var orderId = response.data.orderId;
			        		var tId = response.data.tId;
			        		var pcUrl = response.data.pcUrl;
			        		
			        		$("#orderId").val(orderId);
			        		$("#tId").val(tId);
			        		$("#pcUrl").val(pcUrl);
			        		
			        							//경로, (윈도우오픈)이름	
			        		var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
			                
			        		$("#kakaoForm").submit();
			        		
			        	}
			        	else
			        	{
			        		alert("오류가 발생하였습니다.");
			        		location.href="/main/index";
			        	}
			        },
			        error: function (error) 
			        {
			        	icia.common.error(error);
			        	
			        }
			    });//ajax 끝
			});//$("#payment").onclik 끝
		});//document.ready 끝
	</script>
	</head>
	<body>
	<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
		<div class="payment-page">
			<h1>주문 / 결제</h1>
			<p></p>
		</div>
	     
		<div class="container-buyForm">
	
	<!-- 오른쪽 박스 1  주문한 상품에 대한 박스입니다.-->
		<div class="right-box">
			<div class="item">
				<div class="item">
					<div class="order-product">
						<h2>주문상품</h2>
						<c:if test="${!empty list}">
						
						<!-- list forEach 시작 -->
						
						<c:forEach var="orderProduct" items="${list}" varStatus="status">
						<hr>
						<div class="product-info">
							<img src="/resources/upload/productImage/thum/${orderProduct.productNo}_thum.jpg" alt="">
							<div class="product-details">
							<p class="product-name">상품명 ${orderProduct.productName}</p>
							<p class="product-size">사이즈 ${orderProduct.sizeName}</p>
							<p class="priduct-quantity">수량 ${orderProduct.orderCount}</p>
							<p class="product-price">가격 ${orderProduct.productPrice}</p>
							<!-- 리스트에 값 담기 -->
								<script>
									fn_itemsNoList(${orderProduct.productNo});
									fn_itemsPriceList(${orderProduct.productPrice});
									fn_itemsQuantityList(${orderProduct.orderCount});
									fn_itemsNameList("${orderProduct.productName}");
									fn_itemsSizeNameList("${orderProduct.sizeName}");
								</script>
							<!-- 리스트에 값 담기 끝 -->		
							<c:choose>
								<c:when test="${status.last}">
									<c:set var ="productNameSum" value="${productNameSum}${orderProduct.productName}" />
								</c:when>							
								<c:otherwise>
									<c:set var ="productNameSum" value="${productNameSum}${orderProduct.productName} , " />
								</c:otherwise>
							</c:choose>
							<!-- 총 가격 계산 -->
						<c:set var="ProductPriceSum" value="${ProductPriceSum + ((orderProduct.orderCount) * (orderProduct.productPrice))}" />	
							<!-- ----------- -->
							
							<!-- 총 수량 계산 -->
						<c:set var="ProductCountSum" value="${ProductCountSum + orderProduct.orderCount}" />	
							<!-- --------------- -->
							</div>
						</div>
						<hr>
						</c:forEach>
						
						<!-- list forEach 끝 -->
						</c:if>
					</div>
				</div>
			</div>
	
	<!-- 사용자 정보를 입력 받는 박스입니다.-->
	<c:if test="${!empty user}" >	
			<div class="item" style="margin-top: 20px;">
				<div class="customer-info">
				<h2>주문자 정보</h2>
				<!-- <label for="name">이름</label> -->
				<input type="text" id="name" name="name" value="${user.userName}" required readonly >
				</div>
			</div>
	</c:if>
	<!-- ----------------------------------- -->
	
	
	<!-- 배송정보 입력 div -->
			<div class="item" style="margin-top: 20px;">
				<div class="shipping-info">
					<h2 class="shipping-info__title">배송 정보</h2>
	
					<form class="shipping-info__form"> 
					<input class="input_btn" type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
						<label for="address1" class="shipping-info__label">우편번호</label>
						<input type="text" id="address1" name="address1" class="shipping-info__input" placeholder="우편번호" value="${user.userPostcode}">
						
						<label for="address2" class="shipping-info__label">기본주소</label>
						<input type="text" id="address2" name="address2" class="shipping-info__input" required value="${user.userAddress} ${user.userDetailAddress}">
						
						<!-- 	
						<label for="address2" class="shipping-info__label">상세주소</label>
						<input type="text" id="address2" name="address2" class="shipping-info__input" required value="${user.userDetailAddress}">
						 -->
					</form>
				</div>
			</div>
	<!-- -------------------------------------- -->
	
		</div>	<!-- 장바구니 정보 div 끝 -->
		
			<div class="left-box">
				<div class="item">
					<div class="price-copon-Container">
						<h2 class="title">최종 결제금액</h2>
						<div class="price-container">
							<div class="price-item">
								<span class="label">상품 총 가격</span>
								<span class="value" id="ViewtotalAmount" style="font-size : 20px;">${ProductPriceSum} 원</span>
							</div>
			<hr><!-- ---------------------------------------------------------------------------- -->
			
							<div class="price-item">
								<span class="label">상품이름</span>
								<span class="value" id="ViewitemName">${productNameSum}</span>
							</div>
			<hr><!-- ---------------------------------------------------------------------------- -->
			
							<div class="price-item">
								<span class="label">상품 총 수량</span>
								<span class="value" id="Viewquantity">${ProductCountSum}</span>
							</div>
						</div>
					</div> 
				</div>
			<!-- ----------------------------------------------------------------------------------- -->
				<div class="item" style="margin-top: 20px;">
					<div class="payment-container">
						<h2 class="title">결제</h2>
						<div class="payment-method">
							<span class="label">결제 수단:</span>
							<label class="checkbox-container">
							<input type="checkbox" checked>
							<span class="value">카카오페이</span>
					<!-------------- 카카오 페이 보낼 form ------------------>		
						<form name="payForm" id="payForm" method="post">
							<input type="hidden" name="itemCode" id="itemCode">
							<input type="hidden" name="itemName" id="itemName" value="${productNameSum}">
							<input type="hidden" name="quantity" id="quantity" value="${ProductCountSum}">
							<input type="hidden" name="totalAmount" id="totalAmount" value="${ProductPriceSum}">
							<button type="button" name="kakaoPayment" id="kakaoPayment">결제</button>
						</form>
					<!-- --------------------------------- -->	
							</label>
						</div>
						<div class="payment-form">
						
				  <!-- 카카오페이 결제 폼이 들어갈 자리 -->
				  <form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
				  	<input type="hidden" name="orderId" id="orderId" value="">
				  	<input type="hidden" name="tId" id="tId" value="">
				  	<input type="hidden" name="pcUrl" id="pcUrl" value="">
				  </form>
				  <!-- --------------------------------------------- -->
			          	</div>
					</div>
				</div>
				
				<!-- 주문내역에 들어갈 form -->
				<form name="orderCreateForm" id="orderCreateForm" method="post">
					<input type="hidden" name="orderNo" id="orderNo" value="">
					<input type="hidden" name="itemsNameList" id="itemsNameList" value="">
					<input type="hidden" name="itemsNoList" id="itemsNoList" value="">
					<input type="hidden" name="itemsPriceList" id="itemsPriceList" value="">
					<input type="hidden" name="itemsQuantityList" id="itemsQuantityList" value="">
					<input type="hidden" name="itemsSizeNameList" id="itemsSizeNameList" value="">
				</form>
				<!-- ------------------------- -->
			</div>
	</div>
	<!-- 다음 주소  -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>		
	</body>
</html>