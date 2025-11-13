--FazerExameMarcado
create proc FazerExameMarcado
    (@idPaciente int,
     @idMedico int,
     @idExame int,
     @dataHora datetime)
as
begin
begin try
    begin tran

    if not exists(select * from paciente where idPaciente = @idPaciente)
        throw 50050, 'paciente não cadastrado', 1

    if not exists(select * from medico where idMedico = @idMedico)
        throw 50051, 'medico não cadastrado', 1

    if not exists(select * from exame where idExame = @idExame)
        throw 50052, 'exame não cadastrado', 1

    insert into exameMarcado(idPaciente, idMedico, idExame, examMarc_dataHora, examMarc_status)
    values(@idPaciente, @idMedico, @idExame, @dataHora, 1)

    commit tran

    select 'exame marcado com sucesso'
end try
begin catch
    rollback tran
    select 'erro ' + error_message()
end catch
end;
go

-- RealizarConsulta

create proc RealizarConsulta
    (@idAtendimento int,
     @observacoes varchar(500) = null)
as
begin
begin try
    begin tran

    if not exists(select * from Atendimento where idAtendimento = @idAtendimento)
        throw 50053, 'atendimento não encontrado', 1

    update Atendimento
    set
        atend_realizado = 1,
        atend_observacoes = coalesce(@observacoes, atend_observacoes)
    where idAtendimento = @idAtendimento

    commit tran

    select 'consulta realizada com sucesso'
end try
begin catch
    rollback tran
    select 'erro ' + error_message()
end catch
end;
go
