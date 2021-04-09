<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /webapp/WEB-INF/view/user/password.jsp --%>
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

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 3px solid #dedede;
	text-align: center;
	padding: 8px;
}

th {
	background-color: #c7ebfc;
	color: #000000;
}

td {
	background-color: #F2F2F2;
}

input[type=text], input[type=password], textarea {
	width: 100%;
}

caption {
	color: #111111;
	font-size: 20px;
	background-color: #FFFFFF;
}
</style>
<script type="text/javascript">
function inchk(f) {
	if(f.chgpass.value != f.chgpass2.value) {
		alert("변경 비밀번호와 변경 비밀번호 재입력이 다릅니다.");
		f.chgpass2.value="";
		f.chgpass2.value.focus();
		returln false; 
	}
	return true;
}
</script>
</head>
<body>
<h2>비밀번호 변경</h2>
<form action="password.shop" method="post" name="f" onsubmit="return inchk(this)">
<table>
<tr><th>현재 비밀번호</th><td><input type="password" name="pw"></td></tr>
<tr><th>변경 비밀번호</th><td><input type="password" name="chgpw"></td></tr>
<tr><th>변경 비밀번호 재입력</th><td><input type="password" name="chgpw2"></td></tr>
<tr><td colspan="2"><input type="submit" value="비밀번호 변경"></td></tr>
</table></form>
</body>
</html>