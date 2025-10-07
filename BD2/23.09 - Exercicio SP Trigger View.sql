/*1-	Desenvolva um trigger que, ao inserir um novo registro na tabela Movbanco, atualize automaticamente o campo Ban_Saldo da tabela banco, somando ou subtraindo o valor dependendo do tipo de movimento (movban_tipo). Explique como tratar situações de saldo negativo. */
create trigger banco
on Movbanco
for insert as declare
  @valor decimal (10,2)
  @tipo int
  @id int 

  select
    @valor = movban_valor
    @tipo = movban_tipo
    @id = fkbanco
  from inserted
  
  if(@tipo = 1)
  begin
  update banco
  set ban_saldo = ban_saldo + @valor
  where idbanco = id
  end
  
  else
  begin
  if(select ban_saldo from banco where idbanco = @id) - @valor >= 0)
  begin
  update banco
  set ban_saldo = ban_saldo - @valor where idbanco = id
  end
  end
  
  
/*2-	Ao criar uma view para exibir todos os recebimentos (receber) de uma empresa, incluindo os dados de banco e cidade, qual problema de desempenho pode ocorrer?

a) Views não permitem junções entre múltiplas tabelas
b) O otimizador de consultas pode não reutilizar índices das tabelas base <-
c) Views não podem ser atualizadas quando há chave estrangeira
d) Não é possível usar filtros de data em views
*/

/*3-	Crie uma view que exiba todos os usuários cadastrados (usuarios), mostrando apenas o Usu_nome, ocultando as senhas. Explique por que isso melhora a segurança. */
create view vw_usuarios_seguranca as
  select Usu_nome
  from usuarios;
-- As senhas não aparecem na view, então ninguém que acessar a view poderá vê-las diretamente. Isso evita que usuários ou desenvolvedores sem permissão acessem dados sensíveis. 
--Ao invés de dar acesso à tabela completa usuarios, o usuário só recebe acesso à view vw_usuarios_seguro, aplicando o princípio de menor privilégio.

/*4-	Construa uma view que exiba para cada empresa: razão social, fantasia, ramo de atuação, cidade e UF, e o saldo total a pagar.*/
CREATE VIEW vw_saldo_a_pagar AS
SELECT 
    Emp_RazaoSocial,
    Emp_Fantasia,
    Emp_RamoAtuacao,
    Emp_Cidade,
    Emp_UF,
    SUM(Pag_Valor) AS SaldoTotalPag
FROM 
    Empresa
  
LEFT JOIN Pagar ON IdEmpresa = FkEmpresa
WHERE
    Pag_DataPagto IS NULL
GROUP BY 
    Emp_RazaoSocial,
    Emp_Fantasia,
    Emp_RamoAtuacao,
    Emp_Cidade,
    Emp_UF;

/*5-	Escreva uma stored procedure que retorne todas as contas a pagar (Pagar) que estão vencidas e ainda não foram pagas, agrupadas por empresa*/
CREATE PROCEDURE sp_ContasAPagarVencidas
AS
BEGIN
    SELECT 
        Emp_RazaoSocial,
        COUNT(IdPagar) AS TotalFaturasVencidas,
        SUM(Pag_Valor) AS SaldoVencido
    FROM 
        Empresa
    INNER JOIN 
        Pagar ON IdEmpresa = FkEmpresa
    WHERE 
        Pag_DataPagto IS NULL            -- Ainda não pagas
        AND Pag_DataVencimento < GETDATE()  -- Já estão vencidas
    GROUP BY 
        Emp_RazaoSocial
    ORDER BY 
        Emp_RazaoSocial;
END;

/*6-	Crie uma view que liste todos os movimentos da tabela Movbanco juntamente com os dados da conta (banco) associada, trazendo saldo atual, agência e número da conta.*/
CREATE VIEW vw_movimentos_banco AS
SELECT 
    IdMovBanco,
    movban_data,
    movban_valor,
    movban_tipo,
    ban_saldo AS SaldoAtual,
    ban_agencia AS Agencia,
    ban_numero AS NumeroConta
FROM 
    Movbanco
INNER JOIN 
    Banco ON fkbanco = IdBanco
ORDER BY 
    movban_data;

/* 7-	Quando usar um trigger de banco ao invés de um trigger de tabela no contexto do diagrama apresentado?
a) Quando o evento a ser monitorado afeta múltiplas tabelas ou todo o banco de dados <-
b) Quando o evento está restrito apenas à tabela Movbanco
c) Apenas para capturar operações de SELECT em qualquer tabela
d) Nunca é recomendável usar triggers de banco*/

/*8-	Por que uma view complexa que envolve empresa, cidade, uf e Ramo pode ser difícil de atualizar diretamente (com INSERT, UPDATE, DELETE)?
a) Porque views só aceitam comandos SELECT
b) Porque views que envolvem múltiplas junções podem não ser updatable <-
c) Porque o SQL Server não permite views baseadas em chave estrangeira
d) Porque as views sempre bloqueiam todas as tabelas envolvidas*/

/*9-	Qual a diferença prática entre usar um trigger de banco (DATABASE TRIGGER) e um trigger de tabela (TABLE TRIGGER) para monitorar alterações em Movbanco?
a) Trigger de banco pode monitorar todas as tabelas, trigger de tabela apenas uma específica <-
b) Trigger de tabela funciona para SELECT, trigger de banco apenas para DML
c) Trigger de banco não permite rollback, trigger de tabela permite
d) Não existe diferença, ambos funcionam de forma idêntica*/

/*10-	Foi criado uma view com a seguinte consulta:*/

CREATE VIEW PagarEmpresa 
AS
SELECT 
  idpagar,
  emp_razaosocial,
  Pag_Fatura,
  Pag_Valor
FROM pagar,
     empresa
WHERE FkEmpresa = Idempresa;

/*Qual o resultado dos comandos abaixo:
a)	Delete From PagarEmpresa
--ERRO, a view é baseada em mais de uma tabela (pagar e empresa). Views que envolvem junções geralmente não podem ser atualizadas ou deletadas diretamente no SQL Server, a menos que haja um INSTEAD OF TRIGGER definido.

b)	Select emp_razaosocial from PagarEmpresa where idpagar=20
--FUNCIONA, vai retornar o nome da empresa (emp_razaosocial) associada à fatura com idpagar = 20.

c)	Select pag_descricao, fkbanco from  PagarEmpresa as V, pagar as P
Where v.idpagar=P.idpagar*/
--FUNCIONA, vai retornar os campos pag_descricao e fkbanco da tabela Pagar para todas as faturas que existem na view PagarEmpresa.
