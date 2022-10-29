<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Quartas de Final</title>
		<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
	</head>
	<body>
		<jsp:include page="menu.jsp" />
		<main>
			<div class="conteudo">
				<h1 align="center">Quartas de Final</h1>
				<div class="center">
					<c:if test="${not empty listaClassificacao}">
						<div class="container-tabela-quartas">
							<div class="divTbGrupo">
								<h3 align="center">GRUPO A</h3>
								<table class = "" id="tbGrupoA" border = "1">
									<thead>
										<tr>
											<th>
												Nome Time
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach begin ="0" end="1" items="${listaClassificacao}" var="m">
											<tr>
												<td class="coluna">
													${m.nomeTime}
												</td>												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="divTbGrupo">
								<h3 align="center">GRUPO B</h3>
								<table class = "" id="tbGrupoB" border = "1">
									<thead>
										<tr>
											<th>
												Nome Time
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach begin ="2" end="3" items="${listaClassificacao}" var="m">
											<tr>
												<td class="coluna">
													${m.nomeTime}
												</td>												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
						<div class="container-tabela-quartas">
							<div class="divTbGrupo">
								<h3 align="center">GRUPO C</h3>
								<table class = "" id="tbGrupoA" border = "1">
									<thead>
										<tr>
											<th>
												Nome Time
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach begin ="4" end="5" items="${listaClassificacao}" var="m">
											<tr>
												<td class="coluna">
													${m.nomeTime}
												</td>												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="divTbGrupo">
								<h3 align="center">GRUPO D</h3>
								<table class = "" id="tbGrupoB" border = "1">
									<thead>
										<tr>
											<th>
												Nome Time
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach begin ="6" end="7" items="${listaClassificacao}" var="m">
											<tr>
												<td class="coluna">
													${m.nomeTime}
												</td>												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</main>
	</body>
</html>