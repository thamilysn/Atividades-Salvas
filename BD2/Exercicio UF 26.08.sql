/*1) Gere uma consulta para mostrar em ordem alfabética todos os vendedores  da subregião ‘CARIACICA’*/
select ven_razaosocial 
	from cadVendedor, Subregiao 
where fksubregiao = idsubregiao 
order by ven_razaosocial asc

/*2) Gere uma consulta para mostrar em ordem alfabética todas as empresas da cidade de ‘VITÓRIA’.*/
select emp_razaosocial 
	from empresa, cidade
where fkcidade = idcidade 
order by emp_razaosocial asc

/*3) Gere uma consulta para mostrar em ordem alfabética todas empresas do estado do ‘ES’.*/
select emp_razaosocial 
	from empresa, cidade, uf
where fkcidade = idcidade 
	and fkuf = iduf 
	and fkuf = ‘ES’ 
order by emp_razaosocial asc

/*4) Crie um campo com o nome de EMP_LIMITE no cadastro de empresas. Este campo terá como objetivo armazenar o limite de compra de cada cliente.*/
	Alter table empresa add emp_limite numerical(10,3)

/*5) Defina os seguintes limites para as empresas:
	a) Empresas localizadas no ES  limite de 1.000,00
	b) Empresas localizadas na BA limite de 2.000,00
	b) Empresas localizadas no RS limite de 5.000,00*/

update empresa
set emp_limite = 1000.00
where fkcidade in 
	(select idcidade from cidade,uf 
	where fkuf = iduf 
	and ufDescricao = ‘ES’)

/*6)  Gere uma consulta para mostrar em ordem alfabética os nomes das empresas e o total AINDA não PAGO de cada uma. (campo pag_dtpagto não preenchido).*/
Select emp_razaosocial, 
	sum(case When pag_dtpagto is null then pag_valor else 0 end) 
from empresa, pagar 
where fkempresa = idempresa 
group by emp_razaosocial order by emp_razaosocial asc

/*7)  Gere uma consulta para mostrar a data de vencimento da fatura mais antiga, ainda não paga, do contas a pagar.*/
select top 1 pag_dtvencimento 
from pagar 
where pag_dtpagto is null 
order by pag_dtvencimento asc

/*8)  Gere uma consulta para mostrar QUANTAS faturas de cada empresa AINDA não esta PAGO  (campo pag_dtpagto não preenchido). Esta listagem deve estar ordenada de forma que as empresas com maior qtd de faturas aparecem em primeiro lugar*/
Select emp_razaosocial, 
	sum(case When pag_dtpago is null then 1 else 0 end) 
as totalFaturasPagar 
from empresa, pagar 
	where idempresa = fkempresa 
group by emp_razaosocial 
order by totalFaturasPagar desc

/*9)  Gere a mesma consulta acima, porém mostrando somente as 5 empresas que tem a maior qtd de faturas ainda não pagas.*/
Select top 5 emp_razaosocial, 
	sum(case When pag_dtpago is null then 1 else 0 end) 
as totalFaturasPagar 
from empresa, pagar 
	where idempresa = fkempresa 
group by emp_razaosocial 
order by totalFaturasPagar desc

/*10)  Delete os registros da tabela PAGAR que forma pagos no dia ‘22/11/2011.*/
Delete from pagar where pag_dtpagto = ‘2011-11-22’

/*11) Crie uma tabela com o nome de REGIAO, com os seguintes campos:
	IDregiao tipo inteiro, deve ser autoincremental
	Reg_descricao tipo texto*/
Create table região {
	Idregiao int identity(1,1) primary key,
	Reg_descricao text
	}

/*12) insira os seguintes registros nesta tabela.
	‘Grande São Paulo’, ‘Porto Alegre’,’Rio de Janeiro’*/
Insert into região(reg_descricao)
	Values(‘Grande São Paulo’),
	(‘Porto Alegre’),
	(‘Rio de Janeiro’);

/*13) Exclua a tabela REGIAO do banco de dados.*/
	Drop table região;

14) Gere uma consulta para mostra em ordem alfabética, o nome da empresa, e o total de faturas a receber de cada uma (faturas ainda não recebidas) , SOMENTE das empresas localizadas no estado de SP.
Select emp_razaosocial, 
	sum(case When rec_dtpago is null then 1 else 0 end) 
as totalFaturasReceber 
	from empresa, 
	receber, 
	cidade, 
	uf 
where idempresa = fkempresa 
and fkuf = iduf 
and fkcidade = idcidade 
and uf_descricao = ‘SP’ 
group by emp_razaosocial 
order by emp_razaosocial asc
