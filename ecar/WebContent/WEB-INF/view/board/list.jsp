<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style type="text/css">
.blind {
    overflow: hidden;
    position: absolute;
    clip: rect(0 0 0 0);
    width: 1px;
    height: 1px;
    margin: -1px;
}
.list-i-upload{
	display: inline-block;
    background-image: url(https://ssl.pstatic.net/static/cafe/cafe_pc/sp/sp_icon_06952b76.svg);
    background-repeat: no-repeat;
}
.list-i-upload {
    background-position: -285px -223px;
    width: 12px;
    height: 12px;
    vertical-align: -1px !important;
}

.select_component .select_box {
    display: block;
    position: relative;
    height: 34px;
    padding: 9px 36px 0 12px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
div {
    display: block;
}
.search {
    padding: 16px 0 16px;
    background-color: white;
    text-align: center;
}
.page{
	margin-top: 32px;
    height: 40px;
    padding-top: 16px;
    text-align: center;
}
.skin-1080 .post_btns {
    margin-top: 9px;
    text-align: right;
}
.fr {
    float: right;
}
.btn_type1.post_write {
    width: 74px;
    padding: 9px 0;
}
.btn_type1 {
    display: inline-block;
    min-width: 56px;
    height: 36px;
    padding: 9px 12px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    border: 1px solid #d3d3d3;
    text-align: center;
    vertical-align: top;
    background:white;
}
.btn_type1.post_write:before,.btn_notice:before {
    content: '';
    margin: 3px 6px 0 0;
    vertical-align: -2px;
}
.btn_type1.post_write:before,.btn_notice:before {
    background-position: -84px -90px;
    width: 12px;
    height: 12px;
}
.btn_type1.post_write:before, .btn_notice:before, .check_box input + label:before, .check_box input:checked + label:before, .check_box.green_check input:checked + label:before, .skin-1080 .box_notice .link_more .ico_more, .skin-1080 .box_notice .close .ico_newcafe, .skin-1080 .ico_aside, .skin-1080 .info-action-tab .tit-bookmark .btn-bookmark-off, .skin-1080 .info-action-tab .tit-bookmark .btn-bookmark-on, .skin-1080 .ia-info-data .ico_setting, .skin-1080 .ia-info-data .ico_stat, .skin-1080 .ia-info-data .ico_alarm, .skin-1080 .ia-info-data2 .mem-cnt-info .ico, .skin-1080 .ia-info-data2 .mem-cnt-info .ico_lock2, .skin-1080 .ia-info-data3 .ico_bkmk, .skin-1080 .ia-info-data3 .ico_bkmk2, .skin-1080 .ia-info-data3 .ico_mbl, .skin-1080 #member-action-data .ico_vst, .skin-1080 #member-action-data .ico_wrt, .skin-1080 #member-action-data .ico_cmt, .skin-1080 #member-action-data .ico_pay, .skin-1080 #cafe-menu .cafe-menu-tit .up-btn, .skin-1080 #cafe-menu .cafe-menu-tit .down-btn, .skin-1080 #linked-member .member-reload, .skin-1080 #linked-member .member-up, .skin-1080 #linked-member .member-down, .skin-1080 .article-board .unload .ico_newcafe, .skin-1080 .prev-next .pgL:before, .skin-1080 .prev-next .pgR:after {
    display: inline-block;
    background-image: url(https://ssl.pstatic.net/static/cafe/cafe_pc/sp/sp_icon_white_72ca546e.svg);
    background-repeat: no-repeat;
    vertical-align: top;
}

.btn_notice {
    display: inline-block;
    min-width: 100px;
    height: 36px;
    padding: 9px 12px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    border: 1px solid #d3d3d3;
    text-align: center;
    vertical-align: top;
    background:white;
}
a {
    color: inherit;
    text-decoration: none;
    cursor: pointer;
}
</style>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript">
function listpage(page){
	   document.searchform.pageNum.value=page;
	   document.searchform.submit();
	}</script>

<script type="text/javascript">
function manpage(page){
	   document.manform.btype.value=page;
	   document.manform.submit();
	}
function writecheck() {
	alert("로그인해주세요");
}
</script>
</head>
<body>
     <form action="list.shop?btype=${param.btype}" method="post" name="manform">
     <input type="hidden" name="btype" value="${param.btype}">

<c:if test="${param.btype==1}">
  <select name="man" style="width:100px;">
        <option value="">브랜드선택</option>
        <option value="1">현대</option>
        <option value="2">기아</option>
        <option value="3">르노삼성</option>
        <option value="4">BMW</option>
        <option value="5">한국GM</option>
        <option value="6">한불모터스</option>
        <option value="7">테슬라</option>
        <option value="8">재규어</option>
        <option value="9">벤츠코리아</option>
        <option value="10">쎄미시스코</option>
        <option value="11">기타</option>
        </select>
        <input type="submit" value="보기">
        <script type="text/javascript">
           document.manform.man.value="${param.man}";
        </script>&nbsp;&nbsp;&nbsp;
        <input type="button" value="전체게시물보기"
           onclick="location.href='list.shop?btype=${param.btype}'">
<h1>후기게시판</h1>
<p>자유롭게 전기차에 대해서 후기를 작성해주세요</p>
</c:if>

     <form action="list.shop?btype=${param.btype}" method="post" name="manform">
     <input type="hidden" name="btype" value="${param.btype}">
<c:if test="${param.btype==2}">
        <select name="man" style="width:100px;">
        <option value="">브랜드선택</option>
        <option value="1">현대</option>
        <option value="2">기아</option>
        <option value="3">르노삼성</option>
        <option value="4">BMW</option>
        <option value="5">한국GM</option>
        <option value="6">한불모터스</option>
        <option value="7">테슬라</option>
        <option value="8">재규어</option>
        <option value="9">벤츠코리아</option>
        <option value="10">쎄미시스코</option>
        <option value="11">기타</option>
        </select>
        <input type="submit" value="보기">
        <script type="text/javascript">
           document.manform.man.value="${param.man}";
        </script>&nbsp;&nbsp;&nbsp;
        <input type="button" value="전체게시물보기"
           onclick="location.href='list.shop?btype=${param.btype}'">
<h1>브랜드별 게시판</h1>
<p>브랜드별로 소개 및 궁금한 점 알려드려요</p>
</c:if></form>
   <div class="notice_btns">
    <div class="fr">
    	<c:if test = "${sessionScope.loginUser.id == 'admin'}">
        	<a href="write.shop?btype=${param.btype}" class="btn_notice post_write _rosRestrict">공지글작성</a>
    	</c:if>
    </div>
</div>
<table>
   
     
    <c:if test="${listcount > 0}"> <%--등록된 게시물이 있음 --%>
       <tr><th>번호</th><th>제목</th><th>글쓴이</th><th>날짜</th><th>조회수</th></tr>
       <c:forEach var="board" items="${boardlist}">
          <tr><td>${boardno}</td>
             <c:set var="boardno" value="${boardno - 1}" />
          <td style="text-align:left;">
          
          <c:if test="${! empty board.fileurl}"><%--첨부된 파일이 존재 --%>
          <a href="file/${board.fileurl}"><span class="list-i-upload"></span></c:if>
          <c:if test="${empty board.fileurl }">&nbsp;&nbsp;&nbsp;</c:if>
         
         <%--답변글인 경우 들여쓰기 --%>
       <c:forEach begin="1" end="${board.grplevel}">&nbsp;&nbsp;</c:forEach>
          <c:if test="${board.grplevel > 0}">└</c:if>
         
          <%--제목 부분 출력 --%>
          
          <a href="detail.shop?cnt=${board.cnt}&btype=${board.btype}">${board.title}&nbsp;&nbsp;&nbsp;
          <c:if test="${board.commentTotalCnt>0}">
             <b>[${board.commentTotalCnt}]</b></a></td>
             </c:if>
          <c:if test="${board.commentTotalCnt==0}">
             </a></td>
             </c:if>
             <td>${board.id}</td>
          <td><fmt:formatDate value="${board.date}" pattern="yyyyMMdd" var="rdate"/>
             <c:if test="${today == rdate}">
             <fmt:formatDate value="${board.date}" pattern="HH:mm:ss"/></c:if>
             <c:if test="${today != rdate}">
             <fmt:formatDate value="${board.date}" pattern="yyyy-MM-dd HH:mm"/>
             </c:if></td><td>${board.readcnt}</td></tr>
       </c:forEach>
       </c:if>
       
</table>
<div class="post_btns">
    <div class="fr">
    	<!-- 로그인x -->
   	 	<c:if test="${empty sessionScope.loginUser}">
        	<a onclick="writecheck()" class="btn_type1 post_write _rosRestrict">글쓰기</a>
    	</c:if>
    	
    	<!-- 로그인o -->
    	<c:if test="${!empty sessionScope.loginUser and sessionScope.loginUser.id !='admin'}">
        	<a href="write.shop?btype=${param.btype}" class="btn_type1 post_write _rosRestrict">글쓰기</a>
    	</c:if>
    </div>
</div>
<div class="page">
 <%-- 페이지 표시  --%>
 <c:if test="${listcount > 0}">
          <tr><td colspan="5">
          <c:if test="${pageNum > 1}">
          <a href="javascript:listpage('${pageNum - 1}')">[이전]</a></c:if>
          <c:if test="${pageNum <= 1}">[이전]</c:if>
          <c:forEach var="a" begin="${startpage}" end="${endpage}">
             <c:if test="${a == pageNum}">[${a}]</c:if>
             <c:if test="${a != pageNum}">
             <a href="javascript:listpage('${a}')">[${a}]</a></c:if>
          </c:forEach>
          <c:if test="${pageNum < maxpage}">
             <a href="javascript:listpage('${pageNum +1}')">[다음]</a></c:if>
          <c:if test="${pageNum >= maxpage}">[다음]</c:if></td></tr>
    </c:if> <%-- 등록된 게시물이 있는 경우 끝 --%>
    
    <c:if test="${listcount < 0}"><%--등록된 게시물이 없는 경우 --%>
       <tr><td colspan="5">등록된 게시물이 없습니다.</td></tr></c:if>
    <tr><td colspan="5" align="right">
</div>
<div class="search">
<tr><td colspan="5">
    <div style="display : inline;">
     <form action="list.shop" method="post" name="searchform">
        <input type="hidden" name="pageNum" value="1">
        <input type="hidden" name="btype" value="${param.btype}">
        <input type="hidden" name="man" value="${param.man}">
        <select name="searchtype" style="width:100px;">
        <option value="">선택하세요</option>
        <option value="title">제목</option>
        <option value="con">내용</option>
        </select>
        
        <script type="text/javascript">
           searchform.searchtype.value="${param.searchtype}";
        </script>
        <input type="text" name="searchcontent"
        value="${param.searchcontent}" style="width:250px;">
        <input type="submit" value="검색" >
     </form></div></td></tr>
</div>

    </body></html>