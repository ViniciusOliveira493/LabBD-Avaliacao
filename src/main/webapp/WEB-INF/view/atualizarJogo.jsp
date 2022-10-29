<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Atualização de Jogo</title>
		<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
	</head>
	<body>
		<jsp:include page="menu.jsp" />
		<main>
			<div class="conteudo">
				<form action="">
					<div class="divInput">
						Time A:
						<input type ="text" name="txtTimeA" id="txtTimeA">
						Gols:
						<input type ="text" name="txtGolsTimeA" id="txtGolsTimeA">
					</div>
					<div class="divInput">
						Time B:
						<input type ="text" name="txtTimeB" id="txtTimeB">
						Gols:
						<input type ="text" name="txtGolsTimeB" id="txtGolsTimeB">
					</div>
					<div class="divInput">
						Data:
						<input type ="date" name="txtDataJogo" id="txtDataJogo">
						<input type ="button" name="btnAtualizar" id="btnAtualizar" value = "Atualizar">
					</div>
				</form>
			</div>
		</main>
		
		<script type="text/javascript" src='<c:url value="./resources/js/atualizarJogo.js" />'></script>
	</body>
</html>