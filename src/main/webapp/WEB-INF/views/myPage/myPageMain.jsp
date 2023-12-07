<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="/resources/css/myPage/mypageMain.css" rel="stylesheet">
</head>
<body>
<%@include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<main>
<%@include file="/WEB-INF/views/include/myPageNavigation.jsp" %>
	  <div class="my_page">
	    <div class="my_div">
	      <table>
	        <tr>
	          <td class="user_img"><img id="userImg" src="/resources/upload/userImage/${user.userId}.jpg"></td>
	           <td id="userNickname">${user.userNickname}의 프로필</td><br />
	           <td id="userEmail">${user.userEmail}</td>
	        </tr>
	      </table>
	     </div>
	  </div>
	</main>
		<form name="userInfo" id="userInfo" method="post">
			<input type="hidden" name="userId" value="${user.userId}">
		</form>
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>