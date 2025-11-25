--Questão 1)
create proc baixa_pag(@idfatura int, @data_pag date, @valor_pago numeric(18,2), @fkbanco int) as

begin try
	begin tran;
	if not exists (select 1 from fatura where fatura_id = @idfatura)
    THROW 50001, 'Fatura inválida.', 1;

    if not exists (select 1 from banco where banco_id = @fkbanco)
    THROW 50002, 'Banco inválido.', 1;

	update fatura
    set fatura_data_pagamento = @data_pag,
    fatura_fkbanco = @fkbanco
    where fatura_id = @idfatura;

    update banco
    set banco_saldo = banco_saldo + @valor_pago
    where banco_id = @fkbanco;

    declare @saldoatual numeric(18,2);

    select @saldoatual = banco_saldo 
    from banco 
    where banco_id = @fkbanco;

    insert into movbanco (movban_data, movban_valor, movban_fkbanco, movban_saldo)
    values (@data_pag, @valor_pago, @fkbanco, @saldoatual);
	commit tran;
end try

begin catch
    rollback tran;
    throw 50003, 'Operação não concluídas: procedimento houve falhas.', 1;
end catch
return

--Questão 2)
create proc inserirempresa(@nome varchar(200), @cnpj varchar(20) as

begin try

	begin tran;
	open symmetric key chaveCNPJ  decryption by certificate certificadoEmp;

	insert into empresa(nome, cnpj_crypto) values(@nome, encryptbykey(key_guid('chaveCNPJ'), @cnpj);
	close symmetric key chaveCNPJ;
	commit tran;

end try

begin catch
	rollback
	throw 50005, 'Houve algum erro inesperado.', 1;
end catch

return

exec inserirempresa
@nome = 'MACAL LTDA',
@cnpj = '12.345.678/0001-90';

/* Questão 3)  Analise as seguintes afirmações sobre criptografia em banco de dados e marque a opção que contém as afirmações corretas.
i)	O sql permite tanto criptografia a nível de banco de dados quando a nível de colunas de uma tabela. A criptografia a nível de banco é transparente, não sendo necessário alterar nenhuma instrução de consulta/inserção. Já a criptografia a nível de coluna exige alterar os comandos de consulta/inserção para criptografar e de-criptografar
ii)	A criptografia a nível de banco utiliza um certificado digital que é criado e armazenado no banco master.
iii)	Quando é utilizado criptografia a nível de colunas os dados criptografados não podem ser acessados sem a chave de de-criptografia nem mesmo pelo usuário sa (administrador do banco)
iv)	O comando CREATE CERTIFICATE ‘Meu_certificado’ WITH SUBJECT = 'Certificado para TDE'; irá gerar um erro, pois o comando exige que seja fornecido uma senha na criação do certificado
Está correto o que se afirma em”
a)	Somente I, II e III
b)	II, III e IV
c)	II e IV
d)	Todas as afirmações estão corretas
e)	Todas as afirmações estão incorretas */ 
--a)	Somente I, II e III

/* Questão 4) Associe os três pilares da segurança da informação (modelo CIA) às descrições abaixo:
1.	Garantir que apenas usuários autorizados acessem os dados.
2.	Garantir que as informações estejam sempre disponíveis.
3.	Garantir que os dados não sejam alterados indevidamente.*/ 
--1) Confidencialidade, 2) Disponibilidade, 3) Integridade

/* Questão 5)
a) O que pode ocorrer se o nível de isolamento for READ UNCOMMITTED: Dirty read.
b) Qual princípio do ACID é violado neste caso: Isolamento
c) Como alterar o comportamento sem perder performance drasticamente: Usar o nível de isolamento READ COMMITTED SNAPSHOT (RCSI)*/

/*6º. Questão- (1.0 ponto) – Analise o sql abaixo
d)	O que acontece com uma consulta no contas a pagar se o nível de isolamento READ UNCOMMITTED estiver sendo usado? Ocorre um dirty read 
e)	O que acontece o nível de isolamento READ COMMITTED estiver sendo usado nesta mesma consulta? A consulta vai aguardar a transação terminar
a)	A mesma está violando algum princípio do ACID? Explique. O SQL viola os princípios de atomicidade e isolamento do banco de dados. */

/* 7º. Questão- (1.0 ponto) Considerando criptografia, e os seguintes termos:
1	Dados criptografados
2	Database Master Key (DMK)
3	Chave Simétrica
4	Certificado
Descreva um fluxo de dependência, informando quem protege quem.
DMK -> Certificado -> Chave Simetrica -> Dados criptografados*/ 

/*7º. Questão- (1.0 ponto) – Explique as principais diferenças entre Transparent Data Encryption (TDE) e criptografia de coluna com ENCRYPTBYKEY. Explique quando cada uma delas deve ser usada e oque cada uma tenta proteger.*
TDE (Transparent Data Encryption)
  Criptografa todo o banco de dados (MDF, LDF e backups).
  Funciona de forma transparente, sem mudar INSERT/SELECT.
  Protege apenas dados em repouso contra roubo de arquivos físicos.
  Não impede que usuários internos vejam os dados via SELECT.

Criptografia de Coluna (ENCRYPTBYKEY)
  Criptografa campos específicos, como CPF, CNPJ, cartão etc.
  Exige alterar o código SQL para criptografar e descriptografar.
  Protege os dados dentro do próprio banco, permitindo acesso somente a quem tem a chave/certificado.
  Evita que até DBAs leiam dados sensíveis sem permissão. */

