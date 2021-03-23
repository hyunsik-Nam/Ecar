<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/admin/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
</head>
<body>
<form>
<table><tr><td colspan="7">회원목록</td></tr>
<tr><th>이름</th><th>아이디</th><th>거주지역</th></tr>
<c:forEach items="${list}" var="user">
<tr><td>${user.name}</td>
<td>${user.id}</td>
<td>
	<c:if test="${user.loc == 1}">서울특별시</c:if> 
	<c:if test="${user.loc == 2}">부산광역시</c:if>
	<c:if test="${user.loc == 3}">대구광역시</c:if> 
	<c:if test="${user.loc == 4}">인천광역시</c:if> 
	<c:if test="${user.loc == 5}">광주광역시</c:if>
	<c:if test="${user.loc == 6}">대전광역시</c:if> 
	<c:if test="${user.loc == 7}">울산광역시</c:if> 
	<c:if test="${user.loc == 8}">세종특별자치시</c:if>
	<c:if test="${user.loc == 9}">경기도</c:if> 
	<c:if test="${user.loc == 10}">강원도</c:if> 
	<c:if test="${user.loc == 11}">충청북도</c:if>
	<c:if test="${user.loc == 12}">충청남도</c:if> 
	<c:if test="${user.loc == 13}">전라북도</c:if> 
	<c:if test="${user.loc == 14}">전라남도</c:if> 
	<c:if test="${user.loc == 15}">경상북도</c:if> 
	<c:if test="${user.loc == 16}">경상남도</c:if> 
	<c:if test="${user.loc == 17}">제주특별자치도</c:if>
</td>
<td><a href="../member/update.shop?id=${user.id}">수정</a>
   <a href="../member/delete.shop?id=${user.id}">강제탈퇴</a>
   <a href="../member/mypage.shop?id=${user.id}">회원정보</a>
</td></tr>
</c:forEach>
</table>
</form>
</body>
</html>