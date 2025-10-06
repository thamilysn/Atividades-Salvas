/* 4) Crie um campo com o nome de EMP_LIMITE no cadastro de empresas. Este campo terá como objetivo armazenar o limite de compra de cada cliente.*/

alter table empresa 
add EMP_LIMITE numerical(18,8)

/* 5) Defina os seguintes limites para as empresas:
  
a) Empresas localizadas no ES  limite de 1.000,00 */
(update empresa 

set emp_limite = 1000.00
from cidade, uf
where FkCidade = IdCidade and Fkuf = Iduf and uf_descricao = "ES"
select emp_razaosocial, emp_limite, emp_uf from empresa)
  
****
  
update empresa 
set emp_limite = 1000.00
where emp_uf = 'ES'
select emp_razaosocial, emp_limite, emp_uf from empresa

/* b) Empresas localizadas na BA limite de 2.000,00 */
update empresa 
set emp_limite = 2000.00
where emp_uf = 'BA'
select emp_razaosocial, emp_limite, emp_uf from empresa

/* c) Empresas localizadas no RS limite de 5.000,00 */
update empresa 
set emp_limite = 5000.00
where emp_uf = 'RS'
select emp_razaosocial, emp_limite, emp_uf from empresa

/* 6)  Gere uma consulta para mostrar em ordem alfabética os nomes das empresas e o total AINDA não PAGO de cada uma. (campo pag_dtpagto não preenchido).*/
