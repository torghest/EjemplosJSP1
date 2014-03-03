<%-- 
    Document   : PagEmp
    Created on : 25-feb-2014, 11:17:14
    Author     : alumno
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
public static AccesoJDBC jdbc = new AccesoJDBC();
public static int regPorPagina = 3;
%>
<!DOCTYPE html>
<%
    String p = request.getParameter("pagina");
    int pagina = 1;
    if (p != null){
        pagina = Integer.parseInt(p);
    }
    String regPag = request.getParameter("numReg");
    int nrp = regPorPagina;
    if (regPag != null){
        nrp = Integer.parseInt(regPag);
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados // Pagina <%=pagina%></title>
    </head>
    <body>
        <table border="2" align="center">
            <tr>
<%
    ResultSet rs = jdbc.getEmpPaginado(pagina,nrp);
    ResultSetMetaData rsmd = rs.getMetaData();
    for (int i = 1; i < rsmd.getColumnCount(); i++){
%>
                <td bgcolor="#666666" align="center">
                    <font color="#CCCCCC">
                    <b><%=rsmd.getColumnName(i)%></b>
                    </font>
                </td>
<%
    }
%>
            </tr>
<%
    while (rs.next()){
%>
            <tr>
<%
        for (int i = 1; i < rsmd.getColumnCount(); i++){
%>
                <td>
                    <%=rs.getString(i)%>
                </td>
<%
        }
%>
            </tr>
<%        
    }
%>
            <tr>
                <td>
<%
    if (pagina > 1){
%>
                    <a href="PagEmp.jsp?pagina=<%=(regPag==null)?pagina-1:(pagina-1)+"&numReg="+regPag%>">Anterior</a>
<%
    } else {
%>
                    <font color="#CCCCCC">Anterior</font>
<%
    }
%>
                </td>
                <td colspan="<%=rsmd.getColumnCount()-3%>">
                </td>
                <td>
<%
    int numReg = jdbc.numEmp();
    if (pagina*nrp < numReg){
%>
                    <a href="PagEmp.jsp?pagina=<%=(regPag==null)?pagina+1:(pagina+1)+"&numReg="+regPag%>">Siguiente</a>
<%
    } else {
%>
                    <font color="#CCCCCC">Siguiente</font>
<%
    }
%>
                </td>
            </tr>
        </table>
    </body>
</html>
