<%@page contentType="text/html"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page pageEncoding="ISO-8859-15" import="java.io.*,
com.lowagie.text.*,
com.lowagie.text.pdf.*,
com.lowagie.text.pdf.DefaultFontMapper,
com.lowagie.text.pdf.PdfContentByte,
com.lowagie.text.pdf.PdfTemplate,
com.lowagie.text.pdf.PdfWriter,java.text.*,java.util.*"
%>
<%
    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    Date fechaactual = new Date();
    DecimalFormat formateado = new DecimalFormat("####.##");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        try {
            Font[] fonts = new Font[3];
            fonts[0] = new Font(Font.HELVETICA, 20, Font.ITALIC);
            fonts[1] = new Font(Font.TIMES_ROMAN, 7, Font.BOLD);
            fonts[2] = new Font(Font.HELVETICA, 12,Font.BOLD);

            String datosCliente ="Jose Maria Gutierrez";

            double total = Double.parseDouble("60");
            double iva = total*0.16;
            double totalMasIva = total + iva;
            Image headerImage;

            headerImage = Image.getInstance(this.getServletContext().getRealPath("Images/LogoMadrid.jpg"));

            Document document = new Document();
            ByteArrayOutputStream salida = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, salida);

            document.open();
            document.add(new Paragraph(" "));                                                       //Retorno de carro
            document.add(new Phrase(new Chunk(headerImage, 350, 0)));                               //Añadir imagen
            PdfPTable table = new PdfPTable(3);                                                     //Nueva Tabla de 3 columnas
            PdfPCell cell = new PdfPCell(new Paragraph("FACTURA TIENDA OFICIAL",    fonts[0]));     //Creo celda con texto dentro
            cell.setHorizontalAlignment(1);                                                         //alineacion - centrado
            cell.setColspan(3);                                                                     //fusiona las 3 celdas
            table.addCell(cell);
            table.addCell("Factura nº");
            table.addCell("1");


            table.addCell("Madrid, "+df.format(fechaactual));
            cell = new PdfPCell(new Paragraph(datosCliente,fonts[2]));
            cell.setColspan(2);
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(""));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("Concepto"));
            cell.setColspan(2);
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(""));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("CAMISETA DEL REAL MADRID",fonts[2]));
            cell.setColspan(3);
            table.addCell(cell);
            table.addCell("Base Imponible:\n   "+formateado.format(total)+"¤");
            table.addCell("IVA 16%:\n  "+formateado.format(iva)+"¤");
            table.addCell("Total a pagar:\n  "+formateado.format(totalMasIva)+"¤");
            document.add(table);
            document.add(Chunk.NEWLINE);                                                            //Retorno de carro
            document.add(new Paragraph(" "));                                                       //Retorno de carro
            document.add(new Paragraph(" "));                                                       //Retorno de carro
            document.add(new Paragraph("FORMA DE PAGO:\n Si eres seguidor del Atlético de Madrid/Barcelona abone por adelantado", fonts[1]));
            document.close();


            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            // setting the content type
            response.setContentType("application/pdf");

            response.setContentLength(salida.size());

            ServletOutputStream out2 = response.getOutputStream();
            salida.writeTo(out2);
            out2.flush();

            } catch (Exception ex) {%>
                <h1>Excepcion: <%=ex.toString()%></h1>
            <%}

%>

    </body>
</html>
