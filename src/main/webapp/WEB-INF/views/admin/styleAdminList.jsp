<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
.pagination_num
{
float: right;
}

.d-flex
{
display: flex;
flex-direction: row;
align-items: flex-end;

}

</style>
<script type="text/javascript">

$(document).ready(function() {
    

	
	$("#btnSearch").on("click", function() {   //조회버튼
		document.styleForm.sboardNo.value = "";  //담아져 있는 4개 세팅
		document.styleForm.searchType.value = $("#searchType").val();
		document.styleForm.searchValue.value = $("#searchValue").val();
		document.styleForm.curPage.value = "1";
		document.styleForm.action = "/admin/styleAdminList";
		document.styleForm.submit();
	
	});
});


function deleteList(sboardNo){
	if(confirm("게시물을 삭제 하시겠습니까?") == true)
	{
		//ajax
		$.ajax({
			type:"POST",
			url:"/admin/adminDelete",
			data:{
				sboardNo:sboardNo
			},
			dataType:"JSON",
			beforeSend:function(xhr){
	    		xhr.setRequestHeader("AJAX", "true");
	    	},
	    	success:function(response)
	    	{
	    		if(response.code == 0)
	    		{
	    			alert("게시물이 삭제되었습니다.");
	    			location.href = "/admin/styleAdminList";
	    		}	
	    		else if(response.code == 404)
	    		{
	    			alert("게시물을 찾을 수 없습니다.");
	    			location.href = "/admin/styleAdminList";
	    		}
				else if(response.code == -998)
				{
					alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
					location.href = "/admin/login";
				}
	    		else
	    		{
	    			alert("게시물 삭제 중 오류가 발생하였습니다.");
	    		}	
	    	},
	    	error:function(xhr, status, error)
	    	{
	    		icia.common.error(error);
	    	}
		});
	}
}

function fn_list(curPage)
{
	document.styleForm.curPage.value = curPage;
	document.styleForm.action = "/admin/styleAdminList";
	document.styleForm.submit();
}


</script>
</head>
<body>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@제목/조회@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<main style="width: 70%; margin:auto; display: flex; flex-direction: column; margin-top: 10vh">

<div class="d-flex" >
      <div style=" width: 50%;">
         <h2 style="margin: 0;">게시판</h2>
      </div>
      <div class="ml-auto input-group" style="width: 50%;display: flex;flex-direction: row;justify-content: flex-end;">
         <select name="searchType" id="searchType" class="custom-select" style="font-size: 1rem; width: 8rem; height: 2.2rem; margin-left:.5rem;">
				<option value="">조회 항목</option>
				<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>작성자</option>
				<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>제목</option>
				<option value="3" <c:if test="${searchType eq '3'}">selected</c:if>>내용</option>
			</select>
			<input type="text" name="searchValue" id="searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:15rem; height: 2rem; margin-left:.5rem; font-size: 15px;" placeholder="조회값을 입력하세요." />
			<button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1" style="width:4rem; height:2.2rem; margin-left:.5rem; font-size: 15px; color: #212529; background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118);">조회</button>
      </div>
 	</div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@리스트 표@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --> 	
<table class="table table-hover">
		<thead>
		<tr style="background-color: #e0e4fe;">
			<th scope="col" class="text-center" style="width:20%">글번호</th>
			<th scope="col" class="text-center" style="width:20%">아이디</th>
			<th scope="col" class="text-center" style="width:50%">제목</th>
			<th scope="col" class="text-center" style="width:10%">삭제</th>
		</tr>
		</thead>
		
		
		
		<tbody>
		<c:if test="${empty list}"><span>비어잇습니다</span></c:if>
<c:if test="${!empty list}">	 <!-- list객체가 비어있지 않을때 밑에를 실행 -->
	<c:forEach var="sboard" items="${list}" varStatus="status">	
		<tr>
			<td>${sboard.sboardNo}</td>
			<td>${sboard.userId}</td>
			<td>${sboard.sboardTitle}</td>
			<td><button type="button"  id="btnDelete" class="btnDelete" onclick="deleteList('${sboard.sboardNo}')">삭제</button></td>
		
		
		
		</tr>
	</c:forEach>
</c:if>		
		
		</tbody>
</table>
		
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@페이징@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --> 	
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

	
<form name="styleForm" id="styleForm" method="post">
	<input type="hidden" name="sboardNo" value="${sboardNo}" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>
		
		
		
</main>




</body>