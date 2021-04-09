<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ecar</title>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
	width: 360px;
	padding: 8% 0 0;
	margin: auto;
}

.form {
	position: relative;
	z-index: 1;
	background: #FFFFFF;
	max-width: 360px;
	margin: 0 auto 100px;
	padding: 40px;
	text-align: center;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
}

.form input {
	font-family: "Roboto", sans-serif;
	outline: 0;
	background: #f2f2f2;
	width: 100%;
	border: 0;
	margin: 0 0 7px;
	padding: 7px;
	box-sizing: border-box;
	font-size: 14px;
}

.form .aa {
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

.form .aa:hover, .form .aa:active, .form .aa:focus {
	background: #dcf1fb;
}

.form .message {
	margin: 15px 0 0;
	color: #b3b3b3;
	font-size: 13px;
}

.form .message a {
	color: #B9E2FA;
	text-decoration: none;
}
</style>
</head>
<body>
	<form:form modelAttribute="user" method="post" action="joinForm.shop">
		<div class="login-page">
			<div class="form">
				<form class="login-form">
					<spring:hasBindErrors name="user">
						<font color="red"> 
						<c:forEach items="${errors.globalErrors }" var="error">
						<spring:message code="${error.code }" />
						</c:forEach>
						</font>
					</spring:hasBindErrors>

					<p class="message"> 이름
						<form:input path="name" />
						<font color="red"> <form:errors path="name" /></font></p>
					<p class="message">아이디
						<form:input path="id" />
						<font color="red"><form:errors path="id" /></font></p>
					<p class="message">비밀번호
						<form:password path="pw" />
						<font color="red"><form:errors path="pw" /></font></p>
					<p class="message">이메일
						<form:input path="email" />
						<font color="red"><form:errors path="email" /></font></p>
					<p class="message">거주 지역을 선택하세요 
					<select name="loc">
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
						</select></p>
					<br> 
					<input class="aa" type="submit" value="회원가입"> 
					<input class="aa" type="reset" value="초기화">
				</form>
			</div>
		</div>
	</form:form>
</body>
</html>