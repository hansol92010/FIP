<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style>
html, body{
  color:  #525252;
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
 <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
    <link rel="stylesheet" href="/resources/css/main/HF.css">
    <link rel="stylesheet" href="/resources/css/style/stylelist.css">
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <%@ include file="/WEB-INF/views/include/headerNavigation.jsp" %>
<script type="text/javascript" src="/resources/js/colorBox.js"></script>
<script type="text/javascript">

icia.ajax.post({
   url:"/style/adminDelete",
   data:formData,
   success:function(res)
   {
      if(res.code==0)
       {
         alert("삭제되었습니다.");
         colorboxClose(parent.fn_pageInit);
         
       }
      else if(res.code==-1)
      {
         alert("글 삭제 중 오류가 발생하였습니다.");
      }
      else if(res.code==400)
      {
         alert("파라미터 값에 오류가 발생하였습니다.");
      }
      else if(res.code==404)
       {
         alert("글이 없습니다.");
         colorboxClose();
      }
   },
   error:function(xhr, status, error)
   {
      icia.common.error(error);
   }
   
});

function fn_delete(sboardNo) {
   document.adminDelete.sboardNo.value = sboardNo;
   document.adminDelete.action = "/style/styleAdminList";
   document.adminDelete.submit();
  }
</script>

</head>
<body>
   <div class="layerpopup" style="width:1123px; margin:auto; margin-top:5%;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">게시글</h1>
   <div class="layer-cont">
      <form name="adminDelete" id=""adminDelete"" method="post">
         <table>
            <tbody>
               <tr>
                  <th scope="row">아이디</th>
                  <td>
                     ${sboard.userId}
                     <input type="hidden" id="userId" name="userId" value="${user.userId}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">제목</th>
                  <td>
                     <input type="text" id="sboardTitle" name="sboardTitle" value="${sboard.sboardTitle}" style="font-size:1rem;;" maxlength="50" placeholder="제목" />
                  </td>
                  <th scope="row">내용</th>
                  <td>
                     <input type="text" id="sboardContent" name="sboardContent" value="${sboard.sboardContent}" style="font-size:1rem;;" maxlength="50" placeholder="내용" />
                  </td>
               </tr>
               
            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         
         <button onclick="fn_delete()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</body>
</html>