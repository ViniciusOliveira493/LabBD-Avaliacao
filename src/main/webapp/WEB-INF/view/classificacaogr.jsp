<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Classificação Grupos</title>
		<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
	</head>
	<body>
		<jsp:include page="menu.jsp" />
		<main>
			<div class="conteudo">
				<h1 align="center">Classificação Grupos</h1>
				<div class="center">
					<c:if test="${not empty listaClassificacao}">
						<div class="divTb">
							<table class = "" id="tbClassificacao" border = "1">
								<thead>
										<tr>
											<th>
												Nome Time
											</th>
											<th>
												Total de jogos disputados
											</th>
											<th>
												Total de Vitórias
											</th>
											<th>
												Total de Empates
											</th>
											<th>
												Total de Derrotas
											</th>
											<th>
												Gols Marcados
											</th>
											<th>
												Gols Sofridos
											</th>
											<th>
												Saldo Gols
											</th>
											<th>
												Pontos
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${listaClassificacao}" var="m">
											<tr>
												<td class="coluna">
													${m.nomeTime}
												</td>
												<td class="coluna">
													${m.numeroJogosDisputados}
												</td>
												<td class="coluna">
													${m.vitorias}
												</td>
												<td class="coluna">
													${m.empates}
												</td>
												<td class="coluna">
													${m.derrotas}
												</td>
												<td class="coluna">
													${m.golsMarcados}
												</td>
												<td class="coluna">
													${m.golsSofridos}
												</td>
												<td class="coluna">
													${m.saldoGols}
												</td>
												<td class="coluna">
													${m.pontos}
												</td>
											</tr>
										</c:forEach>
									</tbody>
							</table>
						</div>
					</c:if>
					<c:if test="${empty listaClassificacao}">
						<p>Não há partidas realizadas</p>
					</c:if>
				</div>
			</div>
		</main>
	</body>
</html>