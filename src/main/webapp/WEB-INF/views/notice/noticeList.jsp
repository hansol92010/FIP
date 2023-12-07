<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		*, ::after, ::before {
			box-sizing: unset;
		}
		.table-hover th, td{
			border: 1px solid #c4c2c2;
			text-align: center;
			font-size: 15px;
			width: 10px;
		}
		.container-notice {
			margin: 50px 200px 0px 200px;
		}
		.ul, li {
			list-style-type: none;
			display: flex;
		}
		.table_div {
			display: flex;
		    flex-direction: column;
		    text-align: center;
		    margin-top: 2vh;
		}
		
		.searchtext{
		    font-size: 15px;
		    width: 20vw;
		    height: 5vh;
		    margin-left: 5px;
		    padding-left: 2vw;
		    font-size: 15px; 
		    border-radius: 20px; 
		}
		
		.btn_search{
		    background-color: black;
		    color: white;
		    border-radius: 20px;
		    font-size: 20px;
		    font-family: 'Do Hyeon';
		    width: 8vw;
		    height: 5vh;
		}
		a {
			color: black;
		}
		.list:hover {
			background-color: #9696963b;
		}
		.pagination {
		display: flex;
		width: 80%;
		margin-left: 90px;
		padding: 20px 0 35px;
		text-align: center;
		justify-content: center;
		}
		
		.pagination_num_btn {
		width: 26px;
		border: 1px solid transparent;
		font-family: tahoma,sans-serif;
		font-size: 15px;
		font-weight: 700;
		line-height: 26px;
		color: #333;
		margin: 10px;
		}
		
		.pagination_num_btn a {
		text-decoration: none;
		color: inherit;
		cursor: pointer;
		}
		
		.pagination_num_btn a:active {
		color: #000;
		text-decoration: underline;
		}
		
		.productInfo {
		text-align: center;
		margin: auto;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
			$("#btnSearch").on("click", function() {  
				document.noticeForm.nboardNo.value = ""; 
				document.noticeForm.searchType.value = $("#_searchType").val();
				document.noticeForm.searchValue.value = $("#_searchValue").val();
				document.noticeForm.curPage.value = "1";
				document.noticeForm.action = "/notice/noticeList";
				document.noticeForm.submit();
			
			});
		});
		
		function fn_view(nboardNo)  //상세페이지
		{
			document.noticeForm.nboardNo.value =nboardNo; 
			document.noticeForm.action = "/notice/noticeView";
			document.noticeForm.submit();
		}
		
		function fn_list(curPage)  //이전블럭 다음블럭 페이지 버튼 눌렀을때 이동
		{
			document.noticeForm.nboardNo.value = "";
			document.noticeForm.curPage.value = curPage;
			document.noticeForm.action = "/notice/noticeList";
			document.noticeForm.submit();
		}
	</script>
	</head>
	<body>
		<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
		
		<div class="container-notice" style="width:80%; margin: auto; margin-top: 10vh;">
		
			<div style="width: 20%; margin-left: 3vw;">
				<h2>공지사항</h2>
			</div>
			
				<div class=table_body style="display: flex; font-size: 15px; font-weight: bold; flex-direction: column; ">
					<div class="option_value" style=" display: flex;flex-direction: row-reverse; padding-bottom: 1vh;">
						<button type="button" id="btnSearch" class="btn_search">조회</button>
						<input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="searchtext" maxlength="20"  placeholder="조회값을 입력하세요." />
						<select name="_searchType" id="_searchType" class="admin-select" style="font-size: 15px; width: 8vw; height: 5vh; margin-left: 5px; margin-top: 0.3vh; border-radius: 20px; text-align: center;" >
							<option value="">목록</option>
							<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>제목</option>
							<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>내용</option>
						</select>
					</div>
					<div class="table_div " >
						<table class="table">
						<thead>
							<tr style="background-color: black; color: white;">
								<th scope="col" class="text-center" style="width: 15%; height: 5vh;">번호</th>
								<th scope="col" class="text-center" style="width: 65%; height: 5vh;">제목</th>
								<th scope="col" class="text-center" style="width: 20%; height: 5vh;">날짜</th>
							</tr>
						</thead>
						<tbody>
						
							<c:if test="${!empty list}">	 
								<c:forEach var="notice" items="${list}">	
									<tr class="list">
										<!--게시물번호 -->
										<td class="text-center">${notice.nboardNo}</td>
										<!-- 제목 -->
										<td class="text-title">
											<div class="title">
												<a href="javascript:void(0)" onclick="fn_view(${notice.nboardNo})"> 
														<c:out value="${notice.nboardTitle}"/>
												</a>
											</div>
										</td>
										<!-- 게시물 날짜 -->
										<td class="text-RegDate">${notice.nboardRegDate}</td>   
									</tr>
								</c:forEach>
							</c:if>		
						
						</tbody>
				</table>
			
				<!-- 페이징 -->
				<div class="pagination">
					<div class="pagination_num">
					<c:if test="${!empty paging}">
						<c:if test="${paging.prevBlockPage gt 0 }">
						<span class="prev_btn pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전</a></span>
						</c:if>
						<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
							<c:when test="${i ne curPage}">
						<span class="pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></span>
							</c:when>
							<c:otherwise>
						<span class="pagination_num_btn"><a href="javascript:void(0)" style="cursor:default;">${i}</a></span>
							</c:otherwise>
						</c:choose>
						</c:forEach>
						<c:if test="${paging.nextBlockPage gt 0}">
						<span class="next_btn pagination_num_btn"><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음</a></span>
						</c:if>
					</c:if>
					</div>
				</div>	
				<!-- 페이징 div끝 -->
				
				
			</div>
				</div>
			</div>
			
			<%@ include file="/WEB-INF/views/include/footer.jsp" %>
			<form name="noticeForm" id="noticeForm" method="post">
				<input type="hidden" name="nboardNo" value="" />
				<input type="hidden" name="searchType" value="${searchType}" />
				<input type="hidden" name="searchValue" value="${searchValue}" />
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
		</div>
	</body>
</html>