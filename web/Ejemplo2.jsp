<%-- 
    Document   : Ejemplo2
    Created on : 24-feb-2014, 10:45:29
    Author     : alumno
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta Dept</title>
    </head>
    <body>
        <%!AccesoJDBC jdbc = new AccesoJDBC(); %>
        <%
            ResultSet res = jdbc.consDept();
            ResultSetMetaData rsmd = res.getMetaData();
        %>
        <table border="2" align="center">
            <tr align="center">
            <%for (int i = 1; i <= rsmd.getColumnCount(); i++){%>
                <td bgcolor="black">
                    <font size="3" color="white">
                        <b><%=rsmd.getColumnName(i)%></b>
                    </font>
                </td>
            <%}%>
            </tr>
            <%while (res.next()){%>
            <tr align="center">
                <%for (int i = 1; i <= rsmd.getColumnCount();i++){%>
                <td>
                    <%=res.getString(i)%>
                </td>
                <%}%>
            </tr>
            <%}%>
        </table>
    </body>
</html>
