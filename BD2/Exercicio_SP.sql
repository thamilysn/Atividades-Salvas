/* a) Criar uma store procedure que permite inserir ou alterar o cadastro de colaborador. Se o id do colaborador for fornecido pelo usuário trata-se de uma ALTERAÇÃO, caso contrario trata-se de um inserção. Em caso de alterações, a SP deve conferir se existe o registro que se deseja alterar para evitar erros.
OBS: Em todas as inclusões/alteração estou considerando que os campos IDcolaborador e IDdependente são auto incremental, por isso não dou insert/update nestes campos */

create proc sp_iu_colabolador
  (@Idcolaborador  int,
   @col_nome		varchar(50),
   @col_dtnascimento datetime)
as

if @Idcolaborador is null
   insert colaborador 
      (col_nome,
       col_dtnascimento)
   values 
	  (@col_nome,
       @col_dtnascimento)
else
   begin
      if exists (select idcolaborador from colaborador where idcolaborador=@Idcolaborador)
         update colaborador set
            col_nome		= @col_nome,
            col_dtnascimento= @col_dtnascimento
         where idcolabroador=@Idcolaborador
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
( @TipoID int, --  se o usuário quer o menor ou a maior ID
  @Tabela varchar(1) --  se o usuário quer selecionar a tabela pagar ou receber
)
as
  if @TipoID=0 -- o usuário que o menor ID
    begin
       if @tabela='P' -- o usuário que o menor ID do conta a pagar        
          select min(idpagar) as minimo from pagar
       else --se @tabela for diferente de P o usuário quer o menor ID do receber
          select min(idreceber) as minimo from receber
     end
  else  -- se  @tipoID nÃo for 0 é pq o usuário que o MAIOR id
     begin
       if @tabela='P' -- o usuário que o menor ID do conta a pagar        
          select MAX(idpagar) as maximo from pagar
       else --se @tabela for diferente de P o usuário quer o menor ID do receber
          select MAX(idreceber) as maximo from receber
     end

/* 3) Store procedure para gerar um extrato de clientes em um período desejado. 
O usuário deve passar o NOME do cliente desejado , 
o período desejado, 
e informar de deseja ver somente as faturas RECEBIDAS (0), somente as faturas A RECEBER (1) ou Todas as faturas (2). 

A store procedure  deve retornar os seguintes dados:
Empresa	Descrição	Valor Data vencimento	Data Pagamento
*/

create proc Extrato
( @tipodesejado	int,
  @nome			varchar(50,
  @datainicial	datetime,
  @datafinal	datetime
)
as	

if @tipodesejado=0 -- somente faturas já recebidas
   begin
       select emp_razaosocial as empresa, rec_descricao as descricao,
           rec_vlrpagto as valor, rec_dtvencimento as vencimento,
           rec_dtpagto as DataPagamento
       from empresa,receber
       where fkempresa=idempresa
         and emp_razaosocial like @nome+'%' -- Não esquecer do sinal %,               	   and rec_dtvencimento>=@dataInicial  ---senão o sql ira mostra
         and rec_dtvencimento<=@dataFinal    -- somente os clientes 
         and rec_dtpagto is not null 	    -- EXATAMENTE igual ao 								    --	nome digitado
    end

if @tipodesejado=1 -- somente faturas NÃO recebidas
   begin
       select emp_razaosocial as empresa, rec_descricao as descricao,
           rec_vlrpagto as valor, rec_dtvencimento as vencimento,
           rec_dtpagto as DataPagamento
       from empresa,receber
       where fkempresa=idempresa
         and emp_razaosocial like @nome+'%'
         and rec_dtvencimento>=@dataInicial
         and rec_dtvencimento<=@dataFinal
	   	 and rec_dtpagto is null  -- so muda esta linha, is null 							   ---indica que o filtro vai pegar 						-- somente faturas com a data de 
						-- pagto	em branco, ou seja, não
						-- recebidas
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

/* 4) Store procedure para gerar um extrato resumido de todos os clientes em um determinado período. O usuário deve passar como paramento o período desejado e se deseja ver somente as faturar RECEBIDAS (0), somente as faturas A RECEBER (1) ou Todas as faturas (2).	A store procedure  deve retornar os seguintes dados:

	Empresa	Total Faturado	Total Já Recebido	Total a Receber
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

--- ATENÇÃO paras a linha:
--           sum(case when rec_dtpagto IS NULL then rec_vlrpagto else --  0 end)  as 'Valor A receber',
-- Antes de fazer o SUM o sql ira testar o campo rec_dtpagto, se este -- campo FOR NULO (ou seja, a fatura não esta paga)
-- ele soma o valor do campo no total a receber, senão soma zero. 

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

