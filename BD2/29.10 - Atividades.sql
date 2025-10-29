--crie uma sp que permita efetuar a baixa (pagamento de uma fatura. a sp deve receber como parametro:
--a) id da fatura pagar
--b) data de pagamento
--c) valor pago
--d) fk do banco onde foi feito o pagamento

-- Ela deve fazer os seguintes procedimentos:
--a) baixar a  fatura paga, atualizando o campo data de pagamento e fkbanco
--b) atualizar o saldo bancário na tabela de bancos
--c) criar um registro na tabela movbanco, com os dados do pagamento e atualizar o saldo nesta tabela (movban_saldo)

create proc pagamento(@id int, @data date, @valor decimal (10,3), @fk int) as
	begin try
		update banco 
		set Ban_saldo 
		where @id = @fk and 
