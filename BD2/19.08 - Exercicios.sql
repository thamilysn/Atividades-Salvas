/*
a)	Use a tabela conta a pagar para gerar um relatorio com o seguinte layout:
Obs: Os dia em atraso devem ser calculados somente para fatura NÃO PAGAS e que estejam com o pagamento em atraso. Caso contrario, o campo atraso deve ser zero. */

select 
	Emp_RazaoSocial as Empresa, 
	idPagar as idFatura, 
	Pag_Fatura as Fatura, 
	Pag_Descricao as Descrição, 
	Pag_Valor as Débito, 
	Pag_DataVencimento as Vencimento, 
	Pag_DataPagto as Pagamento, 

case 
    when Pag_DataPagto is not null then 0 /*se a data de pagamento não for nula, isso significa que ela já foi paga, logo o atraso é de 0 dias.*/
    else datediff(dd, Pag_DataVencimento, getdate()) /*se não, você pega os dias em atraso, e considera do dia da data de vencimento até o dia atual para ver quantos dias a conta está atrasada*/
    end as Atraso
       
from Pagar, empresa 
where Idempresa = FkEmpresa
	
/* b)	Use a tabela conta a receber para gerar um relatorio que mostre:
a.	O nome da empresa
b.	Quantidade de fatura ainda não pagas
c.	Valor total ainda não pago */

select 
Emp_RazaoSocial as Empresa, /*puxar o nome das empresas*/
sum(Rec_valor) as Total, /*soma do total que não foi pago ainda*/
count(IdReceber) as Qtd /*Quantidade total do que ainda não foi recebido*/
       
from receber, empresa       
where Idempresa = FkEmpresa and rec_pagto is null /*de onde a empresa tiver fk, e de onde tiver algo a receber*/
group by Emp_RazaoSocial

select * from receber

/*c) Gerar uma lista com o nome  e o total a pagar de todas as empresa que estão na tabela contas a pagar e NÃO estão na tabela do contas a receber. */

select 
	Emp_RazaoSocial as Empresa, /*nome das empresas*/
	sum(Pag_valor) as Total /*total do valor a ser pago*/
       
from pagar, empresa 
where Idempresa = FkEmpresa and fkempresa not in(select fkempresa from receber) /*exclui as empresas que têm contas a receber, sobrando apenas as que tem algo a pagar.*/

group by Emp_RazaoSocial

/*d) Usando a mesma tabela, gere um relatorio que mostre
a.	O nome da empresa
b.	Quantidade de fatura ainda não pagar 
c.	Valor total ainda não pago
d.	Quantidade de fatura já pagas
e.	Valor ds faturas já pagas*/

select 
	Emp_RazaoSocial as Empresa, 
	count(case when rec_Pagto is null then 1 end) as Qtd_Aberto, /*Se rec_pagto é nulo, significa que a fatura ainda não foi paga, logo cada fatura conta como 1 para somar em Qtd_Aberto.*/
	sum(case when rec_Pagto is null then rec_valor else 0 end) as Total_Aberto, /*Se a fatura ainda não foi paga, pega o valor (rec_valor). Se já foi paga, soma 0.*/
	count(case when rec_Pagto is not null then 1 end) as Qtd_Recebida, /*Se rec_Pagto não for nulo, quer dizer que a fatura foi paga, logo cada fatura paga conta 1 para somar em Qtd_Recebidas.*/
	sum(case when rec_Pagto is not null then rec_valor else 0 end) as Total_Recebido /*e então, se já foi pago, soma o valor (rec_valor). Se ainda não foi pago, soma 0. No final mostra o total já recebido daquela empresa.*/
       
from receber, empresa        
where Idempresa = FkEmpresa
group by Emp_RazaoSocial
	
/*e) Use as tabelas pagar e receber para gerar um  fluxo de caixa que mostre:
	Nome da empresa,
	Idfatura
	Descricao,
	Valor do debito (para faturas do contas a pagar)
	Valor do credito (para fatura do contas a receber)
	Vencimento

Obs:  Mostrar somente as fatura AINDA NÃO PAGAS (campo pagamento sem data).
Deve ser mostrado em ordem de data*/

/*CONTAS A PAGAR*/
select 
	Emp_RazaoSocial as Empresa,
	idpagar as idFatura,
	pag_fatura as Fatura,
	pag_descricao as Descrição,
	pag_valor as Débito,
	0.00 as Crédito,
	Pag_DataVencimento as Vencimento
       
from pagar, empresa    
where Idempresa = FkEmpresa and Pag_DataPagto is NULL

union all
	
/*CONTAS A RECEBER*/
select 
	Emp_RazaoSocial as Empresa,
	idreceber as idFatura,
	rec_fatura as Fatura,
	rec_descricao as Descrição,
	0.00 as Débito,
	rec_valor as Crédito,
	rec_vencimento as Vencimento

from receber, empresa
where idempresa = fkempresa  and Rec_Pagto is NULL

order by Vencimento DESC

/*f)	Totalizar o fluxo de caixa por dia, mostrando a data, dia da semana, total a pagar e total a receber.*/

select
	datename(weekday, Pag_DataVencimento) as Dia,
	Pag_DataVencimento as Vencimento,
	pag_valor as Pagar,
	0.00 as Receber
from pagar

union all
select
datename(weekday, rec_vencimento) as Dia,
rec_vencimento as Vencimento,
0.00 as Pagar,
rec_valor as Receber

from receber
 
/*g)	Usar o mesmo sql acima e mostre somente os dias em que o total a pagar seja maior que R$ 1.000,00*/
select
	datename(weekday, Pag_DataVencimento) as Dia,
	Pag_DataVencimento as Vencimento,
	pag_valor as Pagar,
	0.00 as Receber

from pagar
where pag_valor > 1000

union all
	
select
	datename(weekday, rec_vencimento) as Dia,
	rec_vencimento as Vencimento,
	0.00 as Pagar,
	rec_valor as Receber
from receber
where rec_valor > 1000
