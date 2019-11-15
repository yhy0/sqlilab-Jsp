<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>获取 Cookie</title>
</head>
<body>
<%
    Cookie cookie = null;
    Cookie[] cookies = null;
    // 获取当前域名下的cookies，是一个数组
    cookies = request.getCookies();
    if( cookies != null ){
        out.println("<h2> 查找 Cookie 名与值</h2>");
        for (int i = 0; i < cookies.length; i++){
            cookie = cookies[i];
            if((cookie.getName()).compareTo("uname") == 0 ){
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                out.print("删除 Cookie: " +
                        cookie.getName( ) + "<br/>");
            }
            out.print("参数名 : " + cookie.getName());
            out.print("<br>");
            out.print("参数值: " + URLDecoder.decode(cookie.getValue(), "utf-8") +" <br>");
            out.print("------------------------------------<br>");
        }
    }else{
        out.println("<h2>没有发现 Cookie</h2>");
    }
%>
</body>
</html>