<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
	<head>
	<%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
				$("#btnList").on("click", function() {
					document.noticeForm.action = "/notice/noticeList";
					document.noticeForm.submit();
				});
		});
	</script>
	<style>
		.btn-noticeList{
		    background-color: black;
		    color: white;
		    border-radius: 20px;
		    font-size: 20px;
		    font-family: 'Do Hyeon';
		    width: 8vw;
		    height: 5vh;
		    margin-top: 2vh;
		}
	</style>
	</head>
	<body>
		<c:if test= "${!empty notice}">
		<div class="notice_aLl" style="margin-top: 10vh;">
			<div style="width: 30%; margin-left: 15vw;">
				<h2>공지사항 보기</h2>
			</div>
			<div class="row" style="display: flex; border-top: 3px solid black; width: 70%; margin: auto; justify-content: space-around;">
				<table class="notice-table">
					<thead>
						<tr class="table-active">
							<th scope="col" style="height: 8vh;     background-color: white;">
								<div class="title" style="text-align: left; margin-left: 2vw; text-size: 20px; text-weight: bold;">
								 <c:out value="${notice.nboardTitle}"/>
								</div>
								<div class="titleline" style="margin-top: 7px; display: flex; border-top: 1px solid grey; width: 70vw; justify-content: space-around;">
								</div>
							</th>
							<th scope="col">
								
							</th>
							
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2"><pre style="text-align: center;"><c:out value="${notice.nboardContent}" /></pre></td>
						</tr>
						
					</tbody>
				</table>
			</div>	<!--row 끝 -->
			
			<div style="display:flex; justify-content: center;">
				<!-- 리스트로 가는 버튼 -->
				<button type="button" id="btnList" class="btn-noticeList">목록으로</button>
			</div>
		</div> <!-- notice_aLl 끝 -->
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
		</c:if>
		
		<!-- form -->
		<form name="noticeForm" id="noticeForm" method="post">
			<input type="hidden" name="nboardNo" id="nboardNo" value="${nboardNo}" />
			<input type="hidden" name="searchType" value="${searchType}" />
			<input type="hidden" name="searchValue" value="${searchValue}" />
			<input type="hidden" name="curPage" value="${curPage}" />
		</form>
	</body>
</html>