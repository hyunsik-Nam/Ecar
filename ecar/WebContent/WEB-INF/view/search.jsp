<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}찾기</title>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript">
	function sendclose(){
		opener.document.loginform.id.value='${result}';
		self.close();
	}
</script></head>
<body><table>
	<tr><th>${title}찾기</th><td>${result}</td></tr>
	<tr><td colspan="2">
	   <c:if test="${title =='아이디'}">
		<input type="button" value="닫기" onclick="self.close()"></c:if>
	   <c:if test="${title !='아이디'}">
		<input type="button" value="닫기" onclick="self.close()"></c:if></td></tr>
	</table></body></html>