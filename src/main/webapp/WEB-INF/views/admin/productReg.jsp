<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
.container {
flex-direction: row;
margin-top: 10px;
width: 50%;
height: 100%;
margin: 0 auto;
margin-left: 13%;
}

.sidebar {
list-style: none;
width: 12%;
position: fixed;
margin-top: 20px;
margin-left: 25px;
}

.sidebar .category {
margin-bottom: 20px;
}

.sidebar .category h3 {
margin-bottom: 10px;
}

.sidebar .category li {
margin-bottom: 5px;
}

.categoryMenu {
text-decoration: none;
color: black;
}

.category ul{
list-style: none;
padding-left: 3px;
margin-left: 3px;
}

.category:hover > u l{
display: block;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
-webkit-appearance: none;
}

#preview {
width: 200px;
height: 200px;
}


.input-ul { /* 순서없는 목록에 적용할 스타일 */
list-style-type: none; /* 불릿 없앰 */
}

label.title { /* class=title인 label에 적용할 스타일 */
font-weight: bold; /* 굵은 글자 */
width: 180px; /* 너비 80px */
float: left; /* 왼쪽부터 배치 */
}

div.centered { /* class=centered인 div에 적용할 스타일 */
text-align: center; /* 가운데 정렬 */
}

fieldset { /* 필드셋에 적용할 스타일*/
margin: 15px 10px; /* 상하 마진 15xp, 좌우 마진 10px */
}

.input-ul li { /* 목록의 각 항목 */
margin-bottom: 20px; /* 아래 마진 10px */
}

#productDetailImg {
margin-left: 25px;
}

#brandCode, #mainCategoryCode, #subCategoryCode {
width: 200px;
}
</style>
<script type="text/javascript">
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      document.getElementById('preview').src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    document.getElementById('preview').src = "";
  }
}

