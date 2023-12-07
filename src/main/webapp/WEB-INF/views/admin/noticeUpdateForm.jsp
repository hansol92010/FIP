<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
.container {
	width: 80%;
    margin: auto;
    margin-right: 150px;
    margin-left: 170px;
    display: flex;
    align-content: center;
    flex-wrap: wrap;
    flex-direction: column;
    margin-left: 20vw;
}

.text {
	font-size: 20px;
	font-weight: bold;
	width: 100vh;
	margin-top: 1vh;
}
.textContent{
	font-size: 15px;
	width: 100vh;
	height: 33vw;
	margin-top: 3vh;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	<c:choose>
		<c:when test="${empty notice}">
		
		alert("게시물이 존재하지 않습니다.");
		location.href = "/admin/adminNoticeList";
		
		</c:when>
		<c:otherwise>
		
		$("#nboardTitle").focus();
		
		$("#btnUpdate").on("click", function() {
			$("#btnUpdate").prop("disabled", true);
			
			if($.trim($("#nboardTitle").val).length <= 0)
			{
				alert("제목을 입력하세요.");
				$("#nboardTitle").val();
				$("#nboardTitle").focus();
				$("#btnUpdate").prop("disabled", false);
				return;
			}
			
			if($.trim($("#nboardContent").val()).length <= 0)
			{
				alert("내용을 입력하세요.");
				$("#nboardContent").val("");
				$("#nboardContent").focus();
				$("#btnUpdate").prop("disabled", false);
				return;
			}	
			
			var form = $("#updateForm")[0];
			var formData = new FormData(form);
				
			$.ajax({
				type:"POST",
				enctype:"multipart/form-data",
		    	url:"/admin/noticeUpdateProc",
		    	data:formData,
		    	processData:false,						
		    	contentType:false,						
		    	cache:false,
		    	beforeSend:function(xhr){
		    		xhr.setRequestHeader("AJAX", "true");
		    	},
		    	success:function(response)
		    	{
		    		if(response.code == 0)
		    		{
		    			alert("공지사항이 수정되었습니다.");
		    			document.noticeForm.action = "/admin/adminNoticeList";
		    			document.noticeForm.submit();
		    			
		    		}	
		    		else if(response.code == 500)
		    		{
		    			alert("파라미터 값이 올바르지 않습니다.");
		    			$("#btnUpdate").prop("disabled", false); 
		    		}	
		    		else if(response.code == 400)
		    		{
		    			alert("게시물을 찾을 수 없습니다.");
		    			location.href = "/admin/noticeList";
		    		}
					else if(response.code == -998)
					{
						alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
						location.href = "/admin/login";
					}
		    		else
		    		{
		    			alert("게시물 수정 중 오류가 발생하였습니다.1");
		    			$("#btnUpdate").prop("disabled", false);  
		    		}	
		    	},
		    	error:function(error)
		    	{
		    		icia.common.error(error);
		    		alert("게시물 수정 중 오류가 발생하였습니다2.");
		    		$("#btnUpdate").prop("disabled", false);
		    	}
		     });
		});
		
		$("#btnList").on("click", function() {
			document.noticeForm.action = "/admin/adminNoticeList";
			document.noticeForm.submit();
		});
		</c:otherwise>
	</c:choose>

	});
</script>

</head>
<body>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
<!-- 전체 div -->
	<c:if test="${!empty notice}">
	
		<div class="container">
			<h2>공지사항 게시물 수정</h2>
			<form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
				<input type="text" class="text" name="userName" id="userName" maxlength="20" value="${notice.adminId}" style="ime-mode:active;" class="form-control mt-4 mb-2" readonly />
				<input type="text" class="text"name="nboardTitle" id="nboardTitle" maxlength="100" style="ime-mode:active;" value="${notice.nboardTitle}" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
				<div class="form-group">
					<textarea class="textContent" rows="10" name="nboardContent" id="nboardContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required>${notice.nboardContent}</textarea>
				</div>
				<input type="hidden" name="nboardNo" value="${notice.nboardNo}" />
				<input type="hidden" name="searchType" value="${searchType}" />
				<input type="hidden" name="searchValue" value="${searchValue}" />
				<input type="hidden" name="curPage" value="${curPage}" />
		 	
		 
			 <div class="btn_form">
				<div class="col-sm-12">
					<button type="button" id="btnUpdate" class="btn_notice_Update" title="수정">수정</button>
					<button type="button" id="btnList" class="btn_notice_list" title="리스트">리스트</button>
				</div>
			</div> <!-- div btn_form 끝  -->
			</form>
			<form name="noticeForm" id="noticeForm" method="post">
				<input type="hidden" name="nboardNo" value="${notice.nboardNo}" />
				<input type="hidden" name="searchType" value="${searchType}" />
				<input type="hidden" name="searchValue" value="${searchValue}" />
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
		</div>
	</c:if>
</body>
</html>