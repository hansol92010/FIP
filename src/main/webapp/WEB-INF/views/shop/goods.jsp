<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
//상품 상세 페이지로 이동
function fn_detail(productNo) {
	document.goodsForm.productNo.value = productNo;
	document.goodsForm.action = "/shop/detail";
	document.goodsForm.submit();
}

//옵션 조회
function optionSelect(op) {
	document.goodsForm.optionSelect.value = op;
	document.goodsForm.curPage.value = "";
	document.goodsForm.action = "/shop/goods";
	document.goodsForm.submit();
}

//category 메서드의 매개변수를 이용해 값 담기(각 카테고리 클릭 시 현재 페이지 초기화 필요)
function category(main, sub, brand) {
	document.goodsForm.mainCategoryCode.value = main;
	document.goodsForm.subCategoryCode.value = sub;
	document.goodsForm.brandCode.value = brand;
	document.goodsForm.curPage.value = "";
	document.goodsForm.optionSelect.value = "";
	document.goodsForm.action = "/shop/goods";
	document.goodsForm.submit();
}

//페이징을 위한 메서드
function fn_list(curPage) {
	document.goodsForm.curPage.value = curPage;
	document.goodsForm.action = "/shop/goods";
	document.goodsForm.submit();
}
</script>
<link rel="stylesheet" href="/resources/css/shop/sideBar.css" type="text/css">
<link rel="stylesheet" href="/resources/css/shop/productMain.css" type="text/css">
</head>
<body>
<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
<%@include file="/WEB-INF/views/include/sideBar.jsp" %>

	<div class="content">
		<div id="option_list">
			<p class="option_sort">
				<a class="option" href="javascript:optionSelect('1');">최신순</a>
				<a class="option" href="javascript:optionSelect('2');">판매인기순</a>
				<a class="option" href="javascript:optionSelect('3');">높은가격순</a>
				<a class="option" href="javascript:optionSelect('4');">낮은가격순</a>
			</p>
		</div>
		<c:if test="${!empty list}">
			<c:set var="i" value="0" />
			<c:set var="j" value="5" />
			<c:forEach var="product" items="${list}" varStatus="status">
		<c:if test="${i%j == 0}"> 
			<div class="goods_list">
		</c:if>
				<div class="goods_img">
					<a class="deail_goods" href="javascript:void(0)" onclick="fn_detail(${product.productNo})">
						<img class="main_img" src="/resources/upload/productImage/thum/${product.productNo}_thum.jpg" alt="">
						<p class="product_info goods_gender">${product.mainCategoryCode}</p>
						<p class="product_info goods_name">${product.productName}</p>
						<p class="product_info goods_price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.productPrice}" />원</p>
					</a>
				</div>
		<c:if test="${i%j == j-1}">
			</div>
		</c:if>
			<c:set var="i" value="${i+1}" />
			</c:forEach>
		</c:if>
	</div>
	<div class="paginations">
		<div class="pg_num">
		<c:if test="${!empty paging}">
			<c:if test="${paging.prevBlockPage gt 0 }">
			<span class="prev_btn page-item"><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전</a></span>
			</c:if>
			<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			<c:choose>
				<c:when test="${i ne curPage}">
			<span class="page-item"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></span>
				</c:when>
				<c:otherwise>
			<span class="page-item now-item"><a href="javascript:void(0)" style="cursor:default;">${i}</a></span>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${paging.nextBlockPage gt 0}">
			<span class="next_btn page-item"><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음</a></span>
			</c:if>
		</c:if>
		</div>
	</div>


<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ form @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
<form name="goodsForm" id="goodsForm" method="post">
	<input type="hidden" name="productNo" value="" />
	<input type="hidden" name="optionSelect" value="${optionSelect}" />
	<input type="hidden" name="mainCategoryCode" value="${mainCategoryCode}" />
	<input type="hidden" name="subCategoryCode" value="${subCategoryCode}" />
	<input type="hidden" name="brandCode" value="${brandCode}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ form @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>