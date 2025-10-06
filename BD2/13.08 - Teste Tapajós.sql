/*NOME: THAMILY SILVA NOGUEIRA
TURMA: CC3M
TRABALHO AVALIATIVO: EMPRESA TAPAJÓS*/

CREATE DATABASE CC3M_UVV;
USE CC3M_UVV;

CREATE TABLE IF NOT EXISTS empresas (
    empresa_id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_tipo INT NOT NULL,
    empresa_nome VARCHAR(100) NOT NULL,
    tipo_pessoa INT NOT NULL,
    empresa_raz_soc VARCHAR(45) NOT NULL,
    empresa_cpf_cnpj VARCHAR(20) NOT NULL,
    empresa_email VARCHAR(45) NOT NULL, 
    empresa_tel VARCHAR(15) NOT NULL, 
    empresa_rua VARCHAR(45) NOT NULL, 
    empresa_numrua INT NOT NULL, 
    empresa_bairro VARCHAR(45) NOT NULL, 
    empresa_cidade VARCHAR(45) NOT NULL, 
    empresa_estado VARCHAR(45) NOT NULL, 
    empresa_pais VARCHAR(45) NOT NULL, 
    empresa_cep VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS cadastro_banco (
    banco_id INT PRIMARY KEY AUTO_INCREMENT,
    saldo_atual FLOAT NOT NULL,
    banco_nome VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS contas_pagar (
    pagar_id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_id INT,
    banco_id INT, 
    valor_pag FLOAT NOT NULL,
    data_venc_pag DATE NOT NULL,
    data_emissao_pag DATE NOT NULL, 
    cod_barras_pag VARCHAR(50) NOT NULL,
    CONSTRAINT fk_contas_pag_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(empresa_id),
    CONSTRAINT fk_contas_pag_banco FOREIGN KEY (banco_id) REFERENCES cadastro_banco(banco_id)
);

CREATE TABLE IF NOT EXISTS contas_receber (
    receber_id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_id INT,
    banco_id INT,
    valor_rec FLOAT NOT NULL,
    data_venc_rec DATE NOT NULL,
    data_emissao_rec DATE NOT NULL,
    cod_barras_rec VARCHAR(50) NOT NULL,
    CONSTRAINT fk_contas_rec_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(empresa_id),
    CONSTRAINT fk_contas_rec_banco FOREIGN KEY (banco_id) REFERENCES cadastro_banco(banco_id)
);
