<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Calendar"%>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <%
   //데이터베이스를 연결하는 관련 변수를 선언한다
  Connection conn= null;
  PreparedStatement pstmt = null;
   //데이터베이스를 연결하는 관련 정보를 문자열로 선언한다.
  String jdbc_driver= "oracle.jdbc.driver.OracleDriver"; //JDBC 드라이버의 클래스 경로
  String jdbc_url= "jdbc:oracle:thin:@localhost:3306";  //접속하려는 데이터베이스의 정보
   //JDBC 드라이버 클래스를 로드한다.
  Class.forName("org.mariadb.jdbc.Driver");
   //데이터베이스 연결 정보를 이용해서 Connection 인스턴스를 확보한다.
  conn= DriverManager.getConnection("jdbc:mariadb://localhost:3306/ecar","scott","1234");
  if (conn== null) {
   out.println("No connection is made!");
  }
  %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>MyPage</title>
<script type="text/javascript">
   $(document).ready(function(){
    $("#minfo").show();
    $("#oinfo").hide();
    $(".saleLine").each(function(){
       $(this).hide();
    })
    $("#tab1").addClass("select");
   })
   function disp_div(id,tab){ //minfo , tab1
      $(".info").each(function(){ //클래스 속성이 info인 친구들
         $(this).hide();
      })
      $(".tab").each(function(){
         $(this).removeClass("select");
      })
      $("#"+id).show();
      $("#" + tab).addClass("select");
   }
   function list_disp(id){
      $("#"+id).toggle(); //보였다 안보였다
   }
</script>
<script type="text/javascript">
function inputcheck() {
	f = document.f;
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.name.focus();
		return;
	}
	
	f.submit();
}
</script>
<style type="text/css">
.select {
	padding: 3px;
	background-color: #0000ff;
}

.select>a {
	color: #ffffff;
	text-decoration: none;
	font-weight: bold;
}
</style>

</head>
<body>
<table>
   <tr><td id="tab1" class="tab">
 <a href="javascript:disp_div('minfo','tab1')">내 정보</a></td>
   <c:if test="${param.id != 'admin' }">
   
       <td id="tab2" class="tab">
 <a href="javascript:disp_div('oinfo','tab2')">E-car 달력</a></td>
   </c:if></tr></table>

	<%-- oinfo : E-car 달력 정보 출력 --%>
	<div id="oinfo" class="info" style="display: none; width: 100%;">
	<c:if test="${sessionScope.login=='admin'}"> 
<form action="mypage.shop" method="post" name="f"> 
<table style="background-color:light-gray; margin-left: auto; margin-right: auto;">
<tr>
<td><input type="text" name="year" style="width:60px;">년</td>
<td><input type="text" name="month" style="width:60px;">월</td>
<td><input type="text" name="day" style="width:60px;">일</td>
<td><input type="text" name="time">충전시간</td>
<td><input type="text" name="work">주행시간</td>
<td><input type="text" name="cost">충전비용</td>
<td><a href="javascript:inputcheck()">달력 추가</a></td></tr>
</table>
</form>
</c:if>
<%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //나타내고자 하는 날짜
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //처음 호출했을 때
  year=currentYear;
  month=currentMonth;
  }
  else { //나타내고자 하는 날짜를 숫자로 변환
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
   if(month>11) { month=0; year=year+1; }
  }
