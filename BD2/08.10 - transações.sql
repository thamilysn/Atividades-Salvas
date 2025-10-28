-- Exemplo 1
create proc procedimento7 (@valor decimal(10,3), @idbancoorigem int, @idbancodestino int) as 

begin try
begin tran
	-- Atualiza o saldo da conta de origem
	update banco
	set ban_saldo = ban_saldo - @valor
	where idbanco = @idbancoorigem;

	-- Atualiza o saldo da conta de destino
	update banco
	set ban_saldo = ban_saldo + @valor 
	where idbanco = @idbancodestino;
	commit transaction

	-- Confirma a transação se tudo ocorrer sem erros
end try -- Finaliza o Catch
	begin catch 
	-- Executa se der qualquer tipo de erro no bloco try
	rollback transaction
	-- Exibe a mensagem de erro
	select 'Ops, deu erro! O erro foi ' + ERROR_MESSAGE()

end catch
