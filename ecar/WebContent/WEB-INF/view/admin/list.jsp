<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/admin/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
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
.button {
   display: inline-block;
   min-width: 46px;
   height: 34px;
   line-height: 36px;
   font-size: 13px;
   color: var(- -skinCommentWriterText);
   border-radius: 6px;
   box-sizing: border-box;
   font-weight: 700;
   text-align: center;
   vertical-align: top;
   outline:0;
   border:0;
   cursor: pointer;
}

.BaseButton.size_default {
   min-width: 46px;
   height: 36px;
   margin-left: 10px;
   padding: 0 12px;
   font-size: 13px;
   line-height: 36px;
}
.size_comment {
   min-width: 46px;
   height: 30px;
   margin-left: 10px;
   padding: 0 12px;
   font-size: 10px;
   line-height: 36px;
}

.BaseButton--skinGray {
   border: 1px solid var(- -skinBaseButtonDefaultBorder);
   background: white;
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
</style>
</head>
<body>
<h2 >회원 목록</h2>
<form>
<table>
<tr><th>이름</th><th>아이디</th><th>거주지역</th><th></th></tr>
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
<td>
<a href="../member/update.shop?id=${user.id}" role="button"
   class="BaseButton BaseButton--skinGray size_default"> <span
   class="BaseButton__txt">수정</span></a>
<a href="../member/delete.shop?id=${user.id}" role="button"
   class="BaseButton BaseButton--skinGray size_default"> <span
   class="BaseButton__txt">강제탈퇴</span></a>
<a href="../member/mypage.shop?id=${user.id}" role="button"
   class="BaseButton BaseButton--skinGray size_default"> <span
   class="BaseButton__txt">회원정보</span></a>
</td></tr>
</c:forEach>
</table>
</form>
</body>
</html>