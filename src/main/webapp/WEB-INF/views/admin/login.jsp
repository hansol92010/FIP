<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
<%@include file="/WEB-INF/views/resources/css/admin/login.css" %>
</style>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btn-login").on("click", function(){
			fn_loginCheck();
		
		});
		
		/*
		$("#btn-reg").on("click", function(){
		location.href="/user/regForm";
		})
		*/
	});
	
//관리자 로그인 체크 함수	
function fn_loginCheck(){
	
	if($.trim($("#adminId").val()).length <= 0) {
		alert("아이디는 필수입력사항 입니다.");
		$("#adminId").focus();
		return;
	}
	
	if($.trim($("#adminPwd").val()).length <= 0) {
		alert("비밀번호는 필수입력사항 입니다.");
		$("#adminPwd").focus();
		return;
	}
	
	$.ajax({
		type: "POST",
		url: "/admin/loginProc",
		data:{
			adminId:$("#adminId").val(),
			adminPwd:$("#adminPwd").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0) {
				location.href = "/admin/userList";
			}else if(response.code == -1) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#adminPwd").val("");
				$("#adminPwd").focus();
			}else if(response.code == 400) {
				alert("로그인 시도 중 오류가 발생했습니다.");
				$("#adminId").val("");
				$("#adminPwd").val("");
				$("#adminId").focus();
			}else if(response.code == 404) {
				alert("아이디가 존재하지 않습니다.");
				$("#adminId").val("");
				$("#adminPwd").val("");
				$("#adminId").focus();
			}else if(response.code == -998) {
				alert("로그아웃합니다. 관리자 아이디로 로그인하세요");
				location.href = "/admin/login";
			}else if(response.code == -999) {
				alert("관리자 로그인이 필요합니다");
				location.href = "/admin/login";
			}else{
				alert("알수 없는 오류가 발생했습니다.");
			}
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
	});
};	
</script>
<body>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
	   <main>
            <div class="login-back">
                <div class="login">
                    <h2 class="login-title"></h2>
                    <label for="adminId">아이디 <div><span id="idCheck-span" style="font-size:12px;"></span></div></label>
                    <br/>
                    <input type="text" id="adminId" name="adminId" placeholder="아이디">
                    <br/>
                    <label for="adminPwd">비밀번호<div><span id="passwordCheck-span" style="font-size:12px;"></span></div></label>
                    <br/>
                    <input type="password" id="adminPwd" name="adminPwd" placeholder="비밀번호">
                    <br/>
                    <button type="button" id="btn-login">로그인</button>
                </div>
            </div>
    	</main>
</body>
</html>