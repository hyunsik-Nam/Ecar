<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
</head>
<body>
<h2>내 정보 수정</h2>
<form:form modelAttribute="user" method="post" action="update.shop">
<spring:hasBindErrors name="user">
<font color="red">
<c:forEach items="${errors.globalErrors }" var="error">
<spring:message code="${error.code }"/>
</c:forEach>
</font>
</spring:hasBindErrors>
<table>
<tr><td>아이디</td><td><form:input path="id" readonly="true" />
<font color="red"><form:errors path="id" /></font></td></tr>
<tr><td>비밀번호</td><td><form:password path="pw"/>
<font color="red"><form:errors path="pw" /></font></td></tr>
<tr><td>이름</td><td><form:input path="name"/>
<font color="red"><form:errors path="name" /></font></td></tr>
<tr><td>이메일</td><td><form:input path="email"/>
<font color="red"><form:errors path="email" /></font></td></tr>
<tr><td>거주 지역을 선택하세요 </td><td><select name="loc">
						<option value="1">서울특별시</option>
						<option value="2">부산광역시</option>
						<option value="3">대구광역시</option>
						<option value="4">인천광역시</option>
						<option value="5">광주광역시</option>
						<option value="6">대전광역시</option>
						<option value="7">울산광역시</option>
						<option value="8">세종특별자치시</option>
						<option value="9">경기도</option>
						<option value="10">강원도</option>
						<option value="11">충청북도</option>
						<option value="12">충청남도</option>
						<option value="13">전라북도</option>
						<option value="14">전라남도</option>
						<option value="15">경상북도</option>
						<option value="16">경상남도</option>
						<option value="17">제주특별자치도</option>
				</select>
				</td></tr>
<tr><td colspan="2" align="center">
<input type="submit" value="수정">
<input type="reset" value="초기화"></td></tr>
</table></form:form>
</body>
</html>