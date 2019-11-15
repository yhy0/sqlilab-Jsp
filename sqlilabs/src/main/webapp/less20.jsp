<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.SqlConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="util.Tools" %>

<html>
<head>
    <title>Less-20 Cookie Injection- Error Based- string </title>
</head>


<body bgcolor="#000000">
<div style=" margin-top:70px;color:#FFF; font-size:23px; text-align:center">Welcome&nbsp;&nbsp;&nbsp;<font
        color="#FF0000"> Sqli-labs(Java) </font><br>
    <font size="4" color="#FFFF00">

        基于错误的cookie头部POST注入<br><br><br></font>
<%
    Cookie[] cookies =request.getCookies();
    Cookie cookie = null;
    ResultSet rs = null;
    SqlConnection con = new SqlConnection();
    if(cookies != null ) {
        for (int i = 0; i < cookies.length; i++) {
            if ("uname".equalsIgnoreCase(cookies[i].getName())) {
                cookie = cookies[i];
            }
        }
    }
    if(cookie == null) {
        out.println("<div style=' margin-top:20px;color:#FFF; font-size:24px; text-align:center'> Welcome&nbsp;&nbsp;&nbsp;<font color='#FF0000'> Dhakkan </font><br></div>");
        out.println("<div  align='center' style='margin:20px 0px 0px 510px;border:20px; background-color:#0CF; text-align:center;width:400px; height:150px;'>");
        out.println("<div style='padding-top:10px; font-size:15px;'>");
        out.println("<!--Form to post the contents -->");
        out.println("<form action=' ' name='form1' method='post'>");
        out.println(" <div style='margin-top:15px; height:30px;'>Username : &nbsp;&nbsp;&nbsp;");
        out.println("   <input type='text'  name='uname' value=''/>  </div>");

        out.println(" <div> Password : &nbsp; &nbsp; &nbsp;");
        out.println("   <input type='text' name='passwd' value=''/></div></br>");
        out.println("   <div style=' margin-top:9px;margin-left:90px;'><input type='submit' name='submit' value='Submit' /></div>");

        out.println("</form>");
        out.println("</div>");
        out.println("</div>");
        out.println("<div style=' margin-top:10px;color:#FFF; font-size:23px; text-align:center'>");
        out.println("<font size='3' color='#FFFF00'>");
        out.println("<center><br><br><br>");
        out.println("<img src='../images/Less-20.jpg' />");
        out.println("</center>");
        if(request.getMethod().equals("POST")) {
            String uname = request.getParameter("uname");
            String passwd = request.getParameter("passwd");
            uname = Tools.check_input(uname,20);
            passwd = Tools.check_input(passwd,20);
            boolean flag = false;
            if(uname != null && passwd !=null) {
                String sql ="SELECT username, password FROM users WHERE username=" + uname +
                        " and password=" + passwd + " ORDER BY id DESC LIMIT 0,1";
                try {
                    rs = con.select(sql);
                    if(rs.next()) {
                        flag = true;
                        cookie = new Cookie("uname", rs.getString("username"));
                        cookie.setMaxAge(60 * 60 * 24);
                        response.addCookie(cookie);
                        out.println("<font color= '#FFFF00' font size = 3 >I LOVE YOU COOKIES</font> <br>");
                        out.println("<center>");
                        out.println("<form action='/less20.jsp' method='post'>");
                        out.println("<input  type='submit' name='submit' value='Flush!' />");
                        out.println("</form>");
                        out.println("</center>");
                        out.println("<br><br><img src='../images/flag.jpg' /><br>");
                    }
                } catch (SQLException e) {
                    out.println("<font color= '#0000ff' font size='3'>");
                    out.println(e.getMessage());
                    out.println("</font>");
                }
                con.colse();
                if(!flag) {
                    out.println("</br></br></br><img src='../images/slap.jpg' />");
                }
    }
    }
    } else {
        out.println("<center>");
        out.println("<br><br><br>");
        out.println("<img src='../images/Less-20.jpg' />");
        out.println("<br><br><b>");
        out.println("<br><font color= 'red' font size='4'>");
        out.println("YOUR USER AGENT IS : " + request.getHeader("User-Agent"));
        out.println("</font><br>");
        out.println("<font color= 'cyan' font size='4'>");
        out.println("YOUR IP ADDRESS IS : " + request.getRemoteAddr());
        out.println("</font><br>");
        out.println("<font color= '#FFFF00' font size = 4 >");
        out.println("DELETE YOUR COOKIE OR WAIT FOR IT TO EXPIRE <br>");
        out.println("<font color= 'orange' font size = 5 >");
        out.println("YOUR COOKIE : uname = " + cookie.getValue());
        out.println("<br></font>");
        String sql1 = "SELECT * FROM users WHERE username='" + cookie.getValue() + "' LIMIT 0,1";

        try {
            rs = con.select(sql1);
            if (rs.next()) {

                out.println("<font color= 'pink' font size='5'>");
                out.println("Your Login name: " + rs.getString("username"));
                out.println("<br>");
                out.println("<font color= 'grey' font size='5'>");
                out.println("Your Password:" + rs.getString("password"));
                out.println("</font></b>");
                out.println("<br>");
                out.println("Your ID: " + rs.getString("id"));
                out.println("<form action='/deleteCookie.jsp' method='post'>");
                out.println("<input type='submit' name='submit' value='Delete Your Cookie!' />");
                out.println("</form>");
                out.println("</center>");
            } else {
                out.println("<center>");
                out.println("<br><br><br>");
                out.println("<img src='../images/slap1.jpg' />");
                out.println("<br><br><b>");
                out.println("<center>");
            }

        } catch (SQLException e) {
            out.println("<font color= \"#0000ff\" font size=\"3\">");
            out.println(e.getMessage());
            out.println("</font>");
        }
    }
    %>

        </font> </div>
</body>
</html>