<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.SqlConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="util.Tools" %>

<html>
<head>
    <title>Less-18 Header Injection- Error Based- string </title>
</head>

<body bgcolor="#000000">
<div style=" margin-top:70px;color:#FFF; font-size:23px; text-align:center">Welcome&nbsp;&nbsp;&nbsp;<font
        color="#FF0000"> Sqli-labs(Java) </font><br>
    <font size="4" color="#FFFF00">

        基于错误的用户代理，头部POST注入</br></br></br>
        <div  align="center" style="margin:40px 0px 0px 520px;border:20px; background-color:#0CF; text-align:center; width:400px; height:150px;">

            <div style="padding-top:10px; font-size:15px;">

                <!--Form to post the data for sql injections Error based SQL Injection-->
                <form action="" name="form1" method="post">
                    <div style="margin-top:15px; height:30px;">Username : &nbsp;&nbsp;&nbsp;
                        <input type="text"  name="uname" value=""/>
                    </div>
                    <div> Password  : &nbsp;&nbsp;&nbsp;
                        <input type="text" name="passwd" value=""/>
                    </div></br>
                    <div style=" margin-top:9px;margin-left:90px;">
                        <input type="submit" name="submit" value="Submit" />
                    </div>
                </form>

            </div></div>
        <%
            String uagent = request.getHeader("User-Agent");
            String ip = request.getRemoteAddr();

        %>
        <br>Your IP ADDRESS is:  <%=ip%><br>
        <%
            if(request.getMethod().equals("POST")) {
                String uname = request.getParameter("uname");
                String passwd = request.getParameter("passwd");
                uname = Tools.check_input(uname,20);
                passwd = Tools.check_input(passwd,20);
                ResultSet rs = null;
                boolean flag = false;
                SqlConnection con = new SqlConnection();
                if(uname != null && passwd !=null) {
                    String sql ="SELECT  users.username, users.password FROM users WHERE users.username=" + uname +
                            "and users.password=" + passwd + " ORDER BY users.id DESC LIMIT 0,1";
                    try {
                        rs = con.select(sql);
                        if(rs.next()) {
                            flag = true;
                            String
                                    insert="INSERT INTO uagents(uagent, ip_address, username) VALUES ('" + uagent + "', '" + ip + "', " + uname + ")";

                            con.insert(insert);
        %>
        <font color= "#0000ff" font size = 3 >
            Your User Agent is: <%=uagent%>
        </font>
        </br></br><img src="../images/flag.jpg"  />
        <%            }
        } catch (SQLException e) {
        %>
        <font color= "#0000ff" font size="3">
            <%=e.getMessage()%>
        </font>
        <%
            }
            con.colse();
            if(!flag) { %>
        </br></br></br><img src="../images/slap.jpg" />
        <%            }
        }
        }
        %>

    </font> </div>
</body>
</html>