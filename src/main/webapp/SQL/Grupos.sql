CREATE PROCEDURE sp_inseretime
AS
DELETE FROM Grupos
--Gerando Primeiros Quatro Times
DECLARE @GrupoA CHAR, @GrupoB CHAR, @GrupoC CHAR, @GrupoD CHAR, @time1 INT, @time2 INT, @time3 INT, @time4 INT
SET @GrupoA = 'A' 
SET @GrupoB = 'B'
SET @GrupoC = 'C'
SET @GrupoD = 'D'
SET @time1 = CAST (((RAND() * 4) + 1) AS INT)
SET @time2 = CAST (((RAND() * 4) + 1) AS INT) 
WHILE (@time2 = @time1)
BEGIN
SET @time2 = CAST (((RAND() * 4) + 1) AS INT) 
END
SET @time3 = CAST (((RAND() * 4) + 1) AS INT) 
WHILE (@time3 = @time1 OR @time3 = @time2)
BEGIN
SET @time3 = CAST (((RAND() * 4) + 1) AS INT) 
END
SET @time4 = CAST (((RAND() * 4) + 1) AS INT)
WHILE (@time4 = @time3 OR @time4 = @time2 OR @time4 = @time1)
BEGIN
SET @time4 = CAST (((RAND() * 4) + 1) AS INT)
END
INSERT INTO Grupos VALUES (@GrupoA, @Time1)
INSERT INTO Grupos VALUES (@GrupoB, @time2)
INSERT INTO Grupos VALUES (@GrupoC, @Time3)
INSERT INTO Grupos VALUES (@GrupoD, @Time4)
--Gerando outros 12 Times
DECLARE @tam INT, @tam1 INT
SET @tam1 = (SELECT COUNT(*) FROM Grupos)
WHILE @tam1 < 16
BEGIN
--GRUPO A
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoA) 
WHILE (@tam < 4)
BEGIN
BEGIN TRY
SET @time1 = CAST (((RAND() * 16) + 5) AS INT)
INSERT INTO Grupos VALUES (@GrupoA, @time1)
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoA) 
END TRY
BEGIN CATCH
SET @tam = @tam + 0
END CATCH
END
--GRUPO B
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoB)
WHILE (@tam < 4)
BEGIN
BEGIN TRY
SET @time1 = CAST (((RAND() * 16) + 5) AS INT)
INSERT INTO Grupos VALUES (@GrupoB, @time1)
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoB)
END TRY
BEGIN CATCH
SET @tam = @tam + 0
END CATCH
END
--GRUPO C
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoC) 
WHILE (@tam < 4)
BEGIN
BEGIN TRY
SET @time1 = CAST (((RAND() * 16) + 5) AS INT)
INSERT INTO Grupos VALUES (@GrupoC, @time1)
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoC)
END TRY
BEGIN CATCH
SET @tam = @tam + 0
END CATCH
END
--Grupo D
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoD) 
WHILE (@tam < 4)
BEGIN
BEGIN TRY
SET @time1 = CAST (((RAND() * 16) + 5) AS INT)
INSERT INTO Grupos VALUES (@GrupoD, @time1)
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @GrupoD)
END TRY
BEGIN CATCH
SET @tam = @tam + 0
END CATCH
END
SET @tam1 = (SELECT COUNT(*) FROM Grupos)
END



--EXEC sp_inseretime