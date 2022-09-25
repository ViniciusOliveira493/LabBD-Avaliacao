CREATE DATABASE AVL1LabBD
GO
USE AVL1LabBD
GO
CREATE TABLE Times (CodigoTime INT PRIMARY KEY, NomeTime VARCHAR(20), Cidade VARCHAR(90), Estadio VARCHAR(30))
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
CREATE TABLE Grupos(Grupo CHAR,
CodigoTime INT FOREIGN KEY REFERENCES Times(CodigoTime),
CONSTRAINT pk_GCT PRIMARY KEY(GRUPO,CodigoTime))
GO
CREATE TABLE Jogos(CodigoTimeA INT,
CodigoTimeB INT,
GolsTimeA INT,
GolsTimeB INT,
Datajogo INT,
PRIMARY KEY(CodigoTimeA, CodigoTimeB, Datajogo),
FOREIGN KEY (CodigoTimeA) REFERENCES Times(CodigoTime),
FOREIGN KEY (CodigoTimeB) REFERENCES Times(CodigoTime)
)


