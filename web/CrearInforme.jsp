<%-- 
    Document   : CrearInforme
    Created on : 26-feb-2014, 13:50:13
    Author     : alumno
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.util.Date"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.pdf.PdfPCell"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="JDBC.AccesoJDBC"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!AccesoJDBC jdbc = new AccesoJDBC();%>
<%
    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    Date fechaactual = new Date();
    DecimalFormat formateado = new DecimalFormat("####.## €");
    String emp = request.getParameter("emp_no");
    if (emp != null){
        ResultSet rs = jdbc.getEmpleado(Integer.parseInt(emp));
        rs.next();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nomina <%=emp%></title>
    </head>
    <body>
<%
        try{
            Document d = new Document();
            ByteArrayOutputStream salida = new ByteArrayOutputStream();
            PdfWriter.getInstance(d, salida);

            d.open();
            PdfPTable table = new PdfPTable(2);
            PdfPCell cell = new PdfPCell(new Paragraph("NOMINA EMPLEADO "+emp));
            cell.setHorizontalAlignment(1);
            cell.setColspan(2);
            table.addCell(cell);
            cell.setPhrase(new Paragraph("Fecha "+df.format(fechaactual)));
            cell.setHorizontalAlignment(0);
            table.addCell(cell);
            table.addCell("Apellido");
            table.addCell(rs.getString("APELLIDO").toUpperCase());
            table.addCell("Oficio");
            table.addCell(rs.getString("OFICIO"));
            table.addCell("Fecha de Alta");
            table.addCell(rs.getString("FECHA_ALT"));
            String Salario = rs.getString("SALARIO");
            table.addCell("Salario");
            table.addCell(formateado.format(Double.parseDouble(Salario)));
            String Comision = rs.getString("COMISION");
            table.addCell("Comision");
            table.addCell(formateado.format(Double.parseDouble(Comision)));
            Double total = Double.valueOf(Salario) + Double.valueOf(Comision);
            table.addCell("IRPF(16%)");
            table.addCell(String.valueOf(formateado.format(total*-0.16)));
            table.addCell("Total");
            table.addCell(String.valueOf(formateado.format(total*0.84)));
            d.add(table);
            d.close();
            
            response.setContentType("application/pdf");
            response.setContentLength(salida.size());

            ServletOutputStream out2 = response.getOutputStream();
            salida.writeTo(out2);
            out2.flush();
                        
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
%>
            <h1>Excepcion: <%=e.toString()%></h1>");
<%
            e.printStackTrace(pw);
        }
%>
    </body>
</html>
<%
    }
%>
