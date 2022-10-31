CREATE FUNCTION fn_grupos(@GRUPO CHAR)
RETURNS @tab TABLE(
	nomeTime VARCHAR(20)
	, numJogosDisputados INT
	, vitorias INT
    , empates INT
	, derrotas INT
	, golsMarcados INT
	, golsSofridos INT
	, saldoGols INT
	, pontos INT
)
AS
BEGIN
DECLARE @cod INT
        ,@qtd INT
        ,@i INT
        ,@gp CHAR;
    DECLARE timesGrupos CURSOR FOR
	SELECT grupo,codTime FROM fn_buscarGrupo(@GRUPO)

    OPEN timesGrupos
    FETCH NEXT FROM timesGrupos INTO @gp,@cod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN		
		 DECLARE 
            @nome VARCHAR(20)
            , @disp INT
            , @vit INT
            , @emp INT
            , @der INT
            , @golsMarc INT
            , @golsSof INT
        SELECT
            @nome = nomeTime
            , @disp = diputados
            , @vit = vitorias
            , @emp = empates
            , @der = derrotas
            , @golsMarc = golsMarcados
            , @golsSof = golsSofridos
        FROM fn_obterDadosDoTime(@cod)

        INSERT INTO @tab(nomeTime,numJogosDisputados,vitorias,empates
            ,derrotas, golsMarcados, golsSofridos, saldoGols
            , pontos)
            VALUES
                (@nome,@disp,@vit,@emp,@der,@golsMarc,@golsSof,(@golsMarc-@golsSof),((@vit*3)+(@emp*1)))
        FETCH NEXT FROM timesGrupos INTO @gp,@cod  
	END
    RETURN
END

--mostra campeão do grupo
select * from fn_grupos(1)
order by pontos desc, vitorias desc, golsmarcados desc, saldogols desc

--mostra dois times rebaixados
select TOP(2) * from fn_classificacaoGeral()
order by pontos ASC, vitorias ASC, golsmarcados ASC, saldogols ASC

CREATE FUNCTION fn_classi(@GRUPO INT)
RETURNS @tab TABLE(
	nomeTime VARCHAR(20)
	, numJogosDisputados INT
	, vitorias INT
    , empates INT
	, derrotas INT
	, golsMarcados INT
	, golsSofridos INT
	, saldoGols INT
	, pontos INT
	, rebaixado BIT
	, campeao BIT
)
AS 
BEGIN
INSERT INTO @tab(nomeTime
, numJogosDisputados
, vitorias
, empates
, derrotas
, golsMarcados
, golsSofridos
, saldoGols
, pontos
)
SELECT * FROM fn_grupos(@GRUPO)
ORDER BY pontos DESC, vitorias DESC, golsmarcados DESC, saldogols DESC
IF EXISTS (select TOP(1) * from fn_grupos(@GRUPO)
ORDER BY pontos DESC, vitorias DESC, golsmarcados DESC, saldogols DESC) 
BEGIN
UPDATE @tab SET campeao = 1 WHERE LEN(nomeTime) = 1
END
ELSE 
BEGIN 
UPDATE @tab SET campeao = 1 WHERE LEN(nomeTime) != 1
END 
IF EXISTS (select TOP(2) * from fn_classificacaoGeral()
ORDER BY pontos ASC, vitorias ASC, golsmarcados ASC, saldogols ASC) 
BEGIN
UPDATE @tab SET rebaixado = 1
END
ELSE 
BEGIN 
UPDATE @tab SET rebaixado = 0
END  
RETURN
END

SELECT






 