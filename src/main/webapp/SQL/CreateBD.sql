CREATE DATABASE AVL1LabBD
GO
USE AVL1LabBD
GO
CREATE TABLE Times (codigoTime INT PRIMARY KEY, nomeTime VARCHAR(20), cidade VARCHAR(90), estadio VARCHAR(30))
GO
INSERT INTO Times VALUES
	(1, 'Corinthians','S�o Paulo','Neo Qu�mica Arena'),
    (2,'Palmeiras','S�o Paulo','Allianz Parque'),
	(3,'Santos','Santos','Vila Belmiro'),
	(4,'S�o Paulo','S�o Paulo','Morumbi'),
	(5, 'Botafogo-SP', 'Ribeir�o Preto','Santa Cruz'),
	(6,'Ferrovi�ria','Araraquara','Fonte Luminosa'),
	(7,'Guarani','Campinas','Brinco de Ouro'),
	(8,'Inter de Limeira', 'Limeira','Limeir�o'),
	(9,'Ituano','Itu','Novelli J�nior'),
	(10,'Mirassol','Mirassol','Jos� Maria de Campos Maia'),
	(11,'Novorizontino','Novo Horizonte','Jorge Ismael de Biasi'),
	(12,'Ponte Preta','Campinas','Mois�s Lucarelli'),
	(13,'Red Bull Bragantino','Bragan�a Paulista','Nabi Abi Chedid'),
	(14,'Santo Andr�','Santo Andr�','Bruno Jos� Daniel'),
	(15,'S�o Bento','Sorocaba','Walter Ribeiro'),
	(16,'S�o Caetano','S�o Caetano do Sul','Anacletto Campanella')
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
