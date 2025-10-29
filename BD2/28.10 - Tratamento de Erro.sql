-- exemplo 1 dado em sala
create proc procedimento (@valor decimal(10,3), @idbancoorigem int, @idbancodestino int) as 

begin try
begin tran
	update banco
	set ban_saldo = ban_saldo - @valor
	where idbanco = @idbancoorigem;

	update banco
	set ban_saldo = ban_saldo + @valor
	where idbanco = @idbancodestino;
	commit transaction

end try
	begin catch 
	select 'Ops, deu erro! O erro foi ' + ERROR_MESSAGE()
	rollback transaction

end catch

exec procedimento @valor = 100, @idbancoorigem = 2, @idbancodestino = 4

select * from banco 
