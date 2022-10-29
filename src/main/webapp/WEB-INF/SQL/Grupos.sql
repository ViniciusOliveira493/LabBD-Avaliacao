use AVL1LabBD
GO
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
DECLARE @tam INT, @tam1 INT, @grupo CHAR, @num INT

SET @tam1 = (SELECT COUNT(*) FROM Grupos)
WHILE @tam1 < 16
BEGIN
SET @num = CAST (((RAND() * 4) + 1) AS INT)

	IF(@num = 1)
	BEGIN
		SET @grupo = 'A'
	END
	IF(@num = 2)
	BEGIN
		SET @grupo = 'B'
	END
	IF(@num = 3)
	BEGIN
		SET @grupo = 'C'
	END
	IF(@num = 4)
	BEGIN
		SET @grupo = 'D'
	END
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @grupo) 
WHILE (@tam < 4)
BEGIN
BEGIN TRY
SET @time1 = CAST (((RAND() * 16) + 5) AS INT)
INSERT INTO Grupos VALUES (@grupo, @time1)
SET @tam = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @grupo) 
END TRY
BEGIN CATCH
SET @tam = @tam + 0
END CATCH
END
SET @tam1 = (SELECT COUNT(*) FROM Grupos)
END

