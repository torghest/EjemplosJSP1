<%-- 
    Document   : Ejemplo3
    Created on : 24-feb-2014, 11:39:17
    Author     : alumno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ejemplo3 JSP</title>
    </head>
    <body>
        Hola: <%=request.getParameter("txtNombre")%>
        <br/>
        Edad: <%=request.getParameter("txtNombre")%>
        <hr/>
    </body>
</html>
