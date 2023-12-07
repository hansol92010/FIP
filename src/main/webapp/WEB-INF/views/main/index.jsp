<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/head.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<style>
<%@ include file="/WEB-INF/views/resources/css/main/flex-slider.css" %>
<%@ include file="/WEB-INF/views/resources/css/main/lightbox.css" %>
<%@ include file="/WEB-INF/views/resources/css/main/owl-carousel.css" %>
<%@ include file="/WEB-INF/views/resources/css/main/templatemo-hexashop.css" %>
</style>
<script>
        $(function() {
            var selectedClass = "";
            $("p").click(function(){
            selectedClass = $(this).attr("data-rel");
            $("#portfolio").fadeTo(50, 0.1);
                $("#portfolio div").not("."+selectedClass).fadeOut();
            setTimeout(function() {
              $("."+selectedClass).fadeIn();
              $("#portfolio").fadeTo(50, 1);
            }, 500);
                
            });
        });

function fn_list(productNo){
	document.productDetailView.productNo.value = productNo;
	document.productDetailView.action = "/shop/detail"; 
	document.productDetailView.submit();
}

function fn_shopList(MainCode) {
	document.shopFormMove.mainCategoryCode.value = MainCode;
	document.shopFormMove.subCategoryCode.value = 'OUTER';
	document.shopFormMove.action = "/shop/goods";
	document.shopFormMove.submit();
}

function fn_eventList(brandCode) {
	document.shopFormMove.brandCode.value = brandCode;
	document.shopFormMove.action = "/shop/goods";
	document.shopFormMove.submit();
}

function fn_styleDetailView(sboardNo) {
	document.styleViewForm.sboardNo.value = sboardNo;
	document.styleViewForm.action = "/style/styleView";
	document.styleViewForm.submit();
}

var menCode = "M";
var womenCode = "W";
</script>


