CREATE DATABASE AVL1LabBD
GO
USE AVL1LabBD
GO
CREATE TABLE Times (codigoTime INT PRIMARY KEY, nomeTime VARCHAR(20), cidade VARCHAR(90), estadio VARCHAR(30))
GO
INSERT INTO Times VALUES
	(1, 'Botafogo-SP', 'Ribeirão Preto','Santa Cruz'),
	(2, 'Corinthians','São Paulo','Neo Química Arena'),
	(3,'Ferroviária','Araraquara','Fonte Luminosa'),
	(4,'Guarani','Campinas','Brinco de Ouro'),
	(5,'Inter de Limeira', 'Limeira','Limeirão'),
	(6,'Ituano','Itu','Novelli Júnior'),
	(7,'Mirassol','Mirassol','José Maria de Campos Maia'),
	(8,'Novorizontino','Novo Horizonte','Jorge Ismael de Biasi'),
	(9,'Palmeiras','São Paulo','Allianz Parque'),
	(10,'Ponte Preta','Campinas','Moisés Lucarelli'),
	(11,'Red Bull Bragantino','Bragança Paulista','Nabi Abi Chedid'),
	(12,'Santo André','Santo André','Bruno José Daniel'),
	(13,'Santos','Santos','Vila Belmiro'),
	(14,'São Bento','Sorocaba','Walter Ribeiro'),
	(15,'São Caetano','São Caetano do Sul','Anacletto Campanella'),
	(16,'São Paulo','São Paulo','Morumbi')
GO
--========================== Create table Grupos =============================--
CREATE TABLE Grupos(grupo CHAR,
	codigoTime INT FOREIGN KEY REFERENCES Times(CodigoTime),
	CONSTRAINT pk_GCT PRIMARY KEY(GRUPO,CodigoTime))
GO
--========================== Create table Jogos =============================--
CREATE TABLE Jogos(
	codigoTimeA INT NOT NULL,
	codigoTimeB INT NOT NULL,
	golsTimeA INT,
	golsTimeB INT,
	datajogo DATE NOT NULL,
	PRIMARY KEY(CodigoTimeA, CodigoTimeB, Datajogo),
	FOREIGN KEY (CodigoTimeA) REFERENCES Times(CodigoTime),
	FOREIGN KEY (CodigoTimeB) REFERENCES Times(CodigoTime)
)