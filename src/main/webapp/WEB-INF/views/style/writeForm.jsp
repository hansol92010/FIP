<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
		<link rel="stylesheet" href="/resources/css/style/writeForm.css">
		<%@ include file="/WEB-INF/views/include/head.jsp" %>
		<%@ include file="/WEB-INF/views/include/headerNavigation.jsp"%>
		<script type="text/javascript">
			//비어있는지 확인
			$(document).ready(function(){
				$("#sboardTitle").focus();

				$("#btnWrite").on("click", function() {
						$("#btnWrite").prop("disabled", true);
					
			
					if($.trim($("#sboardTitle").val()).length <= 0)
					{
						alert("제목을 입력하세요");
						$("#sboardTitle").val("");
						$("#sboardTitle").focus();
						
						$("#btnWrite").prop("disabled", false);
					
						return;
					}
				
					if($.trim($("#sboardContent").val()).length <= 0)
					{
						alert("내용을 입력하세요");
						$("#sboardContent").val("");
						$("#sboardContent").focus();
						
						$("#btnWrite").prop("disabled", false);  
					
						return;
					}
					
					if($.trim($("#sboardFile").val()).length <= 0)
					{
						alert("첨부파일을 넣으세요.");
						$("#sboardFile").val("");
						$("#sboardFile").focus();
						
						$("#btnWrite").prop("disabled", false);
						
						  
					
						return;
					}
					
					
					var form = $("#writeForm")[0]; 
					var formData = new FormData(form); 
					
					//글쓰기 ajax	
					$.ajax({
						type: "POST",
						enctype: "multipart/form-data",
						url: "/style/writeProc",
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
								$("#sboardNo").val(response.data);
								//스타일 게시글등록 완료후 게시글에 등록된 상품정보 insert AJAX
								$.ajax({
									type:"POST",
									dataType:"JSON",
									url:"/style/styleProInfoInsert",
									data:{
										sboardNo:$("#sboardNo").val(),
										productInfoNo:$("#productInfoNo").val()
									},beforeSend:function(xhr){
										xhr.setRequestHeader("AJAX", "true");
									},
									success:function(response){
										if(response.code == 0) {
											location.href = "/style/styleList";
										}else if(response.code == -1) {
											alert("등록실패");
										}else if(response.code == 400) {
											alert("파라미터값이 올바르지 않습니다");
										}else {
											alert("알수없는 오류가 발생했습니다.");
										}
									},
									error:function(xhr, status, error){
										icia.common.error(error);
									}
								});//스타일게시글 등록후 상품정보 등록 AJAX 끝
							}
							else if(response.code == 400)
							{
								alert("파라미터 값이 올바르지 않습니다.");
								$("#btnWrite").prop("disabled", false);
							}
							else
						    {
								alert("게시물 등록 중 오류가 발생하였습니다.1");
								$("#btnWrite").prop("disabled",false);
								
						    }
						},
						error:function(error)
						{
							icia.common.error(error);
							alert("게시물 등록 중 오류가 발생하였습니다.2");
							$("#btnWrite").prop("disabled", false); 
						}
						
						
					 });
				});
				
				$("#btnCancel").on("click", function() {
					document.bbsForm.action = "/style/styleList";
					document.bbsForm.submit();
				});

			});
			
			function category(brand){
				 document.styleForm.brandCode.value = brand;
				 document.styleForm.action = "/style/writeForm";
				 document.styleForm.submit();
			}
			
			//파일 업로드전 미리보기
			function setThumbnail(event) {
			    var reader = new FileReader();
			
			    reader.onload = function(event) {
			      var img = document.createElement("img");
			      img.setAttribute("src", event.target.result);
			      document.querySelector("div#image_container").appendChild(img);
			    };
			
			    reader.readAsDataURL(event.target.files[0]);
			}
			
			
			function fn_reviewProductSelect() {
				var win = window.open('/style/styleOrderSelect', 'styleOrderSelect', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1000,height=1000,left=100,top=100');
				
			}
			
			function fn_reviewProductImageView(orderProductNoArrList) {
				var productImageArrList = new Array(); 
				productImageArrList = orderProductNoArrList;
				var strDOM = "";
				for(var i=0; i < productImageArrList.length; i++) {
					var productImageArrListes = productImageArrList[i];
					strDOM += '<img src="/resources/upload/productImage/thum/'+ productImageArrListes + '_thum.jpg" style=" width:100px; height:100px; margin-left:30px; margin-top:10px; border: solid 1px grey;">';
				}
				
				var $proImgViewContainerDiv = $("#proImgView-containerDiv");
				$proImgViewContainerDiv.append(strDOM);
				$("#productInfoNo").val(productImageArrList);
			}
		</script>
	</head>

	<body>
		<main>
			<div class="row_div">
				<div class ="img"></div>
				<hr />
				<div class="container">
					<div>
						<h1 style="text-align:center; font-size: 1.6rem;margin-top: 3rem;padding: 0.5rem 0 0.5rem 1rem;background-color: #000000;color: white; width: 100%;">스타일 글쓰기</h1>
					</div>
					<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data"> 
						<div class="">
							<div class="style_view">
								<!-- 프로필 -->
								<div class="style_view_div">
									<!-- 프로필 사진 -->
					 				<div class="profile_img">
										<img src="/resources/upload/userImage/${user.userId}.jpg" class="profile_img">
									</div>
					 				<!-- 프로필 닉네임 -->
									<strong name="userNickName" id="userNickName" class="userNickName" maxlength="20" style="ime-mode:active;" class="form-control mt-4 mb-2"readonly >${user.userNickname} </strong>
								</div>
							</div>
							<div id="image_container" class="image_container"></div>
							<br />
	
						<!--상품선택-->
							<br />
							<div class="fileReal">
								<label class="click_img_label">스타일 사진첨부
								      <input  type="file" id="sboardFile" name="sboardFile" accept="image/*" onchange="setThumbnail(event);"><br><br>
								</label>
							</div>
			          		<br />
				 
							<div class="writeReal">
								<input type="text" name="sboardTitle" id="sboardTitle" maxlength="100" style="ime-mode:active;" class="title" placeholder="제목을 입력해주세요." />
								<div class="form-group">
									<textarea class="content" name="sboardContent" id="sboardContent"  style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
								</div>
							</div>	
	
							<div class="brandCheck">
								<!-- <p class="brand">브랜드</p>   -->
								<p></p>
								<input type="checkbox" id="brandCode" name="brandCode" value="nk"/> 나이키 
								<input type="checkbox" id="brandCode" name="brandCode" value="nb"/> 뉴발란스
								<input type="checkbox" id="brandCode" name="brandCode" value="nf"> 노스페이스
								<input type="checkbox" id="brandCode" name="brandCode" value="mk"> 마뗑킴
								<input type="checkbox" id="brandCode" name="brandCode" value="pl"> 폴로
								<input type="checkbox" id="brandCode" name="brandCode" value="th"> 타미힐피거 
								<input type="checkbox" id="brandCode" name="brandCode" value="dn"> 디스이즈네버댓
								<input type="checkbox" id="brandCode" name="brandCode" value="dm"> 닥터마틴 
								<input type="checkbox" id="brandCode" name="brandCode" value="ae"> 아더에러 
							</div>
	
				     	&nbsp;
						<br />
						<br/>
							<div class="proImgView-container" id="proImgView-containerDiv">          
								<a class="btn my-2 my-sm-0" href="javascript:void(0)" onclick="fn_reviewProductSelect()" style="background-color: black; color: white;">후기 상품 고르기</a>
								<br/>
							</div>
						<br/>
						<br/>
	
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<button type="button" id="btnWrite" class="btn " title="저장">글쓰기</button>
								<button type="button" id="btnCancel" class="btn" title="리스트">취소</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		
			<form name="styleForm" id="styleForm" method="post">
				<input type="hidden" name="brandCode" value="${brandCode}" /> 
				<input type="hidden" name="userId" value="${userId}" /> 
				<input type="hidden" name="sboardNo" id="sboardNo" value="${sboardNo}" />
				<input type="hidden" name="productInfoNo" id="productInfoNo" value="" />
			</form>
			
		</main>
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	</body>
</html>