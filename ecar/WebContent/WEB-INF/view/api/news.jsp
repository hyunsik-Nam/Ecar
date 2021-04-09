<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>Ecar</title>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript" src = "http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
p {
   font-size: 60px;
   text-align: center;
   font-family: Fantasy;
   border-bottom: 12px solid #dcf1fb;
   padding: 0 0 0 0.2em;
}
span.n { color: skyblue;
}
span.e { color: pink;
}
span.w { color: skyblue;
}
span.s { color: pink;
}

.container {
top: 1px;
left: 1px;
padding: .8em .5em;
cursor: text;
text-align: center;
}
</style>
</head>

<body>
<br>
<p><span class="n">N</span><span class="e">E</span><span class="w">W</span><span class="s">S</span></p>
<form action="news.shop" method="post" name="n">
   <div class ='container'>
      <input type="text" name="keyword" placeholder="관심있는 차종 입력" style="width: 300px; height: 40px;">
      <input type="submit" name="검색" style="width: 50px; height: 40px;" value="검색">
      <br>
   </div>
   
<table>
<br>
   <tr>
      <td height="3" colspan="6" bgcolor="lightblue"></td>
   </tr>
   
   <c:forEach items="${news}" var="n">
      <tr>
         <td colspan="10" width="800" ><a href="${n.originallink}" target="_blank" style="text-decoration:none;">"${n.title}"</a></td>
      </tr>
      <tr>
         <!-- <td width="200">${n.originallink}</td>
         <td width="200">${n.link}</td>-->
         <td height="20" width="300">${n.pubDate}</td>
      </tr>
      <tr>
         <td colspan="300">${n.description}</td>
      </tr>      
      <tr>
         <td colspan="20" height="1" width="1000" bgcolor="lightblue"></td>
      </tr>
   </c:forEach>      
</table>
</form>
</body>
</html>