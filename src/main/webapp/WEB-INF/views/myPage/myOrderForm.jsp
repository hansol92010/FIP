<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="/resources/css/myPage/myorder.css" rel="stylesheet">
<script>

function fn_view(orderNo) {
	document.orderNoForm.orderViewNo.value = orderNo;
	document.orderNoForm.action = "/myPage/myOrderDetailForm";
	document.orderNoForm.submit();
}

function fn_list(curPage) {
	document.orderNoForm.orderViewNo.value = "";
	document.orderNoForm.curPage.value = curPage;
	document.orderNoForm.action = "/myPage/myOrderForm";
	document.orderNoForm.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>

<main>
        <div class="my_page">
            <h1>주문 내역</h1>
    <c:if test="${empty myOrderList}">        
            <p>주문내역이 없습니다</p>
    </c:if>
    <c:if test="${!empty myOrderList}">   
    	  
            <table class="orderTbl">
            <!--!!!!!!!!!!!!!!!!!!!! 주문내역 타이틀!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                <tr class="thead">
                    <td>주문번호</td>
                    <td>상세주문보기</td>
                    <td>총주문금액</td>
                    <td>주문날짜</td>
                </tr>
        <c:forEach var="myOrder" items="${myOrderList}">
            <!--!!!!!!!!!!!!!!!!!!!!!!! 주문내역 타이틀 끝 !!!!!!!!!!!!!!!!!!!!!! -->    
            
                <!-- !!!!!!!!!!!!!!!상세주문내역 정보!!!!!!!!!!!!!!!!!!!!!!!! -->
                
                <tr>
                    <td id="orderNo">${myOrder.orderNo}</td>  <!-- rowspan="orderNo" 할수도 있음 -->
                    <td id="orderDetailNo"><a href="javascript:void(0)" onclick="fn_view(${myOrder.orderNo})">상세보기</a></td>
                    <td class="my_buy"><fmt:formatNumber type="number" maxFractionDigits="3" value="${myOrder.totalOrderPrice}" />원</td>
                    <td id="orderDate">${myOrder.orderDate}</td>
               	</tr>
               	<!-- !!!!!!!!!!!!!!!!!상세주문내역 정보 끝!!!!!!!!!!!!!!!!!!!!!!! -->
        </c:forEach>
            </table>
       </c:if> 
        </div>
        <nav>
		<ul class="pagination">
<c:if test="${!empty paging}">
	<c:if test="${paging.prevBlockPage gt 0}">
			<li class="page-item"><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
	</c:if>
	
	<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
		<c:choose>
			<c:when test="${i ne curPage}">		
				<li class="page-item"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item now-item"><a href="javascript:void(0)" style="cursor:default;">${i}</a></li>
			</c:otherwise>	
		</c:choose>	
	</c:forEach>
			
	<c:if test="${paging.nextBlockPage gt 0}">		
			<li class="page-item"><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
	</c:if>		
</c:if>			
		</ul>
	</nav>
    </main>
    <form name="orderNoForm" id="orderNoForm" method="post">
		<input type="hidden" name="orderViewNo" value="" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
<%@include file="/WEB-INF/views/include/footer.jsp" %> 
</body>
</html>