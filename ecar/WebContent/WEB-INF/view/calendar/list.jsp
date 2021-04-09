<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>



<meta charset="UTF-8">
<link rel="stylesheet" href="../css/calendar.css">
<style type="text/css">
            /* *{padding: 0px; margin: 0px;} */  /* 브라우저별 기본 여백 차이가 있기에 작성한다. */
            body{font-size: 12pt; margin: 0;}
            td{font-size: 15pt;}
            table {width: 60%; height:100px; margin: auto; text-align:center;}
            a{cusor: pointer; color: #000000; text-decoration: none; font-size: 12pt; line-height: 160%;}
            a:HOVER, a:ACTIVE{font-size: 9pt; color: #F28011; text-decoration: underline;}
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
</style>
<title>Insert title here</title>
</head>
<body>

<form>
<table>
<br>
<tr><td colspan="6"><b>기록</b></td></tr>
<tr><th>년도</th><th>월</th><th>일</th><th>주행 시간</th><th>충전 시간</th><th>충전 요금</th></tr>
<c:forEach items="${list}" var="calendar">
<tr><td>${calendar.year}</td>
   <td>${calendar.month}</td>
   <td>${calendar.day}</td>
   <td>${calendar.runt}</td>
   <td>${calendar.charge}</td>
   <td>${calendar.cost}</td>
</tr>
</c:forEach>
<tr><td colspan="6">
<a href="newCalendar.shop?id=${param.id}" role="button"
      class="BaseButton BaseButton--skinGray size_default"> <span
      class="BaseButton__txt">돌아가기</span></a>
</td>
</table>
</form>

</body>
</html>