<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title></title>
</head>
<body>
	<nav class="menu">
		<h1 class="titulo">Campeonato Paulista</h1>
		<ul>
		  <li><a href="${pageContext.request.contextPath}/times">Home</a></li>
		 <li><a href="${pageContext.request.contextPath}/grupos">Grupos</a></li>
		  <li><a href="${pageContext.request.contextPath}/jogos">Jogos</a></li>
		  <li><a href="${pageContext.request.contextPath}/classificacao">Classificação</a></li>
		</ul>
	</nav>
</body>
</html>