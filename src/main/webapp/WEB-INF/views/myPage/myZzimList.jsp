<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/zzim.css">
    <link rel="stylesheet" href="/resources/css/myPage/myZzim.css">
<%@include file="/WEB-INF/views/include/head.jsp" %>      
<script type="text/javascript">    

//상품 상세 페이지로 이동
function fn_detail(productNo) {
	document.productForm.productNo.value = productNo;
	document.productForm.action = "/shop/detail";
	document.productForm.submit();
}

//선택 삭제
function deleteZzim(productNo) {
	if(confirm("상품을 삭제하시겠습니까?")==true)
	{		
		//찜 삭제버튼 누르면
		$.ajax({
			type:"POST",
			url:"/myPage/deleteZzim",
			data:{
				productNo:productNo
			},
			dataType:"JSON",
			beforeSend:function(xhr){
		   		xhr.setRequestHeader("AJAX", "true");
		   	},
		   	success:function(response)
		   	{
		   		if(response.code == 0)
		   		{
	   				alert("선택한 상품이 삭제되었습니다.");
		   			location.href = "/myPage/myZzimList";
		   		}	
		   		else if(response.code == 404)
		   		{
		   			alert("상품을 찾을 수 없습니다.");
		   		}
		   		else if(response.code == 400)
		   		{
		   			alert("찜 목록에 상품이 존재하지 않습니다");
		   		}
		   		else
		   		{
		   			alert("찜 삭제 중 오류가 발생하였습니다.");
		   		}	
		   	},
		   	error:function(xhr, status, error)
		   	{
		   		icia.common.error(error);
		   	}
		});
	}	
};    
    
</script>    
    

</head>
<body>
	<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
    <main>
	<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
        <div class="my_zzim">
            <h1>나의 찜 목록</h1>

            <table class="zzim_tbl">
                <tr class="zzim_thead">
                    <td>사진</td>
                    <td>상품명</td>
                    <td>금액</td>
                    <td>관리</td>
                </tr>
                
                
  <!-- @@@@@@@@@@@@여기서부터 반복@@@@@@@@@@@@@@@ -->
  	<c:if test="${!empty list}">
		<c:forEach var="zzimList" items="${list}" varStatus="status">
    
                <tr class="zzim_tr">
                    <td class="myzzim_div">   
                       
                            <img class="myzzim_img" src="/resources/upload/productImage/thum/${zzimList.productNo}_thum.jpg" onclick="fn_detail('${zzimList.productNo}')">
                        
                    </td>
                    <td  class="zzim_title"><span class="zzim_name">${zzimList.productName}</span></td>
                    <td class="zzim_pay">${zzimList.productPrice}</td>
                    <td>
                        <button class="zzim_btn"  onclick="deleteZzim('${zzimList.productNo}') /myPage/deleteZzim여기로  ">찜 취소</button>
                    </td>
                </tr>
         </c:forEach>
    </c:if>
    <c:if test="${empty list}">
				<tr>
				    <td colspan="4">찜한 상품이 존재하지 않습니다.</td>
				</tr>
	</c:if>		
                
  <!-- @@@@@@@@@@@@@@@@반복 끝 @@@@@@@@@@@@@@@@@@@2-->
            </table>   

        </div>
    </main>
    
    
<!-- 상세 상품 불러오기 -->
	<form name="productForm" id="productForm" method="post">
		<input type="hidden" name="productNo" value="${productNo}" /> 
	</form>  
	<%@include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>