</head>
<body>
	<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
    <!-- ***** Preloader Start ***** -->
     <div id="preloader" >
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>  
    <!--***** Preloader End ***** -->


    <!-- ***** Main Banner Area Start ***** -->
    <div class="main-banner" id="top">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6">
                    <div class="left-content">
                        <div class="thumb">
                            <div class="inner-content">
                                <h4>We Are FIP</h4>
                                <span>Fashion</span>
                                <span>Interested</span>
                                <span>People</span>
                                
                            </div>
                            <img src="/resources/images/main/left-banner-image.jpg" alt="">
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="right-content">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="right-first-image">
                                    <div class="thumb">
                                        <div class="inner-content">
                                            <h4>Women</h4>
                                            <span>Best Clothes For Women</span>
                                        </div>
                                        <div class="hover-content">
                                            <div class="inner">
                                                <h4>Women</h4>
                                                <p>Best Clothes For Women</p>
                                                <div class="main-border-button">
                                                    <a onclick="fn_shopList('W')">바로가기</a>
                                                </div>
                                            </div>
                                        </div>
                                        <img src="/resources/images/main/baner-right-image-01.jpg">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="right-first-image">
                                    <div class="thumb">
                                        <div class="inner-content">
                                            <h4>Men</h4>
                                            <span>Best Clothes For Men</span>
                                        </div>
                                        <div class="hover-content">
                                            <div class="inner">
                                                <h4>Men</h4>
                                                <p>Best Clothes For Men</p>
                                                <div class="main-border-button">
                                                    <a onclick="fn_shopList('M')">바로가기</a>
                                                </div>
                                            </div>
                                        </div>
                                        <img src="/resources/images/main/baner-right-image-02.jpg">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="right-first-image">
                                    <div class="thumb eveBN">
                                        <div class="inner-content">
                                            <h4>Dr.martens</h4>
                                            <span>Best Clothes For Kids</span>
                                        </div>
                                        <div class="hover-content">
                                            <div class="inner">
                                                <h4>닥터마틴 할인 행사</h4>
                                                <p>닥터마틴 행사 보러 가기.</p>
                                                <div class="main-border-button">
                                                    <a onclick="fn_eventList('dm')">바로가기</a>
                                                </div>
                                            </div>
                                        </div>
                                        <img src="/resources/images/main/DRBN.jpg">
                                    </div>
                                </div>
                            </div>
                        <!--     <div class="col-lg-6">
                                <div class="right-first-image">
                                    <div class="thumb">
                                        <div class="inner-content">
                                            <h4>Accessories</h4>
                                            <span>Best Trend Accessories</span>
                                        </div>
                                        <div class="hover-content">
                                            <div class="inner">
                                                <h4>Accessories</h4>
                                                <p>Lorem ipsum dolor sit amet, conservisii ctetur adipiscing elit incid.</p>
                                                <div class="main-border-button">
                                                    <a href="#">Discover More</a>
                                                </div>
                                            </div>
                                        </div>
                                        <img src="/resources/images/main/baner-right-image-04.jpg">
                                    </div>
                                </div>
                            </div> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Main Banner Area End ***** -->

    <!-- ***** Men Area Starts ***** -->
    <section class="section" id="men">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-heading">
                        <h2>Men's Best</h2>
                        <i class="fa fa-eye"></i>
                        <span>남성 인기상품</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="men-item-carousel">
                        <div class="owl-men-item owl-carousel">
                        
                        <c:if test="${!empty menBestItems}">
                        	<c:forEach var="items" items="${menBestItems}">
                            <div class="item">
                                <div class="thumb">
                                    <div class="hover-content">
                                        <ul>
                                            <li><a onclick="fn_list(${items.productNo})">해당상품 보러가기</a></li>
                                        </ul>
                                    </div>
                                    <img src="/resources/upload/productImage/thum/${items.productNo}_thum.jpg" alt="">
                                </div>
                                <div class="down-content">
                                    <h4>${items.productName}</h4>
                                    <span>￦${items.productPrice}</span>
                                </div>
                            </div>
                            </c:forEach>
                        </c:if>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Men Area Ends ***** -->

    <!-- ***** Women Area Starts ***** -->
    <section class="section" id="women">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-heading">
                        <h2>Women's Best</h2>
                        <span>여성 인기상품</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="women-item-carousel">
                        <div class="owl-women-item owl-carousel">
                        
                        <c:if test="${!empty womenBestItems}">
                        	<c:forEach var="items" items="${womenBestItems}">
                            <div class="item">
                                <div class="thumb">
                                    <div class="hover-content">
                                       <ul>
                                            <li><a onclick="fn_list(${items.productNo})" >해당상품 보러가기</a></li>
                                        </ul>
                                    </div>
                                    <img src="/resources/upload/productImage/thum/${items.productNo}_thum.jpg" alt="">
                                </div>
                                <div class="down-content">
                                    <h4>${items.productName}</h4>
                                    <span>￦${items.productPrice}</span>
                                    
                                </div>
                            </div>
                        	</c:forEach>
                        </c:if>    
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Women Area Ends ***** -->

    <!-- ***** Style Area Starts ***** -->
    <section class="section" id="kids">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-heading">
                        <h2>Today Pick</h2>
                        <span>인기 스타일</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="kid-item-carousel">
                        <div class="owl-kid-item owl-carousel">
                        
                        <c:if test="${!empty sboardBestItems}">
                        	<c:forEach var="item" items="${sboardBestItems}">
                            <div class="item">
                                <div class="thumb">
                                    <div class="hover-content">
                                       <ul>
                                            <li><a style="color: white;" onclick="fn_styleDetailView(${item.sboardNo})" >스타일 보러가기</a></li>
                                        </ul>
                                    </div>
                                    <img src="/resources/upload/styleImage/thum/${item.sboardNo}.jpg" alt="">
                                </div>
                                <div class="down-content">
                                    <h4>${item.userId}</h4>
                                    <span>좋아요  ${item.likeCount}</span>
                                    
                                </div>
                            </div>
                            </c:forEach>
                          </c:if>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Style Area Ends ***** -->


   
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    

    <!-- jQuery -->
    <script defer src="/resources/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script defer src="/resources/js/bootstrap.min.js"></script>
    <script defer src="/resources/js/popper.js"></script>

    <!-- Plugins -->
    <script defer src="/resources/js/owl-carousel.js"></script>
    <script defer src="/resources/js/accordions.js"></script>
    <script defer src="/resources/js/datepicker.js"></script>
    <script defer src="/resources/js/scrollreveal.min.js"></script>	<!-- 휠 굴릴때 마다 에러 -->
    <script defer src="/resources/js/waypoints.min.js"></script>
    <script defer src="/resources/js/jquery.counterup.min.js"></script>
    <script defer src="/resources/js/imgfix.min.js"></script> 
    <script defer src="/resources/js/slick.js"></script> 
    <script defer src="/resources/js/lightbox.js"></script> 
    <script defer src="/resources/js/isotope.js"></script> 
    
    <!-- Global Init -->
    <script defer src="/resources/js/custom.js"></script>

    <form id="productDetailView" name="productDetailView" method="post">
    	
    	<input type="hidden" id="productNo" name="productNo" value="">
    </form>

	<form id="shopFormMove" name="shopFormMove" method="post">
		<input type="hidden" id="mainCategoryCode" name="mainCategoryCode" value="">
		<input type="hidden" id="subCategoryCode" name="subCategoryCode" value="">
		<input type="hidden" id="brandCode" name="brandCode" value="">
	</form>
	
	<form id="styleViewForm" name="styleViewForm" method="post">
		<input type="hidden" id="sboardNo" name="sboardNo" value="">
	</form>
  </body>
</html>