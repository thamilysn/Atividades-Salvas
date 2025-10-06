/*1º. Questão - (1.0 ponto): Considere as tabelas PAGAR e AUDITORIA com as estruturas listadas abaixo. Crie um método de auditoria, que tenha atenda os seguintes requisitos:
a. Armazene a data/hora, usuário, estação e dados excluidos (Pag_fatura, pag_descricao e
valor) de qualquer registro excluido da tabela pagar.
b. Armazene a data/hora, usuário, estação e dados alterados (Pag_fatura, pag_descricao e
valor), de qualquer registro ALTERADO na tabela pagar.
c. Indicar se a operação registrada foi uma exclusão ou alteração
d. Use SYSTEM_USER e HOST_NAME() para pegar o nome do usuário e o nome da estação */

/*2ª. Questão - (1.0 ponto): Criar uma store procedure que permita inserir ou alterar uma fatura no
contas a pagar (tabela Pagar).
1. Se o id do colaborador for fornecido pelo usuário trata-se de uma ALTERAÇÃO, caso
contrário trata-se de uma inserção.
2. Em caso de alterações, a SP deve conferir se existe o registro que se deseja alterar.Caso
não existir, deve ser mostrado uma mensagem para o usuário.
3. Em todas as inclusões/alteração considere que os campos IDpagar e IDreceber são auto Incrementais, ou seja, não devem ser incluidos nos inserts/updates */

/*3º. Questão - (1.0 ponto): Criar uma store procedure que permita ao usuário consultar o Total a pagar para um fornecedor em um determinado período: 
1. O usuário deve fornecer a data inicial , a data final e nome (ou a parte inicial do nome) da empresa que deseja consultar. 
2. Considere uma fatura paga se o campo pag_pagto contiver uma data.
3. Por exemplo, uma consulta para o cliente 'Fazenda deve retornar algo como: */

/*3º. Questão - (1.0 ponto): Criar uma store procedure que permita ao usuário consultar o Total a pagar para um fornecedor em um determinado período: 
1. O usuário deve fornecer a data inicial , a data final e nome (ou a parte inicial do nome) da empresa que deseja consultar. 
2. Considere uma fatura paga se o campo pag_pagto contiver uma data.
3. Por exemplo, uma consulta para o cliente 'Fazenda deve retornar algo como: 

(0,5 extra)- Mostre também o valor das faturas já pagas, conforme o desenho abaixo:
Total_Pago Total_A_Pagar*/

/* 4ª. Questão - (1.0 ponto ) Use as tabelas pagar e receber para gerar um fluxo de caixa que mostre:
Nome da empresa,
Idfatura
Descricao,
Valor do debito (para faturas do contas a pagar),
Valor do credito (para fatura do contas a receber),
Vencimento 

Obs: 
a) mostrar apenas as faturas AINDA NÃO PAGAS (campo pag_pagto sem data)
b) ordenar por ordem de data
c) exemplo de saída desejada */

/* 5ª. Questão - (0.5 ponto ): Use a tabela conta a pagar para gerar um relatório com o seguinte layout

Observações:
a. Os dias em atraso devem ser calculados somente para Jetora NÃO PAGAS e que estejam
com o pagamento em atraso. Caso contrario, o campo atraso deve ser zero.

b. Mostrar a listagem ordenada pela quantidade de dias em atraso */

/* 5ª. Questão - (0.5 ponto ): Use a tabela conta a pagar para gerar um relatório com o seguinte layout

Observações:
a. Os dias em atraso devem ser calculados somente para Jetora NÃO PAGAS e que estejam
com o pagamento em atraso. Caso contrario, o campo atraso deve ser zero.

b. Mostrar a listagem ordenada pela quantidade de dias em atraso */

/* ( 6. Questão [0.5) : Qual das seguintes opções melhor descreve a propriedade de Atomicifade em
transações de banco de dados?
· Garante que todas as transações sejam executaday no modo serialemdo, uma após a outra
* Garante que uma transação será completado intelcamente ou não será executada de forma
€ Garante que, uma ver que uma transação è concluida, pasresultados serão martidos mesmo em
caso de falha do sittens. F
d. Garante que es dados do banco de dados estejam sempre ens'um estado consistente antes e
05
depois de uma transação €
e. Garante que as operações de leitura dentro de uma transação nunca sejam visiveis para outras
transações. */

/*8. Questão (0.5): Assinale a alternativa correta quo com
1. São procedimentos armazenados de modo persistente que são disparados toda vez que o
programa usuário e solicitar; F
I. As triggers (gatilhos) procedimentos armazenados de modo persistente e executados
automaticamente em resposta a eventos especificos. Existem três tipos principais de triggers no
SQL Server: triggers de tabela, triggers de banco de dados e triggers de servidor, e cada uma del
responde a diferentes tipos de eventos. V
Uma Trigger é criada através do comando CREATE PROC e é apagada através do comando DROP
PROC:
F
Trigger de tabelas são trechos de código armazenado, associados a uma tabela e executadas
automaticamente após certos eventos como INSERT, UPDATE, DELETE e SELECT F
Está correto o que se afirma em:
a. I, II e III
b. IlI e IV
c. I, IV
Somente !!
e. Il e IV */ 

/*9ª, Questão (0.5 ponto): Analise as afirmações abaixo:
L. Uma View consiste da formação de uma tabela única, considerada tabela virtual, a partir de uma
consulta a uma ou mais tabelas do banco de dados; V
M.
A criação de uma View é realizada através do comando CREATE VIEW, enquanto sua exclusão
ocorre quando o SGBD é desligado;
A MATERIALIZAÇÃO da consulta é uma técnica de implementação de Views utilizada por 5GBD's,
que consiste na criação de uma tabela temporária a partir da primeira consulta à View, mantendo-a
para as próximas consultas. Neste caso, o SGBD deve elaborar estratégias para atualização dos
dados da View caso uma das tabelas de definição sofra alteração em seus dados;
IV. O uso do comando UPDATE em Views é sempre possível: F
Está correto o que se afirma em:
L 0,5
b. I. ille IV
e. Ille IV
d. Ile ill*/ 
