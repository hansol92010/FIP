<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
.container{
 display: flex;
 flex-direction: column;
 background-color: white;

}
table{
  width: 248%;
  border: 1px solid #c4c2c2;
  margin: auto;
}
table th, td{
  border-right: 1px solid #c4c2c2;
  border-bottom: 1px solid #c4c2c2;
  height: 4rem;
  padding-left: .5rem;
  padding-right: 1rem;
}
table th{
  background-color: #e0e4fe;
  width: 10%;
  font-size: 20px;
  font-weight: bold;
}
table td {
	font-size: 15px;
}
.table-active{
	width: 15vw;
}
.content {
	 background-color: white;
	 height: 100vh;
	 font-size: 10px;
	
}
button {
	margin-left: 0.5vw;
	width: 4vw;
	height: 3vh;
	border-radius: 20px;
	background-color: #e0e4fe;
}
.listbtn {
	margin-left: 15vw;
}
.content {
	font-size: 15px;
	text-align: left;
	
}

.btn-noticeList
{
	margin-left:750px;
	 width: 6vw;
    height: 5vh;
    margin-bottom:10px;
}

.btn-noticeDelete
{
	 width: 5vw;
    height: 4vh;
}

.btn-noticeUpdate
{
	width: 5vw;
    height: 4vh;
}




</style>
<script type="text/javascript">
$(document).ready(function() {
		$("#btnList").on("click", function() {
			document.noticeForm.action = "/admin/adminNoticeList";
			document.noticeForm.submit();
		});
		
		$("#btnUpdate").on("click", function() {
			document.noticeForm.action = "/admin/noticeUpdateForm";
			document.noticeForm.submit();
		});
		$("#btnDelete").on("click", function(){
			
			
			if(confirm("게시물을 삭제 하시겠습니까?") == true)
			{
				//ajax
				$.ajax({
					type:"POST",
					url:"/admin/noticeDelete",
					data:{
						nboardNo:$("#nboardNo").val()
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
			    			location.href = "/admin/adminNoticeList";
			    		}	
			    		else if(response.code == 400)
			    		{
			    			alert("파라미터 값이 올바르지 않습니다.");
			    		}
			    		else if(response.code == 404)
			    		{
			    			alert("게시물을 찾을 수 없습니다.");
			    			location.href = "/admin/adminNoticeList";
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
		});
	
});

</script>
</head>
<body>
<c:if test= "${!empty notice}">
<div class="container" style="width: 30%; margin-left: 15vw; ">
	<div style="width: 50%; margin-right: 60vw; ">
		<h1 style="font-size: 1.6rem; margin-top: 3rem; padding: .5rem 0 .5rem 1rem; width: 68vw; background-color: #e0e4fe; text-align:center; margin-bottom:13px;">공지사항</h1>
	</div>
	<!-- 리스트로 가는 버튼 -->
	<div class="listbtn">
		<button type="button" id="btnList" class="btn-noticeList">목록보기</button>
	</div>
		<table class="notice-table">
			<thead>
				<tr class="table-active">
					<th scope ="row">아이디</th>
					<td scope="col">
						<c:out value="${notice.adminId}" />
					</td>
				</tr>
				<tr class="table-active">
					<th scope ="row">제목</th>
					<td scope="col">
						<c:out value="${notice.nboardTitle}" />
					</td>
				</tr>
			</thead>
			<tbody>
				<tr class="table-active">
					<th colspan= "2" scope ="row">내용</th>
				</tr>
				<tr class="table-active">
					<th colspan="2" class="content"><c:out value="${notice.nboardContent}" /></th>
				</tr>
				
			</tbody>
		</table>
	
	
	<div style=" margin-left:920px; width: 20vw; margin-top:10px; margin-bottom:10px;">
		
		<!-- 관리자일경우 삭제 -->
		<button type="button" id="btnDelete" class="btn-noticeDelete">삭제</button>
		<button type="button" id="btnUpdate" class="btn-noticeUpdate">수정</button>
	</div>
</div>	
</c:if>

	<!-- form -->
	<form name="noticeForm" id="noticeForm" method="post">
		<input type="hidden" name="nboardNo" id="nboardNo" value="${nboardNo}" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>

</body>
</html>