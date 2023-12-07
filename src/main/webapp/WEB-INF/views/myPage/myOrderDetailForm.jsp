<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="/resources/css/myPage/myorder.css" rel="stylesheet">
</head>
<body>
<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
<script>
function fn_list(curPage) {
	document.orderListForm.curPage.value = curPage;
	document.orderListForm.action = "/myPage/myOrderForm";
	document.orderListForm.submit();
}
</script>
<main>
        <div class="my_page">
            <h1>상세주문 내역</h1>
<c:if test="${empty myOrderDetailList}">
			<h2>주문상세내역이 없습니다.</h2>
</c:if>              
<c:if test="${!empty myOrderDetailList}">            
            <table class="orderTbl">
           
            <!--!!!!!!!!!!!!!!!!!!!! 상세주문내역 타이틀!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                <tr class="thead">
                    <td>상세주문번호</td>
                    <td>상품이미지</td>
                    <td>상품명</td>
                    <td>사이즈</td>
                    <td>상품가격</td>
                    <td>주문수량</td>
                </tr>
            <!--!!!!!!!!!!!!!!!!!!!!!!! 상세주문내역 타이틀 끝 !!!!!!!!!!!!!!!!!!!!!! -->    
            
                <!-- !!!!!!!!!!!!!!!상세주문내역 정보!!!!!!!!!!!!!!!!!!!!!!!! -->
       <c:forEach var="myOrderDetail" items="${myOrderDetailList}">          
                <tr>
                    <td>${myOrderDetail.orderDetailNo}</td>
                    <td><img id="buy_img" src="/resources/upload/productImage/thum/${myOrderDetail.productNo}_thum.jpg"></td>
                    <td>${myOrderDetail.productName}</td>
                    <td>${myOrderDetail.sizeName}</td>
                    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${myOrderDetail.productPrice}" />원</td>
                    <td>${myOrderDetail.orderCount}</td>
               	</tr>
       </c:forEach>        	
               	
               	<br/>
               	<tr>
					<td>배송지</td>
					<td colspan="6">${order.shoppingAddress}</td>       
					<td></td>        	
               	</tr>
               	
               	<!-- !!!!!!!!!!!!!!!!!상세주문내역 정보 끝!!!!!!!!!!!!!!!!!!!!!!! -->
            </table>
</c:if>         
		 	<button type="button" onclick="fn_list(${curPage})">목록</button>		   
        </div>
    </main>
    
    <form name="orderListForm" id="orderListForm" method="post">
		<input type="hidden" name="curPage" value="${curPage}">
	</form>
<%@include file="/WEB-INF/views/include/footer.jsp" %> 
</body>
</html>