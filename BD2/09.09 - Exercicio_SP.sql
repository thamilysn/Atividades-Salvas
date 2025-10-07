/* a) Criar uma store procedure que permite inserir ou alterar o cadastro de colaborador. Se o id do colaborador for fornecido pelo usuário trata-se de uma ALTERAÇÃO, caso contrario trata-se de um inserção. Em caso de alterações, a SP deve conferir se existe o registro que se deseja alterar para evitar erros.
OBS: Em todas as inclusões/alteração estou considerando que os campos IDcolaborador e IDdependente são auto incremental, por isso não dou insert/update nestes campos */

create proc sp_iu_colabolador
  (@Idcolaborador int,
   @col_nome varchar(50),
   @col_dtnascimento datetime)
as

if @Idcolaborador is null /*se o idcolaborador for nulo, logo o user não foi forneceu o id. nesse caso, o banco vai inserir os valores.*/
   insert colaborador 
      (col_nome,
       col_dtnascimento)
   values 
	  (@col_nome,
       @col_dtnascimento)
else 
   begin
      if exists (select idcolaborador from colaborador where idcolaborador=@Idcolaborador) /*se o idcolaborador NÃO for nulo, o user forneceu um id. Nesse caso, o procedure vai verificar se o idcolaborador ja existe. Se NÃO existir, vai informar que o id não existe, e se existir, ele realizará o update. */
         update colaborador set
            col_nome		= @col_nome,
            col_dtnascimento = @col_dtnascimento
         where Idcolaborador = @Idcolaborador
      else
         select 'O colaborador que você deseja alterar os dados NÃO EXISTE'
   end

/* 2) Fazer uma store procedure que permita retornar o MAIOR  ou o MENOR ID da tabela Pagar ou da Tabela receber. O usuário deverá usar os seguintes parâmetros:
	0 – índica que deseja o menor ID
	1 – indica que deseja o maior ID
	‘P’ – Indica que quer o ID do contas a pagar
	‘R’ – indica que quer o ID do contas a receber

O valor deve ser retornado e armazenado em uma variável!! */

create proc MINMAX
( @TipoID int, 
  @Tabela varchar(1)
)
as
  if @TipoID=0 /*se for 0 será o menor id*/
    begin
       if @tabela='P' /*se for o menor id e for da tabela pagar*/     
          select min(idpagar) as minimo from pagar
       else /*se for o menor id da tabela receber*/
          select min(idreceber) as minimo from receber
     end
  else  /*se não for o menor id, será o maior id*/
     begin
       if @tabela='P' /*se for o maior id e for da tabela pagar*/           
          select MAX(idpagar) as maximo from pagar
       else /*se não for o menor id, será o maior id*/
          select MAX(idreceber) as maximo from receber
     end

/* 3) Store procedure para gerar um extrato de clientes em um período desejado. 
O usuário deve passar o NOME do cliente desejado, o período desejado, e informar de deseja ver somente:
as faturas RECEBIDAS (0), 
somente as faturas A RECEBER (1), 
ou Todas as faturas (2). 

A store procedure  deve retornar os seguintes dados:
Empresa, Descrição, Valor, Data vencimento, Data Pagamento
*/

create proc Extrato
( @tipodesejado	int,
  @nome			varchar(50,
  @datainicial	datetime,
  @datafinal	datetime
)
as	

if @tipodesejado=0 -- se for 0 será as faturas recebidas
   begin
       select emp_razaosocial as empresa, rec_descricao as descricao,
           rec_vlrpagto as valor, rec_dtvencimento as vencimento,
           rec_dtpagto as DataPagamento
       from empresa, receber
       where fkempresa=idempresa
         and emp_razaosocial like @nome+'%' -- Não esquecer do sinal %, senão o sql ira mostrar somente os clientes EXATAMENTE igual ao nome digitado
         and rec_dtvencimento<=@dataFinal 
         and rec_dtpagto is not null
    end

if @tipodesejado=1 -- se for 1 será as faturas NÃO recebidas
   begin
       select emp_razaosocial as empresa, rec_descricao as descricao,
           rec_vlrpagto as valor, rec_dtvencimento as vencimento,
           rec_dtpagto as DataPagamento
       from empresa,receber
       where fkempresa=idempresa
         and emp_razaosocial like @nome+'%'
         and rec_dtvencimento>=@dataInicial
         and rec_dtvencimento<=@dataFinal
	   	 and rec_dtpagto is null  -- so muda esta linha, is null, indica que o filtro vai pegar somente faturas com a data de pagto	em branco, ou seja, não recebidas
    end

if @tipodesejado=2 -- Todas as faturas
   begin
       select emp_razaosocial as empresa, rec_descricao as descricao,
           rec_vlrpagto as valor, rec_dtvencimento as vencimento,
           rec_dtpagto as DataPagamento
       from empresa,receber
       where fkempresa=idempresa
         and emp_razaosocial like @nome+'%' 
         and rec_dtvencimento>=@dataInicial 
         and rec_dtvencimento<=@dataFinal
    end

/* 4) Store procedure para gerar um extrato resumido de todos os clientes em um determinado período. 
O usuário deve passar como paramento o período desejado e se deseja ver somente:
as faturas RECEBIDAS (0), 
somente as faturas A RECEBER (1) ou 
Todas as faturas (2).	A store procedure  deve retornar os seguintes dados:

Empresa	Total Faturado Total Já Recebido	Total a Receber
*/ 
	
create proc Extrato
( @tipodesejado	int,
  @datainicial	datetime,
  @datafinal	datetime
)
as	

if @tipodesejado=0 -- somente faturas já recebidas
   begin
       select emp_razaosocial as empresa,
           sum(rec_vlrpagto) as 'Total Faturado',
           sum(case when rec_dtpagto is NOT null then rec_vlrpagto else 0 end)  as 'Valor ja recebido',
           sum(case when rec_dtpagto is null then rec_vlrpagto else 0 end)  as 'Valor A receber'          
       from empresa,receber
       where fkempresa=idempresa
         and rec_dtvencimento>=@dataInicial
         and rec_dtvencimento<=@dataFinal
	     and rec_dtpagto is not null
       group by emp_razaosocial
    end

if @tipodesejado=1 -- somente faturas NÃO recebidas
   begin
       select emp_razaosocial as empresa,
           sum(rec_vlrpagto) as 'Total Faturado',
           sum(case when rec_dtpagto is NOT null then rec_vlrpagto else 0 end)  as 'Valor ja recebido',
           sum(case when rec_dtpagto is null then rec_vlrpagto else 0 end)  as 'Valor A receber'          
       from empresa,receber
       where fkempresa=idempresa
         and rec_dtvencimento>=@dataInicial
         and rec_dtvencimento<=@dataFinal
	     and rec_dtpagto is null
       group by emp_razaosocial
    end

if @tipodesejado=2 -- Todas as faturas
   begin
       select emp_razaosocial as empresa,
           sum(rec_vlrpagto) as 'Total Faturado',
           sum(case when rec_dtpagto is NOT null then rec_vlrpagto else 0 end)  as 'Valor ja recebido',
           sum(case when rec_dtpagto is null then rec_vlrpagto else 0 end)  as 'Valor A receber'          
       from empresa,receber
       where fkempresa=idempresa
         and rec_dtvencimento>=@dataInicial
         and rec_dtvencimento<=@dataFinal
       group by emp_razaosocial
    end
