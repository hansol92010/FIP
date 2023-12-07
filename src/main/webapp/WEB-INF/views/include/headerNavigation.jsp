<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
<%@ include file="/WEB-INF/views/resources/css/main/templatemo-hexashop.css" %>
</style>
	<%
		if(com.icia.web.util.CookieUtil.getCookie(request, (String) request.getAttribute("AUTH_COOKIE_NAME")) == null) {
	%>

					
	<header class="header-area header-sticky">
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
					<!-- 로고시작 -->
						<a href="/main/index" class="logo"> <img
							src="/resources/images/main/logo1.png">
						</a>
					<!-- 로고 끝 -->
						<ul class="nav">
							<li class="scroll-to-section"><a href="/main/index" class="active">Home</a></li>
							<li class="scroll-to-section"><a href="/shop/goods">SHOP</a></li>
							<li class="scroll-to-section"><a href="/style/styleList">STYLE</a></li>
							<li class="scroll-to-section"><a href="/user/loginForm">MY</a></li>
							<li class="scroll-to-section"><a href="/user/loginForm">장바구니</a></li>
							<li class="scroll-to-section"><a href="/user/loginForm">로그인</a></li>
							<li class="scroll-to-section"><a href="/notice/noticeList">공지사항</a></li>
						</ul>
						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<%
		} else {
	%>
	<header class="header-area header-sticky">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->
						<a href="/main/index" class="logo"> <img
							src="/resources/images/main/logo1.png">
						</a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li class="scroll-to-section"><a href="/main/index" class="active">Home</a></li>
							<li class="scroll-to-section"><a href="/shop/goods">SHOP</a></li>
							<li class="scroll-to-section"><a href="/style/styleList">STYLE</a></li>
							<li class="scroll-to-section"><a href="/myPage/userUpdateForm">MY</a></li>
							<li class="scroll-to-section"><div class="centerblankdiv"></div></li>
							<li class="scroll-to-section"><a href="/cart/cart">장바구니</a></li>
							<li class="scroll-to-section"><a href="/user/logout">로그아웃</a></li>
							<li class="scroll-to-section"><a href="/notice/noticeList">공지사항</a></li>
							
						</ul>
						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<%
		}
	%>


</body>
</html>