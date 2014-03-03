<%-- 
    Document   : Paginacion
    Created on : 25-feb-2014, 10:47:37
    Author     : alumno
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String consulta;
            int posicion;
            int numeroregistros=0;
           
            if(request.getParameter("posicion")!=null){
                posicion=Integer.parseInt(request.getParameter("posicion"));
            }else{
                posicion=1;
            }

            try{
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                Connection cn=DriverManager.getConnection("jdbc:oracle:thin:@LOCALHOST:1521:XE","system", "javaoracle");
                Statement sentencia = cn.createStatement();
                consulta="SELECT APELLIDO, SALARIO, OFICIO FROM (SELECT tablaemp.*, ROWNUM rnum FROM (SELECT APELLIDO, SALARIO, OFICIO FROM emp ORDER BY APELLIDO) tablaemp WHERE ROWNUM < "+(posicion+5)+") WHERE rnum >= "+posicion;
                ResultSet rs=sentencia.executeQuery(consulta);
                Statement sentencia2 = cn.createStatement();
                ResultSet rs2 = sentencia2.executeQuery("SELECT COUNT(EMP_NO) AS NUMERO FROM EMP");
                rs2.next();
                numeroregistros = rs2.getInt("NUMERO");
                rs2.close();
                String tabla = "<table border='1'>";
                tabla += "<tr><th>APELLIDO</th><th>SALARIO</th><th>OFICIO</th></tr>";

                while(rs.next())
                {
                    tabla += "<tr><td>"+rs.getString("APELLIDO")+"</td>";
                    tabla += "<td>"+rs.getString("SALARIO")+"</td>";
                    tabla += "<td>"+rs.getString("OFICIO")+"</td>";
                    tabla +="</tr>";
                }
                tabla += "</table>";
                int numpagina = 1;
                for (int i=0;i < numeroregistros; i+=5)
                {
                    int aux = i + 1;
                    tabla +="<a href='Paginacion.jsp?posicion="+ aux + "'>"+numpagina+"</a>&nbsp;";
                    numpagina++;
                }%>
               <%=tabla%>
          <% }catch(Exception ex)
            {%><h1>ERROR <%=ex.toString()%></h1>
          <%}%>

    </body>
</html>
