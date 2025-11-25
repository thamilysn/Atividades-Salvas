/*4º. Questão (1.0): Em um cenário de segurança, você deseja conceder privilégios a um usuário usu_relatorio para apenas realizar consultas em uma tabela chamada Vendas, mas sem permissões de alteração. Escreva os comandos necessários para o processo.*/
grant select on vendas to usu_relatorio
  
deny insert on vendas to usu_relatorio
deny update on vendas to usu_relatorio
deny delete on vendas to usu_relatorio

/*10ª. Questão (1,0 ponto): Um novo analista chamado Rafael precisa consultar e atualizar dados nas tabelas de vendas, mas não pode excluir dados.
Como um DBA, descreva qual estratégia de roles e permissões você usaria para conceder o acesso necessário a Rafael.*/

create role Role_Vendas;
grant select, update on Vendas to Role_Vendas;
alter role Role_Vendas add member Rafael;

/*16ª. Questão (1,0 ponto):
Foi executado:
GRANT CONTROL ON DATABASE::Loja TO gerente;
GRANT EXECUTE ON OBJECT::SP_altera_preco TO vendedor;
Depois:
DENY EXECUTE ON OBJECT::SP_altera_preco TO gerente;

Quem pode executar SP_altera_preco?
a) Apenas gerente, pois CONTROL inclui EXECUTE
b) Apenas vendedor, pois o DENY em gerente bloqueia mesmo o CONTROL
c) Ambos continuam executando normalmente
d) Nenhum dos dois
Porque?*/

--(b) Apenas vendedor, pois o DENY em gerente bloqueia mesmo o CONTROL

/*17ª. Questão (1,0 ponto):  
I.O Transparent Data Encryption (TDE) protege os dados em repouso, criptografando arquivos .mdf e .ldf.
II. O TDE também criptografa os dados em memória e durante o tráfego de rede.
III. Para usar TDE, é necessário um certificado protegido pela master key do banco master.
IV. O TDE não exige alterações nas aplicações.
a) I, III e IV
b) I e II
c) II e III
d) I, II e IV
e) Apenas III*/ 
--(a) I, III e IV

/*18ª. Questão (1,0 ponto):
I. A criptografia a nível de banco protege backups automaticamente.
II. A criptografia a nível de coluna protege apenas os campos específicos.
III. O TDE impede que DBAs leiam dados via consultas SQL.
IV. O Always Encrypted impede até o DBA de ler os dados sem a chave do cliente.
a) I, II e IV
b) I e II
c) II e III
d) I e III
e) II e IV*/
--(a) I, II e IV

/*19ª. Questão (1,0 ponto):
I. GRANT concede permissão.
II. DENY remove permissão concedida.
III. REVOKE remove permissão concedida e negações explícitas.
IV. DENY tem precedência sobre GRANT, mesmo herdado.
a) I, III e IV
b) I e II
c) I, II e IV
d) II e III
e) I e IV*/
--(e) I e IV

/*20ª. Questão :
I. Um DENY sempre prevalece sobre um GRANT.
II. Permissões concedidas via role são herdadas pelo usuário membro.
III. CONTROL em um objeto inclui ALTER, DELETE e EXECUTE.
IV. db_owner tem permissões gerais no banco especific
a) I, II e III
b) I e II
c) II e IV
d) I, II, III e IV
e) Apenas I e III*/
--(d) I, II, III e IV

/*20ª. Questão :
I. Um login é criado no nível da instância do SQL Server.
II. Um usuário é criado dentro de um banco de dados específico.
III. Por padrão, é possível ter um login sem usuário associado.
IV. Por padrão, é possível ter um usuário sem login associado.
a) I e II
b) I, II e III
c) I, II, III e IV
d) I, II e IV
e) Apenas I e III*/
--(b) I, II e III
