<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /webapp/WEB-INF/view/board/detail.jsp 
  Controller, Shopservice ,BoardDao 구현    
    1.num파라미터에 해당하는 게시물 정보를 board 객체 전달 
    2.조회수 증가
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
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
function replycheck() {
   alert("로그인해주세요");
   return;
}
   function inputcheck() {
      f = document.f;
      if (f.content.value == "") {
         alert("내용을 입력하세요");
         f.content.focus();
         return;
      }
      f.submit();
   }
   function recent(f) {
      if (confirm("수정하시겠습니까?") == true) {
         f.submit();
      } else {
         return false;
      }
   }
   function removeCheck1(f) {
      if (confirm("정말 삭제하시겠습니까??") == true) { //확인
      //        document.removefrm.submit();
         f.submit();
      } else { //취소
         return false;
      }
   }
</script>
<style type="text/css">
.leftcol {
   text-align: left;
   vertical-align: top;
}

.lefttoptable {
   height: 250px;
   border-width: 0px;
   text-align: left;
   vertical-align: top;
   padding: 0px;
}
</style>
</head>
<body>
   <table>
      <tr>
         <td colspan="2">Ecar 게시판</td>
      </tr>
      <tr>
         <td width="15%">글쓴이</td>
         <td width="85%" class="leftcol">${board.id}</td>
      </tr>
      <tr>
         <td>제목</td>
         <td class="leftcol">${board.title}</td>
      </tr>
      
       <c:if test="${board.id != 'admin' }">
      <tr>
         <td>차종 구분</td>
         <td><c:if test="${board.man == 1}">현대</c:if> <c:if
               test="${board.man == 2}">기아</c:if> <c:if test="${board.man == 3}">르노삼성</c:if>
            <c:if test="${board.man == 4}">BMW</c:if> <c:if
               test="${board.man == 5}">한국GM</c:if> <c:if test="${board.man == 6}">한불모터스</c:if>
            <c:if test="${board.man == 7}">테슬라</c:if> <c:if
               test="${board.man == 8}">재규어</c:if> <c:if test="${board.man == 9}">벤츠코리아</c:if>
            <c:if test="${board.man == 10}">쎄미시스코</c:if> <c:if
               test="${board.man == 11}">기타</c:if></td>
      <tr>
      </c:if>
         <td>내용</td>
         <td class="leftcol">
            <table class="lefttoptable">
               <tr>
                  <td class="leftcol lefttoptable">${board.con}</td>
               </tr>
            </table>
         </td>
      </tr>
      <tr>
         <td>첨부파일</td>
         <td>&nbsp; <c:if test="${!empty board.fileurl}">
               <a href="file/${board.fileurl}">${board.fileurl }</a>
            </c:if></td>
      </tr>
      <tr>
         <td colspan="2">
            <form action="delete.shop" method="post"
               onsubmit="return removeCheck1(this)">
               <div class="left_area">
                  <c:if test="${!empty sessionScope.loginUser }">
                     <c:if test="${board.id != 'admin'}">
                        <a href="reply.shop?cnt=${board.cnt}&btype=${param.btype}"
                           role="button"
                           class="BaseButton BaseButton--skinGray size_default"> <span
                           class="BaseButton__txt">답글</span></a>
                     </c:if>
                     <c:if
                        test="${sessionScope.loginUser.id == 'admin' or sessionScope.loginUser.id eq board.id}">
                        <a href="update.shop?cnt=${board.cnt}&btype=${param.btype}"
                           role="button"
                           class="BaseButton BaseButton--skinGray size_default"> <span
                           class="BaseButton__txt">수정</span></a>
                        <input type="hidden" name="cnt" value="${param.cnt}">
                        <input type="hidden" name="btype" value="${param.btype}">
                        <input type="hidden" name="man" value="${param.man}">
                        <input type="submit" value="삭제" role="button"
                           class="BaseButton BaseButton--skinGray size_default">
                     </c:if>
                  </c:if>
               </div>
               <div class="right_area">
                  <a href="list.shop?btype=${param.btype}" role="button"
                     class="BaseButton BaseButton--skinGray size_default"> <span
                     class="BaseButton__txt">목록</span></a>
               </div>
            </form>
         </td>
      </tr>
   </table>



   <!-- -----------------------게시물 밑에 댓글달기-------------------------------- -->
   


      <c:forEach var="r" items="${commentlist}">

      <div class="comment_area">
      
         <div class="comment_nick_box">
            <div class="comment_nick_info">
            <font style="font-weight:bolder;">${r.id}</font><c:if test="${sessionScope.loginUser.id eq r.id}"><svg xmlns="http://www.w3.org/2000/svg" style="width:41p; height:18px; margin:1px auto;" viewBox="0 0 41 18" id="ico-post-writer"><g fill="none" fill-rule="evenodd"><path stroke="#F53535" d="M32 .5H9a8.47 8.47 0 00-6.01 2.49C1.45 4.528.5 6.653.5 9s.951 4.472 2.49 6.01A8.465 8.465 0 009 17.5h23a8.47 8.47 0 006.01-2.49c1.54-1.538 2.49-3.663 2.49-6.01s-.951-4.472-2.49-6.01A8.465 8.465 0 0032 .5z" opacity=".5"></path><path fill="#F53535" fill-rule="nonzero" d="M14.031 9.809V7.477h1.397V6.421h-1.397V4.1h-1.298v5.709h1.298zm-7.172-.066c.946-.319 1.98-1.254 2.266-2.2.429.902 1.375 1.639 2.134 1.936l.704-1.023c-1.089-.352-2.079-1.287-2.189-2.684h1.87V4.727H6.485v1.045h1.969c-.066 1.419-.99 2.475-2.354 2.97l.759 1.001zm7.183 4.169v-3.608H7.596v1.023h5.148v2.585h1.298zm9.944-4.092V4.1h-1.287v2.035h-1.672v1.023h1.672V9.82h1.287zm-7.436-.132c.913-.308 1.98-1.232 2.277-2.233.429.913 1.441 1.694 2.178 1.991l.737-1.001c-1.144-.374-2.266-1.474-2.266-2.992v-.902h-1.331v.968c0 1.485-.946 2.629-2.365 3.146l.77 1.023zm4.125 4.202c2.145 0 3.377-.781 3.377-1.969 0-1.221-1.232-1.991-3.377-1.991-2.112 0-3.333.77-3.333 1.991 0 1.188 1.221 1.969 3.333 1.969zm0-1.034c-1.265 0-2.013-.352-2.013-.935 0-.594.748-.957 2.013-.957 1.32 0 2.046.363 2.046.957 0 .583-.726.935-2.046.935zm12.386 1.045V8.94h1.397V7.873h-1.397V4.1h-1.287v9.801h1.287zm-7.194-2.068c1.144-.561 2.134-1.87 2.376-2.871.286.946 1.452 2.211 2.354 2.662l.715-.935c-1.474-.814-2.42-2.211-2.42-4.279v-.253h1.914V5.101h-5.225v1.056h1.98v.264c0 2.057-.858 3.564-2.486 4.455l.792.957z"></path></g></svg></c:if>
            </div>
         </div>
         
         <div class="comment_text_box">
            <p class="comment_text_view">
            <span class="text_comment">${r.content}</span>
            </p>
         </div>
         
         <div class="comment_info_box">
            <div class="left_area">
            <span class="comment_info_date"><font size="1">${r.up}</font></span>
            </div>
            <div class="right_area">
            <div class="left_area">
            <c:if test="${sessionScope.loginUser.id == 'admin' or sessionScope.loginUser.id eq r.id}">
            <font size="1"> <a
                  href="javascript:$('#updateform${r.comnum}').toggle()"
                  role="button"
                           class="BaseButton BaseButton--skinGray size_comment"> <span
                           class="BaseButton__txt">수정</span></a>
            </font>
            </c:if>
            </div>
            <div class="right_area">
            <form action="rdelete.shop" method="post"
               onsubmit="return removeCheck1(this)" name="removefrm">
               <input type="hidden" name="btype" value="${param.btype}"> <input
                  type="hidden" name="cnt" value="${param.cnt}"> <input
                  type="hidden" name="comnum" value="${r.comnum}"> <input
                  type="hidden" name="man" value="${param.man}">
               <c:if test="${sessionScope.loginUser.id == 'admin' or sessionScope.loginUser.id eq r.id}">
               <font size="1"> <input type="submit" value="삭제" role="button"
                           class="BaseButton BaseButton--skinGray size_comment">
               </font></c:if></form>
               </div>
               
            </div>
         </div>      


      </div><br>

         <div style="text-align: left; display: none;" id="updateform${r.comnum}">
               <form action="rupdate.shop" method="post" name="updatef${r.comnum}">
                  <input type="hidden" name="cnt" value="${param.cnt}"> <input
                     type="hidden" name="btype" value="${param.btype}"> <input
                     type="hidden" name="comnum" value="${r.comnum}"> <input
                     type="hidden" name="man" value="${param.man}">
                  
         
                     <div class="CommentWriter">
                        <div class="comment_inbox">
                           <em class="comment_inbox_name">${sessionScope.loginUser.id}</em>
                           <textarea  rows="1" name="content" id="content1"
                              class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px;">${r.content}</textarea>
                        </div>
                        
                        <div class="comment_attach">
                           <div class="register_box">
                              <a href="javascript:recent(document.updatef${r.comnum})" class="button button--green ">수정</a>
                           </div>
                        </div>
                     </div>
                  
               </form>

         </div>
      </c:forEach>


