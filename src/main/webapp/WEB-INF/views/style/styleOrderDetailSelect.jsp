<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="/WEB-INF/views/include/head.jsp" %>
		<link href="/resources/css/style/styleMyorder.css" rel="stylesheet">
	</head>
	
	<body>
	<script>
		$(document).ready(function(){
			
			//상세구매내역에서 선택 완료 버튼 클릭시
			$("#itemsSelectAccess").on("click",function(){
				//fn_ChkBoxValue();
				opener.fn_reviewProductImageView(fn_ChkBoxValue());
				window.close();
			});//상세구매내역에서 선택 완료 버튼 클릭시 끝
		});
	
		function fn_list(curPage) {
			document.orderListForm.curPage.value = curPage;
			document.orderListForm.action = "/style/styleOrderSelect";
			document.orderListForm.submit();
		};
	
		function fn_ChkBoxValue(){
			var obj = $("[name=styleProductSelectCheckBox]")
			var productNoList = new Array(); 
			
			$('input:checkbox[name=styleProductSelectCheckBox]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
				productNoList.push(this.value);
		    });
			$("#testProSelectList").val(productNoList);
			
			return productNoList;
			//$("#productInfoNo", opener.document).val(productNoList);
		}
	</script>
		<main>
			<div class="my_page">
				<h1>상세주문 내역</h1>
				
				<c:if test="${empty myOrderDetailList}">
					<h2>주문상세내역이 없습니다.</h2>
				</c:if>
				
				<c:if test="${!empty myOrderDetailList}">            
	 				<table>
					<!--!!!!!!!!!!!!!!!!!!!! 상세주문내역 타이틀!!!!!!!!!!!!!!!!!!!!!!!!!! -->
						<tr class="thead">
							<td>선택</td>
							<td>상품이미지</td>
							<td>상품명</td>
							<td>사이즈</td>
							<td>상품가격</td>
							<td>주문수량</td>
							<td>총 가격</td>
						</tr>
					<!--!!!!!!!!!!!!!!!!!!!!!!! 상세주문내역 타이틀 끝 !!!!!!!!!!!!!!!!!!!!!! -->    
	
					 <!-- !!!!!!!!!!!!!!!상세주문내역 정보!!!!!!!!!!!!!!!!!!!!!!!! -->
					<c:forEach var="myOrderDetail" items="${myOrderDetailList}">    
						<tr>      
							<td><input type="checkbox" name="styleProductSelectCheckBox" id="styleProductSelectCheckBox" value="${myOrderDetail.productNo}"></td>
							<td><img id="buy_img" src="/resources/upload/productImage/thum/${myOrderDetail.productNo}_thum.jpg"></td>
							<td>${myOrderDetail.productName}</td>
							<td>${myOrderDetail.sizeName}</td>
							<td>${myOrderDetail.productPrice}</td>
							<td>${myOrderDetail.orderCount}</td>
							<td>${(myOrderDetail.orderCount) * (myOrderDetail.productPrice)}</td>
						</tr>
	       			</c:forEach>
	
					<!-- 체크박스 값들을 받기위한 인풋박스 -->       
	   			 	<input type="hidden" name="testProSelectList" id="testProSelectList" value="">
					<!-- ------------------------------------------- -->       	
					<!-- !!!!!!!!!!!!!!!!!상세주문내역 정보 끝!!!!!!!!!!!!!!!!!!!!!!! -->
					</table>
				</c:if>
				
			 	<button type="button" onclick="fn_list(${curPage})">목록</button>		   
			 	<button type="button" id="itemsSelectAccess">선택완료</button>		   
			</div>
		</main>
	
		<form name="orderListForm" id="orderListForm" method="post">
			<input type="hidden" name="curPage" value="${curPage}" />
		</form>
	</body>
</html>