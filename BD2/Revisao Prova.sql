/*1º. Questão - (1.0 ponto): Considere as tabelas PAGAR e AUDITORIA com as estruturas listadas abaixo. Crie um método de auditoria, que tenha atenda os seguintes requisitos:
a. Armazene a data/hora, usuário, estação e dados excluidos (Pag_fatura, pag_descricao e
valor) de qualquer registro excluido da tabela pagar.
b. Armazene a data/hora, usuário, estação e dados alterados (Pag_fatura, pag_descricao e
valor), de qualquer registro ALTERADO na tabela pagar.
c. Indicar se a operação registrada foi uma exclusão ou alteração
d. Use SYSTEM_USER e HOST_NAME() para pegar o nome do usuário e o nome da estação */

create trigger trg_Auditoria_Pagar
on Pagar
for delete, update
as
begin
  
    insert into Auditoria (
        DataHora,
        Usuario,
        Estacao,
        Operacao,
        Pag_Fatura,
        Pag_Descricao,
        Pag_Valor
    )
    select 
        GETDATE(),
        SYSTEM_USER,
        HOST_NAME(),
        'EXCLUSAO',
        d.Pag_Fatura,
        d.Pag_Descricao,
        d.Pag_Valor
    from deleted d
    where NOT EXISTS (SELECT * FROM inserted);

    -- Alteração
    INSERT INTO Auditoria (
        DataHora,
        Usuario,
        Estacao,
        Operacao,
        Pag_Fatura,
        Pag_Descricao,
        Pag_Valor
    )
    SELECT 
        GETDATE(),
        SYSTEM_USER,
        HOST_NAME(),
        'ALTERACAO',
        i.Pag_Fatura,
        i.Pag_Descricao,
        i.Pag_Valor
    FROM inserted i
    WHERE EXISTS (SELECT * FROM deleted);
END;

/*2ª. Questão - (1.0 ponto): Criar uma store procedure que permita inserir ou alterar uma fatura no contas a pagar (tabela Pagar).
1. Se o id do colaborador for fornecido pelo usuário trata-se de uma ALTERAÇÃO, caso contrário trata-se de uma inserção.
2. Em caso de alterações, a SP deve conferir se existe o registro que se deseja alterar.Caso não existir, deve ser mostrado uma mensagem para o usuário.
3. Em todas as inclusões/alteração considere que os campos IDpagar e IDreceber são auto Incrementais, ou seja, não devem ser incluidos nos inserts/updates 
*/
create proc sp_InserirOuAlterarFatura
    @IdPagar int,
    @Pag_Fatura VARCHAR(50),
    @Pag_Descricao VARCHAR(100),
    @Pag_Valor DECIMAL(10,2)
as
begin
  if @IdPagar is null
  begin
   insert pagar (Pag_Fatura, Pag_Descricao, Pag_Valor)
   values (@Pag_Fatura, @Pag_Descricao, @Pag_Valor);
  end
  
  else 
    begin
        if exists (select IdPagar from Pagar where IdPagar=@IdPagar)
        begin
          update Pagar
          set Pag_Fatura = @Pag_Fatura,
            Pag_Descricao = @Pag_Descricao,
            Pag_Valor = @Pag_Valor
          where IdPagar = @IdPagar
      end
      else
      begin
         select 'O registro que você deseja alterar os dados NÃO EXISTE'
      end
   end
end;

/*3º. Questão - (1.0 ponto): Criar uma store procedure que permita ao usuário consultar o Total a pagar para um fornecedor em um determinado período: 
1. O usuário deve fornecer a data inicial , a data final e nome (ou a parte inicial do nome) da empresa que deseja consultar. 
2. Considere uma fatura paga se o campo pag_pagto contiver uma data.
3. Por exemplo, uma consulta para o cliente 'Fazenda deve retornar algo como: */

create proc sp_TotalFaturasFornecedor
(
    @NomeEmpresa VARCHAR(100),
    @DataInicial DATETIME,
    @DataFinal DATETIME
)
as
begin
  
  select
    Emp_razaosocial AS Empresa,
    SUM(CASE WHEN Pag_DataPagto IS NOT NULL THEN p.Pag_Valor ELSE 0 END) AS Total_Pago,
    SUM(CASE WHEN Pag_DataPagto IS NULL THEN p.Pag_Valor ELSE 0 END) AS Total_A_Pagar
    FROM Empresa e
    JOIN Pagar ON FkEmpresa = IdEmpresa
    WHERE Emp_razaosocial LIKE @NomeEmpresa + '%'
      AND Pag_DataVencimento BETWEEN @DataInicial AND @DataFinal
    GROUP BY emp_razaosocial;
END;

/* 4ª. Questão - (1.0 ponto ) Use as tabelas pagar e receber para gerar um fluxo de caixa que mostre:
Nome da empresa,
Idfatura
Descricao,
Valor do debito (para faturas do contas a pagar),
Valor do credito (para fatura do contas a receber),
Vencimento 

Obs: 
a) mostrar apenas as faturas AINDA NÃO PAGAS (campo pag_pagto sem data)
b) ordenar por ordem de data
c) exemplo de saída desejada */

