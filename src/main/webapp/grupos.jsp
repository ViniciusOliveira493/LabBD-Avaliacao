<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Grupos</title>
		<link href="./css/estilo.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<jsp:include page="./menu.jsp" />
		<section class="conteudo">	
			<form action="grupos" method="post"><button type="submit">Gerar Grupos</button></form>
			<div align="center">
				<c:if test="${not empty erro }">
					<H2>
						<c:out value="${erro }" />
					</H2>
				</c:if>
			</div>
			<c:if test="${not empty grupos }">
				<table class="table_round">
					<thead>
						<tr>
							<th><b>Grupo</b></th>
							<th><b>Codigo</b></th>
							<th><b>Nome</b></th>
							<th><b>Cidade</b></th>
							<th><b>Estadio</b></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupos }" var="g">
						<c:if test="${g.grupo == 'A' }">
							<tr>
								<td><c:out value="${g.grupo }" /></td>
								<td><c:out value="${g.time.codigoTime }" /></td>
								<td><c:out value="${g.time.nomeTime }" /></td>
								<td><c:out value="${g.time.cidade }" /></td>
								<td><c:out value="${g.time.estadio }" /></td>
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		
				<c:if test="${not empty grupos }">
				<table class="table_round">
					<thead>
						<tr>
							<th><b>Grupo</b></th>
							<th><b>Codigo</b></th>
							<th><b>Nome</b></th>
							<th><b>Cidade</b></th>
							<th><b>Estadio</b></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupos }" var="g">
								<c:if test="${g.grupo == 'B' }">
							<tr>
								<td><c:out value="${g.grupo }" /></td>
								<td><c:out value="${g.time.codigoTime }" /></td>
								<td><c:out value="${g.time.nomeTime }" /></td>
								<td><c:out value="${g.time.cidade }" /></td>
								<td><c:out value="${g.time.estadio }" /></td>
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			
					<c:if test="${not empty grupos }">
				<table class="table_round">
					<thead>
						<tr>
							<th><b>Grupo</b></th>
							<th><b>Codigo</b></th>
							<th><b>Nome</b></th>
							<th><b>Cidade</b></th>
							<th><b>Estadio</b></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupos }" var="g">
						<c:if test="${g.grupo == 'C' }">
							<tr>
								<td><c:out value="${g.grupo }" /></td>
								<td><c:out value="${g.time.codigoTime }" /></td>
								<td><c:out value="${g.time.nomeTime }" /></td>
								<td><c:out value="${g.time.cidade }" /></td>
								<td><c:out value="${g.time.estadio }" /></td>
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			
					<c:if test="${not empty grupos }">
				<table class="table_round">
					<thead>
						<tr>
							<th><b>Grupo</b></th>
							<th><b>Codigo</b></th>
							<th><b>Nome</b></th>
							<th><b>Cidade</b></th>
							<th><b>Estadio</b></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grupos }" var="g">
							<c:if test="${g.grupo == 'D' }">
							<tr>
								<td><c:out value="${g.grupo }" /></td>
								<td><c:out value="${g.time.codigoTime }" /></td>
								<td><c:out value="${g.time.nomeTime }" /></td>
								<td><c:out value="${g.time.cidade }" /></td>
								<td><c:out value="${g.time.estadio }" /></td>
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		
		</section>
	
	</body>
</html>