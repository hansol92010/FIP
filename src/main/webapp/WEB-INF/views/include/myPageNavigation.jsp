<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/resources/css/myPage/mymenu.css" rel="stylesheet">
<%@include file="/WEB-INF/views/include/head.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		$("#userUpdateForm").on("click", function(){
			location.href = "/myPage/userUpdateForm";
		});
		
		$("#userDeleteForm").on("click", function(){
			location.href = "/myPage/myDeleteForm";
		});
		
		$("#myOrderForm").on("click", function(){
			location.href = "/myPage/myOrderForm";
		});
		
		$("#myCouponForm").on("click", function(){
			location.href = "/myPage/myCouponForm";
		});
		
		$("#myZzimList").on("click", function(){
			location.href = "/myPage/myZzimList";
		});
		
		$("#myStyleList").on("click", function(){
			location.href = "/myPage/myStyleList";
		});
		
		$("#myLikeStyleList").on("click", function(){
			location.href = "/myPage/myLikeStyleList";
		});
	});
		
	
</script>
</head>
<body>
    
        <div class="my_menu">
            <div>
                <h2>회원정보</h2>
                <button type="button" id="userUpdateForm" >회원정보 수정</button><br/>
                <button type="button" id="userDeleteForm">회원 탈퇴</button><br/>
            </div>
            <div>
                <h2 >주문정보</h2>
                <button type="button" id="myZzimList">찜 목록</button><br/>
                <button type="button" id="myOrderForm">주문내역</button><br/>
            </div>
            <div>
                <h2>스타일</h2>
                <button type="button" id="myStyleList">내가 쓴 글</button><br/>
                <button type="button" id="myLikeStyleList">관심 글</button><br/>
            </div>
        </div>
    
</body>
</html>