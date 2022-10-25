USE AVL1LabBD
--==================================================
CREATE FUNCTION fn_verificarQtdJogos() RETURNS INT
AS
BEGIN
	DECLARE @jogos INT
	SELECT @jogos = COUNT(dataJogo) 
	FROM Jogos
	RETURN @jogos
END

SELECT dbo.fn_verificarQtdJogos() 
GO
--==================================================
CREATE TRIGGER tg_times
ON Times
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Os times não podem ser alterados',16,1)
END
GO
--==================================================
CREATE TRIGGER tg_grupo
ON Grupos
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	DECLARE @jogos INT
	SELECT @jogos = dbo.fn_verificarQtdJogos()

	IF(@jogos != 0)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('OS grupos não podem ser alterados quando já existem jogos agendados',16,1)
	END
END
GO
--==================================================
CREATE TRIGGER tg_jogos
ON Jogos
AFTER INSERT,DELETE
AS
BEGIN
	DECLARE @jogos INT
	SELECT @jogos = dbo.fn_verificarQtdJogos()

	IF EXISTS(SELECT codigoTimeA FROM deleted)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Jogos não podem ser inseridos ou deletados',16,1)
	END
	ELSE
	BEGIN
		IF(NOT(@jogos < 97))
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Jogos não podem ser inseridos ou deletados',16,1)
		END
	END
END