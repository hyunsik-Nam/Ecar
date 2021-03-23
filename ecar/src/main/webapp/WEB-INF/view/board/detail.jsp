<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /webapp/WEB-INF/view/board/detail.jsp 
  Controller, Shopservice ,BoardDao 구현    
    1.num파라미터에 해당하는 게시물 정보를 board 객체 전달 
    2.조회수 증가
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript">
function inputcheck(){
	f = document.f;
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		return;
	}
	f.submit();
}
function removeCheck1(f) {
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
//	     document.removefrm.submit();
	     f.submit();
	 }else{   //취소
	     return false;
	 }
}
</script>
<style type="text/css">
.leftcol { text-align: left;  vertical-align: top;}
.lefttoptable { height : 250px;  border-width : 0px;
	text-align: left;  vertical-align: top;   padding: 0px;}
</style>
</head>
<body>
<table>
<input type="hidden" name="btype" value="${param.btype}">
<input type="hidden" name="man" value="${param.man}">
<tr><td colspan="2">Ecar 게시판</td></tr>
	<tr><td width="15%">글쓴이</td>
	    <td width="85%" class="leftcol">${board.id}</td></tr>
	<tr><td>제목</td><td class="leftcol">${board.title}</td></tr>
	<tr><td>차종 구분</td>
	<td>
	<c:if test="${board.man == 1}">현대</c:if>
	<c:if test="${board.man == 2}">기아</c:if>
	<c:if test="${board.man == 3}">르노삼성</c:if>
	<c:if test="${board.man == 4}">BMW</c:if>
	<c:if test="${board.man == 5}">한국GM</c:if>
	<c:if test="${board.man == 6}">한불모터스</c:if>
	<c:if test="${board.man == 7}">테슬라</c:if>
	<c:if test="${board.man == 8}">재규어</c:if>
	<c:if test="${board.man == 9}">벤츠코리아</c:if>
	<c:if test="${board.man == 10}">쎄미시스코</c:if>
	<c:if test="${board.man == 11}">기타</c:if>
	</td>
	
	<tr><td>내용</td><td class="leftcol">
	  <table class="lefttoptable">
<tr><td class="leftcol lefttoptable">${board.con}</td></tr></table></td></tr>
	<tr><td>첨부파일</td><td>&nbsp;
	 <c:if test="${!empty board.fileurl}">
	  <a href="file/${board.fileurl}">${board.fileurl }</a>
	  </c:if></td></tr>
	  	 <tr><td colspan="2">
	<!-- <a href="comment.shop?cnt=${board.cnt}&btype=${param.btype}">[댓글]</a> --> 
	    <a href="update.shop?cnt=${board.cnt}&btype=${param.btype}">[수정]</a>
	    <a href="delete.shop?cnt=${board.cnt}&btype=${param.btype}">[삭제]</a>
	    <a href="list.shop?btype=${param.btype}">[게시물목록]</a>
	 </td></tr></table>
	  
	  
<!-- -----------------------게시물 밑에 댓글달기-------------------------------- -->
<table colspan="2" style="width:100%; margin: auto;">

   
<c:forEach var="r" items="${commentlist}">

   <tr><td style = "text-align:left" width="100%">${r.id}<br>${r.content}<br><font size="1">${r.up}</font></td>
   
 
   <td width="20%"><font size="2">
	</td>

   
   <form action="rdelete.shop" method="post" onsubmit="return removeCheck1(this)" name="removefrm">
      <input type="hidden" name="btype" value="${param.btype}">
      <input type="hidden" name="cnt" value="${param.cnt}">
      <input type="hidden" name="comnum" value="${r.comnum}">
      <input type="hidden" name="man" value="${param.man}">
   <td width="2%"><font size="1"><input type="submit" value="삭제" class="submitLink"></font></td>
   </form>   
</tr>
   </c:forEach>
</table>


<form action="comment.shop" method="post" name="f"> <%--댓글 --%> 
      <input type="hidden" name="id" value="${sessionScope.login}">
      <input type="hidden" name="btype" value="${param.btype}">
      <input type="hidden" name="cnt" value="${param.cnt}">
      <input type="hidden" name="comnum" value="${comment.comnum}">
      <input type="hidden" name="man" value="${param.man}">
         <table border="1" style="background-color: yellow;">
            <tr><td colspan="0.5" width="80%">
<textarea rows="5" name="content" 
id="content1"  class="w3-input w3-border"></textarea></td>
<td colspan="0.5" width="20%">
<a href="javascript:inputcheck()">댓글등록</a>
</td></tr>
</table>
</form>



</body>
</html>