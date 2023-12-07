<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<link href="/resources/css/myPage/mycoupon.css" rel="stylesheet">
</head>
<body>
	<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
	<main>
        <div class="my_coupon">
            <div class="coupon_head">

            </div>
            <div class="coupon_tbl">
                <h1>나의 쿠폰</h1>
<c:if test="${empty myCouponCaseList}">
				<h2>소유한 쿠폰이 없습니다.</h2>
</c:if>                
<c:if test="${!empty myCouponCaseList}">                
                <table>
                    <tr class="tbl_h">
                        <td>쿠폰명</td>
                        <td>사용여부</td>
                        <td>유효기간</td>
                    </tr>
   <c:forEach var="couponCase" items="${myCouponCaseList}">                 
                    <tr>
                        <td><span id="couponName">${couponCase.couponName}</span></td>
                <c:choose>
                    <c:when test="${couponCase.couponStatus eq 'N'}">    
                        <td><span id="couponStatus">사용가능</span></td>
                    </c:when>    
                    <c:otherwise>
                        <td><span id="couponStatus">사용불가능</span></td>
                    </c:otherwise>    
                </c:choose>   
                        <td><p><span id="expirationDate">${couponCase.expirationDate}</span>까지</p></td>
                    </tr>
   </c:forEach>                 
                </table>
</c:if>                
            </div>
        </div>
    </main>
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>