<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /webapp/WEB-INF/view/board/update.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="../css/main.css">
<style type="text/css">
.comment_info_date {
    margin-right: 8px;
}
.comment_info_box {
    margin-top: 7px;
    font-size: 12px;
    color: var(--skinText979797);
}
.text_comment {
    line-height: 17px;
    word-break: break-all;
    word-wrap: break-word;
    vertical-align: top;
}
.comment_text_view {
    overflow: hidden;
}
.comment_text_box {
    position: relative;
    font-size: 13px;
    word-break: break-all;
    word-wrap: break-word;
}
.comment_nick_info {
    display: inline-block;
    position: relative;
    font-size: 13px;
    vertical-align: top;
}
.comment_nick_box {
    margin-bottom: 4px;
}
.comment_area {
    position: relative;
    padding: 12px 23px 10px 0;
    margin: 6px 5px auto;
}
div {
    display: block;
}
.comment_attach:after {
    content: "";
    display: block;
    clear: both;
}
.register_box {
   float: right;
}

.comment_attach {
   position: relative;
}

.CommentWriter .comment_inbox_text {
   overflow-x: hidden;
   overflow-y: auto;
   display: block;
   width: 100%;
   min-height: 17px;
   padding-right: 1px;
   border: 0;
   font-size: 13px;
   -webkit-appearance: none;
   resize: none;
   box-sizing: border-box;
   background: transparent;
   color: var(- -skinTextColor);
   outline: 0;
}

.CommentWriter .comment_inbox_name {
   display: block;
   margin-bottom: 10px;
   font-weight: 700;
   font-size: 13px;
   text-align: left;
}

.CommentWriter {
   margin: 12px 0 29px;
   padding: 16px 10px 10px 18px;
   border: 2px solid rgba(0, 0, 0, 0.1);
   border-radius: 6px;
   box-sizing: border-box;
   background: var(- -skinCommentWriterBg);
}

.left_area {
   float: left;
}

.right_area {
   float: right;
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
<script type="text/javascript">
function file_delete(){
   document.f.fileurl.value = ""
   file_desc.style.display = "none";
}
</script>
</head>
<body>
<form:form modelAttribute="board" action = "update.shop"
   enctype="multipart/form-data" name="f">
<input type="hidden" name="btype" value="${param.btype}">
   <form:hidden path="cnt" />
   <table><tr><td>글쓴이</td><td><form:input path="id" />
   <font color="red"><form:errors path="id" /></font></td></tr>
   <tr><td>제목</td><td><form:input path="title" />
   <font color="red"><form:errors path="title" /></font></td></tr>
   <tr><td>차종 구분</td><td>
         <input type="radio" name="man" value="1" ${board.man eq '1' ? 'checked':''} />현대
         <input type="radio" name="man" value="2" ${board.man eq '2' ? 'checked':''}/>기아
         <input type="radio" name="man" value="3" ${board.man eq '3' ? 'checked':''}/>르노삼성
         <input type="radio" name="man" value="4" ${board.man eq '4' ? 'checked':''}/>BMW
         <input type="radio" name="man" value="5" ${board.man eq '5' ? 'checked':''}/>한국GM
         <input type="radio" name="man" value="6" ${board.man eq '6' ? 'checked':''}/>한불모터스
         <input type="radio" name="man" value="7" ${board.man eq '7' ? 'checked':''}/>테슬라
         <input type="radio" name="man" value="8" ${board.man eq '8' ? 'checked':''}/>재규어
         <input type="radio" name="man" value="9" ${board.man eq '9' ? 'checked':''}/>벤츠코리아
         <input type="radio" name="man" value="10" ${board.man eq '10' ? 'checked':''}/>쎄미시스코
         <input type="radio" name="man" value="11" ${board.man eq '11' ? 'checked':''}/>기타
         </td></tr>  

   <tr><td>내용</td><td><form:textarea path="con" rows="15" cols="80" />
   <script>CKEDITOR.replace("con",{
      filebrowserImageUploadUrl : "imgupload.shop"
   });
   </script>
   <font color="red"><form:errors path="con" /></font></td></tr>
   <tr><td>첨부파일</td><td><c:if test="${!empty board.fileurl }">
     <div id="file_desc">
       <a href="file/${board.fileurl }">${board.fileurl }</a>
       <a href="javascript:file_delete()">[첨부파일삭제]</a>
     </div></c:if>
    <form:hidden path="fileurl"/>
    <input type="file" name="file1"></td></tr>
    <tr><td colspan="2">
      <!-- <a href="javascript:document.f.submit()">[게시글수정]</a>  -->
   <a href="javascript:document.f.submit()"
      role="button"
      class="BaseButton BaseButton--skinGray size_default"> <span
      class="BaseButton__txt">수정</span></a>
                        
   <a href="list.shop?btype=${param.btype}" role="button"
      class="BaseButton BaseButton--skinGray size_default"> <span
      class="BaseButton__txt">목록</span></a>               
     
      </td></tr>
   </table></form:form>
</body>
</html>