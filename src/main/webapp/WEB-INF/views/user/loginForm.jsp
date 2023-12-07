<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="/WEB-INF/views/include/head.jsp" %>
		<style>
		<%@include file="/WEB-INF/views/resources/css/user/loginForm.css" %>
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#btn-login").on("click", function(){
					fn_loginCheck();
				});
				
				$("#btn-reg").on("click", function(){
					location.href="/user/regForm";
				})
				
				$("#userId").keydown(function(e){
					$("#idCheck-span").text("");
				});
				
				$("#userPwd").keydown(function(e){
					$("#passwordCheck-span").text("");
				});
			});
			
			//로그인 체크 함수	
			function fn_loginCheck(){
				
				if($.trim($("#userId").val()).length <= 0) {
					alert("아이디는 필수입력사항 입니다.");
					$("#userId").focus();
					return;
				}
				
				if($.trim($("#userPwd").val()).length <= 0) {
					alert("비밀번호는 필수입력사항 입니다.");
					$("#userPwd").focus();
					return;
				}
				
				$.ajax({
					type: "POST",
					url: "/user/login",
					data:{
						userId:$("#userId").val(),
						userPwd:$("#userPwd").val()
					},
					datatype:"JSON",
					beforeSend:function(xhr){
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response){
						if(response.code == 0) {
							location.href = "/main/index";
						}else if(response.code == -1) {
							$("#passwordCheck-span").text("비밀번호가 일치하지않습니다.");
							$("#passwordCheck-span").css("color","red");
							$("#userPwd").val("");
							$("#userPwd").focus();
						}else if(response.code == 400) {
							alert("로그인 시도중 오류가 발생했습니다.");
							$("#userId").val("");
							$("#userPwd").val("");
							$("#userId").focus();
						}else if(response.code == 404) {
							$("#idCheck-span").text("존재하지않는 아이디입니다.");
							$("#idCheck-span").css("color","red");
							$("#userId").val("");
							$("#userPwd").val("");
							$("#userId").focus();
						}else if(response.code == 500) {
							alert("이미 로그인 되어있습니다. 로그아웃합니다");
							location.href = "/index";
						}else {
							alert("알수 없는 오류가 발생했습니다.");
						}
					},
					error:function(xhr, status, error){
						icia.common.error(error);
					}
				});
			};	
		</script>
	</head>
	
	<body>
		<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
		<main>
			<div class="login-back">
			<div class="login">
				<h2 class="login-title"></h2>
				<label for="userId">아이디 <div><span id="idCheck-span" style="font-size:12px;"></span></div></label>
				<br/>
				<input type="text" id="userId" name="userId" placeholder="아이디">
				<br/>
				<label for="userPwd">비밀번호<div><span id="passwordCheck-span" style="font-size:12px;"></span></div></label>
				<br/>
				<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호">
				<br/>
				<button type="button" id="btn-login">로그인</button>
				<button type="button" id="btn-reg">회원가입</button>
			</div>
			</div>
		</main>
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	</body>
</html>