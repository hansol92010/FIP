<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
		<link rel="stylesheet" href="/resources/css/style/stylelist.css">
		<link rel="stylesheet" href="/resources/css/style/styleDetail.css" />
		<%@ include file="/WEB-INF/views/include/head.jsp" %>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	
		<!--style 헤더-->
		<nav>
			<div class="style_tag">
				<a href="/style/styleList" type="button">#나이키 &nbsp;</a>
				<a href="/style/styleList" type="button">#뉴발  &nbsp;</a>
				<a href="/style/styleList" type="button">#마뗑킴 &nbsp;</a>
				<a href="/style/styleList" type="button">#폴로 &nbsp;</a>
				<a href="/style/styleList" type="button">#아더에러 &nbsp;</a>
				<a href="/style/styleList" type="button">#타미힐피거 &nbsp;</a>
				<a href="/style/styleList" type="button">#디스이즈네버댓 &nbsp;</a>
				<a href="/style/styleList" type="button">#닥터마틴 &nbsp;</a>
			</div>
			<div>
		  	<!-- 인기순,최신순 -->
				<p class="style_align">
				  <a href="">인기순 &nbsp;</a>
				  <a href="">최신순 &nbsp;</a>
				</p>
			</div>
		</nav>
	
		<!--스타일 메인-->
		<div class="row">
			<!-- 화면 왼쪽 스타일 사진 -->
			<div class="left">
			      <img src="/resources/upload/style/Air Force 1 '07 Low White_style.jpg"/>
			</div>
			<!-- 화면오른쪽 프로필 -->
			<div class="right">
				<div class="profile">
				<!-- 프로필 사진 -->
					<img src="/resources/upload/style/Big Swoosh Full Zip Jacket Black Sail_style.jpg" class="profile_img">
				</div>
				<!-- 프로필 닉네임 -->
				<div class="user_id">
					<p>또복</p>
				</div>
	
	              &nbsp;
	              <hr />
	              &nbsp;
	              <br /><br />
	
				<!--내가 한 태그-->
				<div class="btn_mytag">
					<button>#나이키</button>
					<button>#조이연</button>
					<button>#또복맘</button>
					<button>#패션</button>
					<br />
					<br />
					<button>#오늘의 ootd</button>
					<button>#에어포스</button>
				</div>
				
	            &nbsp;
	           <hr />
	           &nbsp;
	           <br /><br /><br />
	
				<!-- 상품 -->
				<div class="p_detail">
				<a href= "/shop/shopDetail" >
					<!-- 상품사진 -->
					<img src="/resources/upload/product/Air Force 1 '07 Low White_thum.jpg" class="p_detail_img"  />
				</a>
				</div>
				
				<!-- 상품정보 -->
				<div class="p_detail_info">
					<h3> &nbsp; &nbsp;모델 번호 : CJ9179-200 </h3>
					<h3> &nbsp; &nbsp;브랜드 : Nike </h3>
					<h3> &nbsp; &nbsp;가격 : 160,000 </h3>
				</div>
			</div>
		</div>
	
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	</body>
</html>
