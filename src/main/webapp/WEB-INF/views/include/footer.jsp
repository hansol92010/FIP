<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<!-- ***** Footer Start ***** -->
<script>
function fn_shopList2(val) {
	document.shopFormMove2.mainCategoryCode.value = val;
	document.shopFormMove2.subCategoryCode.value = 'OUTER';
	document.shopFormMove2.action = "/shop/goods";
	document.shopFormMove2.submit();
}
</script>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="first-item">
                        <div class="logo">
                            <img src="/resources/images/main/white-logo1.png" alt="hexashop ecommerce templatemo">
                        </div>
                        <ul>
                            <li><a href="#" style="pointer-events:none;">16501 Collins Ave, Sunny Isles Beach, FL 33160, United States</a></li>
                            <li><a href="#" style="pointer-events:none;">FIP@company.com</a></li>
                            <li><a href="#" style="pointer-events:none;">010-020-0340</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3">
                    <h4>Shopping &amp; Categories</h4>
                    <ul>
                        <li><a href="/shop/goods" onclick="fn_shopList2('M')">Men’s Shopping</a></li>
                        <li><a href="/shop/goods" onclick="fn_shopList2('W')">Women’s Shopping</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                </div>
                <div class="col-lg-3">
                    <h4>고객지원</h4>
                    <ul>
                        <li><a href="/notice/noticeList">공지사항</a></li>
                        <li><a href="#" style="pointer-events:none;">1:1문의</a></li>
                        <li><a href="#" style="pointer-events:none;">이용정책</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-12">
                    <div class="under-footer">
                        <p>Copyright © 2022 FIP Co., Ltd. All Rights Reserved. 
                        
                        <br>Design: <a href="https://templatemo.com" target="_parent" title="free css templates">TemplateMo</a>

                        <br>Distributed By: <a href="https://themewagon.com" target="_blank" title="free & premium responsive templates">ThemeWagon</a></p>
                        <ul>
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-behance"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <form id="shopFormMove2" name="shopFormMove2" method="post">
		<input type="hidden" id="mainCategoryCode" name="mainCategoryCode" value="">
		<input type="hidden" id="subCategoryCode" name="subCategoryCode" value="">
		<input type="hidden" id="brandCode" name="brandCode" value="">
	</form>
    </footer>