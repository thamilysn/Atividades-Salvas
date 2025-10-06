/*1-	Desenvolva um trigger que, ao inserir um novo registro na tabela Movbanco, atualize automaticamente o campo Ban_Saldo da tabela banco, somando ou subtraindo o valor dependendo do tipo de movimento (movban_tipo). Explique como tratar situações de saldo negativo.

2-	Ao criar uma view para exibir todos os recebimentos (receber) de uma empresa, incluindo os dados de banco e cidade, qual problema de desempenho pode ocorrer?

a) Views não permitem junções entre múltiplas tabelas
b) O otimizador de consultas pode não reutilizar índices das tabelas base
c) Views não podem ser atualizadas quando há chave estrangeira
d) Não é possível usar filtros de data em views


3-	Crie uma view que exiba todos os usuários cadastrados (usuarios), mostrando apenas o Usu_nome, ocultando as senhas. Explique por que isso melhora a segurança.

4-	Construa uma view que exiba para cada empresa: razão social, fantasia, ramo de atuação, cidade e UF, e o saldo total a pagar.


5-	Escreva uma stored procedure que retorne todas as contas a pagar (Pagar) que estão vencidas e ainda não foram pagas, agrupadas por empresa

6-	Crie uma view que liste todos os movimentos da tabela Movbanco juntamente com os dados da conta (banco) associada, trazendo saldo atual, agência e número da conta.

7-	Quando usar um trigger de banco ao invés de um trigger de tabela no contexto do diagrama apresentado?
a) Quando o evento a ser monitorado afeta múltiplas tabelas ou todo o banco de dados
b) Quando o evento está restrito apenas à tabela Movbanco
c) Apenas para capturar operações de SELECT em qualquer tabela
d) Nunca é recomendável usar triggers de banco

8-	Por que uma view complexa que envolve empresa, cidade, uf e Ramo pode ser difícil de atualizar diretamente (com INSERT, UPDATE, DELETE)?
a) Porque views só aceitam comandos SELECT
b) Porque views que envolvem múltiplas junções podem não ser updatable
c) Porque o SQL Server não permite views baseadas em chave estrangeira
d) Porque as views sempre bloqueiam todas as tabelas envolvidas

9-	Qual a diferença prática entre usar um trigger de banco (DATABASE TRIGGER) e um trigger de tabela (TABLE TRIGGER) para monitorar alterações em Movbanco?
a) Trigger de banco pode monitorar todas as tabelas, trigger de tabela apenas uma específica
b) Trigger de tabela funciona para SELECT, trigger de banco apenas para DML
c) Trigger de banco não permite rollback, trigger de tabela permite
d) Não existe diferença, ambos funcionam de forma idêntica

10-	Foi criado uma view com a seguinte consulta:

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

Qual o resultado dos comandos abaixo:
a)	Delete From PagarEmpresa
b)	Select emp_razaosocial from PagarEmpresa where idpagar=20
c)	Select pag_descricao, fkbanco from  PagarEmpresa as V, pagar as P
Where v.idpagar=P.idpagar



