<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Times</title>
<link href="./css/estilo.css" rel="stylesheet" type="text/css">
</head>
<body>


	<div class="container" id="topo">
		<header class="cabecalho" id="home">

			<h1 class="titulo">Campeonato Paulista</h1>
			<jsp:include page="menu.jsp" />
		</header>
		<br />
		<section class="conteudo">
			<div align="center">
		<c:if test="${not empty Times }">
			<table class="table_round">
				<thead>
					<tr>
						<th><b>#codigo</b></th>
						<th><b>Nome</b></th>
						<th><b>Cidade</b></th>
						<th><b>Estadio</b></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${Times }" var="t">
					<tr>
						<td><c:out value="${t.codigo }" /></td>
						<td><c:out value="${t.nome }" /></td>
						<td><c:out value="${t.cidade }" /></td>
						<td><c:out value="${t.estadio }" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
			<form>
			<input type="submit" name="btnSub" id="btnSub" value="Gerar Grupos">
			</form>
		</section>
	</div>

</body>
</html>