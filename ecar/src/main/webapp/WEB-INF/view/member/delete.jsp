<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/user/delete.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
<table>

  <tr><td>아이디</td><td>${user.id}</td></tr>
  <tr><td>이름</td><td>${user.name}</td></tr>
  
</table>
<form action="delete.shop" method="post" name="deleteform">
  <input type="hidden" name="id" value="${param.id }">
   비밀번호 <input type="password" name="pw">
  <a href="javascript:deleteform.submit()">[회원탈퇴]</a>
</form>
</body>
</html>