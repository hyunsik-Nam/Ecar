<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ecar</title>
<style type="text/css">
h2 {
   font-size: 40px;
   text-align: center;
   font-family: Monospace;
   border-bottom: 12px solid #dcf1fb;
}

@import url(https://fonts.googleapis.com/css?family=Roboto:300);

aa {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #B9E2FA;
	width: 100%;
	border: 0;
	padding: 10px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;
}

aa:hover, .form .aa:active, .form .aa:focus {
	background: #dcf1fb;
}
</style>

</head>
<body>
<br><br>
<h2 >내 정보 수정</h2>
<form:form modelAttribute="user" method="post" action="update.shop" name="f">
<center>
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
<tr><td>거주 지역 </td>
            <td><select name="loc" onChange="getSelectValue(this.f);">
            <option value="1" <c:if test="${user.loc eq  '1' }" >selected</c:if>>서울특별시</option>
            <option value="2" <c:if test="${user.loc eq  '2' }" >selected</c:if>>부산광역시</option>
            <option value="3" <c:if test="${user.loc eq  '3' }" >selected</c:if>>대구광역시</option>
            <option value="4" <c:if test="${user.loc eq  '4' }" >selected</c:if>>인천광역시</option>
            <option value="5" <c:if test="${user.loc eq  '5' }" >selected</c:if>>광주광역시</option>
            <option value="6" <c:if test="${user.loc eq  '6' }" >selected</c:if>>대전광역시</option>
            <option value="7" <c:if test="${user.loc eq  '7' }" >selected</c:if>>울산광역시</option>
            <option value="8" <c:if test="${user.loc eq  '8' }" >selected</c:if>>세종특별자치시</option>
            <option value="9" <c:if test="${user.loc eq  '9' }" >selected</c:if>>경기도</option>
            <option value="10" <c:if test="${user.loc eq  '10' }" >selected</c:if>>강원도</option>
            <option value="11" <c:if test="${user.loc eq  '11' }" >selected</c:if>>충청북도</option>
            <option value="12" <c:if test="${user.loc eq  '12' }" >selected</c:if>>충청남도</option>      
            <option value="13" <c:if test="${user.loc eq  '13' }" >selected</c:if>>전라북도</option>
            <option value="14" <c:if test="${user.loc eq  '14' }" >selected</c:if>>전라남도</option>
            <option value="15" <c:if test="${user.loc eq  '15' }" >selected</c:if>>경상북도</option>
            <option value="16" <c:if test="${user.loc eq  '16' }" >selected</c:if>>경상남도</option>
            <option value="17" <c:if test="${user.loc eq  '17' }" >selected</c:if>>제주특별자치도</option>
            </select>
            </td></tr>
<tr><td colspan="2" align="center">
<input class="aa" type="submit" value="수정"> 
<input class="aa" type="reset" value="초기화">
</td></tr>
</table>
</center>
</form:form>
</body>
</html>