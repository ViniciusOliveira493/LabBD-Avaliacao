USE AVL1LabBD
go
--========================================= FUNCTION OBTER DATAS DE JOGOS ==============--
CREATE FUNCTION fn_obterDatasValidas(@dataInicio DATE, @dataFim DATE)
RETURNS @tab TABLE(id INT,dataJogo DATE)
AS
BEGIN
	DECLARE @i INT
	SET @dataFIM = DATEADD(DAY,1, @dataFim)
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
GO
--======================== FUNCTION OBTER DATAS PRIMEIRA FASE ============--
CREATE FUNCTION fn_obterDatasValidasPrimeiraFase()
RETURNS @tab TABLE(id INT,dataJogo DATE)
AS
BEGIN
	INSERT INTO @tab(id,dataJogo)
		SELECT id,dataJogo from fn_obterDatasValidas('2021-02-27','2021-04-07')
	RETURN
END
GO
--======================================= PROCEDURE JOGO VALIDO =======================================--
CREATE PROCEDURE sp_jogoValido(@timeA INT, @timeB INT,@valido BIT OUTPUT)
AS
BEGIN
	DECLARE @jogoJaAconteceu INT
	SET @jogoJaAconteceu = 0
	SET @valido = 0
	--=======
	SELECT @jogoJaAconteceu = COUNT(dataJogo) FROM Jogos 
	WHERE 
		(codigoTimeA = @timeA AND codigoTimeB = @timeB)
		OR
		(codigoTimeA = @timeB AND codigoTimeB = @timeA)
	--=======
	IF(@jogoJaAconteceu = 0)
	BEGIN
		SET @valido = 1
	END
END
GO
--======================================= PROCEDURE JOGO VALIDO DIA=======================================--
CREATE PROCEDURE sp_jogoValidoDia(@timeA INT, @timeB INT,@dt DATE,@valido BIT OUTPUT)
AS
BEGIN
	DECLARE @timeJaJogouDia INT;
	SET @timeJaJogouDia = 0
	SET @valido = 0
	SELECT @timeJaJogouDia = COUNT(dataJogo) FROM Jogos 
		WHERE
			datajogo = @dt
			AND(
			(codigoTimeA = @timeA OR codigoTimeB = @timeB)
			OR
			(codigoTimeA = @timeB OR codigoTimeB = @timeA))
	IF(@timeJaJogouDia = 0)
	BEGIN
		SET @valido = 1
	END
END
GO
--======================================= PROCEDURE VERIFICAR DATA =======================================--
--Verifica se a data já possui 8 jogos
CREATE PROCEDURE sp_verificarData(@dt DATE,@valido BIT OUTPUT) 
AS
BEGIN
	DECLARE @qtd INT
	SET @valido = 1
	SELECT @qtd = COUNT(codigoTimeA) FROM Jogos
	WHERE datajogo = @dt
	IF(@qtd>7)
	BEGIN
		SET @valido = 0
	END
END
GO
--======================================= PROCEDURE BUSCAR PROXIMA DATA =======================================--
CREATE PROCEDURE sp_buscarProximaData(@dt DATE OUTPUT)
AS
BEGIN	
	DECLARE @id INT,@datas INT
	--verificando se a data que foi inserida é válida
	SELECT @datas = COUNT(id) FROM fn_obterDatasValidasPrimeiraFase() WHERE dataJogo = @dt
	IF(@datas > 0)
	BEGIN
		SELECT @datas = COUNT(id) FROM fn_obterDatasValidasPrimeiraFase()
		SELECT @id = id FROM fn_obterDatasValidasPrimeiraFase() WHERE dataJogo = @dt
		SET @id = @id + 1
		IF(@id > @datas)
		BEGIN
			SET @id = 1
		END
		SELECT @dt = dataJogo FROM fn_obterDatasValidasPrimeiraFase() WHERE id = @id
	END
	ELSE
	BEGIN
		SELECT @dt = dataJogo FROM fn_obterDatasValidasPrimeiraFase() WHERE id = 1
	END
