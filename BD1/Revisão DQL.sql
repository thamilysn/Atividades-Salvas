USE Revisao;

-- 1. Selecione todos os jogos disponíveis no banco de dados.
SELECT * FROM jogos;

-- 2. Liste os nomes e telefones de todos os clientes cadastrados.
SELECT nome, telefone FROM clientes;

-- 3. Encontre todos os jogos lançados após o ano de 2020.
SELECT * FROM jogos WHERE ano_lancamento > 2020;

-- 4. Liste todos os clientes que moram na cidade de 'Vila Velha'.
SELECT nome FROM clientes
JOIN enderecos ON clientes.endereco_id = enderecos.endereco_id
WHERE enderecos.cidade = 'Vila Velha';

-- 5. Obtenha todas as locações feitas no último mês (considerando a data atual).
SELECT * FROM locacoes WHERE data_locacao >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 6. Liste os jogos disponíveis em ordem crescente de preço da diária.
SELECT * FROM jogos ORDER BY preco_diaria ASC;

-- 7. Mostre os 5 clientes mais recentes cadastrados, ordenados pela data de nascimento.
SELECT * FROM clientes ORDER BY data_nascimento DESC LIMIT 5;

-- 8. Calcule a quantidade de locações feitas por cada cliente.
SELECT cliente_id, COUNT(*) AS quantidade_locacoes
FROM locacoes
GROUP BY cliente_id;

-- 9. Encontre os jogos mais alugados (com pelo menos 5 locações).
SELECT jogo_id, COUNT(*) AS quantidade_locacoes
FROM locacoes
GROUP BY jogo_id
HAVING COUNT(*) >= 5;

-- 10. Liste os métodos de pagamento e a soma total de valores pagos para cada método.
SELECT metodo_pagamento, SUM(valor_pago) AS total_pago
FROM pagamentos
GROUP BY metodo_pagamento;

-- 11. Recupere os detalhes das locações, incluindo o nome do cliente e o título do jogo.
SELECT clientes.nome AS nome_cliente, jogos.titulo AS titulo_jogo, locacoes.*
FROM locacoes
JOIN clientes ON locacoes.cliente_id = clientes.cliente_id
JOIN jogos ON locacoes.jogo_id = jogos.jogo_id;

-- 12. Liste os endereços de todos os clientes, com seus respectivos nomes.
SELECT clientes.nome, enderecos.*
FROM clientes
JOIN enderecos ON clientes.endereco_id = enderecos.endereco_id;

-- 13. Mostre todas as locações em que o status é 'Atrasada', incluindo os dados do cliente e o jogo alugado.
SELECT clientes.nome AS nome_cliente, jogos.titulo AS titulo_jogo, locacoes.*
FROM locacoes
JOIN clientes ON locacoes.cliente_id = clientes.cliente_id
JOIN jogos ON locacoes.jogo_id = jogos.jogo_id
WHERE locacoes.status_loc = 'Atrasada';

-- 14. Calcule o valor médio das diárias dos jogos.
SELECT AVG(preco_diaria) AS valor_medio_diaria FROM jogos;

-- 15. Determine o valor total arrecadado em pagamentos.
SELECT SUM(valor_pago) AS total_arrecadado FROM pagamentos;

-- 16. Encontre o jogo mais caro no banco de dados.
SELECT * FROM jogos ORDER BY preco_diaria DESC LIMIT 1;

-- 17. Liste os 3 jogos mais baratos disponíveis para locação.
SELECT * FROM jogos ORDER BY preco_diaria ASC LIMIT 3;

-- 18. Mostre as 10 locações mais recentes, incluindo a data de locação e o status.
SELECT * FROM locacoes ORDER BY data_locacao DESC LIMIT 10;

-- 19. Identifique os clientes que fizeram mais de 3 locações.
SELECT cliente_id, COUNT(*) AS quantidade_locacoes
FROM locacoes
GROUP BY cliente_id
HAVING COUNT(*) > 3;

-- 20. Liste os jogos com preço médio diário acima de R$5 e que possuem mais de 2 locações.
SELECT jogo_id, AVG(preco_diaria) AS preco_medio_diaria, COUNT(*) AS locacoes
FROM locacoes
JOIN jogos ON locacoes.jogo_id = jogos.jogo_id
GROUP BY jogo_id
HAVING AVG(preco_diaria) > 5 AND COUNT(*) > 2;