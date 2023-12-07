<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
.layerpopup
{
	  flex-direction: row;
  margin-top: 10px;
  width: 80%;
  margin: auto;
  margin-right: 150px;
  margin-left: 170px;
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
  background-color: #e0e4fe;
}
html, body{
  color:  #525252;
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
<script type="text/javascript" src="/resources/js/colorBox.js"></script>
<script type="text/javascript">

function goBack()  //목록으로 가기 버튼
{  
	location.href="/admin/userList";
}

function fn_userUpdate() //수정버튼
{
	
	if(icia.common.isEmpty($("#userName").val()))
	{
		alert("이름을 입력하세요.");
		$("#userName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#userNickname").val()))
	{
		alert("닉네임을 입력하세요.");
		$("#userNickname").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#userEmail").val()))
	{
		alert("이메일을 입력하세요.");
		$("#userEmail").focus();
		return;
	}
	
	if(!fn_validateEmail($("#userEmail").val()))
	{
		alert("이메일 형식이 올바르지 않습니다.");
		$("#userEmail").focus();
		return;	
	}

	if(icia.common.isEmpty($("#userPhoneNo").val()))
	{
		alert("전화번호를 입력하세요.");
		$("#userPhoneNo").focus();
		return;
	}

	if(icia.common.isEmpty($("#userPostcode").val()))
	{
		alert("우편번호를 입력하세요.");
		$("#userPostCode").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#userDetailAddress").val()))
	{
		alert("상세주소를 입력하세요.");
		$("#userDetailAddress").focus();
		return;
	}

	if(!confirm("회원정보를 수정하시겠습니까?"))
	{
		return;   //취소면 프로그램 끝내버려
	}
	
	var formData = {
		userId: $("#userId").val(),	
		userName: $("#userName").val(),
		userNickname: $("#userNickname").val(),
		userEmail: $("#userEmail").val(),
		userPhoneNo: $("#userPhoneNo").val(),
		userAddress: $("#userAddress").val(),
		userPostcode: $("#userPostcode").val(),
		userDetailAddress: $("#userDetailAddress").val(),
		userExtraAddress: $("#userExtraAddress").val(),
		userStatus: $("#userStatus").val()
	};
	
	icia.ajax.post({
		url: "/admin/userUpdateProc",
		data: formData,
		success: function(res)
		{
			if(res.code == 0)
			{
				alert("회원정보가 수정 되었습니다.");
				location.href="/admin/userList";
			}		
			else if(res.code == -1)
			{
				alert("회원정보 수정 중 오류가 발생하였습니다.");
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
				alert("회원정보가 없습니다.");
			}	
		},
		error: function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
}

function fn_validateEmail(value)
{
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	
	return emailReg.test(value);
}

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
</script>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@도로명 주소 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@회원정보수정 타이틀@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
<div class="layerpopup" style="width:1123px; margin:auto; margin-top:5%; text-align : center;">
	<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">회원정보 수정</h1>
	<div class="layer-cont">
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@회원정보 폼 테이블@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	<div style="margin-left:auto;margin-right:auto;">
		<form name="regForm" id="regForm" method="post">
			<table >
				<tbody>
					<tr>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">아이디</th>
						<td style="width: 300px; height: 30px; font-size: 20px;">${user.userId}<input type="hidden" id="userId" name="userId" value="${user.userId}" style="width: 300px; height: 30px; font-size: 20px;"/></td>
						<th scope="row"style="width: 300px; height: 30px; font-size: 20px;">이름</th>
						<td style="width: 300px; height: 30px; font-size: 20px;"><input type="text" id="userName" name="userName" value="${user.userName}"  placeholder="이름" /></td>
					</tr>
					<tr>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">닉네임</th>
						<td style="width: 300px; height: 30px; font-size: 20px;"><input type="text" id="userNickname" name="userNickname" value="${user.userNickname}" style="width: 300px; height: 30px; font-size: 20px;" maxlength="50" placeholder="닉네임" /></td>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">이메일</th>
						<td style="width: 300px; height: 30px; font-size: 20px;"><input type="text" id="userEmail" name="userEmail" value="${user.userEmail}" style="width: 300px; height: 30px; font-size: 20px;" maxlength="50" placeholder="이메일" /></td>
					</tr>
					<tr>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">전화번호</th>
						<td style="width: 300px; height: 30px; font-size: 20px;"><input type="text" id="userPhoneNo" name="userPhoneNo" value="${user.userPhoneNo}" style="width: 400px; height: 30px; font-size: 20px;" maxlength="50" placeholder="전화번호" /></td>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">주소</th>
						<td style="width: 300px; height: 30px; font-size: 20px;">
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@도로명주소 입력창@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->		
						<input type="text" id="userPostcode" value="${user.userPostcode}" placeholder="우편번호">
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="userAddress" value="${user.userAddress}" placeholder="주소"><br>
						<input type="text" id="userDetailAddress" value="${user.userDetailAddress}" placeholder="상세주소">
						<input type="text" id="userExtraAddress" value="${user.userExtraAddress}" placeholder="참고항목">
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@도로명 주소 입력 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->						
						
						</td>
					</tr>	
					<tr>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">상태</th>
						<td style="width: 300px; height: 30px; font-size: 20px;">
							<select id="userStatus" name="userStatus" style="width: 300px; height: 30px; font-size: 20px;">
								<option value="Y" <c:if test="${user.userStatus == 'Y'}">selected</c:if>>정상</option>
								<option value="N" <c:if test="${user.userStatus == 'N'}">selected</c:if>>정지</option>
							</select>
						</td>
						<th scope="row" style="width: 300px; height: 30px; font-size: 20px;">등록일</th>
						<td style="width: 300px; height: 30px; font-size: 20px;">${user.userRegDate}</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
		
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@수정 삭제 버튼@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->		
		<div class="pop-btn-area" style="text-align : center; margin-top:20px;">
			<button onclick="fn_userUpdate()" class="btn-type01"><span>수정</span></button>
			<button onclick="goBack()" id="userUpdateClose" class="btn-type01" style="margin-left: 1rem;"><span>목록으로</span></button>
		</div>
	</div>
</div>


</body>
</html>