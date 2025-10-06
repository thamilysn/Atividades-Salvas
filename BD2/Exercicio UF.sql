/* Baseado no projeto mostrado na pagina anterior, responda:

1) Gere uma consulta para mostrar em ordem alfabética todos os vendedores  da subregião ‘CARIACICA’

2) Gere uma consulta para mostrar em ordem alfabética todas as empresas da cidade de ‘VITÓRIA’.

3) Gere uma consulta para mostrar em ordem alfabética todas empresas do estado do ‘ES’.

4) Crie um campo com o nome de EMP_LIMITE no cadastro de empresas. Este campo terá como objetivo armazenar o limite de compra de cada cliente.

5) Defina os seguintes limites para as empresas:
	a) Empresas localizadas no ES  limite de 1.000,00
	b) Empresas localizadas na BA limite de 2.000,00
	b) Empresas localizadas no RS limite de 5.000,00

6)  Gere uma consulta para mostrar em ordem alfabética os nomes das empresas e o total AINDA não PAGO de cada uma. (campo pag_dtpagto não preenchido).

7)  Gere uma consulta para mostrar a data de vencimento da fatura mais antiga, ainda não paga, do contas a pagar.

8)  Gere uma consulta para mostrar QUANTAS faturas de cada empresa AINDA não esta PAGO  (campo pag_dtpagto não preenchido). Esta listagem deve estar ordenada de forma que as empresas com maior qtd de faturas aparecem em primeiro lugar

8)  Gere a mesma consulta acima, porém mostrando somente as 5 empresas que tem a maior qtd de faturas ainda não pagas.

10)  Delete os registros da tabela PAGAR que forma pagos no dia ‘22/11/2011.

11) Crie uma tabela com o nome de REGIAO, com os seguintes campos:
	IDregiao tipo inteiro, deve ser autoincremental
	Reg_descricao tipo texto

12) insira os seguintes registros nesta tabela.
	‘Grande São Paulo’, ‘Porto Alegre’,’Rio de Janeiro’

13) Exclua a tabela REGIAO do banco de dados.

14) Gere uma consulta para mostra em ordem alfabética, o nome da empresa, e o total de faturas a receber de cada uma (faturas ainda não recebidas) , SOMENTE das empresas localizadas no estado de SP.
 
15) Qual o tipo de deleção deve ser aplicado no relacionamento entre as tabelas empresa e receber? Por que?
