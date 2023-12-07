<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<link href="/resources/css/myPage/myout.css" rel="stylesheet">
	<script>
		$(document).ready(function(){
			
			$("#userDelete").on("click",function(){
				if($.trim($("#userPwd").val()).length <= 0) {
					alert("삭제를 하려면 패스워드를 입력해주세요");
					return;
				}
				
				$.ajax({
					type:"POST",
					url:"/myPage/userDeleteProc",
					data:{
						userPwd:$("#userPwd").val()
					},
					beforeSend:function(xhr){
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response){
						if(response.code == 0) {
							alert("회원탈퇴가 완료되었습니다.");
							location.href = "/main/index";
						}else if(response.code == 404) {
							alert("비밀번호가 일치하지 않습니다.");
						}else if(response.code == -1) {
							alert("요청이 실패했습니다.");
						}else if(response.code == 400) {
							alert("파라미터값이 올바르지않습니다.");
						}
					},
					error:function(xhr, status, error){
						icia.common.error(error);
					}
				});
				
			});
			
		});
	</script>
</head>
<body>
	<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
	<main>
        <div class="out_page">
            <div>
                <h1>탈퇴를 하게 될 시 고객님의 개인 정보 및 이메일,<br/>
                    구매 내역 및 스타일 이력 등 개인형 서비스 이용 기록은 모두 삭제됩니다.</h1>
                <p>탈퇴를 원하신다면 비밀번호를 입력하십시오.</p>
                <input type="password" id="userPwd">
                <button type="button" id="userDelete">확인</button>
            </div>
        </div>
    </main>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>