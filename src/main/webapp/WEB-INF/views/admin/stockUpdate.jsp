<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
.container {
flex-direction: row;
margin-top: 10px;
width: 80%;
margin-right: 0px;
margin-left: 0px;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
-webkit-appearance: none;
}

.inputArea {
margin-left: 0px;
}

</style>
<script type="text/javascript">
function stockUpdate() {
	
	$("#stockUpdate").prop("disabled", false);
	
	var form = $("#stockRegForm")[0];
	var formData = new FormData(form); 
	
	$.ajax({
		type: "POST",
		enctype: "multipart/form-data",
		url: "/admin/stockUpdateProc",
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
				alert("상품의 사이즈와 재고 수정이 완료되었습니다");
				/* location.href ="/admin/productDetail"; */
				opener.parent.location.reload();
				window.open("about:black", "_self").close();
				
			}
			else if(response.code == 400)
			{
				alert("입력이 올바르지 않습니다.");
				$("#stockUpdate").prop("disabled", false);
			}
			else if(response.code == -998)
			{
				alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
				location.href = "/admin/login";
			}
			else
		    {
				alert("재고 수정 중 오류가 발생하였습니다.");
				$("#stockUpdate").prop("disabled",false);
		    }
		},
		error:function(error)
		{
			icia.common.error(error);
			alert("재고 수정 중 오류가 발생하였습니다.");
			$("#stockUpdate").prop("disabled", false); 
		}
		
		
	 });
	
}
</script>
</head>
<body>
<div class="container">
    <div class="content">
        <div style="width:50%;">
            <h2>재고 수정</h2>
        </div>

	<form name="stockRegForm" id="stockRegForm" method="post" enctype="multipart/form-data">     
		<c:if test="${!empty product}">
		
		<div class="inputArea">
            <label for="productNo">상품 번호</label>
            <input type="number" id="productNo" name="productNo" value="${product.productNo}" readonly>
        </div>

		<div class="inputArea">
            <label>사이즈</label>
			<c:choose>
				<c:when test="${product.subCategoryCode eq 'BAG'}">
					<div>
						<input type="text" id="sizeName" name="sizeName" value="F" readonly/>
						<input type="number" id="units" name="units" />
					</div>
				</c:when>
				<c:when test="${product.subCategoryCode eq 'SHOES'}">
					<div>
						<input type="text" id="sizeName" name="sizeName" value="240" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="245" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="250" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="255" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="260" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="265" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="270" readonly/>
						<input type="number" id="units" name="units" />
					</div>
				</c:when>
				<c:otherwise>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="S" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="M" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="L" readonly/>
						<input type="number" id="units" name="units" />
					</div>
					<div>
						<input type="text" id="sizeName" name="sizeName" value="XL" readonly/>
						<input type="number" id="units" name="units" />
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		      		<div class="inputArea">
	            		<button type="button" onclick="stockUpdate();">등록</button>
	       			</div>
	       			
	</form>
	
	</div>
</div>

	
<!--
	<form name="stockRegForm" id="stockRegForm" method="post" enctype="multipart/form-data">
        <div class="inputArea">
            <label for="productNo">상품 번호</label>
            <input type="number" id="productNo" name="productNo" />
        </div>

        <div class="inputArea">
            <label for="sizeName">사이즈</label>
			<input type="text" id="sizeName" name="sizeName" />
		</div>
	
        <div class="inputArea">
            <label for="units">재고 수량</label>
            <input type="number" name="units" id="units"  />
       </div>

       <div class="inputArea">
            <button type="button" onclick="stockReg();">등록</button>
       </div>
	</form>
    </div>
</div>

-->


</body>
</html>