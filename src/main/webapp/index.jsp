<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>table</title>
	</head>
	<body>
	
		<header class="cabecalho" id="home">

			<h1 class="titulo">Campeonato Paulista</h1>
			<jsp:include page="menu.jsp" />
		</header>
		<br />
		<form action="jogos" method="post">
			<input type="text" name="txtUsr" id="txtUsr">
			<input type="password" name="txtPass" id="txtPass">
			<input type="submit" name="btnSub" id="btnSub" value="send">
		</form>
		
		<form action="jogos" method="get">
			<input type="text" name="txtUsr" id="txtUsr">
			<input type="password" name="txtPass" id="txtPass">
			<input type="submit" name="btnSub" id="btnSub" value="send">
		</form>
	</body>
</html>