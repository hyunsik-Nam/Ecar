<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /webapp/WEB-INF/view/board/reply.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 답글 쓰기</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<form:form modelAttribute="board" action="reply.shop" method="post" name="f">
<input type="hidden" name="btype" value="${param.btype}">
<form:hidden path="cnt"/>
<form:hidden path="grp" />
<form:hidden path="grplevel" />
<form:hidden path="grpstep" />
<input type="hidden" name="btype" value="${param.btype}">
<input type="hidden" name="id" value="${sessionScope.loginUser.id}">
<table><caption>Ecar 게시판 답글 등록</caption>

<tr><td>제목</td><td><form:input path="title" value="RE:${board.title }"/>
<font color="red"><form:errors path="title"/></font></td></tr>
<tr><td>내용</td><td><textarea name="con" rows="15" cols="80"></textarea>
<font color="red"><form:errors path="con"/></font></td></tr>
<script>CKEDITOR.replace("con", {
   filebrowserImageUploadUrl : "imgupload.shop" });</script>
<tr><td colspan="2">
<a href="javascript:document.f.submit()">[답변글등록]</a></td></tr>

</table>
</form:form>
</body>
</html>
