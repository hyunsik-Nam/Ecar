<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>E-car</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%-- <link rel="stylesheet" href="${path}/css/main.css"> --%>
<decorator:head />
<style>
.fl {
    float: left;
}
#content-area:after {
    content: '';
    display: block;
    clear: both;
}
#content-area #main-area {
    width: 860px;
}
.fr {
    float: right;
}
#content-area #group-area {
    width: 200px;
}
.skin-1080#group-area {
    text-align: left;
}
#content-area {
    position: relative;
    width: 1080px;
    margin: 0 auto;
    clear: both;
}
div {
    display: block;
}
html,body,h1,h2,h3,h4 {font-family:"Lato", sans-serif}
.w3-top {
    font-family: Verdana,sans-serif;
    font-size: 20px;
    line-height: 1.5;
}
.mySlides {display:none}
.w3-tag, .fa {cursor:pointer}
.w3-tag {height:15px;width:15px;padding:0;margin-top:6px}
.a {cusor: pointer; color: #000000; text-decoration: none; font-size: 12pt; line-height: 150%;}
.a:HOVER, .a:ACTIVE{font-size: 9pt; text-decoration: none;}
</style>

</head>

<body>
<script type="text/javascript"
   src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



    

<div id="content-area">
<div style="margin: 0 auto 20px;"><a href="/ecar/user/main.shop"><img src="${path}/layout/ecarimg.png" width="1080" ></a></div>
<div id="group-area" class="skin-1080 fl">
<br>
  <div class="w3-container">
    <h4><b>
    <c:if test="${empty sessionScope.loginUser}">
       <font size="6">guest</font><br>
        <font size="3"><a href="${path}/member/login.shop" class="a">Login</a>
        <font size="3"><a href="${path}/member/joinForm.shop" class="a">Join</a>
     </c:if>
     <c:if test="${!empty sessionScope.loginUser}">
      <font size="6">${sessionScope.loginUser.name }님</font><br>
      <font size="3"><a href="${path}/member/logout.shop" style="text-decoration:none" class="a">로그아웃</a><br></font>
     <font size="3"><a href="${path}/member/mypage.shop?id=${loginUser.id}" style="text-decoration:none" class="a">내 정보</a></font>
     <c:if test = "${sessionScope.loginUser.id == 'admin'}">
     <font size="3"><a href = "${path}/admin/list.shop" style="text-decoration:none" class="a" >회원목록</a></h3></font>
     </c:if>
     
   </c:if>
     </b></h4>
  </div>
  <br><br>
  <div class="w3-bar-block">
    <a href="/ecar/user/intro.shop" class="w3-bar-item w3-button a" > <b>전기차소개</b></a><br>
      <a href="/ecar/charger/location.shop" class="w3-bar-item w3-button a"> <b>전기차 충전소</b></a><br>
      <a href="/ecar/user/pricing.shop" class="w3-bar-item w3-button a"> <b>보조지원금</b></a><br>
      <a href="${path}/board/list.shop?btype=1" class="w3-bar-item w3-button a"> <b>후기 게시판</b></a><br>
      <a href="${path}/board/list.shop?btype=2" class="w3-bar-item w3-button a"> <b>브랜드 게시판</b></a><br>
      <a href="${path}/api/news.shop" class="w3-bar-item w3-button a"> <b>관련 뉴스</b></a>
  </div>
</div>
<div id="main-area" class="skin-1080 fr">
<decorator:body />
</div>
</div>


<!-- Content -->
<div class="w3-content" style="max-width:1100px;margin-bottom:80px">

</div>

<!--   <div class="w3-panel">
    <h1><b>MARKETING</b></h1>
    <p>Template by w3.css</p>
  </div> -->

 
</body>
</html>