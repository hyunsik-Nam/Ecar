<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /webapp/WEB-INF/view/user/password.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
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
<form action="password.shop" method="post" name="f" onsubmit="return inchk(this)">
<table><caption>비밀번호 변경</caption>   
<tr><th>현재 비밀번호</th><td><input type="password" name="pw"></td></tr>
<tr><th>변경 비밀번호</th><td><input type="password" name="chgpw"></td></tr>
<tr><th>변경 비밀번호 재입력</th><td><input type="password" name="chgpw2"></td></tr>
<tr><td colspan="2"><input type="submit" value="비밀번호 변경"></td></tr>
</table></form>
</body>
</html>