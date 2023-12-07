<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="/resources/css/myPage/mystyle.css" rel="stylesheet">

<script>
function fn_list(curPage){
	document.myStyleListForm.curPage.value = curPage;
	document.myStyleListForm.action = "/myPage/myStyleList";
	document.myStyleListForm.submit();
}

function fn_styleDetailView(sboardNo) {
	var win = window.open('', 'styleDetailPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1000,height=1000,left=100,top=100');
	document.styleDetailView.sboardNo.value = sboardNo;
	document.styleDetailView.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
<main>
        <div class="mystyle">
            <h1>내 스타일</h1>

			<c:if test="${empty sboardList}">
				<h2>게시물이 존재하지 않습니다.</h2>
			</c:if>
            <!-- 스타일 페이지와 비슷한 형식 -->
		            <div class="style_div">
			<c:if test="${!empty sboardList}">
				<c:forEach var="sboard" items="${sboardList}">
		                <div class="list">
		                    <a onclick="fn_styleDetailView(${sboard.sboardNo})">
		                        <div class="list_img">
		                            <img src="/resources/upload/styleImage/thum/${sboard.sboardNo}.jpg">
		                        </div>
		                        <p class="sboardTitle">${sboard.sboardTitle}</p>
		                    </a>
		                </div>
	            </c:forEach>
	        </c:if>    
		            </div>
	            <!-- 스타일 게시글  -->
        </div>
        
        <!-- 페이징  -->
        <nav>
			<ul class="paginations ">
				<c:if test="${!empty paging}">
					<c:if test="${paging.prevBlockPage gt 0}">
							<li class="page-item"><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
					</c:if>
					
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
							<c:when test="${i ne curPage}">		
								<li class="page-item"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item now-item"><a href="javascript:void(0)" style="cursor:default;">${i}</a></li>
							</c:otherwise>	
						</c:choose>	
					</c:forEach>
							
					<c:if test="${paging.nextBlockPage gt 0}">		
							<li class="page-item"><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
					</c:if>		
				</c:if>			
			</ul>
		</nav>
		<!-- 페이징 끝 -->
    </main>
    <form id="myStyleListForm" name="myStyleListForm" method="post">
    	<input type="hidden" id="curPage" name="curPage" value="${curPage}">
    </form>
    
    <form id="styleDetailView" name="styleDetailView" action="/style/styleView" target="styleDetailPopUp">
		<input type="hidden" id="sboardNo" name="sboardNo" value="">    
    </form>
<%@include file="/WEB-INF/views/include/footer.jsp" %> 
</body>
</html>