%>
  <div>
  <table border=0> <!-- 달력 상단 부분, 더 좋은 방법이 없을까? -->
   <tr>
    <td align=left width=200> <!-- 년 도-->
    <a href="mypage.shop?id=${loginUser.id}&year=<%out.print(year-1);%>&month=<%out.print(month);%>">◀</a>
    <% out.print(year); %>년
    <a href="mypage.shop?id=${loginUser.id}&year=<%out.print(year+1);%>&month=<%out.print(month);%>">▶</a>
    </td>
    <td align=center width=300> <!-- 월 -->
    <a href="mypage.shop?id=${loginUser.id}&year=<%out.print(year);%>&month=<%out.print(month-1);%>">◀</a>
    <% out.print(month+1); %>월
    <a href="mypage.shop?id=${loginUser.id}&year=<%out.print(year);%>&month=<%out.print(month+1);%>">▶</a>
    </td>
    <td align=right width=200><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></td>
   </tr>
  </table>
  <table border=1 cellspacing=0> <!-- 달력 부분 -->
   <tr>
    <th width=100>일</th> <!-- 일=1 -->
    <th width=100>월</th> <!-- 월=2 -->
    <th width=100>화</th> <!-- 화=3 -->
    <th width=100>수</th> <!-- 수=4 -->
    <th width=100>목</th> <!-- 목=5 -->
    <th width=100>금</th> <!-- 금=6 -->
    <th width=100>토</th> <!-- 토=7 -->
   </tr>
   <tr height=80>
    <%
   cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
   int br=0; //7일마다 줄 바꾸기
   for(int i=0; i<(startDay-1); i++) { //빈칸출력
    out.println("<td>&nbsp;</td>");
    br++;
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //날짜출력
    out.println("<td>" + i + "<br>");
      //메모(일정) 추가 부분
      int memoyear, memomonth, memoday;
      try{
        // select 문장을 문자열 형태로 구성한다.
       String sql= "SELECT calyear, calmonth, calday, time, work, cost FROM calendar where id";
       pstmt= conn.prepareStatement(sql);
        // select 를 수행하면 데이터 정보가 ResultSet 클래스의 인스턴스로 리턴
       ResultSet rs= pstmt.executeQuery();
       while (rs.next()) { // 마지막 데이터까지 반복함.
        //날짜가 같으면 데이터 출력
        memoyear=rs.getInt("calyear");
        memomonth=rs.getInt("calmonth");
        memoday=rs.getInt("calday");
        if(year==memoyear && month+1==memomonth && i==memoday) {
         out.println("<b>"+"충전시간 : "+rs.getString("time")+"분"+"<br>"
        +"주행시간:"+rs.getString("work")+"분"+"<br>"+"충전비용"+rs.getString("cost")+"원"+"</b><br>"); 
        }
       }
       rs.close();
      }
      catch(Exception e) {
       System.out.println(e);
      };
    out.println("</td>");
    br++;
    if((br%7)==0 && i!=end) {
     out.println("</tr><tr height=80>");
    }
   }
   while((br++)%7!=0) //말일 이후 빈칸출력
    out.println("<td>&nbsp;</td>");
   %>
   </tr>
  </table>
  </div>   
  <div>
		<table>
			<tr>
				<th>한 달 충전 시간</th>
				<th>72(h)</th>
			</tr>
			<tr>
				<th>한 달 주행 시간</th>
				<th>20(h)</th>
			</tr>
			<tr>
				<th>한 달 충전 비용</th>
				<th>9200(원)</th>
			</tr>
		</table>
	</div>
</div>  
	<%-- minfo : 내 정보 출력 --%>
	<div id="minfo" class="info">
		<table>
			<tr>
				<td>아이디</td>
				<td>${user.id}</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>${user.name}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${user.email}</td>
			</tr>
			<tr>
				<td>거주지역</td>
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
			</tr>
		</table>
		<br> <a href="update.shop?id=${loginUser.id}">[정보수정]</a>&nbsp; 
		<a href="password.shop">[비밀번호수정]</a>&nbsp;
		<c:if test="${loginUser.id != 'admin' }">
			<a href="delete.shop?id=${loginUser.id}">[회원탈퇴]</a>&nbsp;
         </c:if>
		<c:if test="${loginUser.id == 'admin' }">
			<a href="../admin/list.shop">[회원목록]</a>&nbsp;
          </c:if>
	</div>
	<br>
</body>
</html>
 <%
       pstmt.close();
       conn.close();
   %>