<c:if test="${!empty sessionScope.loginUser}">
   <form action="comment.shop" method="post" name="f">
      <%--댓글 --%>
      <input type="hidden" name="id" value="${sessionScope.loginUser.id}">
      <input type="hidden" name="btype" value="${param.btype}"> <input
         type="hidden" name="cnt" value="${param.cnt}"> <input
         type="hidden" name="comnum" value="${comment.comnum}"> <input
         type="hidden" name="man" value="${param.man}">
      <div class="CommentWriter">
         <div class="comment_inbox">
            <em class="comment_inbox_name">${sessionScope.loginUser.id}</em>
            <textarea placeholder="댓글을 입력해주세요" rows="1" name="content" id="content1"
               class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px;"></textarea>
         </div>
         <div class="comment_attach">
            <div class="register_box">            
               <a href="javascript:inputcheck()" class="button button--green ">등록</a>
               
            </div>
         </div>
      </div>
   </form>
</c:if>

<c:if test="${empty sessionScope.loginUser}">
   <div class="CommentWriter">
         <div class="comment_inbox">
            <em class="comment_inbox_name">${sessionScope.loginUser.id}</em>
            <textarea placeholder="댓글을 입력해주세요" rows="1" name="content" id="content1" 
               class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px;"></textarea>
         </div>
         <div class="comment_attach">
            <div class="register_box">
               <button class="button button--green" onclick="replycheck()">등록</button>
            </div>
         </div>
      </div>
</c:if>


</body>
</html>