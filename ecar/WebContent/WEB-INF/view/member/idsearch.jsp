<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ecar</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<h3 style="text-align: center;">아이디 찾기</h3>
<form:form modelAttribute="user" action="idsearch.shop" method ="post" >
<spring:hasBindErrors name="user">
<font color="red"><c:forEach items="${errors.globalErrors}" var="error">
<spring:message code="${error.code }" />
</c:forEach></font></spring:hasBindErrors>
<table>
<tr><th>이름</th><td><input type="text" name="name">
<font color = "red"><form:errors path="name" /></font></td></tr>
<tr><th>이메일</th><td><input type="text" name="email">
<font color = "red"><form:errors path="email" /></font></td></tr>
<tr><td colspan="2"><input type="submit" value="아이디찾기"></td></tr>
</table></form:form>
</body>
</html>