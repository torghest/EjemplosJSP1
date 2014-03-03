<%-- 
    Document   : index
    Created on : 24-feb-2014, 9:43:56
    Author     : alumno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>
        <%!int i = 6;%>
        <%
            if (i%2==0){
                out.println("PAR");
            }else{
                out.println("IMPAR");
            }
        %>
        </h1>
    </body>
</html>
