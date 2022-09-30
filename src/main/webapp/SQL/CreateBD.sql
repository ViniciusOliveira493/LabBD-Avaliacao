CREATE DATABASE AVL1LabBD
GO
USE AVL1LabBD
GO
CREATE TABLE Times (codigoTime INT PRIMARY KEY, nomeTime VARCHAR(20), cidade VARCHAR(90), estadio VARCHAR(30))
GO
INSERT INTO Times VALUES
	(1, 'Botafogo-SP', 'Ribeir�o Preto','Santa Cruz'),
	(2, 'Corinthians','S�o Paulo','Neo Qu�mica Arena'),
	(3,'Ferrovi�ria','Araraquara','Fonte Luminosa'),
	(4,'Guarani','Campinas','Brinco de Ouro'),
	(5,'Inter de Limeira', 'Limeira','Limeir�o'),
	(6,'Ituano','Itu','Novelli J�nior'),
	(7,'Mirassol','Mirassol','Jos� Maria de Campos Maia'),
	(8,'Novorizontino','Novo Horizonte','Jorge Ismael de Biasi'),
	(9,'Palmeiras','S�o Paulo','Allianz Parque'),
	(10,'Ponte Preta','Campinas','Mois�s Lucarelli'),
	(11,'Red Bull Bragantino','Bragan�a Paulista','Nabi Abi Chedid'),
	(12,'Santo Andr�','Santo Andr�','Bruno Jos� Daniel'),
	(13,'Santos','Santos','Vila Belmiro'),
	(14,'S�o Bento','Sorocaba','Walter Ribeiro'),
	(15,'S�o Caetano','S�o Caetano do Sul','Anacletto Campanella'),
	(16,'S�o Paulo','S�o Paulo','Morumbi')
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