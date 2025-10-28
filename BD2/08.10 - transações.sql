create proc procedimento6 (@valor decimal(10,3), @idbancoorigem int, @idbancodestino int) as 

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
	-- Executa as 
	select 'Ops, deu erro! O erro foi ' + ERROR_MESSAGE()
	rollback transaction

end catch

exec procedimento6 @valor = 200, @idbancoorigem = 1, @idbancodestino = 2

select * from banco 
