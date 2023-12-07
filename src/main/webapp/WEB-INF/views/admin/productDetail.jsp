<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
.container {
flex-direction: row;
margin-top: 10px;
width: 80%;
margin: auto;
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

.category:hover >ul{
display: block;
}

html, body{
color:  #525252;
}

table{
width:100%;
border: 1px solid #c4c2c2;
}

table th, td{
border-right: 1px solid #c4c2c2;
border-bottom: 1px solid #c4c2c2;
height: 4rem;
padding-left: .5rem;
padding-right: 1rem;
}

table th{
  background-color: #dee2e6;
}

input[type=text], input[type=password]{
height:2rem;
width: 100%;
border-radius: .2rem;
border: .2px solid rgb(204,204,204);
background-color: rgb(246,246,246);
}

button{
width: 5rem;
margin-top: 1rem;
border: .1rem solid rgb(204,204,204);
border-radius: .2rem;
box-shadow: 1px 1px #666;
}

button:active {
background-color: rgb(186,186,186);
box-shadow: 0 0 1px 1px #666;
transform: translateY(1px);
}
</style>
<script type="text/javascript">
$(document).ready(function() {
<c:choose>
	<c:when test="${empty product}">
	
	alert("조회하신 상품은 존재하지 않습니다.");
	document.productForm.action = "/admin/productList";
	document.productForm.submit();
	
	</c:when>
	<c:otherwise>
	
	$("#productName").focus();
	
	$("#btnList").on("click", function() {
	document.productForm.action = "/admin/productList";
	document.productForm.submit();
	});
	
/* 	$("#btnUpdate").on("click", function() {
		document.productDetailForm.action = "/board/updateForm";
		document.productDetailForm.submit();
	}); */
	
	
	</c:otherwise>
</c:choose>	
});

function fn_delete()
{
	if(confirm("상품 정보를 삭제 하시겠습니까?") == true)
	{
		//ajax
		$.ajax({
			type:"POST",
			url:"/admin/deleteProc",
			data:{
				productNo:<c:out value="${product.productNo}" />
			},
			dataType:"JSON",
			beforeSend:function(xhr){
	    		xhr.setRequestHeader("AJAX", "true");
	    	},
	    	success:function(response)
	    	{
	    		if(response.code == 0)
	    		{
	    			alert("상품이 삭제되었습니다.");
	    			location.href = "/admin/productList";
	    		}	
	    		else if(response.code == 400)
	    		{
	    			alert("파라미터 값이 올바르지 않습니다.");
	    		}
	    		else if(response.code == 404)
	    		{
	    			alert("상품을 찾을 수 없습니다.");
	    			location.href = "/admin/productList";
	    		}
				else if(response.code == -998)
				{
					alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
					location.href = "/admin/login";
				}
	    		else
	    		{
	    			alert("상품 삭제 중 오류가 발생하였습니다.");
	    		}	
	    	
	    	},
	    	error:function(xhr, status, error)
	    	{
	    		icia.common.error(error);
	    	}
		});
	}
}


function fn_update()
{
	if(icia.common.isEmpty($("#productName").val()))
	{
		alert("상품명을 입력하세요.");
		$("#productName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#brandCode").val()))
	{
		alert("브랜드 코드를 입력하세요.");
		$("#brandCode").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#productPrice").val()))
	{
		alert("상품 가격을 입력하세요.");
		$("#productPrice").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#mainCategoryCode").val()))
	{
		alert("상위 카테고리를 입력하세요.");
		$("#mainCategoryCode").focus();
		return;	
	}
	
	if(icia.common.isEmpty($("#subCategoryCode").val()))
	{
		alert("하위 카테고리를 입력하세요.");
		$("#subCategoryCode").focus();
		return;	
	}
			
	if(!confirm("상품 정보를 수정하시겠습니까?"))
	{
		return;
	}
	
 	var form = $("#detailForm")[0];
	var formData = new FormData(form);
	
	icia.ajax.post({
		url: "/admin/updateProc",
		data: formData,
		processData:false,			
		contentType:false,			
		cache: false,
		success:function(res)
		{
			if(res.code == 0)
			{
				alert("상품정보가 수정되었습니다.");
				documnet.productDetailForm.productNo.value = <c:out value="${product.productNo}" />;
				document.productDetailForm.action = "/admin/productList";
				document.productDetailForm.submit();
			}
			else if(res.code == 400)
			{
				alert("파라미터 값에 오류가 발생하였습니다.");
			}
			else if(response.code == -998)
			{
				alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
				location.href = "/admin/login";
			}
			else if(res.code == 404)
			{
				alert("상품 정보를 찾을 수 없습니다.");
				document.productDetailForm.action = "/admin/productList";
				document.productDetailForm.submit();
			}
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
}

function fn_stockUpdate() {
	
		var form = document.detailForm;
		var url = "/admin/stockUpdate";
		var title = "stock";
		var status = "width=600,height=680,menubar=no,toolbar=no,location=no,status=no,fullscreen=no,scrollbars=no,resizable=yes,top=0,left=0";

		window.open(url, title, status);

		form.productNo.value = <c:out value="${product.productNo}" />;
		form.method = "get";
		form.encoding = "application/x-www-form-urlencoded";
		form.target = title;
		form.action = url;
		form.submit();
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

<div class="container" style="width:1120px;">
	<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #dee2e6;">상품 상세정보</h1>
	<div class="layer-cont">
		<form name="detailForm" id="detailForm" method="post">
			<table>
				<tbody>
					<tr>
						<th scope="row">상품 번호</th>
						<td>
							${product.productNo}
							<input type="hidden" id="productNo" name="productNo" value="${product.productNo}" />
						</td>
						<th scope="row">상품명</th>
						<td>
							<input type="text" id="productName" name="productName" value="${product.productName}" placeholder="상품명" />
						</td>
					</tr>
					<tr>
						<th scope="row">브랜드</th>
						<td>
							<input type="text" id="brandCode" name="brandCode" value="${product.brandCode}" style="font-size:1rem;;" maxlength="100" placeholder="브랜드 코드"/>
						</td>
						<th scope="row">상품 가격</th>
						<td>
							<input type="text" id="productPrice" name="productPrice" value="${product.productPrice}" style="font-size:1rem;;" maxlength="100" placeholder="제품 가격" />		
						</td>
					</tr>
					<tr>
						<th scope="row">상위 카테고리</th>
						<td>
							<input type="text" id="mainCategoryCode" name="mainCategoryCode" value="${product.mainCategoryCode}" style="font-size:1rem;;" maxlength="100" placeholder="상위 카테고리" />
						</td>
						<th scope="row">하위 카테고리</th>
						<td>
							<input type="text" id="subCategoryCode" name="subCategoryCode" value="${product.subCategoryCode}" style="font-size:1rem;;" maxlength="100" placeholder="하위 카테고리" />
						</td>
					</tr>
					<%-- <c:if test="${!empty list}" >
						<c:forEach var="productSize" items="${list}" varStatus="status"> --%>
					<tr>
						<th scope="row">사이즈별 재고</th>
						<td colspan="3">
							<table>
								<tr>
									<th>사이즈</th>
									<th>재고량</th>
								</tr>
								<c:if test="${!empty list}" >
										<c:forEach var="productSize" items="${list}" varStatus="status">
								<tr>
									<td>
									<input type="text" id="sizeName" name="sizeName" value="${productSize.sizeName}" style="font-size:1rem;;" maxlength="100" readonly />
									</td>
									<td>
									<input type="text" id="units" name="units" value="${productSize.units}" style="font-size:1rem;;" maxlength="100" placeholder="재고량"/>
									</td>
								</tr>
									</c:forEach>
								</c:if>
									
							</table>
							<button onclick="fn_stockUpdate()" class="btn-type01"><span>재고수정</span></button>
						</td>
					</tr>
<%-- 						</c:forEach>
					</c:if> --%>
					<tr>
						<th scope="row">판매량</th>
							<td>${product.salesRate}</td>
						<th scope="row">등록 날짜</th>
						<td>${product.productRegDate}</td>
					</tr>
				</tbody>
			</table> 
		</form>
		<div class="pop-btn-area" style="float: right;">
			<button onclick="fn_update()" class="btn-type01"><span>수정</span></button>
			<button onclick="fn_delete()" class="btn-type01"><span>삭제</span></button>
			<button id="btnList" class="btn-type01"><span>리스트</span></button>
		</div>
	</div>
</div>


<form name="productForm" id="productForm" method="get">
	<input type="hidden" name="productNo" value="" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>

</body>
</html>