function productReg() {
	
	$("#productReg").prop("disabled", false);
	
	//입력값 체크하기
	if(!($("#productName").val()))
	{
		alert("상품명을 입력하세요")
		$("#productName").val("");
		$("#productName").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	if(!($("#productThumImg").val()))
	{
		alert("썸네일 이미지를 첨부하세요")
		$("#productThumImg").val("");
		$("#productThumImg").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	if(!($("#productDetailImg").val()))
	{
		alert("디테일 이미지를 첨부하세요")
		$("#productDetailImg").val("");
		$("#productDetailImg").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	if($('#brandCode > option:selected').val() == 0)
	{
		alert("브랜드 코드를 선택하세요");
		$("#brandCode").val("");
		$("#brandCode").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	if($('#mainCategoryCode > option:selected').val() == 0)
	{
		alert("상위 카테고리를 선택하세요");
		$("#mainCategoryCode").val("");
		$("#mainCategoryCode").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	if($('#subCategoryCode > option:selected').val() == 0)
	{
		alert("하위 카테고리를 선택하세요");
		$("#subCategoryCode").val("");
		$("#subCategoryCode").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	if(!($("#productPrice").val()))
	{
		alert("상품 가격을 입력하세요")
		$("#productPrice").val("");
		$("#productPrice").focus();
		$("#productReg").prop("disabled", true);
		return;
	}
	
	var form = $("#productRegForm")[0]; 
	var formData = new FormData(form); 
	
	$.ajax({
		type: "POST",
		enctype: "multipart/form-data",
		url: "/admin/productRegProc",
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
				alert("상품이 등록되었습니다. 다음 페이지에서 상품의 사이즈와 재고를 입력하세요");
				location.href = "/admin/productList";
/*  			document.productForm.productNo.value = $("#productNo").val();
				document.productForm.action = "/admin/stockReg";
				document.productForm.submit(); */
			}
			else if(response.code == 400)
			{
				alert("입력이 올바르지 않습니다.");
				$("#productReg").prop("disabled", false);
			}
			else if(response.code == -998)
			{
				alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
				location.href = "/admin/login";
			}
			else
		    {
				alert("상품 등록 중 오류가 발생하였습니다.");
				$("#productReg").prop("disabled",false);
		    }
		},
		error:function(error)
		{
			icia.common.error(error);
			alert("상품 등록 중 오류가 발생하였습니다.");
			$("#productReg").prop("disabled", false); 
		}
	 });
	
}
</script>
</head>
<body>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
  <!--사이드 바-->
  <div class="sidebar">
      <div class="category">
          <h3>상품 관리</h3>
          <ul>
              <li><a class="categoryMenu" href="/admin/productList">상품 목록</a></li>
              <li><a class="categoryMenu" href="/admin/productReg">상품 등록</a></li>
          </ul>
      </div>
<!--       <div class="category">
          <h3>브랜드 관리</h3>
          <ul>
              <li><a class="categoryMenu" href="">브랜드 목록</a></li>
              <li><a class="categoryMenu" href="">브랜드 등록</a></li>
          </ul>
      </div> -->
  </div>

<!-- <div class="container">
    <div class="content">
        <div style="width:50%;">
            <h2>상품 등록</h2>
        </div>

        <form name="productRegForm" id="productRegForm" method="post" enctype="multipart/form-data">
        
        
        <div class="inputArea">
            <label for="productName">상품 번호</label>
            <input type="number" id="productNo" name="productNo">
        </div>
       

        <div class="inputArea">
            <label for="productName">상품명</label>
            <input type="text" id="productName" name="productName">
        </div>
        
        <div class="inputArea">
            <label for="productThumImg">썸네일 사진등록</label><br />
            <img id="preview"><br />
	        <input type="file" id="productThumImg"  name="productThumImg" onchange="readURL(this)"><br />
        </div>
        
        <div class="inputArea">
            <label for="productDetailImg">디테일 사진등록</label><br />
	        <input type="file" id="productDetailImg" name="productDetailImg"  multiple/><br />
        	<input type="file" id="productDetailImg" name="productDetailImg"  /><br />
        	<input type="file" id="productDetailImg" name="productDetailImg"  /><br />
        </div>

        <div class="inputArea">
            <label>브랜드</label>
            <select name="brandCode" id="brandCode">
                <option value=""> -- 옵션 선택 -- </option>
                <option value="nk">나이키</option>
                <option value="nb">뉴발란스</option>
                <option value="mk">마뗑킴</option>
                <option value="pl">폴로</option>
                <option value="th">타미힐피거</option>
                <option value="dn">디스이즈네버댓</option>
                <option value="dm">닥터마팀</option>
                <option value="ae">아더에러</option>
                <option value="nf">노스페이스</option>
            </select>
        </div>

        <div class="inputArea">
            <label>상위 카테고리</label>
            <select name="mainCategoryCode" id="mainCategoryCode">
                <option value=""> -- 옵션 선택 -- </option>
                <option value="M">M</option>
                <option value="W">W</option>
            </select>
        </div>

		<div class="inputArea">
            <label>하위 카테고리</label>
            <select name="subCategoryCode" id="subCategoryCode">
                <option value=""> -- 옵션 선택 -- </option>
                <option value="OUTER">OUTER</option>
                <option value="TOP">TOP</option>
                <option value="BOTTOM">BOTTOM</option>
                <option value="BAG">BAG</option>
                <option value="SHOES">SHOES</option>
            </select>
        </div>

        <div class="inputArea">
            <label for="productPrice">상품 가격</label>
            <input type="number" name="productPrice" id="productPrice">
        </div>
        
        <div class="inputArea">
            <button type="button" onclick="productReg();">등록</button>
        </div>
        </form>
    </div>
</div> -->

	<div class="container">
		<div class="content">
			<div style="width:50%;">
				<h2>상품 등록</h2>
			</div>
		
		<form name="productRegForm" id="productRegForm" method="post" enctype="multipart/form-data">
		<div style="border: 1px solid #ccc;">
			<fieldset>
				<ul class="input-ul">
					<li>
						<div class="inputArea">
							<label for="productName" class="title">상품명</label>
							<input type="text" id="productName" name="productName">
						</div>
					</li>
					<li>
						<div class="inputArea">
							<label for="productPrice" class="title">상품 가격</label>
							<input type="number" name="productPrice" id="productPrice">
						</div>
					</li>
				</ul>
			</fieldset>

			<fieldset>
				<ul class="input-ul">
					<li>
						<div class="inputArea">
							<label for="productThumImg" class="title">썸네일 사진등록</label><br />
							<div>
								<img id="preview">
								<input type="file" id="productThumImg"  name="productThumImg" onchange="readURL(this)"><br />
							</div>
						</div>
					</li>

					<li>
						<div class="inputArea">
							<label for="productDetailImg" class="title">디테일 사진등록</label>
							<input type="file" id="productDetailImg" name="productDetailImg"  multiple/><br />
						</div>
					</li>
				</ul>
			</fieldset>

			<fieldset>
				<ul class="input-ul">
					<li>
						<div class="inputArea">
							<label class="title">브랜드</label>
							<select name="brandCode" id="brandCode">
								<option value=""> -- 옵션 선택 -- </option>
								<option value="nk">나이키</option>
								<option value="nb">뉴발란스</option>
								<option value="mk">마뗑킴</option>
								<option value="pl">폴로</option>
								<option value="th">타미힐피거</option>
								<option value="dn">디스이즈네버댓</option>
								<option value="dm">닥터마팀</option>
								<option value="ae">아더에러</option>
								<option value="nf">노스페이스</option>
							</select>
						</div>
					</li>
					<li>
						<div class="inputArea">
							<label class="title">상위 카테고리</label>
							<select name="mainCategoryCode" id="mainCategoryCode">
								<option value=""> -- 옵션 선택 -- </option>
								<option value="M">M</option>
								<option value="W">W</option>
							</select>
						</div>
					</li>
					<li>
						<div class="inputArea">
							<label class="title">하위 카테고리</label>
							<select name="subCategoryCode" id="subCategoryCode">
								<option value=""> -- 옵션 선택 -- </option>
								<option value="OUTER">OUTER</option>
								<option value="TOP">TOP</option>
								<option value="BOTTOM">BOTTOM</option>
								<option value="BAG">BAG</option>
								<option value="SHOES">SHOES</option>
							</select>
						</div>
					</li>
				</ul>
			</fieldset>
			
			<div class="inputArea centered">
				<button type="button" onclick="productReg();">상품 등록</button>
			</div>
		</div>
		</form>
		</div>
	</div>

<!-- <form name="productForm" method="get">
	<input type="hidden" name="productNo" value="" />
</form> -->

</body>
</html>