SELECT 
    e.emp_razaosocial AS Empresa,
    p.IdPagar AS IdFatura,
    p.Pag_Descricao AS Descricao,
    p.Pag_Valor AS ValorDebito,
    CAST(0 AS DECIMAL(10,2)) AS ValorCredito,
    p.Pag_DataVencimento AS Vencimento
FROM Empresa e
JOIN Pagar p ON p.FkEmpresa = e.IdEmpresa
WHERE p.Pag_DataPagto IS NULL

UNION ALL

SELECT 
    e.emp_razaosocial AS Empresa,
    r.IdReceber AS IdFatura,
    r.Rec_Descricao AS Descricao,
    CAST(0 AS DECIMAL(10,2)) AS ValorDebito,
    r.Rec_VlrPagto AS ValorCredito,
    r.Rec_DtVencimento AS Vencimento
FROM Empresa e
JOIN Receber r ON r.FkEmpresa = e.IdEmpresa
WHERE r.Rec_Pagto IS NULL

ORDER BY Vencimento;

/* 5ª. Questão - (0.5 ponto ): Use a tabela conta a pagar para gerar um relatório com o seguinte layout

Observações:
a. Os dias em atraso devem ser calculados somente para Jetora NÃO PAGAS e que estejam
com o pagamento em atraso. Caso contrario, o campo atraso deve ser zero.

b. Mostrar a listagem ordenada pela quantidade de dias em atraso */
SELECT 
    e.emp_razaosocial AS Empresa,
    p.IdPagar AS IdFatura,
    p.Pag_Descricao AS Descricao,
    p.Pag_Valor AS Valor,
    p.Pag_DataVencimento AS Vencimento,
    CASE 
        WHEN p.Pag_DataPagto IS NULL AND p.Pag_DataVencimento < GETDATE() 
        THEN DATEDIFF(DAY, p.Pag_DataVencimento, GETDATE())
        ELSE 0
    END AS DiasAtraso
FROM Empresa e
JOIN Pagar p ON p.FkEmpresa = e.IdEmpresa
WHERE p.Pag_DataPagto IS NULL
ORDER BY DiasAtraso DESC;

/* ( 6. Questão [0.5) : Qual das seguintes opções melhor descreve a propriedade de atomicidade em
transações de banco de dados?
a) Garante que todas as transações sejam executadas no modo serializado, uma após a outra.
b) Garante que uma transação será completada inteiramente ou não será executada de forma alguma. <-
c) Garante que, uma vez que uma transação é concluida, os resultados serão mantidos mesmo em
caso de falha do sistema.
d) Garante que os dados do banco de dados estejam sempre em um estado consistente antes e depois de uma transação 
e) Garante que as operações de leitura dentro de uma transação nunca sejam visiveis para outras transações.*/

/* 7ª. Questão - (1.0): Exclua todos os registros da tabela RECEBER que foram recebidos no período de 01-09-2024 a 31-09-2024. */

delete from Receber
where Rec_Pagto is not null and Rec_Pagto between '2024-09-01' and '2024-09-30';


/*8. Questão (0.5): Assinale a alternativa correta quanto aos conceitos de triggers num sgbd

1. São procedimentos armazenados de modo persistente que são disparados toda vez que o programa usuário e solicitar; 
I. As triggers (gatilhos) procedimentos armazenados de modo persistente e executados
automaticamente em resposta a eventos especificos. Existem três tipos principais de triggers no
SQL Server: triggers de tabela, triggers de banco de dados e triggers de servidor, e cada uma del
responde a diferentes tipos de eventos.
III. Uma Trigger é criada através do comando CREATE PROC e é apagada através do comando DROP PROC:
IV. Trigger de tabelas são trechos de código armazenado, associados a uma tabela e executadas
automaticamente após certos eventos como INSERT, UPDATE, DELETE e SELECT
Está correto o que se afirma em:
a. I, II e III
b. IlI e IV
c. I, IV
d. somente II <--
e. Il e IV */ 

/*9ª, Questão (0.5 ponto): Analise as afirmações abaixo:
I. Uma View consiste da formação de uma tabela única, considerada tabela virtual, a partir de uma
consulta a uma ou mais tabelas do banco de dados; 
II. A criação de uma View é realizada através do comando CREATE VIEW, enquanto sua exclusão ocorre quando o SGBD é desligado;
III. A MATERIALIZAÇÃO da consulta é uma técnica de implementação de Views utilizada por 5GBD's, que consiste na criação de uma tabela temporária a partir da primeira consulta à View, mantendo-a
para as próximas consultas. Neste caso, o SGBD deve elaborar estratégias para atualização dos dados da View caso uma das tabelas de definição sofra alteração em seus dados;
IV. O uso do comando UPDATE em Views é sempre possível.
Está correto o que se afirma em:
a) I e III <-
b. I. ille IV
e. Ille IV
d. Ile ill*/ 
