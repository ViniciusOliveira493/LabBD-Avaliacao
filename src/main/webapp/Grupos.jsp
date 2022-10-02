<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Grupos</title>
</head>
<div class="container" id="topo">
		<header class="cabecalho" id="home">

			<h1 class="titulo">Campeonato Paulista</h1>
			<jsp:include page="menu.jsp" />
		</header>
		<br />
		<section class="conteudo">
			<div align="center">
		<c:if test="${not empty Grupos }">
			<table class="table_round">
				<thead>
					<tr>
						<th><b>#Grupo</b></th>
						<th><b>CodigoTime</b></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${Grupos }" var="g">
					<tr>
						<td><c:out value="${g.codigo }" /></td>
						<td><c:out value="${g.nome }" /></td>
						<td><c:out value="${g.cidade }" /></td>
						<td><c:out value="${g.estadio }" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
			<form>
			<input type="submit" name="btnSub" id="btnSub" value="Gerar grupos novamente">
			</form>
		</section>
	</div>

</body>
</html>