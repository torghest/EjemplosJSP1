<%@page import="java.util.Hashtable"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
public static AccesoJDBC jdbc = new AccesoJDBC();
public static int regPorPagina = 3;
public Hashtable hs;
public int total;
%>
<!DOCTYPE html>
<%
    if (session.getAttribute("hash") == null){
        hs = new Hashtable();
        session.setAttribute("hash", hs);
        total = 0;
        session.setAttribute("total", total);
    } else {
        hs = (Hashtable)session.getAttribute("hash");
        total = ((Integer)session.getAttribute("total")).intValue();
    }
    
    String[] anadir = request.getParameterValues("anadir");
    if (anadir != null){
        for (String c : anadir){
            String cod = c.substring(0,c.indexOf("/"));
            String val = c.substring(c.indexOf("/")+1);
            if (!hs.containsKey(cod)){
                total += Integer.parseInt(val);
                hs.put(cod,val);
            }
        }
    }
    
    String[] quitar = request.getParameterValues("quitar");
    if (quitar != null){
        for (String c : quitar){
            String cod = c.substring(0,c.indexOf("/"));
            String val = c.substring(c.indexOf("/")+1);
            if (hs.containsKey(cod)){
                total -= Integer.parseInt(val);
                hs.remove(c.substring(0,c.indexOf("/")));
            }
        }
    }
    
    if (anadir != null || quitar !=null){
        session.setAttribute("hash", hs);
        session.setAttribute("total", total);
    }
    
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
    <form name="form" action="SessionAplication.jsp?pagina=<%=(regPag==null)?pagina:(pagina)+"&numReg="+regPag%>" method="post">    
        <table border="2" align="center">
            <tr>
<%
    ResultSet rs = jdbc.getEmpPaginado(pagina,nrp);
    ResultSetMetaData rsmd = rs.getMetaData();
    for (int i = -1; i <= rsmd.getColumnCount(); i++){
%>
                <td bgcolor="#666666" align="center">
                    <font color="#CCCCCC">
                    <b><%=(i==-1)?"-":(i==0)?"+":rsmd.getColumnName(i)%></b>
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
        for (int i = -1; i <= rsmd.getColumnCount(); i++){
            String emp_no = rs.getString("EMP_NO");
            String rem = "<input type=\"checkbox\" name=\"quitar\" value=\""+emp_no+"/"+rs.getString("Salario")+"\""+((!hs.containsKey(emp_no))?" DISABLED":"")+"/>";
            String add = "<input type=\"checkbox\" name=\"anadir\" value=\""+emp_no+"/"+rs.getString("Salario")+"\""+((hs.containsKey(emp_no))?" CHECKED DISABLED":"")+"/>";
%>
                <td align="center">
                    <%=(i==-1)?rem:(i==0)?add:rs.getString(i)%>
                </td>
<%
        }
%>
            </tr>
<%        
    }
%>
            <tr>
                <td colspan="3" bgcolor="#DDDDDD" align="center">
                    <%=total%>
                </td>
                <td colspan="<%=rsmd.getColumnCount()-2%>" align="center">
<%
    int numReg = jdbc.numEmp();
    int pag = 1;
    for (int i = 1; i <= numReg; i += nrp){
        if (pagina == pag){
%>
                    <font color="#AAAAAA">
                    <b><%=pag++%></b>
                    </font>
<%
        } else {
%>
                    <a href="SessionAplication.jsp?pagina=<%=(regPag==null)?pag:(pag)+"&numReg="+regPag%>"><b><%=pag++%></b></a>
<%
        }
    }
%>
                </td>
                <td align="center">
                    <input type="submit" value="Actualizar"/>
                </td>
            </tr>
        </table>
    </form>
    </body>
</html>
