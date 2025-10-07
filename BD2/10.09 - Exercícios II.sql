/*1) Analise as afirmações abaixo: (usada)

i - Um backup diferencial captura todas as alterações feitas desde o último backup completo.
ii - Um backup incremental captura apenas as alterações desde o último backup feito, seja ele completo, diferencial ou incremental
iii – O tamanho do backup diferencial geralmente é menor que o incremental
iv –  Os backup’s incrementais e diferenciais, quando usados em conjunto, substituem o backup completo.

Está correto o que se afirma em:
(a)	i, ii, iv
(b)	i e ii <-
(c)	i e iii
(d)	ii e iv
(e)	ii e iii*/

/*2) Qual comando deve ser emitido para mostrar o nome da empresa  e o total das faturas ainda não pagas de cada empresa,  somente das empresas que possuem um total a pagar superior à R$ 2.000,00? 
Considere que fatura não paga é aquela na qual o campo Pagamento está vazio (Null).*/
select empresa, sum(valor) as total_a_pagar
from faturas
where pagamento is null
group by empresa
having sum(valor) > 2000;

/*3) o comando select* into ##tab_temp from empresa terá o seguinte resultado.(usada)
i.	Irá criar uma tabela temporária com todos os campos e dados da tabela empresa. A tabela temporária criada terá um escopo global, estará visível para qualquer sessão e ficará ativa até que a sessão que a criou permaneça ativa. A tabela temporária criada ficará armazenada no banco de dados tempdb.<-
ii.	Irá criar uma tabela temporária vazia, com todos os campos da tabela empresa. A tabela temporária criada terá um escopo local, estará visível para qualquer sessão do servidor e ficará ativa até que a sessão que a criou permaneça ativa. A tabela temporária ficara armazenada no banco de dados tempdb. 
iii.	Irá criar uma tabela temporária vazia, com todos os campos da tabela empresa. A tabela temporária criada terá um escopo local, estará visível somente para a sessão que a criou e será excluída quando a sessão que a criou for encerrada. A tabela temporária criada ficara armazenada no mesmo banco de dados da tabela empresa.
iv.	Irá criar uma tabela temporária com todos os campos e dados da tabela empresa. A tabela temporária criada terá um escopo local, estará visível somente para a sessão que a criou e será excluída quando a sessão que a criou for encerrada. A tabela temporária criada ficara armazenada no mesmo banco de dados da tabela empresa.
v.	Irá criar uma tabela normal com o nome ##tab_temp no mesmo banco de dados da tabela empresa.*/

/*4)  Assinale a alternativa que descreve as VIEWS correta. (usada)
i.	É uma tabela física, derivada de outra tabela ou consulta e uma vez criada, não tem nenhum vínculo com a tabela ou consulta que a originou. Alterações feitas nas tabelas de origem não afetam a view, e alterações feitas na view nunca afetam as tabelas que a origem
ii.	É uma tabela virtual, derivada de outra tabela ou consulta e após a criação mantém um vínculo com as tabelas de origem. Alterações na tabela de origem irão afetar a view e alterações feitas na view podem afetar as tabelas de origem <-
iii.	É uma tabela virtual, derivada de outra tabela ou consulta e após a criação não mantém nenhum vínculo com as tabelas de origem. Alterações na tabela de origem não irão afetar a view e alterações feitas na view podem afetar as tabelas de origem
iv.	É uma tabela virtual, derivada de outra tabela ou consulta e após a criação  mantém um vínculo com as tabelas de origem. Alterações na tabela de origem afetam a view e alterações feitas na view não afetam as tabelas de origem
v.	É uma tabela fisica, derivada de outra tabela ou consulta e após a criação  mantém um vínculo com as tabelas de origem. Alterações na tabela de origem afetam a view e alterações feitas na view  podem afetar as tabelas de origem*/

/*5) Qual das seguintes afirmações melhor descreve uma view em um banco de dados?
a) Uma view é uma cópia física dos dados que pode ser modificada sem afetar as tabelas originais.
b) Uma view é uma tabela virtual que não mantém qualquer vínculo com as tabelas originais após sua criação.
c) Uma view é uma tabela virtual que representa dados derivados de uma consulta ou de uma ou mais tabelas originais. <-
d) Uma view é um procedimento armazenado que automatiza tarefas no banco de dados.
e) Uma view é um conjunto de regras aplicadas ao banco de dados para garantir a segurança dos dados.*/


/*8) Suponha que você tenha a tabela Funcionarios(id_func, nome, departamento, salario).
Crie uma VIEW chamada vw_salario_depto que mostre o salário médio de cada departamento.

Depois, escreva uma consulta sobre essa view que retorne apenas os departamentos com salário médio acima de R$ 5.000.*/

create view vw_salario_depto as
select departamento, avg(salario) as media_salarial
from funcionarios
group by departamento
having media_salarial > 5000;

/*9) Dada a tabela Produtos(id_prod, nome, categoria, preco, estoque) e a tabela Vendas(id_venda, id_prod, quantidade, data_venda), 
crie uma stored procedure chamada sp_top_vendas_categoria que retorne, para um período informado (@data_ini, @data_fim), os 3 produtos mais vendidos por categoria, considerando a soma das quantidades.*/

create proc sp_top_vendas_categoria(@data_inicio, @data_fim) as
  
begin
select top (3) nome, categoria, count*(quantidade) as qtd from produtos, vendas
where id_prod = fk_prod 
and data_venda >= @data_inicio 
and data_venda <+ @datafim
  
group by nome, categoria
order by categoria, count(quantidade) desc
end

