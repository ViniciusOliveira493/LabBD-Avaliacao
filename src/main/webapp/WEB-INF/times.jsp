<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<header class="cabecalho" id="home">
			<h1 class="titulo">Campeonato Paulista</h1>
			<jsp:include page="../menu.jsp" />
		</header>
		<section class="conteudo">	
			<form action="${pageContext.request.contextPath}/times" method="post"><button type="submit">Buscar</button></form>
			<div align="center">
				<c:if test="${not empty erro }">
					<H2>
						<c:out value="${erro }" />
					</H2>
				</c:if>
			</div>
			<c:if test="${not empty times }">
				<table class="table_round">
					<thead>
						<tr>
							<th><b>Codigo</b></th>
							<th><b>Nome</b></th>
							<th><b>Cidade</b></th>
							<th><b>Estadio</b></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${times }" var="t">
							<tr>
								<td><c:out value="${t.codigoTime }" /></td>
								<td><c:out value="${t.nomeTime }" /></td>
								<td><c:out value="${t.cidade }" /></td>
								<td><c:out value="${t.estadio }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</section>
	
	</body>
</html>