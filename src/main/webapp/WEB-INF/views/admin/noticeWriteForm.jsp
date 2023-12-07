<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
h2{
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
}


.container {
	flex-direction: row;
	width: 100%;
	margin: auto;
	margin-right: 200px;
	margin-left: 170px;
	display: flex;
    align-content: center;
    flex-wrap: wrap;
    flex-direction: column;
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

.form-control
{
	margin-left:500px;
}


</style>
<script type="text/javascript">
$(document).ready(function() {
    
	$("#nboardTitle").focus();
	
	$("#btnWrite").on("click", function() {
		
		$("#btnWrite").prop("disabled", true); 
		
		
		if($.trim($("#nboardTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요");
			$("#nboardTitle").val("");
			$("#nboardTitle").focus();
			
			$("#btnWrite").prop("disabled", false);  
		
			return;
		}
		
		if($.trim($("#nboardContent").val()).length <= 0)
		{
			alert("내용을 입력하세요");
			$("#nboardContent").val("");
			$("#nboardContent").focus();
			
			$("#btnWrite").prop("disabled", false);
			
			return;
			
		}
		
		var form = $("#writeForm")[0]; 
		var formData = new FormData(form); 
		
		$.ajax({
			type:"POST",
			enctype: "multipart/form-data",  
			url: "/admin/noticeWriteProc",    
			data: formData,
			processData:false,		
			contentType:false,			
			cache: false,
			beforeSend: function(xhr){ 
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("게시물 등록 되었습니다.");
					location.href ="/admin/adminNoticeList";  
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#btnWrite").prop("disabled", false);   //정하기 나름 타이틀에 포커스 줘도 되고
				}
				else if(response.code == -998)
				{
					alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
					location.href = "/admin/login";
				}
				else
			    {
					alert("게시물 등록 중 오류가 발생하였습니다.");
					$("#btnWrite").prop("disabled",false);
					
			    }
			},
			error:function(error)
			{
				icia.common.error(error);
				alert("게시물 등록 중 오류가 발생하였습니다.");
				$("#btnWrite").prop("disabled", false);    //저장버튼 다시 활성화
			}
			
			
		 });
	});
	
	$("#btnList").on("click", function() {
		document.noticeForm.action = "/admin/adminNoticeList";
		document.noticeForm.submit();
	});
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/adHeader.jsp" %>
	<h2  >공지사항 작성</h2>
	<div class="container">
		<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data"> 
			<input type="text" class= "text" name="adminId" id="adminId" maxlength="20" value="${notice.adminId}" style="ime-mode:active; margin-left:100px;" class="form-control mt-4 mb-2"  readonly /> <Br>
			<input type="text" class= "text" name="nboardTitle" id="nboardTitle" maxlength="100" style="ime-mode:active; margin-left:100px;" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
			<div class="form-group">
				<textarea class="textContent" rows="10" name="nboardContent" id="nboardContent" style="ime-mode:active; margin-left:100px;" placeholder="내용을 입력해주세요" required></textarea>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-12">
					<button type="button" id="btnWrite" class="btn btn-primary" title="저장" style="margin-left:680px;">저장</button>
					<button type="button" id="btnList" class="btn btn-secondary" title="리스트">리스트</button>
				</div>
			</div>
		</form>
		<form name="noticeForm" id="noticeForm" method="post">
			<input type="hidden" name="nboardNo" value="" />
			<input type="hidden" name="searchType" value="${searchType}" />
			<input type="hidden" name="searchValue" value="${searchValue}" />
			<input type="hidden" name="curPage" value="${curPage}" />
		</form>
	</div>	

</body>
</html>