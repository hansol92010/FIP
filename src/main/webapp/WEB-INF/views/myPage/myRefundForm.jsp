<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<link href="/resources/css/myPage/myrefund.css" rel="stylesheet">
</head>
<body>
	<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
	 <main>
        <div class="my_page">
            <h1>환불 내역</h1>
            <table class="orderTbl">
                <tr class="thead">
                    <td>환불번호</td>
                    <td>상품정보</td>
                    <td>주문정보</td>
                    <td>환불사유</td>
                    <td>환불신청일</td>
                </tr>
                <tr>
                    <td id="refundNo"><span id="refundNo">환불번호</span></td> 
                    <td class="my_buy">
                        <a href=""><img src="/img/옷.jpg" id="buy_img"></a>  <!-- 이미지 부분 따로 적용 필요 -->
                        <a href=""><span id="productName">상품 이름</span></a>
                    </td>
                    <td id="order_list">
                        <p>주문번호:<span id="orderNo">123456</span></p>
                        <p>수량:<span id="orderCount">124</span></p>
                        <p>총 주문 금액:<span id="totalOrderPrice">12421</span></p>
                        
                    </td>
                    <td><span id="reasonRefund">상품파손</span></td>
                    <td id="applicationDate"><span id="applicationDate">2023-03-02</span></td>  
                    
               </tr>
             
            </table>
        </div>
    </main>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>