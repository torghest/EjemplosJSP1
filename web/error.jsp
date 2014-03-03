<%@page language = "java" isErrorPage = "true" %>
<HTML>
<HEAD><TITLE>Página de Error JSP's</TITLE></HEAD>
<BODY text="#ffffff" bgcolor="#7A7BAB">
<CENTER>
	<br></br>
	Ha ocurrido un error.<br></br>
	<%= exception %><br></br>
	Traza error <%= exception.getMessage() %><br></br>
	Por favor, póngase en contacto con el administrador<br></br>
	para notificarle dicho error.<br></br>
	<a href="mailto:webmaster@website.es">webmaster@website.es</a><br></br><br></br>
	Gracias.
</CENTER>
</BODY>
</HTML>
