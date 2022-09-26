USE AVL1LabBD
go
--========================================= FUNCTION OBTER DATAS DE JOGOS ==============--
CREATE FUNCTION fn_obterDatasValidas()
RETURNS @tab TABLE(id INT,dataJogo DATE)
AS
BEGIN
	DECLARE 
		@dataInicio DATE
		, @dataFim DATE
		, @i INT

	SET @dataInicio = '27/02/2021'
	SET @dataFIM = DATEADD(DAY,1,'23/05/2021')
	SET @i = 1
	WHILE(@dataInicio != @dataFim)
	BEGIN
		IF(DATEPART(DW, @dataInicio) = 1 OR DATEPART(DW, @dataInicio) = 4)
		BEGIN
			INSERT INTO @tab VALUES (@i,@dataInicio)			
			SET @i = @i + 1
		END
		SET @dataInicio = DATEADD(DAY,1,@dataInicio)
	END
	RETURN
END

--=============== Testes =====--
SELECT * from fn_obterDatasValidas()

--======================================= PROCEDURE JOGO VALIDO =======================================--
CREATE PROCEDURE sp_jogoValido(@timeA INT, @timeB INT,@valido BIT OUTPUT)
AS
BEGIN
	DECLARE @qtd INT;
	SET @qtd = 0
	SELECT @qtd = COUNT(dataJogo) FROM Jogos 
	WHERE 
		(codigoTimeA = @timeA AND codigoTimeB = @timeB)
		OR
		(codigoTimeA = @timeB AND codigoTimeA = @timeB)
	IF(@qtd = 0)
	BEGIN
		SET @valido = 1
	END
	ELSE
	BEGIN
		SET @valido = 0
	END
END

--=============== Testes =====--
DECLARE @valido BIT
EXEC sp_jogoValido 1,2,@valido OUTPUT 
print @valido

INSERT INTO Jogos VALUES(1,2,0,0,'23/05/2021')
DELETE FROM Jogos

--======================================= PROCEDURE ALOCAR JOGO =======================================--

--======================================= PROCEDURE CRIAR PARTIDAS =======================================--