--crie uma sp que permita efetuar a baixa (pagamento de uma fatura. a sp deve receber como parametro:
--a) id da fatura pagar
--b) data de pagamento
--c) valor pago
--d) fk do banco onde foi feito o pagamento

-- Ela deve fazer os seguintes procedimentos:
--a) baixar a  fatura paga, atualizando o campo data de pagamento e fkbanco
--b) atualizar o saldo bancário na tabela de bancos
--c) criar um registro na tabela movbanco, com os dados do pagamento e atualizar o saldo nesta tabela (movban_saldo)

create proc pagamento (@idfatura int, @data date, @valor numeric(10,3), @fkbanco int) as
begin
    begin try
        begin transaction;

        if exists (select * from pagar where idpagar = @idfatura)
        begin 
            declare @vsaldo numeric(18,3);
            select @vsaldo = ban_saldo from banco where idbanco = @fkbanco;

            if @vsaldo is null
            begin
                rollback transaction;
                throw 50001, 'banco informado não existe.', 1;
            end;

            if @vsaldo < @valor
            begin
                rollback transaction;
                throw 50015, 'saldo insuficiente.', 1;
            end;

            update pagar
            set pag_datapagto = @data,
                fkbanco = @fkbanco
            where idpagar = @idfatura;

            update banco 
            set ban_saldo = ban_saldo - @valor
            where idbanco = @fkbanco;

            insert movbanco 
                (movban_data, movban_descricao, movban_valor, movban_tipo, movban_saldo)
            values
                (@data,
                 'pagamento duplicata nr. ' + cast(@idfatura as varchar(12)),
                 @valor,
                 0,
                 @vsaldo - @valor);

            commit transaction;
        end
        else
        begin
            rollback transaction;
            throw 50020, 'fatura informada não existe.', 1;
        end;

    end try

begin catch
	select 'Erro na baixa. O erro informado foi:' + ERROR_MESSAGE()
end catch
end
go

exec pagamento 
    @idfatura = 52, 
    @data = '2025-10-29', 
    @valor = 10, 
    @fkbanco = 1;
