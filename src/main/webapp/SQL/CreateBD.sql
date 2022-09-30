CREATE DATABASE AVL1LabBD
GO
USE AVL1LabBD
GO
CREATE TABLE Times (codigoTime INT PRIMARY KEY, nomeTime VARCHAR(20), cidade VARCHAR(90), estadio VARCHAR(30))
GO
INSERT INTO Times VALUES
	(1, 'Corinthians','São Paulo','Neo Química Arena'),
    	(2,'Palmeiras','São Paulo','Allianz Parque'),
	(3,'Santos','Santos','Vila Belmiro'),
	(4,'São Paulo','São Paulo','Morumbi'),
	(5, 'Botafogo-SP', 'Ribeirão Preto','Santa Cruz'),
	(6,'Ferroviária','Araraquara','Fonte Luminosa'),
	(7,'Guarani','Campinas','Brinco de Ouro'),
	(8,'Inter de Limeira', 'Limeira','Limeirão'),
	(9,'Ituano','Itu','Novelli Júnior'),
	(10,'Mirassol','Mirassol','José Maria de Campos Maia'),
	(11,'Novorizontino','Novo Horizonte','Jorge Ismael de Biasi'),
	(12,'Ponte Preta','Campinas','Moisés Lucarelli'),
	(13,'Red Bull Bragantino','Bragança Paulista','Nabi Abi Chedid'),
	(14,'Santo André','Santo André','Bruno José Daniel'),
	(15,'São Bento','Sorocaba','Walter Ribeiro'),
	(16,'São Caetano','São Caetano do Sul','Anacletto Campanella')
GO
--========================== Create table Grupos =============================--
CREATE TABLE Grupos(grupo CHAR,
	codigoTime INT FOREIGN KEY REFERENCES Times(CodigoTime) UNIQUE,
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
