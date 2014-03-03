<%-- 
    Document   : InformeEmpleados
    Created on : 26-feb-2014, 13:38:01
    Author     : alumno
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!AccesoJDBC jdbc = new AccesoJDBC();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
    </head>
    <body>
        <h1>Empleados:</h1>
<%
    ResultSet rs = jdbc.getEmpleados();
    while (rs.next()){
%>
        <a href="CrearInforme.jsp?emp_no=<%=rs.getString("EMP_NO")%>"><%=rs.getString("APELLIDO")%></a><br/>
<%
    }
%>
    </body>
</html>
