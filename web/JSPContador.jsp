<HTML>
	<HEAD>
		<TITLE>Primer JSP</TITLE>
	</HEAD>
	<%! int cont = 0; %>
	<BODY bgcolor="navy" text="white">
		<CENTER>
			<%
				if( application.getAttribute( "contador" ) == null ) {
					application.setAttribute( "contador", "1" );
				}
				else {
					cont = Integer.parseInt( ( String )application.getAttribute( "contador" ) );
				}
				
				if( session.getAttribute( "sesion" ) == null ) {
					session.setAttribute( "sesion", session.getId() );
					application.setAttribute( "contador", ++ cont + "" );
				}
			%>
			<H1>La página ha sido visitada <%= cont %> veces</H1>
		</CENTER>
	</BODY>
</HTML>
