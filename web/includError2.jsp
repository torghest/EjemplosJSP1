<%-- 
    Document   : includError2
    Created on : 25-feb-2014, 19:13:31
    Author     : compac
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procesado</title>
    </head>
    <body bgcolor="#7A7BAB">
        <table border="2" align="center">
            <tr>
                <td>
                    <%@include file="Banner.htm" %>
                </td>
            </tr>
            
                    
                </td>
            </tr>
<%
    String[] datos = request.getParameterValues("empleados");
    for (String dato: datos){
%>
            <tr>
                <td>
                    <h5><%=dato%></h5>
                </td>
            </tr>
<%        
    }
%>
        </table>
    </body>
</html>