END
GO
--======================================= PROCEDURE ALOCAR JOGO =======================================--
CREATE PROCEDURE sp_alocarJogo(@codTimeA INT,@codTimeB INT,@dt DATE,@erro INT OUTPUT)
AS
BEGIN
	DECLARE @valido BIT
	DECLARE @tentativas INT;
	DECLARE @qtdDias INT
	SELECT @qtdDias = COUNT(dataJogo) FROM fn_obterDatasValidasPrimeiraFase()
	SET @qtdDias = @qtdDias + 2
	SET @tentativas = 0
	SET @erro = 0
	WHILE(@tentativas < @qtdDias)
	BEGIN		
		SET @valido = 0
		EXEC sp_jogoValido @codTimeA,@codTimeB,@valido OUTPUT 
		IF(@valido = 1)		
		BEGIN
			SET @valido = 0
			EXEC sp_verificarData @dt,@valido OUTPUT
			IF(@valido = 1)
			BEGIN
				SET @valido = 0
				EXEC sp_jogoValidoDia @codTimeA,@codTimeB,@dt,@valido OUTPUT
				IF(@valido = 1)
				BEGIN
					INSERT INTO Jogos(codigoTimeA,codigoTimeB,datajogo) 
					VALUES
						(@codTimeA,@codTimeB,@dt)
					SET @tentativas = @qtdDias
					SET @erro = 0
				END
				ELSE
				BEGIN
					EXEC sp_buscarProximaData @dt OUTPUT
					SET @erro = 3
				END
			END
			ELSE
			BEGIN
				EXEC sp_buscarProximaData @dt OUTPUT
				SET @erro = 2
			END	
		END
		ELSE
		BEGIN
			DECLARE @qtd INT
			SELECT @qtd = COUNT(*) FROM Jogos
			WHERE 
				(codigoTimeA =	@codTimeA AND codigoTimeB = @codTimeB)
				OR
				(codigoTimeA = @codTimeB AND codigoTimeB = @codTimeA)
				AND 
				datajogo = @dt
			IF(@qtd > 0)
			BEGIN
				SET @erro = 0
			END
			ELSE
			BEGIN
				SET @erro = 1
			END
		END
		SET @tentativas = @tentativas + 1
	END
END
GO
--======================================= FUNCTION BUSCAR GRUPO =======================================--
CREATE FUNCTION fn_buscarGrupo(@num INT) 
RETURNS @tbGrupo TABLE(grupo CHAR,codTime INT)
AS
BEGIN
	DECLARE @grupo CHAR;
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
	INSERT INTO @tbGrupo(grupo,codTime)
		SELECT grupo,codigoTime from Grupos WHERE grupo = @grupo	
	RETURN
END
GO
--======================================= PROCEDURE CRIAR JOGOS =======================================--
CREATE PROCEDURE sp_criarJogos(@tb1 INT, @tb2 INT)
AS
BEGIN
	DECLARE @qtdDias INT
	SELECT @qtdDias = COUNT(dataJogo) FROM fn_obterDatasValidasPrimeiraFase()
	DECLARE @i INT
	DECLARE @counti INT,@countj INT
	SET ROWCOUNT 0
	SELECT grupo,codTime INTO #temp1 FROM fn_buscarGrupo(@tb1)

	SET ROWCOUNT 1
	SET @counti = 0
	WHILE (@counti < 4)
	BEGIN
		SELECT @i = codTime FROM #temp1
		SET ROWCOUNT 0
		SET @countj = 0
		SELECT grupo,codTime INTO #temp2 FROM fn_buscarGrupo(@tb2)
		WHILE (@countj < 4)
		BEGIN			
			DECLARE @j INT
			SET ROWCOUNT 1
			SELECT @j = codTime FROM #temp2

			SET ROWCOUNT 0
				DECLARE @rand INT
				SET @rand = 1
				DECLARE @dt DATE,@res INT
				SELECT @dt = dataJogo FROM fn_obterDatasValidasPrimeiraFase() WHERE id = @rand
				EXEC sp_alocarJogo @i,@j,@dt,@res OUTPUT
				PRINT CAST(@i AS char(2)) +' | '+CAST(@j AS char(2)) + ' | count' + CAST(@counti AS char(2)) +' | '+CAST(@countj AS char(2)) + ' | '+CAST(@res AS char)
			DELETE #temp2 WHERE codTime = @j
			SET ROWCOUNT 1
			SELECT @j = codTime FROM #temp2
			SET @countj = @countj + 1			
		END
		DROP TABLE #temp2
		SET ROWCOUNT 0
		DELETE #temp1 WHERE codTime = @i
		SET ROWCOUNT 1
		SET @counti = @counti + 1
	END
	SET ROWCOUNT 0
	DROP TABLE #temp1
END
GO
--======================================= PROCEDURE CRIAR RODADAS =======================================--
CREATE PROCEDURE sp_criarRodadas
AS
BEGIN
	DECLARE @i INT,@j INT
	DECLARE @qtdGrupos INT
	SELECT @qtdGrupos = COUNT(DISTINCT grupo)
	FROM Grupos
	SET @qtdGrupos = @qtdGrupos + 1
	SET @i = 1
	WHILE(@i < @qtdGrupos)
	BEGIN
		SET @j = @i+1
		WHILE(@j < @qtdGrupos)
		BEGIN
			PRINT CAST(@i AS CHAR)+ ' VS ' + CAST(@j AS CHAR)
			EXEC sp_criarJogos @i,@j
			SET @j = @j + 1
		END
		SET @i = @i + 1
	END
END