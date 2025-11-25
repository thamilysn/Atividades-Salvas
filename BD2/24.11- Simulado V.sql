✅1) Explique cada propriedade ACID e por que elas são fundamentais em sistemas multiusuários.
Resposta:
Atomicidade: a transação executa tudo ou nada; evita dados parciais em caso de falhas.
Consistência: garante que o banco continue válido após a transação, respeitando regras e constraints.
Isolamento: evita interferência entre transações simultâneas (dirty read, phantom read etc.).
Durabilidade: após o COMMIT, os dados ficam permanentes, mesmo com falhas de energia ou sistema.

✅ 2) Explique a função dos comandos BEGIN TRAN, COMMIT e ROLLBACK, e dê um exemplo real onde elas são essenciais.
Resposta:
BEGIN TRAN: inicia uma transação.
COMMIT: confirma as operações e grava no banco.
ROLLBACK: desfaz tudo o que foi alterado.
Exemplo: transferência bancária. Se um depósito falha durante o processo, tudo deve ser revertido para não haver inconsistências.

✅ 3) O que é a variável @@ERROR e qual sua limitação principal?
Resposta:
@@ERROR captura o código do último erro ocorrido.
Limitação: seu valor é perdido ao executar qualquer outra instrução. Deve ser verificada logo após o comando que pode gerar erro.

✅ 4) Explique os três pilares do modelo de segurança CIA.
Resposta:
Confidencialidade: apenas pessoas autorizadas podem acessar os dados.
Integridade: evita alterações indevidas ou corrupção de dados.
Disponibilidade: o sistema deve estar acessível sempre que necessário.

✅ 5) Compare os mecanismos TRY/CATCH e THROW na tratativa de erros. Quando cada um deve ser utilizado?
Resposta:

TRY/CATCH: permite capturar, tratar e registrar erros dentro do T-SQL (ex: log, rollback).
THROW: relança o erro mantendo a mensagem original.
Uso:
TRY/CATCH quando for tratar internamente.
THROW quando quiser repassar o erro para o chamador.

✅ 6) Explique a diferença entre login e usuário (user) no SQL Server e por que ambos são necessários para acesso ao banco.
Resposta:
Login: nível da instância; autentica o acesso ao SQL Server.
User: nível do banco; controla permissões dentro de um banco específico.
Ambos são necessários porque entrar no servidor não garante acesso a bancos, e vice-versa.

✅ 7) Explique o que são Roles.
Resposta:
Roles são grupos de permissões. Em vez de dar permissões usuário por usuário, vinculamos o usuário a uma role que já possui permissões acumuladas.

✅ 8) Qual a diferença entre roles de servidor e roles de banco de dados? Dê um exemplo de uso.
Resposta:
Server roles: controlam permissões na instância inteira (ex: sysadmin, securityadmin).
Database roles: controlam permissões dentro de um banco (ex: db_datareader).
Exemplo:
sysadmin pode tudo no servidor.
db_datareader permite ler tabelas apenas dentro de um banco.

✅ **9) Escreva uma SP que receba como parâmetro o ID de registros (separadamente), e exclua este ID no contas a receber. Considere:
a) Todos os registros devem ser excluídos ou a operação revertida
b) Se algum não existir ou houver erro, reverta
c) Caso algum não exista, mostrar mensagem**

Resposta (SP):
CREATE PROCEDURE spExcluirContasReceber
    @ID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        IF NOT EXISTS (SELECT 1 FROM contas_receber WHERE id = @ID)
        BEGIN
            RAISERROR('Registro não encontrado.', 16, 1);
        END

        DELETE FROM contas_receber WHERE id = @ID;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END

✅ 10) Crie um login no SQL Server com autenticação SQL e depois crie um usuário correspondente dentro do banco uvv.
Resposta:
CREATE LOGIN login_uvv
WITH PASSWORD = 'Senha123#';
USE uvv;
CREATE USER usuario_uvv FOR LOGIN login_uvv;

✅ 11) Conceda permissão de execução em todas as Stored Procedures do banco para o usuário criado na questão anterior.
Resposta:
GRANT EXECUTE TO usuario_uvv;

✅ 12) Remova o direito de SELECT sobre a tabela empresa para o usuário criado.
Resposta:
REVOKE SELECT ON dbo.empresa FROM usuario_uvv;

✅ 13) Crie uma Role chamada Role_financeira e adicione a ela o usuário criado anteriormente. Em seguida, conceda permissões de SELECT e INSERT nas tabelas pagar e receber e empresa.
Resposta:
USE uvv;
CREATE ROLE Role_financeira;
ALTER ROLE Role_financeira ADD MEMBER usuario_uvv;
GRANT SELECT, INSERT ON pagar   TO Role_financeira;
GRANT SELECT, INSERT ON receber TO Role_financeira;
GRANT SELECT, INSERT ON empresa TO Role_financeira;

✅ 14) O usuário anterior (adicionado à role) pode consultar todas as colunas da tabela empresa? Por quê?
Resposta:
Sim.
Porque a Role_financeira recebeu permissão de SELECT na tabela empresa, e permissões de roles são herdadas pelos usuários membros.

✅ 15) É possível um usuário (user) estar relacionado a mais de um login? Explique.
Resposta:
Não.
Um usuário (user) só pode estar associado a um único login no SQL Server.

✅ 16) Crie uma SP para validar usuário e senha que seja imune a ataques de SQL Injection.
Resposta:
CREATE PROCEDURE spValidarUsuario
    @usuario VARCHAR(50),
    @senha   VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id, nome
    FROM usuarios
    WHERE login = @usuario
      AND senha = HASHBYTES('SHA2_256', @senha);
END
