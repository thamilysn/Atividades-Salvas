create proc transferencia( @idbancoorigem int, @idbancodestino int, @valor numeric(18, 2)) as
Begin tran
  
  update banco set ban_saldo = ban_saldo - @valor
  where idbanco = @idbancoorigem

  update banco set ban_saldo = ban_saldo + @valor
  where idbanco = @idbancoDestino

  if @@error > 0
  
    rollback
  else
    commit
  return
