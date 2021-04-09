<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /webapp/WEB-INF/view/board/write.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript">
function inputcheck() {
   f = document.f;
   if(f.title.value==""){
      alert("제목을 입력하세요");
      f.title.focus();
      return;
   }
   if(f.man.value==""){
      alert("차종을 선택해주세요");
      f.man.focus();
      return;
   }
   if(f.con.value=""){
      alert("내용을 입력하세요");
      f.con.focus();
      return;
   }
   
   f.submit();
}
</script>
<style type="text/css">
.BaseButton--skinGray {
   border: 1px solid var(- -skinBaseButtonDefaultBorder);
   background: white;
   color: var(- -skinBaseButtonDefaultColor);
}

.button--green {
   border: 0px solid var(- -skinBaseButtonDefaultBorder);
   background: rgba(3, 199, 90, 0.12);
   color: #009f47;
}

.BaseButton {
   display: inline-block;
   border-radius: 6px;
   box-sizing: border-box;
   font-weight: 700;
   text-align: center;
   vertical-align: top;
   outline: none;
   cursor: pointer;
   border: 0;
}

a.button {
   -webkit-appearance: button;
   -moz-appearance: button;
   appearance: button;
}

a {
   text-decoration: none
}

input.submitLink {
   background-color: transparent;
   border: none;
   text-decoration: none;
   cursor: pointer;
   outline: none;
}
</style>
</head>
<body>
<form:form modelAttribute="board" action="write.shop"
   enctype="multipart/form-data" name="f">
<input type="hidden" name="btype" value="${param.btype}">
<input type="hidden" name="id" value="${sessionScope.loginUser.id}">
   <table>
   <c:if test="${sessionScope.loginUser.id == 'admin'}">
      <tr><td>제목</td><td><input type="text" name ="title" class="w3-input w3-border" value="[공지사항] "></td></tr>
   </c:if>
   <c:if test="${sessionScope.loginUser.id != 'admin'}">
      <tr><td>제목</td><td><input type="text" name ="title" class="w3-input w3-border"></td></tr>
   </c:if>
      
    <tr><td>차종 구분</td><td>   
         <input type="radio" name="man" value="1" />현대
         <input type="radio" name="man" value="2" />기아
         <input type="radio" name="man" value="3" />르노삼성
         <input type="radio" name="man" value="4" />BMW
         <input type="radio" name="man" value="5" />한국GM
         <input type="radio" name="man" value="6" />한불모터스
         <input type="radio" name="man" value="7" />테슬라
         <input type="radio" name="man" value="8" />재규어
         <input type="radio" name="man" value="9" />벤츠코리아
         <input type="radio" name="man" value="10" />쎄미시스코
         <input type="radio" name="man" value="11" />기타

         </td></tr>  
      
   <tr><td>내용</td><td><textarea id="con" name="con" rows="15" cols="80"></textarea>
   <script>CKEDITOR.replace("con",{
      filebrowserImageUploadUrl : "imgupload.shop" }); </script>
   </td></tr>
   <tr><td>첨부파일</td><td><input type="file" name="file1"></td></tr>
   
   <!-- 
   <tr><td>내용</td><td><textarea rows="15" name ="con"
   id="con" class="w3-input w3-border"></textarea></td></tr>
      <script>CKEDITOR.replace("con",{
         filebrowserImageUploadUrl : "imgupload.shop"
      })</script>
<tr><td>첨부파일</td><td><input type="file" name ="file1"></td></tr>
-->
   <tr><td colspan="3">
   <a href="javascript:inputcheck()" role="button"
      class="BaseButton BaseButton--skinGray size_default"> <span
      class="BaseButton__txt">등록</span></a>
&nbsp;&nbsp;&nbsp;
   <a href="list.shop?btype=${param.btype}" role="button"
      class="BaseButton BaseButton--skinGray size_default"> <span
      class="BaseButton__txt">목록</span></a>
   </td></tr>
      </table></form:form>
</body>
</html>