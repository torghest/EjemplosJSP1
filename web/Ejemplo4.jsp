<%-- 
    Document   : Ejemplo4
    Created on : 24-feb-2014, 11:59:31
    Author     : alumno
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
public static AccesoJDBC jdbc = new AccesoJDBC();
public ResultSet res;
%>
                    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle Oficios</title>
    </head>
    <body>
        <table align="center" border="2">
            <tr>
                <td bgcolor="#CCCCCC" align="right">
                <form name="form" action="Ejemplo4.jsp" method="GET">
                    Oficio:
                    <select name="oficio" onchange="form.submit()">
<%
    res = jdbc.getOficios();
    String sel = request.getParameter("oficio");
    while (res.next()){
        String oficio = res.getString(1);
        if (sel == null){
            sel = oficio;
        }
%>
                        <option value="<%=oficio%>" <%=(sel.equals(oficio))?"Selected":""%>><%=oficio%></option>
<%
    }
%>    
                    </select>
                </form>
                </td>
            </tr>
            <tr>
                <td>
<%
    res = jdbc.selPorOficio(sel);
%>
                    <table align="center" border="1">
<%
    ResultSetMetaData rsmd = res.getMetaData();
%>
                        <tr>
<%
    for (int i = 1; i <= rsmd.getColumnCount(); i++){
%>
                            <td bgcolor="#666666">
                                <font color="#CCCCCC">
                                <b><%=rsmd.getColumnName(i)%></b>
                                </font>
                            </td>
<%
    }
%>
                        </tr>
<%
    while (res.next()){
%>
                        <tr>
<%
        for (int i = 1; i <= rsmd.getColumnCount(); i++){
%>
                            <td>
                                <%=res.getString(i)%>
                            </td>
<%
        }
%>
                        </tr>
<%
    }
%>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
