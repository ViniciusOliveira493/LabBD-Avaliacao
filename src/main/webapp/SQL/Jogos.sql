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

DECLARE @valido BIT
EXEC sp_jogoValido 1,2,@valido OUTPUT 
print @valido
--======================================= PROCEDURE JOGO VALIDO DIA=======================================--
CREATE PROCEDURE sp_jogoValidoDia(@timeA INT, @timeB INT,@dt DATE,@valido BIT OUTPUT)
AS
BEGIN
	DECLARE @timeJaJogouDia INT;
	SET @timeJaJogouDia = 0
	SET @valido = 0
	SELECT @timeJaJogouDia = COUNT(dataJogo) FROM Jogos 
		WHERE
			(codigoTimeA = @timeA OR codigoTimeA = @timeB
			OR
			codigoTimeB = @timeA OR codigoTimeB = @timeB)
			AND
			datajogo = @dt
	IF(@timeJaJogouDia = 0)
	BEGIN
		SET @valido = 1
	END
END
--=============== Testes =====--
DECLARE @valido BIT
EXEC sp_jogoValido 4,2,'21/05/2021',@valido OUTPUT 
print @valido

INSERT INTO Jogos VALUES(1,2,0,0,'23/05/2021')
DELETE FROM Jogos
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

--=============== Testes =====--
DECLARE @valido BIT
EXEC sp_verificarData '21/05/2021',@valido OUTPUT 
print @valido

INSERT INTO Jogos 
	VALUES
		(1,5,0,0,'23/05/2021')
		,(2,5,0,0,'23/05/2021')
		,(3,5,0,0,'23/05/2021')
		,(4,5,0,0,'23/05/2021')
		,(5,5,0,0,'23/05/2021')
		,(6,5,0,0,'23/05/2021')
		,(7,5,0,0,'23/05/2021')
		,(8,5,0,0,'23/05/2021')
SELECT * FROM Jogos
DELETE FROM Jogos WHERE codigoTimeA = 7 AND codigoTimeB = 5
--======================================= PROCEDURE BUSCAR PROXIMA DATA =======================================--
CREATE PROCEDURE sp_buscarProximaData(@dt DATE OUTPUT)
AS
BEGIN	
	DECLARE @id INT,@datas INT
	--verificando se a data que foi inserida é válida
	SELECT @datas = COUNT(id) FROM fn_obterDatasValidas() WHERE dataJogo = @dt
	IF(@datas > 0)
	BEGIN
		SELECT @datas = COUNT(id) FROM fn_obterDatasValidas()
		SELECT @id = id FROM fn_obterDatasValidas() WHERE dataJogo = @dt
		SET @id = @id + 1
		IF(@id > @datas)
		BEGIN
			SET @id = 1
		END
		SELECT @dt = dataJogo FROM fn_obterDatasValidas() WHERE id = @id
	END
	ELSE
	BEGIN
		SELECT @dt = dataJogo FROM fn_obterDatasValidas() WHERE id = 1
	END
END
--===TESTE
DECLARE @dt DATE
SET @dt = '12/05/2021'
EXEC sp_buscarProximaData @dt OUTPUT
print @dt
--======================================= PROCEDURE ALOCAR JOGO =======================================--
CREATE PROCEDURE sp_alocarJogo(@codTimeA INT,@codTimeB INT,@dt DATE,@sucesso BIT OUTPUT)
AS
BEGIN
	DECLARE @valido BIT
	DECLARE @tentativas INT;
	DECLARE @qtdDias INT
	SELECT @qtdDias = COUNT(dataJogo) FROM fn_obterDatasValidas()
	SET @qtdDias = @qtdDias + 1
	SET @tentativas = 0
	SET @sucesso = 0
	WHILE(@tentativas < @qtdDias)
	BEGIN		
		EXEC sp_jogoValido @codTimeA,@codTimeB,@valido OUTPUT 
		IF(@valido = 1)		
		BEGIN
			EXEC sp_verificarData @dt,@valido OUTPUT
			IF(@valido = 1)
			BEGIN
				EXEC sp_jogoValidoDia 4,2,@dt,@valido OUTPUT
				IF(@valido = 1)
				BEGIN
					INSERT INTO Jogos(codigoTimeA,codigoTimeB,datajogo) 
					VALUES
						(@codTimeA,@codTimeB,@dt)
					SET @tentativas = 6
					SET @sucesso = 1
				END
				ELSE
				BEGIN
					EXEC sp_buscarProximaData @dt OUTPUT
				END
			END
			ELSE
			BEGIN
				EXEC sp_buscarProximaData @dt OUTPUT
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
				SET @sucesso = 1
			END
		END
		SET @tentativas = @tentativas + 1
	END
END

--=======TESTE==--
DECLARE @sucesso BIT
EXEC sp_alocarJogo 1,2,'12/05/2021', @sucesso OUTPUT
print @sucesso

SELECT * from Jogos
DELETE FROM Jogos
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
--teste
SELECT * from fn_buscarGrupo(4)

--======================================= PROCEDURE CRIAR JOGOS =======================================--
CREATE PROCEDURE sp_criarJogos(@tb1 INT, @tb2 INT)
AS
BEGIN
	DECLARE @qtdDias INT
	SELECT @qtdDias = COUNT(dataJogo) FROM fn_obterDatasValidas()
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
				SET @rand = (RAND()*@qtdDias)+1
				DECLARE @dt DATE,@res BIT
				SELECT @dt = dataJogo FROM fn_obterDatasValidas() WHERE id = @rand
				EXEC sp_alocarJogo @i,@j,@dt,@res OUTPUT
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
--=========TESTE
EXEC sp_criarJogos 1,2

--======================================= PROCEDURE CRIAR RODADAS =======================================--
CREATE PROCEDURE sp_criarRodadas(@sucesso BIT OUTPUT)
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
--=== TESTE
DECLARE @s BIT
EXEC sp_criarRodadas @s OUTPUT
PRINT @s