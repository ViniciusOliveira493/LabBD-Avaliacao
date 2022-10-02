<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Jogos</title>
	</head>
	<body>
		<form action="jogos" method="post">
			<input type="submit" name="btn" id="btn" value="Criar Jogos">
			<input type="date" name="txtData" id="txtData">		
			<input type="submit" name="btn" id="btn" value="Pesquisar">	
		</form>
		<div>
			<c:if test="${not empty jogos}">
				<div class="divTb">
					<table>
						<thead>
							<tr>
								<th>
									Time 1
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
									<td>
										${m.timeA.nomeTime}
									</td>
									<td>
										${m.timeB.nomeTime}
									</td>
									<td>
										${m.golsTimeA}
									</td>
									<td>
										${m.golsTimeB}
									</td>
									<td>
										${m.datajogo}
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>
			<c:if test="${empty jogos}">
				<p>Não há rodadas nessa data</p>
			</c:if>
		</div>
	</body>
</html>