<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/user/delete.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.BaseButton--skinGray {
   border: 1px solid var(- -skinBaseButtonDefaultBorder);
   background: #eaeaea;
   color: var(- -skinBaseButtonDefaultColor);
}

.button--green {
   border: 0px solid var(- -skinBaseButtonDefaultBorder);
   background: rgba(3, 199, 90, 0.12);
   color: #009f47;
}

.BaseButton {
   display: inline-block;
   border-radius: 6px;
   box-sizing: border-box;
   font-weight: 700;
   text-align: center;
   vertical-align: top;
   outline: none;
   cursor: pointer;
   border: 0;
}

a.button {
   -webkit-appearance: button;
   -moz-appearance: button;
   appearance: button;
}

a {
   text-decoration: none
}

input.submitLink {
   background-color: transparent;
   border: none;
   text-decoration: none;
   cursor: pointer;
   outline: none;
}
.right_area {
   float: right;
}
</style>
<title>Ecar</title>
<link rel="stylesheet" href="../css/main.css">
<style type="text/css">
h2 {
   font-size: 40px;
   text-align: center;
   font-family: Monospace;
   border-bottom: 12px solid #dcf1fb;
}
input {
	margin: 0 0 10px;
	padding: 10px;
	box-sizing: border-box;
	font-size: 14px;
}
</style>
</head>
<body>
<h2>회원 탈퇴</h2>
<table>

  <tr><th>아이디</th><td>${user.id}</td></tr>
  <tr><th>이름</th><td>${user.name}</td></tr>
  <br><br>
</table>
<form action="delete.shop" method="post" name="deleteform">
  <input type="hidden" name="id" value="${param.id }">
  <input type="password" name="pw" placeholder="비밀번호를 입력하세요">

<div class="right_area">
<a href="javascript:deleteform.submit()" role="button"
      class="BaseButton BaseButton--skinGray size_default"> 
      <span class="BaseButton__txt">회원탈퇴</span></a>
</div>
</form>
</body>
</html>