<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Jogos</title>
		<link href="./css/estilo.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<jsp:include page="menu.jsp" />
		<main>
			<div class="conteudo">
				<form action="jogos" method="post">
					<table>
						<tr>
							<td>
								<input class = "form-item" type="submit" name="btn" id="btn" value="Criar Jogos">
							</td>
							<td>
								<input class = "inputTxt" type="date" name="txtData" id="txtData" value='<c:out value="${data}"></c:out>'>	
								<input class = "" type="submit" name="btn" id="btn" value="Pesquisar">
							</td>
						</tr>
					</table>				
				</form>
				<div class="center">
					<c:if test="${not empty jogos}">
						<div class="divTb">
							<table class = "tbJogos" id="tbJogos" border = "1">
								<thead>
									<tr>
										<th>
											Time 1
										</th>
										<th>
											X
										</th>
										<th>
											Time 2
										</th>
										<th>
											Gols time 1
										</th>
										<th>
											Gols time 2
										</th>
										<th>
											Data do Jogo
										</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${jogos}" var="m">
										<tr>
											<td class="coluna">
												${m.timeA.nomeTime}
											</td>
											<td class="coluna">
												X
											</td>
											<td class="coluna">
												${m.timeB.nomeTime}
											</td>
											<td class="coluna">
												${m.golsTimeA}
											</td>
											<td class="coluna">
												${m.golsTimeB}
											</td>
											<td class="coluna">
												${m.datajogo}
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div>
							<input type="button" id="btnVisualizarJogo" value="Ver jogo"/>
						</div>
					</c:if>
					<c:if test="${empty jogos}">
						<p>Não há rodadas nessa data</p>
					</c:if>
				</div>
			</div>
		</main>
		<script type="text/javascript" src="./js/script.js"></script>
	</body>
</html>