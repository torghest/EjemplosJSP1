<%-- 
    Document   : includError
    Created on : 25-feb-2014, 13:19:49
    Author     : alumno
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%!public static AccesoJDBC jdbc = new AccesoJDBC();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Departamentos</title>
    </head>
    <body bgcolor="#7A7BAB">
        <table align="center">
            <tr>
                <td>
                    <!-- include banner -->
                    <%@include file="Banner.htm"%>
                </td>
            </tr>
            <tr>
                <td bgcolor="#CCCCCC" style="border: 1px solid">
                    <font size="5">
                    <b>Departamentos:</b>
                    </font>
                    <form name="form" action="includError.jsp" method="post">
                        <select name="dept">
<%
    String deptCheck = request.getParameter("dept");
    ResultSet rs;
    rs = jdbc.getDepartamentos();
    while (rs.next()){
        String selected = "";
        String cod = rs.getString("DEPT_NO");
        String nom = rs.getString("DNOMBRE");
        if (deptCheck != null){
            selected = (deptCheck.equals(cod))?" SELECTED":"";
        }
%>                        
                            <option value="<%=cod%>"<%=selected%>><%="("+cod+")"+nom%></option>
<%
    }
%>
                            <option value="aa">ProvocarError</option>
                        </select>
                        <input type="submit" value="Buscar"/>
                    </form>
                </td>
            </tr>
<%
    if (deptCheck != null){
%>
            <tr>
                <td bgcolor="#FFFFFF" style="border: 1px solid">
<%
        rs = jdbc.getEmpDept(deptCheck);
        if (rs.next()){
            rs.beforeFirst();
            ResultSetMetaData rsmd = rs.getMetaData();
%>
                    <table border="1" align="center" width="100%">
                        <form name="formBorrado" action="includError2.jsp" method="post">
                        <tr>
                            
<%
            for (int i = 0; i <= rsmd.getColumnCount(); i++){
%>
                            <td bgcolor="#666666" align="center"><!-- Cabeceras -->
                                <font color="#CCCCCC">
                                <b><%=(i==0)?"Sel.":rsmd.getColumnName(i)%></b>
                                </font>
                            </td>
<%
            }
%>
                        </tr>
<%
            boolean par = false;
            while (rs.next()){
%>
                        <tr bgcolor="<%=(par)?"#DDDDDD":"#FFFFFF"%>">
<%
                for (int i = 0; i <= rsmd.getColumnCount(); i++){
                    String input = "<input type=\"checkbox\" name=\"empleados\" value=\""+rs.getString("EMP_NO")+"\"/>";
%>
                            <td><!-- Datos -->
                                <%=(i==0)?input:rs.getString(i)%>
                            </td>
<%
                }
%>
                        </tr>
<%
                par = !par;
            }
%>
                        <tr>
                            <td colspan="<%=rsmd.getColumnCount()+1%>" bgcolor="#666666">
                                <input type="submit" value="Borrar Selección"
                            </td>
                        </tr>
                        </form>
                    </table>
<%
        } else {
%>
                    <h3>No hay empleados en este departamento</h3>
<%
        }
%>
                </td>
            </tr>
<%
    }
%>
        </table>
    </body>
</html>
