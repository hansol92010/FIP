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
width: 460px;
}

.input-ul li { /* 목록의 각 항목 */
margin-bottom: 20px; /* 아래 마진 10px */
}


</style>
<script type="text/javascript">
function stockReg() {
	
	$("#stockReg").prop("disabled", false);
	
	var form = $("#stockRegForm")[0];
	var formData = new FormData(form); 
	
	$.ajax({
		type: "POST",
		enctype: "multipart/form-data",
		url: "/admin/stockRegProc",
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
				alert("상품의 사이즈와 재고 등록이 완료되었습니다");
				location.href ="/admin/productList";
				
			}
			else if(response.code == 400)
			{
				alert("입력이 올바르지 않습니다.");
				$("#stockReg").prop("disabled", false);
			}
			else if(response.code == 404)
			{
				alert("이미 재고가 입력된 상품입니다. 재고 수정으로 이동해주세요");
				$("#stockReg").prop("disabled", false);
			}
			else
		    {
				alert("재고 등록 중 오류가 발생하였습니다.");
				$("#stockReg").prop("disabled",false);
		    }
		},
		error:function(error)
		{
			icia.common.error(error);
			alert("재고 등록 중 오류가 발생하였습니다.");
			$("#stockReg").prop("disabled", false); 
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


<div class="container">
    <div class="content">
        <div style="width:50%;">
            <h2>재고 등록</h2>
        </div>

<form name="stockRegForm" id="stockRegForm" method="post" enctype="multipart/form-data">     
	<c:if test="${!empty product}">
		<fieldset>
			<ul class="input-ul">
				<li>
					<div class="inputArea">
						<label for="productNo">상품 번호</label>
						<input type="number" id="productNo" name="productNo" value="${product.productNo}" readonly>
					</div>
				</li>
				<li>
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
					</div>
				</li>
			</ul>
		</fieldset>
	</c:if>

	<c:if test="${empty product}">
		<fieldset>
			<ul class="input-ul">
				<li>
					<div class="inputArea">
						<label for="productNo">상품 번호</label>
						<input type="number" id="productNo" name="productNo" value="${product.productNo}" readonly>
					</div>
				</li>
				<li>
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
					</div>
				</li>
			</ul>
		</fieldset>
	</c:if>
	
		<div class="inputArea centered">
			<button type="button" onclick="stockReg();">등록</button>
		</div>
</form>

	
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