<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			<c:choose>
				<c:when test="${empty product}">
					alert("해당하는 상품이 존재 하지 않습니다.");
					location.href = "/shop/goods";
				</c:when>
				<c:otherwise>
					var $detailImg = $(".detail_img");
					var i = 0;
					var img_list = ["${product.productNo}_1.jpg","${product.productNo}_2.jpg","${product.productNo}_3.jpg"];
			
					setInterval(function() {
						i++;
						//i가 커지는 순간 다시 0으로 세팅
						if (i >= img_list.length) {
							i = 0;
						}
						//이미지 이름을 배열에서 얻기
						var imgName = img_list[i];
						//속성 설정하는 부분(이미지 출력)
						$detailImg.attr("src","/resources/upload/productImage/detail/" + imgName);
					}, 3000); 
				</c:otherwise>
			</c:choose>
		});
		
		function fn_detail(productNo) {
			document.goodsForm.productNo.value = productNo;
			document.goodsForm.action = "/shop/detail";
			document.goodsForm.submit();
		}
		
		function category(main, sub, brand) {
			document.goodsForm.mainCategoryCode.value = main;
			document.goodsForm.subCategoryCode.value = sub;
			document.goodsForm.brandCode.value = brand;
			document.goodsForm.action = "/shop/goods";
			document.goodsForm.submit();
		}
		
		//수량 감소 함수
		function decreaseQuantity() {
			var quantityInput = document.getElementById("orderCount");
			var quantity = quantityInput.value;
			if (quantity > 1) {
				quantity--;
				quantityInput.value = quantity;
			}
		}
		
		// 수량 증가 함수
		function increaseQuantity() {
			var quantityInput = document.getElementById("orderCount");
			var quantity = quantityInput.value;
			quantity++;
			quantityInput.value = quantity;
		}
		
		// 구매 버튼
		function goToBuy(productNo) {
			if(confirm("선택하신 상품을 주문하시겠습니까?") == true) {
				$.ajax({
					type:"POST",
					url:"/shop/goBuy",
					data:{
						productNo:productNo,
						sizeName:$("#size_select").val(),
						orderCount:$("#orderCount").val()   
					},
					dataType:"JSON",
					beforeSend:function(xhr){
					    xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response) {
						if(response.code == 0) {
							document.buyForm.productNo.value=productNo;
							document.buyForm.orderCount.value= $("#orderCount").val();
							document.buyForm.sizeName.value = $("#size_select").val();
							document.buyForm.action = "/cart/cart";
							document.buyForm.submit();
						} else if(response.code == -997) {
							alert("로그인이 필요합니다");
							document.buyForm.productNo.value= productNo;
							document.buyForm.action = "/user/loginForm";
							document.buyForm.submit();
						} else if(response.code == 400) {
							alert("상품의 사이즈와 수량을 입력하세요");
						} else if(response.code == 404) {
							alert("상품이 존재하지 않습니다");
							location.href = "/shop/goods";
						} else if(response.code == -998) {
							alert("선택하신 상품의 사이즈는 현재 재고가 남아 있지 않습니다");
						} else {
							alert("구매 전 오류가 발생하였습니다");
						}
					},
					error:function(xhr, status, error) {
						icia.common.error(error);
						alert("구매 전 오류가 발생하였습니다");
					}
				});
			} else {
				location.href;
			}
		}
		
		//장바구니 추가
		function addCart(productNo) {
			$.ajax({
				type:"POST",
				url:"/shop/addCart",
				data:{
					productNo:productNo,
					sizeName:$("#size_select").val(),
					orderCount:$("#orderCount").val()
				},
				dataType:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response) {
					if(response.code == 0) {
						if(confirm("선택하신 상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?") == true) {
							location.href = "/cart/cart";
						} else {
							location.href = "/shop/goods";
						}
					} else if(response.code == 100) { //장바구니에 같은 상품이 존재할때
						//if(confirm("이미 장바구니에 상품이 담겨있습니다. 같은 제품을 장바구니에 추가하시겠습니까?") == true)
						alert("장바구니에 같은 상품이 존재하여 수량이 추가되었습니다.");
						location.href = "/cart/cart";
					} else if(response.code == -997) {
						alert("로그인이 필요합니다");
						document.cartForm.action = "/user/loginForm";
						document.cartForm.submit();
					} else if(response.code == 400) {
						alert("상품의 사이즈와 수량을 입력하세요");
					} else if(response.code == -998) {
						alert("선택하신 상품의 사이즈는 현재 재고가 남아 있지 않습니다 ");
					} else if(response.code == 404) {
						alert("상품이 존재하지 않습니다");
						location.href = "/shop/goods";
					} else {
						alert("장바구니 담기 중 오류가 발생하였습니다");
					}
				},
				error:function(xhr, status, error) {
					icia.common.error(error);
					alert("찜하기에 오류가 발생하였습니다");
				}
		   });
		}
		
		//찜 안눌렀을 때 찜버튼 누르면
		function doZzim(productNo)
		{
			$.ajax({
				type:"POST",
				url:"/shop/zzimProc",
				data:{
					productNo:productNo 
				},
				dataType:"JSON",
				beforeSend:function(xhr){
				    xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response) {
					if(response.code == 0) {
						alert("찜 목록에 추가되었습니다.");
						document.zzimForm.productNo.value = productNo;
						document.zzimForm.action = "/shop/detail";
						document.zzimForm.submit();	
					} else if(response.code == -998) {
						alert("로그인이 필요합니다");
					} else {
						alert("찜하기에 오류가 발생하였습니다");
					}
				},
				error:function(xhr, status, error) {
					icia.common.error(error);
					alert("찜하기에 오류가 발생하였습니다");
				}
			});	
		}
			
		
		//찜 누른적 있을때 한번 더 누르면 찜 취소
		function zzimCancel(productNo)
		{
			$.ajax({
				type:"POST",
				url:"/shop/zzimProc",
				data:{
					productNo:productNo 
				},
				dataType:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response) {
					if(response.code == 0) {
						alert("찜 취소 되었습니다");
						document.zzimForm.productNo.value = productNo;
						document.zzimForm.action = "/shop/detail";
						document.zzimForm.submit();
				 	} else if(response.code == -998) {
						alert("로그인이 필요합니다");
					} else {
						alert("찜하기에 오류가 발생하였습니다");
					}
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
					alert("장바구니 담기 중 오류가 발생하였습니다");
				}
			});	
		}
	</script>
	<link rel="stylesheet" href="/resources/css/shop/sideBar.css" type="text/css">
	<link rel="stylesheet" href="/resources/css/shop/shop_detail.css" type="text/css">
	</head>
	<body>
	<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<%@include file="/WEB-INF/views/include/sideBar.jsp" %>
	
		<!--상품상세-->
		<div class="detail_goods_list">
			<ul class="detail_goods_img">
				<li class="imgbox">
					<img class="detail_img" src="/resources/upload/productImage/detail/${product.productNo}_1.jpg">
				</li>
			</ul>
			<div class="detail_info">
				<div class="top_info">
				<%@include file="/WEB-INF/views/include/brand.jsp" %>
	
				<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@찜 버튼@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2 -->
				<c:choose>
					<c:when test="${empty list2}">
						<img class="btn_like" onclick="doZzim('${product.productNo}')" src="/resources/upload/styleImage/like/before.png" />
					</c:when>
					<c:otherwise>
						<img class="btn_like"  onclick="zzimCancel('${product.productNo}')" src="/resources/upload/styleImage/like/after.png" />
					</c:otherwise>
				</c:choose>	
				<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@찜 버튼@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2 -->
				</div>
	
				<p class="detail_name"> ${product.productName}</p>
				<p class="detail_price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.productPrice}" />원</p>
	
		<c:choose>
			<c:when test="${product.subCategoryCode eq 'SHOES'}" >
				<p class="detail_size">
					<select name="size_select" id="size_select" class="size_select">
						<option value="" disabled selected>[필수] 옵션을 선택해주세요</option>
						<option value="240">240</option>
						<option value="245">245</option>
						<option value="250">250</option>
						<option value="255">255</option>
						<option value="260">260</option>
						<option value="265">265</option>
						<option value="270">270</option>
					</select>
				 </p>
			</c:when>
			<c:when test="${product.subCategoryCode eq 'BAG'}" >
				<p class="detail_size">
					<select name="size_select" id="size_select" class="size_select">
						<option value="" disabled selected>[필수] 옵션을 선택해주세요</option>
						<option value="F">FREE</option>
					</select>
				</p>
			</c:when>
			<c:otherwise>
				<p class="detail_size">
					<select name="size_select" id="size_select" class="size_select">
						<option value="" disabled selected>[필수] 옵션을 선택해주세요</option>
						<option value="S">S</option>
						<option value="M">M</option>
						<option value="L">L</option>
						<option value="XL">XL</option>
					</select>
				</p>
			</c:otherwise>
		</c:choose>
		
				<div>
					<button id="decreaseBtn" onclick="decreaseQuantity()">-</button>
					<input id="orderCount" type="number" value="1" readonly>
					<button id="increaseBtn" onclick="increaseQuantity()">+</button>
				</div>
				<p class="detail_btn_div">
					<button type="button" class="detail_btn" id="button_buy" onclick="goToBuy('${product.productNo}')">BUY NOW</button>
					<button type="button" class="detail_btn" id="button_cart" onclick="addCart('${product.productNo}')">ADD TO CART</button>
				</p>
			</div>
		</div>
	
		<div class="recommend_words">같은 브랜드 추천상품</div>
	
	<c:if test="${!empty list}">
		<div class="recommend_list">
		<c:forEach var="brand" items="${list}" begin="1" end="6" varStatus="status">   
			<div class="recommend_info">
				<a class="recommend_goods" href="javascript:void(0)" onclick="fn_detail(${brand.productNo})">
					<img class="recommend_img" src="/resources/upload/productImage/thum/${brand.productNo}_thum.jpg" alt="">
					<span class="recommend_productName">${brand.productName}</span>
					<span class="recommend_productPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${brand.productPrice}" />원</span>
				</a>
				</div>
			</c:forEach>
		</div>
	</c:if>
	
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ form @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
		<form name="buyForm" id="buyForm" method="post">
			<input type="hidden" name="productNo" value="" />
			<input type="hidden" name="orderCount" value="" />
			<input type="hidden" name="sizeName" value="" />
		</form>
		
		<form name="cartForm" id="cartForm" method="post">
			<input type="hidden" name="productNo" value="" />
			<input type="hidden" name="orderCount" value="" />
			<input type="hidden" name="sizeName" value="" />
		</form>
		
		<form name="goodsForm" id="goodsForm" method="post">
			<input type="hidden" name="productNo" value="" />
			<input type="hidden" name="mainCategoryCode" value="" />
			<input type="hidden" name="subCategoryCode" value="" />
			<input type="hidden" name="brandCode" value="" />
			<input type="hidden" name="curPage" value="" />
		</form>
		
		<form name="zzimForm" id="zzimForm" method="post">
			<input type="hidden" name="productNo" value="" />
		</form>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ form @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
	
	<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</body>
</html>