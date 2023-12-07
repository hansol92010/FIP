<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
<%@include file="/WEB-INF/views/resources/css/main/HF.css" %>
</style>

<c:if test="${empty adminId}">
    <header>
    <!-- <div>
        <ul class="top_list">
            <li>
                <a  href="고객센터" class="top_link">고객센터</a>
            </li>
            <li>
                <a href="/cart/cart" class="top_link">관심상품</a>
            </li>
            <li>
                <a href="/user/loginForm" class="top_link">로그인</a>
            </li>
        </ul>
    </div> -->
    <div>
        <ul class="top_header_ul">
            <li><a class="logo" href="/main/index"><img src="/resources/images/headLogo.png"></a></li>
        </ul>
    </div>
</header>
</c:if>

<c:if test="${!empty adminId}">
 	<header>
    <div>
        <ul class="top_list">
<!--        <li>
                <a  href="/admin/notice" class="top_link">공지사항</a>
            </li>
            <li>
                <a href="/admin/cart" class="top_link">상품등록</a>
            </li>
            <li>
                <a href="/admin/cart" class="top_link">상품등록</a>
            </li>
            <li>
                <a href="/admin/cart" class="top_link">상품등록</a>
            </li> -->
            <li>
                <a href="/admin/logout" class="top_link">관리자 로그아웃</a>
            </li>
        </ul>
    </div>
    <div>
        <ul class="top_header_ul">
            <li><a class="logo" href="/admin/main">WE ARE FIP</a></li>
            <ul class="www">
                <li><a class="menu" href="/admin/userList">회원 관리</a></li>
                <li><a class="menu" href="/admin/productList/">상품관리</a></li>
                <li><a class="menu" href="/admin/styleAdminList">스타일 관리</a></li>
                <li><a class="menu" href="/admin/adminNoticeList">공지사항 관리</a></li>
            </ul>    
        </ul>
    </div>
</header>
</c:if>