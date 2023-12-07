<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	 <head>
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
		<%@ include file="/WEB-INF/views/include/head.jsp" %>
		<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
		<link rel="stylesheet" href="/resources/css/style/styleview.css" />
		<script type="text/javascript">
			
			//브랜드별 조회
			function category(brand){
				document.styleForm.brandCode.value = brand;
				document.styleForm.action = "/style/styleList";
				document.styleForm.submit();
			}
			
			//상세페이지에서 상품이미지 누를시 해당 상품상세페이지로 이동
			function shopDetail(productNo)
			{
				document.productForm.productNo.value = productNo;
				document.productForm.action = "/shop/detail";
				document.productForm.submit();
			}
		   
			//좋아요 누르기 전
			function beforeLike(){
				var form = $("#likeForm")[0];   //폼 아이디 이용 0번째에 대입
				var formData = new FormData(form);  //폼태그를 객체에 담아
				
				$.ajax({
					type:"POST",
					enctype:"multipart/form-data",
			    	url:"/style/likeProc",
			    	data:formData,
			    	processData:false,						//formData를 string으로 변환하지 않음
			    	contentType:false,						//content-type헤더가 multipart/form-data로 전송
			    	cache:false,
			    	beforeSend:function(xhr){
			    		xhr.setRequestHeader("AJAX", "true");
			    	},
			    	success:function(response)
		  	    	{
			    		if(response.code == 0)
		  	    		{
		  	    			document.likeForm.action="/style/styleView";
		  	    			document.likeForm.submit();
		  	    		}
		  	    		
		  	    		else if(response.code == 400)
		  	    		{
		  	    			alert("로그인이 필요합니다.");
		  	    			document.likeForm.action="/user/loginForm";
		  	    			document.likeForm.submit();
		  	    		}
		  	    		
		  	    		else if(response.code == 500)
		  	    		{
		  	    			alert("오류가 발생하였습니다.");
		  	    			document.likeForm.action="/user/styleView";
		  	    			document.likeForm.submit();
		  	    		}
		  	    		
		  	    		else
		  	    		{
		  	    			alert("오류가 발생하였습니다.");
		  	    			document.likeForm.action="/user/styleList";
		  	    			document.likeForm.submit();
		  	    		}
		  			}
		  		});
			}
			
			//좋아요 누르기 후
			function afterLike(){
		  		var form = $("#likeForm")[0];   //폼 아이디 이용 0번째에 대입
				var formData = new FormData(form);  //폼태그를 객체에 담아서 보낼거야
				
				$.ajax({
					type:"POST",
					enctype:"multipart/form-data",
			    	url:"/style/likeProc",
			    	data:formData,
			    	processData:false,						//formData를 string으로 변환하지 않음
			    	contentType:false,						//content-type헤더가 multipart/form-data로 전송
			    	cache:false,
			    	beforeSend:function(xhr){
			    		xhr.setRequestHeader("AJAX", "true");
			    	},
			    	success:function(response)
		  	    	{
			    		if(response.code == 0)
		  	    		{
		  	    			document.likeForm.action="/style/styleView";
		  	    			document.likeForm.submit();
		  	    		}
		  	    		
		  	    		else if(response.code == 400)
		  	    		{
		  	    			alert("로그인이 필요합니다.");
		  	    			document.likeForm.action="/user/loginForm";
		  	    			document.likeForm.submit();
		  	    		}
		  	    		
		  	    		else if(response.code == 500)
		  	    		{
		  	    			alert("오류가 발생하였습니다.");
		  	    			document.likeForm.action="/user/styleView";
		  	    			document.likeForm.submit();
		  	    		}
		  	    		
		  	    		else
		  	    		{
		  	    			alert("오류가 발생하였습니다.");
		  	    			document.likeForm.action="/user/styleList";
		  	    			document.likeForm.submit();
		  	    		}
		  			}
		  		});
			}
			
			//댓글 삭제  
			function styleReplyDelete(val)
			{
			   if(confirm("댓글을 삭제 하시겠습니까?") == true)
			   {   
			      
			      //ajax
			      $.ajax({
			         type:"POST",
			         url:"/style/styleReplyDelete",
			         data:{
			            	sboardCommentNo:val
			         },
			         datatype:"JSON",
			         
			         beforeSend:function(xhr){
			            xhr.setRequestHeader("AJAX","true");
			         },
			         success:function(response)
			         {
			            if(response.code == 0)
			            {
			               alert("댓글이 삭제 되었습니다.");
			               document.replyForm.action="/style/styleView";
			               document.replyForm.submit();
			            }
			            else if(response.code == 500)
			            {
			               alert("댓글 삭제 중 오류가 발생했습니다.");
			               document.replyForm.action="/style/styleView";
			               document.replyForm.submit();
			            }
			            else if(response.code == 400)
			            {
			               alert("댓글 작성자가 아닙니다.");
			               document.replyForm.action="/style/styleView";
			               document.replyForm.submit();
			            }
			            else
			            {
			               alert("시스템 오류가 발생하였습니다.");
			            }
			         },
			         error: function(xhr,status,error)
			         {
			            icia.common.error(error);
			         }
			      });
			      
			   }
			}

		   $(document).ready(function() {
			
				$("#btnList").on("click",function() {
					location.href="/style/styleList";
				})

			<c:choose>
				<c:when test="${empty sboard}">
				alert("조회하신 게시물이 존재하지 않습니다.");
				document.styleForm.action="/style/styleList";
				document.styleForm.submit();
				</c:when>

				<c:otherwise>
		   			<c:if test="${boardMe eq 'Y'}">
				$('#stylebtnUpdate').on("click", function() {
					document.styleForm.action="/style/styleUpdateForm";
					document.styleForm.submit();
				});
		   		
		   		$("#stylebtnDelete").on("click", function() {
		   			if(confirm("게시물을 삭제 하시겠습니까?") == true)
		   			{
		   				
		   				$.ajax({
		   					type:"POST",
		   					url:"/style/styleDelete",
		   					data:{
		   						sboardNo:<c:out value="${sboard.sboardNo}" />
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
		   							location.href = "/style/styleList";
		   							
		   						}
		   						else if(response.code == 400)
		   						{
		   							alert("파라미터 값이 올바르지 않습니다.");
		   						}
		   						else if(response.code == 404)
		   						{
		   							alert("게시물을 찾을 수 없습니다.");
		   							location.href = "/style/styleList";
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
		    		</c:if>
		    	</c:otherwise>
			</c:choose>
		  
		  		//댓글
				 $("#btnReply").on("click", function() { 
			 		var form = $("#replyForm")[0];   //폼 아이디 이용 0번째에 대입
					var formData = new FormData(form);  //폼태그를 객체에 담아서 보낼거야
				
					$.ajax({
						type:"POST",
						enctype:"multipart/form-data",
				    	url:"/style/styleReplyWriteProc",
				    	data:formData,
				    	processData:false,						//formData를 string으로 변환하지 않음
				    	contentType:false,						//content-type헤더가 multipart/form-data로 전송
				    	cache:false,
				    	beforeSend:function(xhr){
				    		xhr.setRequestHeader("AJAX", "true");
				    	},
				    	success:function(response)
				    	{
				    		if(response.code == 0)
				    		{
				    			document.replyForm.action="/style/styleView";
				    			document.replyForm.submit();
				    		}
				    		else if(response.code == 400)
				    		{
				    			alert("로그인이 필요합니다.");
				    			document.replyForm.action="/user/loginForm";
				    			document.replyForm.submit();
				    		}
				    		else
				    		{
				    			alert("댓글이 등록 중 오류가 발생하였습니다.");
				    			$("#btnReply").prop("disabled", false);
				    			
				    		}
				    	},
				    	error:function(error)  //500번대 오류는 여기로
				    	{
				    		icia.common.error(error);
				    		alert("댓글을 작성해주세요");
				    		$("#btnReply").prop("disabled", false);		//저장 버튼 활성화
				    	}
					});
				});
		 	}); 
		</script>
	</head>
	
	<body>
  		<!--스타일 헤더 (브랜드 옵션 박스) -->
   		<nav>
			<div class="style_nav">
				<div class="style_brand">
					<!-- 브랜드 별 태그 -->
					<a class="category_Menu" href="javascript: category('nk');">#나이키</a>
					<a class="category_Menu" href="javascript: category('nf');">#노스페이스</a>
					<a class="category_Menu" href="javascript: category('mk');">#마뗑킴</a>
					<a class="category_Menu" href="javascript: category('pl');">#폴로</a>
					<a class="category_Menu" href="javascript: category('th');">#타마힐피거</a>
					<a class="category_Menu" href="javascript: category('dn');">#디스이즈네버댓</a>
					<a class="category_Menu" href="javascript: category('dm');">#닥터마틴</a>
					<a class="category_Menu" href="javascript: category('ae');">#아더에러</a>
					<a class="category_Menu" href="javascript: category('ae');">#뉴발란스</a>
				</div>
			</div>
    	</nav>

		<div class="st_btn">
	<c:if test="${!empty sboard}">
		<c:if test="${boardMe eq 'Y'}">  <!-- 내 글일때(수정,삭제)-->
			<div class="btn_style_button">
				<button type="button" id="stylebtnDelete" class="btn_style_Delete">삭제</button>
			</div>
		</c:if>
	</c:if>
			<div>
				<!-- 리스트로 돌아가는 버튼 -->
				<button type="button" id="btnList" class="style_btn_list">목록으로</button>
			</div>
		</div>

		<!--스타일 상세 화면-->
		<div class="style_view_main">
			<div class="style_view">
	    		<!-- 프로필 -->
				<div class="style_profile">
		    		<!-- 프로필 사진 -->
					<div class="profile_img">
						<img src="/resources/upload/userImage/${sboard.userId}.jpg" class="profile_img">
					</div>
					<!-- 프로필 닉네임 -->
					<div class="profile_user_info">
						<p class="profile_user_NickName">${sboard.userNickName}</p>
						<!-- 좋아요 버튼 -->
	 					<div class="btn_like">
						<c:choose>
							<c:when test="${empty list2}">
							<button type="button" class="btn_like_after" id="btn_like" onclick="beforeLike()"><img class="btn_like" src="/resources/upload/styleImage/like/before.png" />${sboard.likeCount}개</button>
			 				</c:when>
			 				<c:otherwise>
			 			 	<button type="button" class="btn_like_after" id="btn_like" onclick="afterLike()"><img class="btn_like" src="/resources/upload/styleImage/like/after.png" />${sboard.likeCount}개</button>
				        	</c:otherwise>
						</c:choose>
						</div>
					</div>
				</div>
				
				<!-- 스타일 사진 -->
				<div class="style_view_img">
					<img class="view_main_img" src="/resources/upload/styleImage/thum/${sboard.sboardNo}.jpg">
				</div>
			</div>

			<!-- 게시물 제목, 내용 -->	 
	    	<div class="sboard_info_div">
			    <p class="sboardTitle"><c:out value="${sboard.sboardTitle}" /></p>
			   	<p class="sboardContent"><c:out value="${sboard.sboardContent}" /></p>
	    	</div>
	    
	     	<!-- 상품 상세-->
	    	<div class="shop_detail">
	        	<!-- 상품사진 -->
	        	<p class="shop_font">상품태그</p>
	        	<div class= "shop_detial_all">
	        		<div class="item_img_div">
		        <c:if test="${!empty listpro}">
			        <c:forEach var="proInfo" items="${listpro}">
				        <div>
					        <a class="shop_detail_img">
					        	<img class="shop_detail_img" src="/resources/upload/productImage/thum/${proInfo.productNo}_thum.jpg" onclick="shopDetail(${proInfo.productNo})"/>
								<div class="item_name">
					    			<p class="shop_detail_no"> ${proInfo.productName}</p>
								</div>
					    	</a>
				        </div>
			    	</c:forEach>
		    	</c:if>
	        		</div>
	        	</div>
	   		</div>
	   		
	    	<br><br><Br>

	    	<!-- 댓글 -->
			<div class="reply-main">
		<c:if test = "${!empty list}">
			<c:forEach var="sboardComment" items="${list}" varStatus="status">
				<div class="reply_all">
					<div class="style-main">
						<div class="reply_profile">
							<input type="hidden" value="${sboardComment.sboardNo}" id="sboardNo" name="sboardNo">
							<div class="reply_profile_img">
								<img src="/resources/upload/userImage/${sboardComment.commentUserId}.jpg">
							</div>
							<div class="reply-writer"><strong>${commentUser[status.index].userNickname} </strong></div>
							<div class="reply-content">${sboardComment.commentContent}</div>
						</div>
					<c:if test="${sboardComment.commentUserId eq cookieUserId}">
						<div class="style_Reply_Delete">
							<button type="button" id="Reply_Delete" class="Reply_Delete" style= "float:right;" onclick="styleReplyDelete(${sboardComment.sboardCommentNo})">
								<img class="btn_delete" src="/resources/upload/styleImage/delete/delete.png" />
							</button>
						</div>
                    </c:if>
                    </div>
				</div>
			</c:forEach>
		</c:if>
			</div>
		
			<!--브랜드 코드-->
			<form name="styleForm" id="styleForm" method="post">
				<input type="hidden" name="sboardNo" value="${sboardNo}" />
				<input type="hidden" name="brandCode" value="${brandCode}" /> 
			</form>
	
			<!--댓글 -->
			<div class="btn_Reply">
				<form name="replyForm" id="replyForm" method="post">
					<input type="hidden" name="sboardNo" value="${sboardNo}" />
					<input type="hidden" name="sboardCommentNo" value="${sboardCommentNo}" />
					<input type="hidden" name="commentUserId" value="${commentUserId}" />
					<textarea id="commentContent" name="commentContent" class="commemtContent" placeholder="댓글을 남겨주세요:) "></textarea>
				</form>
				<div class="reply-write_btn">
			         <button type="button" id="btnReply" class="reply_write_button">댓글남기기</button>
			    </div>
			</div>

		    <!-- 좋아요 폼 -->
			<form name="likeForm" id="likeForm" method="post">
				<input type="hidden" name="sboardNo" value="${sboardNo}" />
				<input type="hidden" name="userId" value="${sboard.userId}" /> 
			</form>
			
			<!-- 상세 상품 불러오기 -->
			<form name="productForm" id="productForm" method="post">
				<input type="hidden" name="productNo" value="${productNo}" /> 
			</form>
		</div>
		<br><br>
 		<%@ include file="/WEB-INF/views/include/footer.jsp" %>	
	</body>
</html>
