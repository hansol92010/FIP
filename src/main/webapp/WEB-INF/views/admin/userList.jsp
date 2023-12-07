<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<style>
*, ::after, ::before {
	box-sizing: unset;
}
.table-hover th, td{
	text-align: center;
}

</style>
<script type="text/javascript">
function fn_search()  //
{
	document.searchForm.curPage.value = "1";
	document.searchForm.action = "/admin/userList";
	document.searchForm.submit();
}

function fn_paging(curPage) //페이지 버튼
{
	document.searchForm.curPage.value = curPage;
	document.searchForm.action = "/admin/userList";
	document.searchForm.submit();
}

/* function fn_pageInit() 
{
	$("#searchType option:eq(0)").prop("selected", true);
	$("#searchValue").val("");
	
	fn_search();		
} */

</script>
<body id="user_list">
<%@include file="/WEB-INF/views/include/adHeader.jsp" %>
<div class="container11" style="width:80%; margin:auto; margin-top: 10vh;">
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 검색조건 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2-->
<div class="mnb" style="display:flex; margin-bottom: 1rem; ">
			<h2 style="width: 30%;margin: 0;">회원 리스트</h2>
			<form class="d-flex" name="searchForm" id="searchForm" method="post" style="width: 70%;display: flex;
			    justify-content: flex-end;align-items: flex-end;padding-bottom: 1vh;">
				<select id="userStatus" name="userStatus" style="font-size: 1rem; width: 6rem; height: 2rem; ">
					<option value="">상태</option>
					<option value="Y" <c:if test="${userStatus == 'Y'}">selected</c:if>>정상</option>
					<option value="N" <c:if test="${userStatus == 'N'}">selected</c:if>>정지</option>
				</select>
				<select id="searchType" name="searchType" style="font-size: 1rem; width: 8rem; height: 2rem; margin-left:.5rem; ">
					<option value="">조회 항목</option>
					<option value="1"<c:if test="${searchType == '1'}">selected</c:if> >회원아이디</option>
					<option value="2"<c:if test="${searchType == '2'}">selected</c:if>>회원명</option>
				</select>
				<input name="searchValue" id="searchValue" class="form-control me-sm-2" style="margin-left : 1vh; display: flex; flex-direction: row-reverse; padding-bottom: 1vh;height: 1.4rem;" type="text" value="${searchValue}">
				<button class="btn my-2 my-sm-0" href="javascript:void(0)" onclick="fn_search()" style="width:4rem; height:1.7rem; margin-left:.5rem; font-size: 15px; background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118);">조회</button>
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
		</div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@리스트 보여주는 테이블@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div>
<div class="list_table">
			<table class="table table-hover" >
				<thead>
				<tr class="table-thead-main" style="background-color: #e0e4fe;">
					<th scope="col" style="width: 10%; height: 30px;">아이디</th>
					<th scope="col" style="width: 10%; height: 30px;">이름</th>
					<th scope="col" style="width: 10%; height: 30px;">이메일</th>
					<th scope="col" style="width: 10%; height: 30px;">닉네임</th>
					<th scope="col" style="width: 10%; height: 30px;">전화번호</th>
					<th scope="col" style="width: 30%; height: 30px;">주소</th>
					<th scope="col" style="width: 10%; height: 30px;min-width: 40px;">상태</th>
					<th scope="col" style="width: 10%; height: 30px;">등록일</th>
				</tr>
				</thead>
				<tbody>
			<c:if test="${!empty list}">
				<c:forEach items="${list}" var="user" varStatus="status">	
					<tr>
				    <th scope="row" style="width: 300px; height: 30px; font-size: 20px;"><a href="/admin/userUpdate?userId=${user.userId}">${user.userId}</a></th>
				    <td style="width: 300px; height: 30px; font-size: 20px;">${user.userName}</td>
					<td style="width: 300px; height: 30px; font-size: 20px;">${user.userEmail}</td>
					<td style="width: 300px; height: 30px; font-size: 20px;">${user.userNickname}</td>
					<td style="width: 300px; height: 30px; font-size: 20px;">${user.userPhoneNo}</td>
					<td style="width: 300px; height: 30px; font-size: 20px;">${user.userPostcode} ${user.userAddress} ${user.userDetailAddress} ${userExtraAddress}</td>
					<td style="width: 300px; height: 30px; font-size: 20px;"><c:if test="${user.userStatus == 'Y'}">정상</c:if><c:if test="${user.userStatus == 'N'}">정지</c:if></td>
					<td style="width: 300px; height: 30px; font-size: 20px;">${user.userRegDate}</td>
				</tr>
				</c:forEach>
			</c:if>	
			<c:if test="${empty list}">
				<tr>
				    <td colspan="8">등록된 회원정보가 없습니다.</td>
				</tr>
			</c:if>		
				</tbody>
			</table>		
</div>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@페이징처리@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div class="paging-right" style="text-align:center; margin-top:7px;">
	<!-- 페이징 샘플 시작 -->
	<c:if test="${!empty paging}"> <!-- 페이징이 비어있지 않으면 -->
		<!--  이전 블럭 시작 -->
		<c:if test="${paging.prevBlockPage gt 0}">  <!-- 페이징 객체에 있는 변수, 계산하는거 -->
	
			<button href="javascript:void(0)" class="btn2 btn-primary" onclick="fn_paging(${paging.prevBlockPage})"  title="이전 블럭">이전</button>
		</c:if>
		<!--  이전 블럭 종료 -->
		<span>
		<!-- 페이지 시작 -->
		<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			<c:choose>
				<c:when test="${i ne curPage}">
					<button href="javascript:void(0)"  class="btn2 btn-primary" onclick="fn_paging(${i})" style="font-size:14px;">${i}</button>
				</c:when>	
				<c:otherwise>
					<h class="btn2 btn-primary" style="font-size:20px; font-weight:bold;">${i}</h>
				</c:otherwise>	
			</c:choose>		
		</c:forEach>
		<!-- 페이지 종료 -->
		</span>
		<!--  다음 블럭 시작 -->
		<c:if test="${paging.nextBlockPage gt 0}">
			<button href="javascript:void(0)"  class="btn2 btn-primary" onclick="fn_paging(${paging.nextBlockPage})" title="다음 블럭">다음</button>
		</c:if>
		<!--  다음 블럭 종료 -->
	</c:if>
	<!-- 페이징 샘플 종료 -->
	</div>
  </div>
 </div>
</body>
</html>