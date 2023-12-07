<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	if(com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) == null)
	{
%>
	<div>
        <ul class="top_list">
            <li>
                <a  href="/notice/noticeList" class="top_link"> 공지사항 </a>
            </li>
            <li>
                <a href="/user/loginForm" class="top_link"> 장바구니 </a>
            </li>
            <li>
                <a href="/user/loginForm" class="top_link"> 로그인 </a>
            </li>
        </ul>
    </div>
    <header>
    
    <div>
        <ul class="top_header_ul">
            <li><a class="logo" href="/main/index"><img src="/resources/images/headLogo.png"></a></li>
            <ul class="www">
                <li><a  class="menu" href="/main/index">HOME</a></li>
                <li><a  class="menu" href="/shop/goods">SHOP</a></li>
                <li><a  class="menu" href="/style/styleList">STYLE</a></li>
                <li><a  class="menu" href="/myPage/myPageMain">MY</a></li>
            </ul>    
        </ul>
    </div>
</header>

<%
	}else {
%>    
 	<header>
    <div>
        <ul class="top_list">
            <li>
                <a  href="/notice/noticeList" class="top_link"> 고객센터 </a>
            </li>
            <li>
                <a href="/cart/cart" class="top_link"> 장바구니 </a>
            </li>
            <li>
                <a href="/user/logout" class="top_link"> 로그아웃 </a>
            </li>
        </ul>
    </div>
    <div>
        <ul class="top_header_ul">
            <li><a class="logo" href="/main/index"><img src="/resources/images/headLogo.png"></a></li>
            <ul class="www">
                <li><a  class="menu" href="/main/index">HOME</a></li>
                <li><a  class="menu" href="/shop/goods">SHOP</a></li>
                <li><a  class="menu" href="/style/styleList">STYLE</a></li>
                <li><a  class="menu" href="/myPage/myPageMain">MY</a></li>
            </ul>    
        </ul>
    </div>
</header>
<%
	}
%>