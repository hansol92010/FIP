<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<link href="/resources/css/myPage/myupdate.css" rel="stylesheet">
	<script>
		$(document).ready(function(){
			$("#btnUpdate").on("click", function(){
				if($.trim($("#userNickname").val()).length <= 0) {
					alert("닉네임을  입력해주세요.");
					return;
				}
				
				if($.trim($("#userPhoneNo").val()).length <= 0) {
					alert("전화번호를 입력해주세요");
					return;
				}
				
				
    			if($.trim($("#userPostcode").val()).length <= 0) {
    				alert("우편번호를 입력해주세요.");
    				$("#userPostcode").focus();
    				return;
    			}
    			
    			if($.trim($("#userDetailAddress").val()).length <= 0) {
    				alert("상세주소를 입력해주세요.");
    				$("#userDetailAddress").focus();
    				return;
    			}
    			
    			var form = $("#_userUpdateForm")[0];
    			var formData = new FormData(form);
				
    			$.ajax({
					type:"POST",
					enctype:"multipart/form-data",
					url:"/myPage/userUpdateProc",
					data:formData,
					processData:false,			
					contentType:false,			
					cache: false,
					beforeSend:function(xhr){
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response){
						if(response.code == 0) {
							alert("변경되었습니다.");
							location.href = "/myPage/userUpdateForm";
						}else if(response.code == -1) {
							alert("변경중 오류가발생했습니다.");
						}else if(response.code == 400) {
							alert("올바른값을 입력해주세요");
						}else if(response.code == -2){
							alert("중복된 닉네임입니다.");
						}else {
							alert("알수없는 오류가 발생했습니다.");
						}
					},
					error:function(xhr, status, error){
						icia.common.error(error);
					}
					
					
				});
			});
		});
		
	</script>
	
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@도로명주소 시작@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("userExtraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("userExtraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("userPostcode").value = data.zonecode;
                document.getElementById("userAddress").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("userDetailAddress").focus();
            }
        }).open();
    }
    
 //파일 업로드전 미리보기
function setThumbnail(event) {
	var reader = new FileReader();

    reader.onload = function(event) {
		var img = document.getElementById('preview_profile_img');
        img.setAttribute("src", event.target.result);
    };

    reader.readAsDataURL(event.target.files[0]);
}
</script>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@도로명 주소 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->	
</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<main>
	<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
        <div class="my_page">
            <div class="my_info">
                <form id="_userUpdateForm" name="_userUpdateForm" method="post" enctype="multipart/form-data">
	                <h1>회원정보 / 변경하기</h1>
	                <div class="my_info_div">
	                <div class="my_img" id="profile_image_container">
	                <img src="/resources/upload/userImage/${user.userId}.jpg" alt="등록된 이미지가 없습니다" id="preview_profile_img" name="preview_profile_img">
	                <label>
					<p class="update_img">사진 수정</p>         
	                <input type="file" id="btn_profile_img_change" name="btn_profile_img_change" accept="image/*" onchange="setThumbnail(event);">
	                </label>
	                
	                </div>
	                
	                <table class="user_info">
	                    <tr>
	                        <td class="td1">아이디</td>
	                        <td><input type="text" id="userId" name="userId" value="${user.userId}" disabled></td>
	                    </tr>
	                    <tr>
	                        <td class="td1">이름</td>
	                        <td><input type="text" id="userName" name="userName" value="${user.userName}" disabled>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="td1">닉네임</td>
	                        <td><input type="text" id="userNickname" name="userNickname" value="${user.userNickname}"></td>
	                    </tr>
	                    
	                    <tr>
	                        <td class="td1">E-mail</td>
	                        <td><input type="text" id="userEmail" name="userEmail" value="${user.userEmail}" disabled>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="td1">전화번호</td>
	                        <td><input type="text" id="userPhoneNo" name="userPhoneNo" value="${user.userPhoneNo}">
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="td1">주소</td>
	                        <td>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@도로명주소 입력창@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->		
								<input type="button" id="btn_postcode" name="btn_postcode" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="userPostcode" name="userPostcode" value="${user.userPostcode}" placeholder="우편번호"><br>
								<input type="text" id="userAddress" name="userAddress" value="${user.userAddress}" placeholder="주소"><br>
								<input type="text" id="userDetailAddress" name="userDetailAddress" value="${user.userDetailAddress}" placeholder="상세주소">
								<input type="text" id="userExtraAddress" name="userExtraAddress" value="${user.userExtraAddress}" placeholder="참고항목">
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@도로명 주소 입력 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->						
	                        </td>
	                    </tr>
	                    </table>
	                </div>
                    <button type="button" id="btnUpdate">변경</button>
                </form>
            </div>
            <div class="my_info2">
            </div>
        </div>
    </main>
    
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>