/*8º. Questão (1.0): Em um cenário de segurança, você deseja conceder privilégios a um usuário usu_relatorio para apenas realizar consultas em uma tabela chamada Vendas, mas sem permissões de alteração. Escreva os comandos necessários para o processo.*/
grant select on vendas to usu_relatorio;

/*9ª. Questão(1.0): Considere as tabelas pagar e evento com a estrutura abaixo. Crie uma sp que permita inserir um registro no contas a pagar. Esta SP deve registrar todo e qualquer erro que acontecer na tabela evento. O registro do erro deve conter:
•	o nome da SP  (use ERROR_PROCEDURE())
•	O nome do usuário (use SUSER_SNAME())
•	A mensagem de erro (use ERROR_MESSAGE())
•	A linha onde aconteceu o erro (use ERROR_LINE())
•	Data e hora do erro*/
create proc inserirregisto(@pag_descricao varchar(100), @pag_valor decimal(18,2), 
    @fkempresa int, @pag_vencimento date, @pag_pagto date, @pag_fatura varchar(50),
	@fkbanco int) as 

begin try
	begin tran;
		insert into pagar(pag_descricao, pag_valor, fkempresa, pag_vencimento, pag_pagto, pag_fatura, fkbanco)
        values (@pag_descricao, @pag_valor, @fkempresa, @pag_vencimento, @pag_pagto, @pag_fatura, @fkbanco);
	commit tran;
end try

begin catch
	insert into evento (eve_nomeSP, eve_nomeUser, eve_erro, eve_linha, Eve_datahora)
        values (ERROR_PROCEDURE(), SUSER_SNAME(), ERROR_MESSAGE(), ERROR_LINE(), GETDATE());
end catch
return

exec inserirregisto
@pag_descricao = 'Pagamento de energia',
@pag_valor = 450.75,
@fkempresa = 1,
@pag_vencimento = '2025-12-10',
@pag_pagto = '2025-12-05',
@pag_fatura = 'FAT-2025-889',
@fkbanco = 3;

/*10ª. Questão (1,0 ponto):  Analise a SP abaixo:
a)	A mesma é suscetível a ataques do tipo Sql Inject? Por que?
b)	Caso for, faça as alterações necessárias para que a mesma fique imune a este tipo de ataque.
c)	Explique como um usuário poderia fazer um ataque a uma procedure que não estivesse protegida.

drop proc validaUsuario
go
create proc validaUsuario
(@usuario varchar(100),
 @senha varchar(20))
as

DECLARE @consulta VARCHAR(500);
SET @consulta = 
  'SELECT usu_nome FROM usuarios 
      WHERE Usu_nome = ''' + @usuario + 
	  ''' AND Usu_senha = ''' + @senha + '''';
EXEC (@consulta)
Return*/ 
-- Sim, é totalmente suscetível a SQL Injection. Os parâmetros @usuario e @senha são concatenados diretamente para montar a string SQL. Isso permite que um usuário insira comandos maliciosos, como ' OR '1'='1 ou até '; DROP TABLE usuarios; --.
-- DROP PROC validaUsuario;
GO

CREATE PROC validaUsuario
(
    @usuario VARCHAR(100),
    @senha   VARCHAR(20)
)
AS
BEGIN
    SELECT usu_nome 
    FROM usuarios
    WHERE usu_nome = @usuario
      AND usu_senha = @senha;
END
GO
-- usando argumentos como 1=1

/*11ª Questão (1,0 ponto): Considerando o banco de dados uvv, faça as seguintes operações:
a)	Crie uma role chamada RoleFinanceira e configure as permissões para permitir leitura , escrita e consulta na tabela pagar. 
b)	Em seguida, adicione o usuário  usu_financeiro a esta role, mas de forma que ele não tenha permissão de escrita na tabela pagar.*/
--a) 
create role RoleFinanceira
grant select, insert, update on pagar to RoleFinanceira;
--b)
alter role RoleFinanceira add member usu_financeiro;
deny insert, update on pagar to usu_financeiro;

/*12ª Questão (1,0 ponto): Conceda permissão para o usuário user_consulta realizar consultas na tabela pagar, mas negue a ele a permissão de consultar os campos idpagar e fkempresa.*/
grant select on pagar to user_consulta;

deny select on idpagar to user_consulta;
deny select on fkempresa to user_consulta;

/*13ª Questão (1,0 ponto): Quais são os três pilares fundamentais da segurança em banco de dados conhecidos como modelo CIA? Explique cada um deles.*/
-- C: Confidencialidade- Garante que apenas usuários autorizados possam acessar determinadas informações. Impede acesso não autorizado, espionagem, vazamento de dados e uso indevido.
-- I: Isolamento- Garante que os dados não sejam alterados de forma indevida, acidentalmente ou maliciosamente. As informações devem permanecer corretas, completas e confiáveis.
-- A: Atomicidade- Garante que os dados estejam sempre acessíveis quando necessários. O sistema deve continuar funcionando mesmo diante de falhas, picos de uso ou ataques.

/*14ª. Questão (1,0 ponto): Explique a diferença entre conta de usuário e login de usuário. Explique onde é usado cada caso e como os dois tipos de contas se relacionam (ou não).
-- Login de usuário é criado no nível do servidor e serve apenas para autenticar a pessoa no SQL Server — é o que permite “entrar” no servidor.
-- Usuário de banco é criado dentro de um banco de dados específico e define as permissões que esse usuário terá naquele banco — é o que permite acessar tabelas e executar comandos.
Relação: O login permite entrar no servidor e o usuário do banco permite trabalhar dentro de um banco. Normalmente um login está associado a um usuário, mas um pode existir sem o outro.*/
