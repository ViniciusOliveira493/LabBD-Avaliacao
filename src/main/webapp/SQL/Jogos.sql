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
	SET @tentativas = 0
	WHILE(@tentativas < 10)
	BEGIN		
		EXEC sp_jogoValido 4,2,@valido OUTPUT 
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
			SET @sucesso = 0
		END
		SET @tentativas = @tentativas + 1
	END
END
--=======TESTE==--
DECLARE @sucesso BIT
EXEC sp_alocarJogo 1,2,'12/05/2021', @sucesso OUTPUT
print @sucesso

SELECT * from Jogos
--======================================= PROCEDURE CRIAR PARTIDAS =======================================--