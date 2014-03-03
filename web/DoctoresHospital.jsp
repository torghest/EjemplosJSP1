<%-- 
    Document   : DoctoresHospital
    Created on : 25-feb-2014, 8:17:54
    Author     : alumno
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
public static AccesoJDBC jdbc = new AccesoJDBC();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctores del Hospital</title>
    </head>
    <body>
        <table border="2" align="center">
            <tr>
                <td bgcolor="#CCCCCC">
                <form name="form" action="DoctoresHospital.jsp" method="post">
<%
    ResultSet rs;
    String[] datos = request.getParameterValues("hospitales");
    rs = jdbc.getHospitales();
    while (rs.next()){
        String cod = rs.getString("HOSPITAL_COD");
        String nombre = rs.getString("NOMBRE");
        boolean esta = false;
        if (datos != null){
            for (int i = 0; (i < datos.length) && !esta; i++){
                if (cod.equals(datos[i])){
                    esta = true;
                }
            }
        }
%>                    
                    <input type="checkbox" name="hospitales" value="<%=cod%>" <%=(esta)?"checked":""%>/><%=nombre%><br/>
<%
    }
%>
                    <hr/>
                    <input type="submit" value="Mostrar Doctores"/>
                </form>
                </td>
            </tr>
            <tr>
                <td>
<%
    if (datos == null){
%>
                    <h3>Seleccione Hospitales</h3>
<%
    } else {
        rs = jdbc.selDoctHosp(datos);
        if (!rs.next()){
%>
                    <h3>No hay doctores para los<br>hospitales selecionados</h3>
<%
        } else {
            rs.beforeFirst();
%>                    
                    <table border="1" align="center">
                        <tr><!-- Cabeceras -->
<%
            ResultSetMetaData rsmd = rs.getMetaData();
            for (int i = 1; i <= rsmd.getColumnCount(); i++){
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
                        <tr><!-- Datos -->
<%
                for (int i = 1; i <= rsmd.getColumnCount(); i++){
%>
                            <td align="center">
                                <%=rs.getString(i)%>
                            </td>
<%
                }
%>
                        </tr>
<%
            }
%>
                    </table>
<%
        }
    }
%>
                </td>
            </tr>
        </table>
    </body>
</html>
