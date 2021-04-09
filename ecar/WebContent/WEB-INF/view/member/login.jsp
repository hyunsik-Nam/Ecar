<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<script type="text/javascript">
	function win_open(page) {
		var op = "width=500, height=350, left=50, top=150";
		open(page + ".shop", "", op);
	}
</script>
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
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #B9E2FA;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #dcf1fb;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #B9E2FA;
  text-decoration: none;
}

</style>
</head>
<body>
	<form:form modelAttribute="user" method="post" action="login.shop" name="loginform">
		<div class="login-page">
			<div class="form">
				<form class="login-form">
						<spring:hasBindErrors name="user">
			<font color="red"> <c:forEach items="${errors.globalErrors }" var="error">
					<spring:message code="${error.code }" />
				</c:forEach>
			</font>
		</spring:hasBindErrors>
					<form:input path="id" placeholder="Id"/>
					<font color="red"><form:errors path="id" /></font> 
					<form:password path="pw" placeholder="Password"/>
					<font color="red"><form:errors path="pw" /></font>
					<button>login</button>
					<p class="message"> Not registered? <a href="joinForm.shop">회원가입</a></p>
					<input type="button" value="아이디찾기" onclick="win_open('idsearch')">
					<input type="button" value="비밀번호찾기" onclick="win_open('pwsearch')">
				</form>
			</div>
		</div>
</form:form>
</body>
</html>
