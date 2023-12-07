<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
.container {
  flex-direction: row;
  width: 100%;
  margin-top: 60px;
  
 }
 
.table_div {
	display: flex;
    flex-direction: column;
    text-align: center;
}

.top_div {
	display: flex;
    flex-direction: row;
    justify-content: flex-end;
    padding: 1vw;
}
.list:hover {
	background-color: #9696963b;
}
a {
	color: black;
}
.style_btn_Write {
	
	  background-color: black;
    color: white;
    border-radius: 20px;
    font-size: 20px;
    /* border-color: plum; */
    font-family: 'Do Hyeon';
    width: 6vw;
    height: 5vh;
    margin-left:1150px;
    margin-bottom:13px;
  	

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

.admin-select
{
	width:30rem;
	height:2rem;
}




</style>
<script type="text/javascript">
$(document).ready(function() {
    
	$("#btnWrite").on("click", function() {    
		document.noticeForm.nboardNo.value = "";
		document.noticeForm.action = "/admin/noticeWriteForm";
		document.noticeForm.submit();
	});
	
	$("#btnSearch").on("click", function() {   
		document.noticeForm.nboardNo.value = "";  
		document.noticeForm.searchType.value = $("#_searchType").val();
		document.noticeForm.searchValue.value = $("#_searchValue").val();
		document.noticeForm.curPage.value = "1";
		document.noticeForm.action = "/admin/adminNoticeList";
		document.noticeForm.submit();
	
	});
});

function fn_view(nboardNo)  //상세페이지
{
	document.noticeForm.nboardNo.value =nboardNo;  
	document.noticeForm.action = "/admin/adminNoticeView";
	document.noticeForm.submit();
}

function fn_list(curPage)  //이전블럭 다음블럭 페이지 버튼 눌렀을때 이동
{
	document.noticeForm.nboardNo.value = "";
	document.noticeForm.curPage.value = curPage;
	document.noticeForm.action = "/admin/adminNoticeList";
	document.noticeForm.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
<main style="width: 80%; margin:auto; display: flex; flex-direction: column; margin-top: 10vh">



<div class="top_div">
		<div style=" width: 50%;">
			<h2 style="margin: 5px;">공지사항</h2>
		</div>
		 <div class="ml-auto input-group" style="width: 50%;display: flex;flex-direction: row;justify-content: flex-end;">
			<select name="_searchType" id="_searchType" class="admin-select" style="width:7rem; height: 2rem; margin-left:.5rem; font-size: 15px;">
				<option value="">조회 항목</option>
				<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>제목</option>
				<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>내용</option>
			</select>
			<input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" maxlength="20"  style="width:15rem; height: 2rem; margin-left:.5rem; font-size: 15px;" placeholder="조회값을 입력하세요." />
			<button type="button" id="btnSearch" class="btn_search" style="width:4.5vw; height:5.5vh; margin-left:.5rem; font-size: 15px;  background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118); border-radius: 7px;  ">조회</button>
		</div>
	</div>
		<!-- 글쓰기 버튼 div -->
			<div class="btn_notice_writer" >
				<button type="button" id="btnWrite" class="style_btn_Write" >글쓰기</button>
			</div>
		<!-- 글쓰기 버튼 div 끝-->
	
	
		<div class="table_div">
			<table class="table">
			<thead>
				<tr style="background-color: #e0e4fe;">
					<th scope="col" class="text-center" style="width: 15%; height: 5vh;">번호</th>
					<th scope="col" class="text-center" style="width: 65%; height: 5vh;">제목</th>
					<th scope="col" class="text-center" style="width: 20%; height: 5vh;">날짜</th>
				</tr>
			</thead>
			<tbody>
			
				<c:if test="${!empty list}">	 <!-- list객체가 비어있지 않을때 밑에를 실행 -->
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
							<td class="text-RegDate">${notice.nboardRegDate}</td>    <!-- 이렇게도 작성가능 -->
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
	
	
	<form name="noticeForm" id="noticeForm" method="post">
		<input type="hidden" name="nboardNo" value="" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>

</body>
</html>