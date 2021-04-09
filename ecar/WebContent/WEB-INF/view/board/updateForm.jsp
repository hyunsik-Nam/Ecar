<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%--
    	1. num값에 해당하는 게시물을 조회
    	2. 조회된 게시물을 화면에 출력
     --%>
<script>
	function file_delete() {
		document.f.file2.value="";
		file_desc.style.display="none";
	}
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 수정 화면</title>
<link rel = "stylesheet" href="../../css/main.css">
</head>
<body>
<form action="update.do" method="post"
		enctype="multipart/form-data" name = "f">
		
<input type="hidden" name="num" value="${b.num}">
<input type="hidden" name="btype" value="${b.btype}">
<input type="hidden" name="picture" value="${empty b.picture?"":b.picture}">
<table><caption>게시판 수정 화면</caption>
<tr><td>글쓴이</td><td>
<input type="text" name="nick" value="${b.nick}"></td></tr>
<tr><td>제목</td><td>
<input type="text" name="subject" value="${b.subject}"></td></tr>
<tr><td>내용</td><td>
<textarea rows="15" name="content" id="content1" class="w3-input w3-border">${b.content}</textarea></td></tr>
<script>CKEDITOR.replace("content1",{
	filebrowserImageUploadUrl : "imgupload.do"
})</script>
<tr><td>첨부파일</td><td style="text-align:left">
<c:if test="${!empty b.picture}">
<div id="file_desc">${picture}
	<a href = "javascript:file_delete()">[첨부파일 삭제]</a></div>
</c:if>
<input type="file" name="file1"></td></tr>
<tr><td colspan="2">
<a href="javascript:document.f.submit()">[게시물수정]</a></td></tr>
</table>
</form>
</body>
</html>