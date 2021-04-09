<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    
    Calendar now = Calendar.getInstance();
    int year = now.get(Calendar.YEAR);
    int month = now.get(Calendar.MONTH)+1;
    int date = now.get(Calendar.DATE);
   
    String _year = request.getParameter("year");
    String _month = request.getParameter("month");
   
    if(_year != null)
        year = Integer.parseInt(_year);
   
    if(_month != null)
        month = Integer.parseInt(_month);
   
    now.set(year, month-1, 1);    //출력할 년도, 월로 설정
   
    year = now.get(Calendar.YEAR);    //변화된 년, 월
    month = now.get(Calendar.MONTH) + 1;
   
    int end = now.getActualMaximum(Calendar.DAY_OF_MONTH);    //해당월의 마지막 날짜
    int w = now.get(Calendar.DAY_OF_WEEK);    //1~7(일~토)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP 만년달력</title>
        <link rel="stylesheet" href="../css/calendar.css">
        <style type="text/css">
            *{padding: 0px; margin: 0px;}  /* 브라우저별 기본 여백 차이가 있기에 작성한다. */
            body{font-size: 11pt;}
            td{font-size: 12pt;}
            table {width: 420}
            a{cusor: pointer; color: #000000; text-decoration: none; font-size: 12pt; line-height: 150%;}
            a:HOVER, a:ACTIVE{font-size: 9pt; color: #F28011; text-decoration: underline;}
        </style>
       
        <script type="text/javascript">
            function sendIt()
            {
                var f = document.forms[0];
                f.submit();
            }
        </script>
        <style type="text/css">
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
    </head>
    <body>
        <br/>&nbsp;<br/>
       
        <center>
            <table class="table2" cellpadding="3" cellspacing="5">
                <tr height="30">
                    <td align="center">
                        <form action ="newCalendar.shop" method="get">
                            <select name="year" onchange="sendIt()">
                                    <%for(int i=year-5; i<year; i++) { %>
                                        <option value="<%=i%>" > <%=i%>년</option>
                                    <%} %>
                                    <option value="<%=year%>" selected="selected"><%=year%>년</option>
                                    <%for(int i=year+1; i<year+5; i++) { %>
                                        <option value="<%=i%>" > <%=i%>년</option>
                                    <%} %>
       
                            </select>
                           
                            <select name="month" onchange="sendIt()">
                                <% for(int i=1; i<=12; i++) {%>
                                    <option value="<%=i%>" <%=month==i?"selected='selected'":"" %>> <%=i%>월 </option>
                                <%} %>
                            </select>
                               
                        </form>
                        
                        
                        
                    </td>
                </tr>
            </table>
           
            <table class="2">
            
                <tr height="25">
                    <td align="center" bgcolor="#e6e4e6"><font color="red">일</font></td>
                    <td align="center" bgcolor="#e6e4e6">월</td>
                    <td align="center" bgcolor="#e6e4e6">화</td>
                    <td align="center" bgcolor="#e6e4e6">수</td>
                    <td align="center" bgcolor="#e6e4e6">목</td>
                    <td align="center" bgcolor="#e6e4e6">금</td>
                    <td align="center" bgcolor="#e6e4e6"><font color="blue">토</font></td>
                </tr>
                <%
                    int newLine = 0;
                    //1일이 어느 요일에서 시작하느냐에 따른 빈칸 삽입
                    out.println("<tr height='25'>");
                    for(int i=1; i<w; i++)
                    {
                        out.println("<td bgcolor='#ffffff'>&nbsp;</td>");
                        newLine++;
                    }
                   
                    String fc, bg;
                    for(int i=1; i<=end; i++)
                    {
                       
                        fc = (newLine == 0)?"red":(newLine==6?"blue":"#000000");
                        bg = "#ffffff";
                        out.println("<td align='center' bgcolor=" + bg + "><font color=" + fc + ">"
                                + i + "</font></td>");
                        newLine++;
                        if(newLine == 7 && i != end)
                        {
                            out.println("</tr>");
                            out.println("<tr height='25'>");
                            newLine = 0;
                        }
                    }
                   
                    while(newLine>0 && newLine<7)
                    {
                        out.println("<td bgcolor='ffffff'>&nbsp;</td>");
                        newLine++;   
                    }
                    out.println("</tr>");
                %>
            </table>
            
            <br>
            <br>
            <br>
            
            <b>${calendar.id}</b> 님의 오늘<b>(<%=year %>년 <%=month %>월 <%=date %>일)</b>의 기록
            <br><br>
         주행 시간:&nbsp; ${calendar.runt} 시간<br>
         충전 시간:&nbsp; ${calendar.charge} 시간<br>
         충전 요금:&nbsp; ${calendar.cost} 원
      
         <br>
         <br>
         <br>
            
            <a href="write.shop?id=${param.id}" role="button" class="BaseButton BaseButton--skinGray size_default"> 
            <span class="BaseButton__txt">등록</span></a>
            <a href="delete.shop?id=${param.id}" role="button" class="BaseButton BaseButton--skinGray size_default"> 
            <span class="BaseButton__txt">삭제</span></a>
            <a href="list.shop?id=${param.id}" role="button" class="BaseButton BaseButton--skinGray size_default"> 
            <span class="BaseButton__txt">기록 보기</span></a>
            
        </center>
    </body>
</html>