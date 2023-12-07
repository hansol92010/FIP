<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
			<link rel="stylesheet" href="/resources/css/style/stylelist.css">
			<%@ include file="/WEB-INF/views/include/head.jsp" %>
			<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
		
		<script type="text/javascript">
			//글쓰기 버튼을 눌렀을때 글쓰기 페이지로 이동
			$(document).ready(function() {
			 	$("#btnWrite").on("click", function() {
			
			 		document.styleForm.sboardNo.value="";
			 		document.styleForm.action = "/style/writeForm";
			 		document.styleForm.submit();
			 	});
				
			});
		    
			//스타일 게시물 페이지로 이동
			function style_View(sboardNo) {
				document.styleForm.sboardNo.value = sboardNo;
				document.styleForm.action = "/style/styleView";
				document.styleForm.submit();
			}
		  
		    
			//최신순,인기순 옵션 조회
			function optionSelect(os) {
				document.styleForm.optionSelect.value = os;
				document.styleForm.action = "/style/styleList";
				document.styleForm.submit();
			}
		    
			//브랜드별 조회
			function category(brand){
				document.styleForm.brandCode.value = brand;
				document.styleForm.action = "/style/styleList";
				document.styleForm.submit();
			}
		</script>
	</head>
	
	<body>
		<!--스타일 헤더 (브랜드 옵션 박스) -->
		<nav>
			<div class="style_nav">
				<div class="style_brand">
					<!-- 브랜드 별 태그 -->
					<a class="category_Menu" href="javascript: category('nk');">#나이키</a>
					<a class="category_Menu" href="javascript: category('nf');">#노스페이스</a>
					<a class="category_Menu" href="javascript: category('mk');">#마뗑킴</a>
					<a class="category_Menu" href="javascript: category('pl');">#폴로</a>
					<a class="category_Menu" href="javascript: category('th');">#타마힐피거</a>
					<a class="category_Menu" href="javascript: category('dn');">#디스이즈네버댓</a>
					<a class="category_Menu" href="javascript: category('dm');">#닥터마틴</a>
					<a class="category_Menu" href="javascript: category('ae');">#아더에러</a>
					<a class="category_Menu" href="javascript: category('ae');">#뉴발란스</a>
				</div>
			</div>
			
		 	<!-- 옵션 리스트 -->
			<div id="syle_option_list">
				<div class="style_option_sort">
		 			<!--옵션 (조회순, 좋아요 순) -->
					<a class="style_option_1" href="javascript:optionSelect('1');">최신순</a>
					<a class="style_option_2" href="javascript:optionSelect('2');">인기순</a>
				</div>
					<!-- 로그인이 되어있을 때 글쓰기 버튼 -->
				<div class="btnWrite">
					<c:if test="${!empty cookieUserId}">
					<c:if test="${loginCheck eq 'Y'}">
						<button type="button" id="btnWrite" class="style_btn_Write">글쓰기</button>
					</c:if>
					</c:if>
				</div>
			</div>
		</nav>
	
		<div class="style_main">
			<c:if test="${!empty list}">
				<c:set var="i" value="0" />
				<c:set var="j" value="4" />
				<c:forEach var="sboard" items="${list}" varStatus="status">
				<c:if test="${i%j == 0}">
				</c:if>
					<div class="style_List_img">
				   		<a class="style_list_main_img" href="javascript:void(0)" onclick="style_View(${sboard.sboardNo})">
					  		 <img class="style_list_main_img" src="/resources/upload/styleImage/thum/${sboard.sboardNo}.jpg" alt="">	
				   		</a>
				   		<div class="style_info_div">
				   			<div class="info_img">
				   				<img src="/resources/upload/userImage/${sboard.userId}.jpg">
				   			</div>
				   			<div class="info_name">
				   				<p>${sboard.userNickName}</p>
				   			</div>
				   	
				   			<div class="info_like">
				   				<p>${sboard.likeCount}</p>
				   				<img src="/resources/upload/styleImage/like/after.png">
				   			</div>
				   		</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
	
		<!--브랜드 코드, 옵션(조회순, 좋아요순)-->
		<form name="styleForm" id="styleForm" method="post">
			<input type="hidden" name="brandCode" value="${brandCode}" /> 
			<input type="hidden" name="optionSelect" value="${optionSelect}" /> 
			<input type="hidden" name="sboardNo" value="${sboardNo}" />
		</form>
		
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>	
	</body>
</html>

