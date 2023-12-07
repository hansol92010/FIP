<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>  
.container {
flex-direction: row;
margin-top: 10px;
width: 80%;
margin: auto;
margin-left: 13%;
}

.content {
display: flex;
align-items: flex-end;
flex-direction: row;
}

.titlePart {
width:50%;
}

.selectPart {
width: 45%;
display: flex;
justify-content: flex-end;
margin-bottom: 1rem;
}

.searchValue {
width:auto;
ime-mode:active;
}

.searchType {
width:auto;
}

.productName {
color: black;
}

.productName:hover {
color: #ccc;
}

.sidebar {
list-style: none;
width: 12%;
position: fixed;
margin-top: 20px;
margin-left: 25px;
}

.sidebar .category {
margin-bottom: 20px;
}

.sidebar .category h3 {
margin-bottom: 10px;
}

.sidebar .category li {
margin-bottom: 5px;
}

.categoryMenu {
text-decoration: none;
color: black;
}

.category ul{
list-style: none;
padding-left: 3px;
margin-left: 3px;
}

.category:hover >ul{
display: block;
}

.listImg {
width: 100px;
height: 120px;
}

.pagination {
display: flex;
width: 80%;
margin: auto;
margin-left: 13%;
padding: 20px 0 35px;
text-align: center;
justify-content: center;
}

.pagination_num_btn {
width: 26px;
border: 1px solid transparent;
font-family: tahoma,sans-serif;
font-size: 15px;
font-weight: 700;
line-height: 26px;
color: #333;
margin: 10px;
}

.pagination_num_btn a {
text-decoration: none;
color: inherit;
cursor: pointer;
}

.pagination_num_btn a:active {
color: #000;
text-decoration: underline;

}

.productInfo {
text-align: center;
margin: auto;
}

#stockReg {
margin: auto;
display: block;
}

</style>
<script>
$(document).ready(function() {
	
	$("#btnSearch").on("click", function() {
	document.productForm.searchType.value = $("#_searchType").val();
	document.productForm.searchValue.value = $("#_searchValue").val();
	document.productForm.curPage.value = "1";
	document.productForm.action = "/admin/productList";
	document.productForm.submit();
	});
	
	
	
});

function fn_list(curPage)
{
	document.productForm.curPage.value = curPage;
	document.productForm.action = "/admin/productList";
	document.productForm.submit();
}

function stockReg(productNo)
{
	document.productForm.productNo.value = productNo;
	document.productForm.action = "/admin/stockReg";
	document.productForm.submit();
}

function fn_detail(productNo) {
	document.productForm.productNo.value = productNo;
	document.productForm.action = "/admin/productDetail";
	document.productForm.submit();
}

</script>
</head>
<body>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
  <!--사이드 바-->
  <div class="sidebar">
      <div class="category">
          <h3>상품 관리</h3>
          <ul>
              <li><a class="categoryMenu" href="/admin/productList">상품 목록</a></li>
              <li><a class="categoryMenu" href="/admin/productReg">상품 등록</a></li>
          </ul>
      </div>
<!--       <div class="category">
          <h3>브랜드 관리</h3>
          <ul>
              <li><a class="categoryMenu" href="">브랜드 목록</a></li>
              <li><a class="categoryMenu" href="">브랜드 등록</a></li>
          </ul>
      </div> -->
  </div>

  <div class="container">

	<div class="content">
      <div class="titlePart">
         <h2>상품 목록</h2>
      </div>
      
      <div class="selectPart">
         <select name="_searchType" id="_searchType" class="searchType" style="font-size: 1rem; width: 8rem; height: 2.2rem; margin-left:.5rem;">
				<option value="">조회 항목</option>
				<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>상품 번호</option>
				<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>상품명</option>
			</select>
			<input type="text" name="_searchValue" id="_searchValue" class="searchValue" value="${searchValue}" maxlength="20" style="width:15rem; height: 2rem; margin-left:.5rem; font-size: 15px;" placeholder="조회값을 입력하세요." />
			<button type="button" id="btnSearch" style="width:4rem; height:2.2rem; margin-left:.5rem; font-size: 15px; background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118);">조회</button>
      </div>
 	</div>
 	
	<table class="table" style="width:95%">
		<thead>
            <tr style="background-color: #e0e4fe;">
                <th scope="col" style="width:10%">상품 번호</th>
                <th scope="col" style="width:15%">상품 이미지</th>
                <th scope="col" style="width:15%">상품명</th>
                <th scope="col" style="width:10%">브랜드</th>
                <th scope="col" style="width:10%">상위 카테고리</th>
                <th scope="col" style="width:10%">하위 카테고리</th>
                <th scope="col" style="width:15%">등록 날짜</th>
                <th scope="col" style="width:15%">재고 등록</th>
            </tr>
		</thead>

		<tbody>
<c:if test="${!empty list }" >
	<c:forEach var="product" items="${list}" varStatus="status">
		    <tr>
                <td class="productInfo">${product.productNo}</td>
                <td>
                    <img class="listImg productInfo" src="/resources/upload/productImage/thum/${product.productNo}_thum.jpg">
                </td>
                <td class="productInfor">
                	<a href="javascript:void(0)" class="productName" onclick="fn_detail(${product.productNo})">${product.productName}</a>
                </td>
                <td class="productInfo">${product.brandCode}</td>
                <td class="productInfo">${product.mainCategoryCode}</td>
                <td class="productInfo">${product.subCategoryCode }</td>
                <td class="productInfo">${product.productRegDate}</td>
                <td>
                	<button type="button" class="productInfo" id="stockReg" onclick="stockReg(${product.productNo});">재고 등록</button>
                </td>
            </tr>
	</c:forEach>
</c:if>	
		</tbody>

		<tfoot>
            <tr>
                <td colspan="5"></td>
            </tr>
		</tfoot>
	</table>
	
		<div class="pagination">
			<div class="pagination_num">
		
	<c:if test="${!empty paging}">
				<c:if test="${paging.prevBlockPage gt 0 }">
					<span class="prev_btn pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전</a></span>
				</c:if>
				
				<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
				<c:choose>
					<c:when test="${i ne curPage}">
						<span class="pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></span>
					</c:when>
					<c:otherwise>
						<span class="pagination_num_btn"><a href="javascript:void(0)" style="cursor:default;">${i}</a></span>
					</c:otherwise>
				</c:choose>
				</c:forEach>
				<c:if test="${paging.nextBlockPage gt 0}">
					<span class="next_btn pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음</a></span>
				</c:if>
	</c:if>
	
			</div>
		</div>
	
</div>

<%-- 	<div class="pagination">
		<div class="pagination_num">
		
<c:if test="${!empty paging}">
			<c:if test="${paging.prevBlockPage gt 0 }">
				<span class="prev_btn pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전</a></span>
			</c:if>
			
			<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			<c:choose>
				<c:when test="${i ne curPage}">
					<span class="pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></span>
				</c:when>
				<c:otherwise>
			<span class="pagination_num_btn"><a href="javascript:void(0)" style="cursor:default;">${i}</a></span>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${paging.nextBlockPage gt 0}">
				<span class="next_btn pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음</a></span>
			</c:if>
</c:if>
		</div>
	</div> --%>

	<form name="productForm" id="productForm" method="get">
		<input type="hidden" name="productNo" value="" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>

</body>
</html>