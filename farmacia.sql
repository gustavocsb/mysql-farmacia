CREATE SCHEMA farmacia;
USE farmacia;

CREATE TABLE funcionario (
	id INT NOT NULL AUTO_INCREMENT,
	data_emissao DATE,
	nome VARCHAR(45) NULL,
	idade INT,
	telefone VARCHAR(15),
	salario DECIMAL(6,2) NULL,
    cargo_id INT NOT NULL,
    endereco_funcionario_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE cargo (
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR (20),
	funcionarios INT,
	funcao VARCHAR (50),
	carga_horaria DECIMAL(4,2) NULL,
	PRIMARY KEY (id)
);

CREATE TABLE endereco_funcionario (
	id INT NOT NULL AUTO_INCREMENT,
	cep INT,
	bairro VARCHAR (30),
	rua VARCHAR (30),
	numero INT,
    cidade_funcionario_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE cidade_funcionario (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR (30),
    estado_funcionario_id INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE estado_funcionario (
	id INT NOT NULL AUTO_INCREMENT,
    uf VARCHAR (3),
    PRIMARY KEY (id)
);

CREATE TABLE pagamento (
	id INT NOT NULL AUTO_INCREMENT,
	valor DECIMAL(5,2) NULL,
    nf_id INT NOT NULL,
    forma_pagamento_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE nf (
	id INT NOT NULL AUTO_INCREMENT,
	numero BIGINT, 
	serie INT, 
	chave_acesso INT,
	PRIMARY KEY (id)
);

CREATE TABLE forma_pagamento (
	id INT NOT NULL AUTO_INCREMENT,
	tipo VARCHAR(15),
	PRIMARY KEY (id)
);

CREATE TABLE cliente (
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(45) NULL,
	cpf VARCHAR(15),
	telefone VARCHAR(15),
	email VARCHAR(30),
    endereco_cliente_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE endereco_cliente (
	id INT NOT NULL AUTO_INCREMENT,
	cep INT,
	bairro VARCHAR (30),
	rua VARCHAR (30),
	numero INT,
    cidade_cliente_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE cidade_cliente (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR (30),
    estado_cliente_id INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE estado_cliente (
	id INT NOT NULL AUTO_INCREMENT,
    uf VARCHAR (3),
    PRIMARY KEY (id)
);

CREATE TABLE pedido (
	id INT NOT NULL AUTO_INCREMENT,
	status_pedido VARCHAR (30),
    cliente_id INT NOT NULL,
    receita_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    estoque_id INT NOT NULL,
    pagamento_id INT NOT NULL,
    qtd_produto INT,
    qtd_remedio INT,
	PRIMARY KEY (id)
);

CREATE TABLE pedido_web (
	id INT NOT NULL AUTO_INCREMENT,
	status_pedido_web VARCHAR (30),
    rastreio_id INT NOT NULL,
    pagamento_id INT NOT NULL,
    estoque_id INT NOT NULL,
    qtd_produto INT,
    qtd_remedio INT,
	PRIMARY KEY (id)
);

CREATE TABLE empresa_entrega (
	id INT NOT NULL AUTO_INCREMENT,
    cnpj VARCHAR(20),
    telefone VARCHAR(15),
    prazo_medio_entrega VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE rastreio (
	id INT NOT NULL AUTO_INCREMENT,
	data_estimada DATE,
	latitude DECIMAL(4,2) NULL,
	longitude DECIMAL(4,2) NULL,
    empresa_entrega_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE receita (
	id INT NOT NULL AUTO_INCREMENT,
	beneficiario VARCHAR(40),
	crm VARCHAR (15),
	PRIMARY KEY (id)
);

CREATE TABLE retencao_receita (
	id INT NOT NULL AUTO_INCREMENT,
	remedio_tarja VARCHAR (15),
    receita_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE estoque (
	id INT NOT NULL AUTO_INCREMENT,
	quantidade_produto INT,
	quantidade_remedio INT,
    produto_id INT NOT NULL,
    remedio_id INT NOT NULL,
    entradaProdutoRemedio_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE entradaProdutoRemedio (
	id INT NOT NULL AUTO_INCREMENT,
    data_emissao DATE,
    data_chegada DATE,
    valor DECIMAL (4,2) NULL,
    qtd_produto INT,
    qtd_remedio INT,
    fornecedor_id INT NOT NULL,
    produto_id INT NOT NULL,
    remedio_id INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE produto (
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(30),
	data_validade DATE,
	data_fabricacao DATE,
	preco DECIMAL(4,2) NULL,
	codigo_barra BIGINT,
    categoria_id INT NOT NULL,
    fornecedor_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE remedio (
	id INT NOT NULL AUTO_INCREMENT,
	tarja VARCHAR(15),
	nome VARCHAR(45) NULL,
	lote VARCHAR(10),
	data_validade DATE,
	data_fabricacao DATE,
	preco DECIMAL(4,2) NULL,
	dosagem VARCHAR(10),
	principio_ativo VARCHAR(40),
	bula TEXT,
    fornecedor_id INT NOT NULL,
    retencao_receita_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE fornecedor (
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(45) NULL,
	cnpj VARCHAR(20),
    endereco_fornecedor_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE endereco_fornecedor (
	id INT NOT NULL AUTO_INCREMENT,
	cep INT,
	bairro VARCHAR (30),
	rua VARCHAR (30),
	numero INT,
    cidade_fornecedor_id INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE cidade_fornecedor (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR (30),
    estado_fornecedor_id INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE estado_fornecedor (
	id INT NOT NULL AUTO_INCREMENT,
    uf VARCHAR (3),
    PRIMARY KEY (id)
);

CREATE TABLE categoria (
	id INT NOT NULL AUTO_INCREMENT,
	tipo_produto VARCHAR(20),
	PRIMARY KEY (id)
);

-- ALTER TABLE table1 ADD CONSTRAINT fk_table1_table2 FOREIGN KEY (table2_id) REFERENCES table2(id);

ALTER TABLE funcionario ADD CONSTRAINT fk_funcionario_cargo FOREIGN KEY (cargo_id) REFERENCES cargo(id);
ALTER TABLE funcionario ADD CONSTRAINT fk_funcionario_endereco_funcionario FOREIGN KEY (endereco_funcionario_id) REFERENCES endereco_funcionario(id);

ALTER TABLE endereco_funcionario ADD CONSTRAINT fk_endereco_funcionario_cidade_funcionario FOREIGN KEY (cidade_funcionario_id) REFERENCES cidade_funcionario(id);

ALTER TABLE cidade_funcionario ADD CONSTRAINT fk_cidade_funcionario_estado_funcionario FOREIGN KEY (estado_funcionario_id) REFERENCES estado_funcionario(id);

ALTER TABLE pagamento ADD CONSTRAINT fk_pagamento_nf FOREIGN KEY (nf_id) REFERENCES nf(id);
ALTER TABLE pagamento ADD CONSTRAINT fk_pagamento_forma_pagamento FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id);

ALTER TABLE cliente ADD CONSTRAINT fk_cliente_endereco_cliente FOREIGN KEY (endereco_cliente_id) REFERENCES endereco_cliente(id);

ALTER TABLE endereco_cliente ADD CONSTRAINT fk_endereco_cliente_cidade_cliente FOREIGN KEY (cidade_cliente_id) REFERENCES cidade_cliente(id);

ALTER TABLE cidade_cliente ADD CONSTRAINT fk_cidade_cliente_estado_cliente FOREIGN KEY (estado_cliente_id) REFERENCES estado_cliente(id);

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_receita FOREIGN KEY (receita_id) REFERENCES receita(id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario(id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_estoque FOREIGN KEY (estoque_id) REFERENCES estoque(id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_pagamento FOREIGN KEY (pagamento_id) REFERENCES pagamento(id);

ALTER TABLE pedido_web ADD CONSTRAINT fk_pedido_web_rastreio FOREIGN KEY (rastreio_id) REFERENCES rastreio(id);
ALTER TABLE pedido_web ADD CONSTRAINT fk_pedido_web_pagamento FOREIGN KEY (pagamento_id) REFERENCES pagamento(id);
ALTER TABLE pedido_web ADD CONSTRAINT fk_pedido_web_estoque FOREIGN KEY (estoque_id) REFERENCES estoque(id);

ALTER TABLE rastreio ADD CONSTRAINT fk_rastreio_empresa_entrega FOREIGN KEY (empresa_entrega_id) REFERENCES empresa_entrega(id);

ALTER TABLE retencao_receita ADD CONSTRAINT fk_retencao_receita_receita FOREIGN KEY (receita_id) REFERENCES receita(id);

ALTER TABLE estoque ADD CONSTRAINT fk_estoque_produto FOREIGN KEY (produto_id) REFERENCES produto(id);
ALTER TABLE estoque ADD CONSTRAINT fk_estoque_remedio FOREIGN KEY (remedio_id) REFERENCES remedio(id);
ALTER TABLE estoque ADD CONSTRAINT fk_estoque_entradaProdutoRemedio FOREIGN KEY (entradaProdutoRemedio_id) REFERENCES entradaProdutoRemedio (id);

ALTER TABLE entradaProdutoRemedio ADD CONSTRAINT fk_entradaProdutoRemedio_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id);

ALTER TABLE produto ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id);
ALTER TABLE produto ADD CONSTRAINT fk_produto_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id);

ALTER TABLE remedio ADD CONSTRAINT fk_remedio_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id);
ALTER TABLE remedio ADD CONSTRAINT fk_remedio_retencao_receita FOREIGN KEY (retencao_receita_id) REFERENCES retencao_receita(id);

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_endereco_fornecedor FOREIGN KEY (endereco_fornecedor_id) REFERENCES endereco_fornecedor(id);

ALTER TABLE endereco_fornecedor ADD CONSTRAINT fk_endereco_fornecedor_cidade_fornecedor FOREIGN KEY (cidade_fornecedor_id) REFERENCES cidade_fornecedor(id);

ALTER TABLE cidade_fornecedor ADD CONSTRAINT fk_cidade_fornecedor_estado_fornecedor FOREIGN KEY (estado_fornecedor_id) REFERENCES estado_fornecedor(id);

INSERT INTO `p2_farmacia`.`cargo` (`nome`, `funcionarios`, `funcao`, `carga_horaria`) VALUES ('Yago', '23', 'gerente de caixa', '60');
INSERT INTO `p2_farmacia`.`cargo` (`nome`, `funcionarios`, `funcao`, `carga_horaria`) VALUES ('Gustavo', '23', 'atendente de caixa', '60');
INSERT INTO `p2_farmacia`.`cargo` (`nome`, `funcionarios`, `funcao`, `carga_horaria`) VALUES ('Heitor', '23', 'farmaceutico', '40');
INSERT INTO `p2_farmacia`.`cargo` (`nome`, `funcionarios`, `funcao`, `carga_horaria`) VALUES ('Guilherme', '23', 'medico', '20');
INSERT INTO `p2_farmacia`.`cargo` (`nome`, `funcionarios`, `funcao`, `carga_horaria`) VALUES ('Gabriel', '23', 'farmaceutico', '60');

INSERT INTO `p2_farmacia`.`estado_funcionario` (`uf`) VALUES ('GO');
INSERT INTO `p2_farmacia`.`estado_funcionario` (`uf`) VALUES ('DF');
INSERT INTO `p2_farmacia`.`estado_funcionario` (`uf`) VALUES ('DF');
INSERT INTO `p2_farmacia`.`estado_funcionario` (`uf`) VALUES ('DF');
INSERT INTO `p2_farmacia`.`estado_funcionario` (`uf`) VALUES ('GO');

INSERT INTO `p2_farmacia`.`cidade_funcionario` (`nome`, `estado_funcionario_id`) VALUES ('Luziania', '1');
INSERT INTO `p2_farmacia`.`cidade_funcionario` (`nome`, `estado_funcionario_id`) VALUES ('Taguatinga', '2');
INSERT INTO `p2_farmacia`.`cidade_funcionario` (`nome`, `estado_funcionario_id`) VALUES ('Taguatinga', '3');
INSERT INTO `p2_farmacia`.`cidade_funcionario` (`nome`, `estado_funcionario_id`) VALUES ('Brasilia', '4');
INSERT INTO `p2_farmacia`.`cidade_funcionario` (`nome`, `estado_funcionario_id`) VALUES ('Valparaiso de Goias', '5');

INSERT INTO `p2_farmacia`.`endereco_funcionario` (`cep`, `bairro`, `rua`, `numero`, `cidade_funcionario_id`) VALUES ('57129581', 'Taguatinga Sul', 'CSB 10', '123', '6');
INSERT INTO `p2_farmacia`.`endereco_funcionario` (`cep`, `bairro`, `rua`, `numero`, `cidade_funcionario_id`) VALUES ('85119519', 'Taguatinga Sul', 'CSB 1', '10', '7');
INSERT INTO `p2_farmacia`.`endereco_funcionario` (`cep`, `bairro`, `rua`, `numero`, `cidade_funcionario_id`) VALUES ('72841590', 'Taguatinga Norte', 'CNB 8', '9', '8');
INSERT INTO `p2_farmacia`.`endereco_funcionario` (`cep`, `bairro`, `rua`, `numero`, `cidade_funcionario_id`) VALUES ('91512951', 'Etapa A', 'Ypiranga', '54', '9');
INSERT INTO `p2_farmacia`.`endereco_funcionario` (`cep`, `bairro`, `rua`, `numero`, `cidade_funcionario_id`) VALUES ('51824581', 'Etapa B', 'Da mata', '23', '10');

INSERT INTO `p2_farmacia`.`funcionario` (`data_emissao`, `nome`, `idade`, `telefone`, `salario`, `cargo_id`, `endereco_funcionario_id`) VALUES ('2021-03-30', 'Yago', '21', '(61)94179-1492', '4000', '1', '6');
INSERT INTO `p2_farmacia`.`funcionario` (`data_emissao`, `nome`, `idade`, `telefone`, `salario`, `cargo_id`, `endereco_funcionario_id`) VALUES ('2020-06-15', 'Guilherme', '23', '(61)91723-3129', '10000', '2', '7');
INSERT INTO `p2_farmacia`.`funcionario` (`data_emissao`, `nome`, `idade`, `telefone`, `salario`, `cargo_id`, `endereco_funcionario_id`) VALUES ('2020-01-10', 'Gustavo', '42', '(61)99518-5189', '5000', '3', '8');
INSERT INTO `p2_farmacia`.`funcionario` (`data_emissao`, `nome`, `idade`, `telefone`, `salario`, `cargo_id`, `endereco_funcionario_id`) VALUES ('2021-08-22', 'Heitor', '40', '(62)91209-4218', '2500', '4', '9');
INSERT INTO `p2_farmacia`.`funcionario` (`data_emissao`, `nome`, `idade`, `telefone`, `salario`, `cargo_id`, `endereco_funcionario_id`) VALUES ('2022-01-08', 'Gabriel', '34', '(11)91230-9312', '3500', '5', '10');

INSERT INTO `p2_farmacia`.`estado_cliente` (`uf`) VALUES ('GO');
INSERT INTO `p2_farmacia`.`estado_cliente` (`uf`) VALUES ('DF');
INSERT INTO `p2_farmacia`.`estado_cliente` (`uf`) VALUES ('DF');
INSERT INTO `p2_farmacia`.`estado_cliente` (`uf`) VALUES ('DF');
INSERT INTO `p2_farmacia`.`estado_cliente` (`uf`) VALUES ('GO');

INSERT INTO `p2_farmacia`.`cidade_cliente` (`nome`, `estado_cliente_id`) VALUES ('Luziania', '1');
INSERT INTO `p2_farmacia`.`cidade_cliente` (`nome`, `estado_cliente_id`) VALUES ('Taguatinga', '2');
INSERT INTO `p2_farmacia`.`cidade_cliente` (`nome`, `estado_cliente_id`) VALUES ('Taguatinga', '3');
INSERT INTO `p2_farmacia`.`cidade_cliente` (`nome`, `estado_cliente_id`) VALUES ('Brasilia', '4');
INSERT INTO `p2_farmacia`.`cidade_cliente` (`nome`, `estado_cliente_id`) VALUES ('Valparaiso de Goias', '5');

INSERT INTO `p2_farmacia`.`endereco_cliente` (`cep`, `bairro`, `rua`, `numero`, `cidade_cliente_id`) VALUES ('57129581', 'Taguatinga Sul', 'CSB 10', '123', '1');
INSERT INTO `p2_farmacia`.`endereco_cliente` (`cep`, `bairro`, `rua`, `numero`, `cidade_cliente_id`) VALUES ('85119519', 'Taguatinga Sul', 'CSB 1', '10', '2');
INSERT INTO `p2_farmacia`.`endereco_cliente` (`cep`, `bairro`, `rua`, `numero`, `cidade_cliente_id`) VALUES ('72841590', 'Taguatinga Norte', 'CNB 8', '9', '3');
INSERT INTO `p2_farmacia`.`endereco_cliente` (`cep`, `bairro`, `rua`, `numero`, `cidade_cliente_id`) VALUES ('91512951', 'Etapa A', 'Ypiranga', '54', '4');
INSERT INTO `p2_farmacia`.`endereco_cliente` (`cep`, `bairro`, `rua`, `numero`, `cidade_cliente_id`) VALUES ('51824581', 'Etapa B', 'Da mata', '23', '5');

INSERT INTO `p2_farmacia`.`estado_fornecedor` (`uf`) VALUES ('TO');
INSERT INTO `p2_farmacia`.`estado_fornecedor` (`uf`) VALUES ('TO');
INSERT INTO `p2_farmacia`.`estado_fornecedor` (`uf`) VALUES ('MG');
INSERT INTO `p2_farmacia`.`estado_fornecedor` (`uf`) VALUES ('SP');
INSERT INTO `p2_farmacia`.`estado_fornecedor` (`uf`) VALUES ('RJ');

INSERT INTO `p2_farmacia`.`cidade_fornecedor` (`nome`, `estado_fornecedor_id`) VALUES ('Palmas', '1');
INSERT INTO `p2_farmacia`.`cidade_fornecedor` (`nome`, `estado_fornecedor_id`) VALUES ('Palmas', '2');
INSERT INTO `p2_farmacia`.`cidade_fornecedor` (`nome`, `estado_fornecedor_id`) VALUES ('Belo Horizonte', '3');
INSERT INTO `p2_farmacia`.`cidade_fornecedor` (`nome`, `estado_fornecedor_id`) VALUES ('São Paulo', '4');
INSERT INTO `p2_farmacia`.`cidade_fornecedor` (`nome`, `estado_fornecedor_id`) VALUES ('Rio de Janeiro', '5');

INSERT INTO `p2_farmacia`.`endereco_fornecedor` (`cep`, `bairro`, `rua`, `numero`, `cidade_fornecedor_id`) VALUES ('81231913', 'Setor Industrial de Taquaralto', 'R. Amazonas', '48', '1');
INSERT INTO `p2_farmacia`.`endereco_fornecedor` (`cep`, `bairro`, `rua`, `numero`, `cidade_fornecedor_id`) VALUES ('85128911', 'Setor Industrial de Taquaralto', 'R. Boa Vista', '20', '2');
INSERT INTO `p2_farmacia`.`endereco_fornecedor` (`cep`, `bairro`, `rua`, `numero`, `cidade_fornecedor_id`) VALUES ('51824124', 'Bairro das Indústrias I', 'R. Um', '1', '3');
INSERT INTO `p2_farmacia`.`endereco_fornecedor` (`cep`, `bairro`, `rua`, `numero`, `cidade_fornecedor_id`) VALUES ('94124894', 'Higienópolis', 'Rua Alagoas', '50', '4');
INSERT INTO `p2_farmacia`.`endereco_fornecedor` (`cep`, `bairro`, `rua`, `numero`, `cidade_fornecedor_id`) VALUES ('12958412', 'Vasco da Gama', 'R. Sen Alencar', '23', '5');

INSERT INTO `p2_farmacia`.`forma_pagamento` (`tipo`) VALUES ('Cartão de Crédito');
INSERT INTO `p2_farmacia`.`forma_pagamento` (`tipo`) VALUES ('Cartão de Débito');
INSERT INTO `p2_farmacia`.`forma_pagamento` (`tipo`) VALUES ('Boleto Bancário');
INSERT INTO `p2_farmacia`.`forma_pagamento` (`tipo`) VALUES ('Boleto Bancário');
INSERT INTO `p2_farmacia`.`forma_pagamento` (`tipo`) VALUES ('Pix');

INSERT INTO `p2_farmacia`.`nf` (`numero`, `serie`, `chave_acesso`) VALUES ('12783612763125217123752312', '551013913', '123781223125812');
INSERT INTO `p2_farmacia`.`nf` (`numero`, `serie`, `chave_acesso`) VALUES ('23587213723159235723152358', '551581275', '859128591281891');
INSERT INTO `p2_farmacia`.`nf` (`numero`, `serie`, `chave_acesso`) VALUES ('32158723582357828562315235', '551591874', '518275182905912');
INSERT INTO `p2_farmacia`.`nf` (`numero`, `serie`, `chave_acesso`) VALUES ('23518762357816235872523587', '551190285', '295682918259010');
INSERT INTO `p2_farmacia`.`nf` (`numero`, `serie`, `chave_acesso`) VALUES ('23175891276298376982137698', '551129481', '521358192593859');

INSERT INTO `p2_farmacia`.`pagamento` (`valor`, `nf_id`, `forma_pagamento_id`) VALUES ('55,99', '1', '1');
INSERT INTO `p2_farmacia`.`pagamento` (`valor`, `nf_id`, `forma_pagamento_id`) VALUES ('99,50', '2', '2');
INSERT INTO `p2_farmacia`.`pagamento` (`valor`, `nf_id`, `forma_pagamento_id`) VALUES ('499,89', '3', '3');
INSERT INTO `p2_farmacia`.`pagamento` (`valor`, `nf_id`, `forma_pagamento_id`) VALUES ('12,99', '4', '4');
INSERT INTO `p2_farmacia`.`pagamento` (`valor`, `nf_id`, `forma_pagamento_id`) VALUES ('120,50', '5', '5');

INSERT INTO `p2_farmacia`.`cliente` (`nome`, `cpf`, `telefone`, `email`, `endereco_cliente_id`) VALUES ('Junior', '91258129812', '(61)99841-4198', 'xilap90421@gmail.com', '7');
INSERT INTO `p2_farmacia`.`cliente` (`nome`, `cpf`, `telefone`, `email`, `endereco_cliente_id`) VALUES ('Tevez', '58127582158', '(61)91499-1249', 'ledeyel959@hotmail.com', '8');
INSERT INTO `p2_farmacia`.`cliente` (`nome`, `cpf`, `telefone`, `email`, `endereco_cliente_id`) VALUES ('Marilia', '15723168787', '(61)99111-9519', 'jimowol111@hotmail.com', '9');
INSERT INTO `p2_farmacia`.`cliente` (`nome`, `cpf`, `telefone`, `email`, `endereco_cliente_id`) VALUES ('Amanda', '52185723127', '(61)91578-1528', 'rowid41701@yahoo.com', '10');
INSERT INTO `p2_farmacia`.`cliente` (`nome`, `cpf`, `telefone`, `email`, `endereco_cliente_id`) VALUES ('Sávio', '21358723587', '(61)98125-5812', 'najako8228@outlook.com', '11');

INSERT INTO `p2_farmacia`.`receita` (`beneficiario`, `crm`) VALUES ('Matheus Borges', 'CRM/DF 123456');
INSERT INTO `p2_farmacia`.`receita` (`beneficiario`, `crm`) VALUES ('Guilherme Braz', 'CRM/DF 259821');
INSERT INTO `p2_farmacia`.`receita` (`beneficiario`, `crm`) VALUES ('Matheus Oliveira', 'CRM/GO 281741');
INSERT INTO `p2_farmacia`.`receita` (`beneficiario`, `crm`) VALUES ('Junior da Silva', 'CRM/MT 941278');
INSERT INTO `p2_farmacia`.`receita` (`beneficiario`, `crm`) VALUES ('Diego Rodrigues', 'CRM/DF 758189');

INSERT INTO `p2_farmacia`.`fornecedor` (`nome`, `cnpj`, `endereco_fornecedor_id`) VALUES ('Palmed Palmas Medicamentos', '04677096000188', '1');
INSERT INTO `p2_farmacia`.`fornecedor` (`nome`, `cnpj`, `endereco_fornecedor_id`) VALUES ('Multfar Distribuidora de Medicamentos', '42993800055512', '2');
INSERT INTO `p2_farmacia`.`fornecedor` (`nome`, `cnpj`, `endereco_fornecedor_id`) VALUES ('Orgafarma Organizacao Farmaceutica', '17291576000158', '3');
INSERT INTO `p2_farmacia`.`fornecedor` (`nome`, `cnpj`, `endereco_fornecedor_id`) VALUES ('Navarromed-SP', '24415230000180', '4');
INSERT INTO `p2_farmacia`.`fornecedor` (`nome`, `cnpj`, `endereco_fornecedor_id`) VALUES ('Prohosp Distribuidora de Medicamentos', '04355394000232', '5');

INSERT INTO `p2_farmacia`.`entradaprodutoremedio` (`data_emissao`, `data_chegada`, `valor`, `qtd_produto`, `qtd_remedio`, `fornecedor_id`) VALUES ('2022-04-15', '2022-05-10', '500.00', '10', '25', '1');
INSERT INTO `p2_farmacia`.`entradaprodutoremedio` (`data_emissao`, `data_chegada`, `valor`, `qtd_produto`, `qtd_remedio`, `fornecedor_id`) VALUES ('2022-03-20', '2022-03-29', '750.00', '5', '30', '1');
INSERT INTO `p2_farmacia`.`entradaprodutoremedio` (`data_emissao`, `data_chegada`, `valor`, `qtd_remedio`, `fornecedor_id`) VALUES ('2022-08-25', '2022-09-10', '45.00', '4', '3');
INSERT INTO `p2_farmacia`.`entradaprodutoremedio` (`data_emissao`, `data_chegada`, `valor`, `qtd_remedio`, `fornecedor_id`) VALUES ('2022-11-08', '2022-12-08', '1200.00', '50', '4');
INSERT INTO `p2_farmacia`.`entradaprodutoremedio` (`data_emissao`, `data_chegada`, `valor`, `qtd_produto`, `fornecedor_id`) VALUES ('2021-12-25', '2022-01-01', '269.90', '24', '5');

INSERT INTO `p2_farmacia`.`categoria` (`tipo_produto`) VALUES ('Higiene Pessoal');
INSERT INTO `p2_farmacia`.`categoria` (`tipo_produto`) VALUES ('Suplemento');
INSERT INTO `p2_farmacia`.`categoria` (`tipo_produto`) VALUES ('Alimentos');
INSERT INTO `p2_farmacia`.`categoria` (`tipo_produto`) VALUES ('Higiene Infantil');
INSERT INTO `p2_farmacia`.`categoria` (`tipo_produto`) VALUES ('Embelezamento');

INSERT INTO `p2_farmacia`.`produto` (`nome`, `data_fabricacao`, `preco`, `codigo_barra`, `categoria_id`, `fornecedor_id`) VALUES ('Escova de Dente', '2020-12-09', '12.00', '1289148901239', '1', '3');
INSERT INTO `p2_farmacia`.`produto` (`nome`, `data_validade`, `data_fabricacao`, `preco`, `codigo_barra`, `categoria_id`, `fornecedor_id`) VALUES ('Whey Protein', '2023-11-29', '2022-10-10', '159.00', '5817519827512', '2', '3');
INSERT INTO `p2_farmacia`.`produto` (`nome`, `data_validade`, `data_fabricacao`, `preco`, `codigo_barra`, `categoria_id`, `fornecedor_id`) VALUES ('Doritos', '2023-06-30', '2022-06-30', '15.00', '8725382358523', '3', '1');
INSERT INTO `p2_farmacia`.`produto` (`nome`, `data_validade`, `data_fabricacao`, `preco`, `codigo_barra`, `categoria_id`, `fornecedor_id`) VALUES ('Fralda Descartável', '2025-03-30', '2022-02-30', '59.00', '2316827262362', '4', '3');
INSERT INTO `p2_farmacia`.`produto` (`nome`, `data_validade`, `data_fabricacao`, `preco`, `codigo_barra`, `categoria_id`, `fornecedor_id`) VALUES ('Tinta de Cabelo', '2025-05-15', '2021-04-15', '25.00', '6236243487345', '5', '2');

INSERT INTO `p2_farmacia`.`retencao_receita` (`remedio_tarja`, `receita_id`) VALUES ('Tarja Preta', '1');
INSERT INTO `p2_farmacia`.`retencao_receita` (`remedio_tarja`, `receita_id`) VALUES ('Tarja Preta', '2');
INSERT INTO `p2_farmacia`.`retencao_receita` (`remedio_tarja`, `receita_id`) VALUES ('Tarja Preta', '3');
INSERT INTO `p2_farmacia`.`retencao_receita` (`remedio_tarja`, `receita_id`) VALUES ('Tarja Vermelha', '4');
INSERT INTO `p2_farmacia`.`retencao_receita` (`remedio_tarja`, `receita_id`) VALUES ('Tarja Vermelha', '5');

INSERT INTO `p2_farmacia`.`remedio` (`tarja`, `nome`, `lote`, `data_validade`, `data_fabricacao`, `dosagem`, `principio_ativo`, `fornecedor_id`, `retencao_receita_id`) VALUES ('Preta', 'Venvanse 50mg Shire 28 Cápsulas', 'A203', '2023-08-09', '2021-08-09', '50mg', 'Dimesilato De Lisdexanfetamina', '4', '1');
INSERT INTO `p2_farmacia`.`remedio` (`tarja`, `nome`, `lote`, `data_validade`, `data_fabricacao`, `dosagem`, `principio_ativo`, `fornecedor_id`, `retencao_receita_id`) VALUES ('Preta', 'Concerta 36mg 30 Comprimidos', 'B505', '2024-05-20', '2022-05-20', '36mg', 'Cloridrato De Metilfenidato', '4', '2');
INSERT INTO `p2_farmacia`.`remedio` (`tarja`, `nome`, `lote`, `data_validade`, `data_fabricacao`, `dosagem`, `principio_ativo`, `fornecedor_id`, `retencao_receita_id`) VALUES ('Preta', 'Ritalina 10mg 30 Comprimidos', 'B505', '2024-05-20', '2022-05-20', '10mg', 'Cloridrato De Metilfenidato', '5', '3');
INSERT INTO `p2_farmacia`.`remedio` (`tarja`, `nome`, `lote`, `data_validade`, `data_fabricacao`, `dosagem`, `principio_ativo`, `fornecedor_id`, `retencao_receita_id`) VALUES ('Vermelha', 'Imovane 7,5mg 20 comprimidos', 'A203', '2023-08-09', '2021-08-09', '7.5mg', 'Zopiclona', '2', '4');
INSERT INTO `p2_farmacia`.`remedio` (`tarja`, `nome`, `lote`, `data_validade`, `data_fabricacao`, `dosagem`, `principio_ativo`, `fornecedor_id`, `retencao_receita_id`) VALUES ('Vermelha', 'Zolfest D 10mg 20 Comprimidos Efervescentes', 'A205', '2025-07-15', '2022-07-15', '10mg', 'Hemitartarato De Zolpidem', '1', '5');
UPDATE `p2_farmacia`.`remedio` SET `preco` = '40.00' WHERE (`id` = '1');
UPDATE `p2_farmacia`.`remedio` SET `preco` = '35.00' WHERE (`id` = '2');
UPDATE `p2_farmacia`.`remedio` SET `preco` = '45.00' WHERE (`id` = '3');
UPDATE `p2_farmacia`.`remedio` SET `preco` = '90.00' WHERE (`id` = '4');
UPDATE `p2_farmacia`.`remedio` SET `preco` = '120.00' WHERE (`id` = '5');

INSERT INTO `p2_farmacia`.`empresa_entrega` (`cnpj`, `telefone`, `prazo_medio_entrega`) VALUES ('04355394012232', '(61)9418-94121', '2 horas');
INSERT INTO `p2_farmacia`.`empresa_entrega` (`cnpj`, `telefone`, `prazo_medio_entrega`) VALUES ('85172581251871', '(61)9123-9841', '1 hora');
INSERT INTO `p2_farmacia`.`empresa_entrega` (`cnpj`, `telefone`, `prazo_medio_entrega`) VALUES ('52813798719727', '(61)8841-8515', '1 hora');
INSERT INTO `p2_farmacia`.`empresa_entrega` (`cnpj`, `telefone`, `prazo_medio_entrega`) VALUES ('28917591827358', '(61)2568-5813', '30 min');
INSERT INTO `p2_farmacia`.`empresa_entrega` (`cnpj`, `telefone`, `prazo_medio_entrega`) VALUES ('82375897213523', '(62)5818-5129', '20 min');

INSERT INTO `p2_farmacia`.`rastreio` (`data_estimada`, `latitude`, `longitude`, `empresa_entrega_id`) VALUES ('2022-12-16', '-15', '-47.92', '1');
INSERT INTO `p2_farmacia`.`rastreio` (`data_estimada`, `latitude`, `longitude`, `empresa_entrega_id`) VALUES ('2022-12-15', '-15', '-40.91', '2');
INSERT INTO `p2_farmacia`.`rastreio` (`data_estimada`, `latitude`, `longitude`, `empresa_entrega_id`) VALUES ('2021-12-10', '-14', '-42.90', '3');
INSERT INTO `p2_farmacia`.`rastreio` (`data_estimada`, `latitude`, `longitude`, `empresa_entrega_id`) VALUES ('2022-11-11', '-13', '-47.22', '2');
INSERT INTO `p2_farmacia`.`rastreio` (`data_estimada`, `latitude`, `longitude`, `empresa_entrega_id`) VALUES ('2023-09-15', '-15', '-49.15', '1');

INSERT INTO `p2_farmacia`.`estoque` (`quantidade_produto`, `quantidade_remedio`, `produto_id`, `remedio_id`) VALUES ('812', '257', '1', '1');
INSERT INTO `p2_farmacia`.`estoque` (`quantidade_produto`, `quantidade_remedio`, `produto_id`, `remedio_id`) VALUES ('123', '213', '2', '2');
INSERT INTO `p2_farmacia`.`estoque` (`quantidade_produto`, `quantidade_remedio`, `produto_id`, `remedio_id`) VALUES ('181', '235', '3', '3');
INSERT INTO `p2_farmacia`.`estoque` (`quantidade_produto`, `quantidade_remedio`, `produto_id`, `remedio_id`) VALUES ('12', '184', '4', '4');
INSERT INTO `p2_farmacia`.`estoque` (`quantidade_produto`, `quantidade_remedio`, `produto_id`, `remedio_id`) VALUES ('285', '9', '5', '5');

INSERT INTO `p2_farmacia`.`pedido` (`status_pedido`, `cliente_id`, `receita_id`, `funcionario_id`, `estoque_id`, `pagamento_id`) VALUES ('Finalizado', '6', '1', '16', '1', '3');
INSERT INTO `p2_farmacia`.`pedido` (`status_pedido`, `cliente_id`, `receita_id`, `funcionario_id`, `estoque_id`, `pagamento_id`) VALUES ('Finalizado', '9', '2', '16', '2', '2');
INSERT INTO `p2_farmacia`.`pedido` (`status_pedido`, `cliente_id`, `receita_id`, `funcionario_id`, `estoque_id`, `pagamento_id`) VALUES ('Finalizado', '10', '4', '17', '3', '1');
INSERT INTO `p2_farmacia`.`pedido` (`status_pedido`, `cliente_id`, `receita_id`, `funcionario_id`, `estoque_id`, `pagamento_id`) VALUES ('Finalizado', '7', '5', '17', '4', '5');
INSERT INTO `p2_farmacia`.`pedido` (`status_pedido`, `cliente_id`, `receita_id`, `funcionario_id`, `estoque_id`, `pagamento_id`) VALUES ('Finalizado', '8', '3', '16', '5', '4');
UPDATE `p2_farmacia`.`pedido` SET `qtd_produto` = '2', `qtd_remedio` = '1' WHERE (`id` = '1');
UPDATE `p2_farmacia`.`pedido` SET `qtd_remedio` = '1' WHERE (`id` = '2');
UPDATE `p2_farmacia`.`pedido` SET `qtd_remedio` = '1' WHERE (`id` = '3');
UPDATE `p2_farmacia`.`pedido` SET `qtd_remedio` = '2' WHERE (`id` = '4');
UPDATE `p2_farmacia`.`pedido` SET `qtd_remedio` = '5' WHERE (`id` = '5');

INSERT INTO `p2_farmacia`.`pedido_web` (`status_pedido_web`, `rastreio_id`, `pagamento_id`, `estoque_id`) VALUES ('Finalizado', '6', '1', '5');
INSERT INTO `p2_farmacia`.`pedido_web` (`status_pedido_web`, `rastreio_id`, `pagamento_id`, `estoque_id`) VALUES ('Finalizado', '7', '2', '4');
INSERT INTO `p2_farmacia`.`pedido_web` (`status_pedido_web`, `rastreio_id`, `pagamento_id`, `estoque_id`) VALUES ('Finalizado', '8', '3', '3');
INSERT INTO `p2_farmacia`.`pedido_web` (`status_pedido_web`, `rastreio_id`, `pagamento_id`, `estoque_id`) VALUES ('Finalizado', '9', '4', '2');
INSERT INTO `p2_farmacia`.`pedido_web` (`status_pedido_web`, `rastreio_id`, `pagamento_id`, `estoque_id`) VALUES ('Finalizado', '10', '5', '1');
UPDATE `p2_farmacia`.`pedido_web` SET `qtd_remedio` = '2' WHERE (`id` = '1');
UPDATE `p2_farmacia`.`pedido_web` SET `qtd_remedio` = '2' WHERE (`id` = '2');
UPDATE `p2_farmacia`.`pedido_web` SET `qtd_produto` = '5', `qtd_remedio` = '2' WHERE (`id` = '3');
UPDATE `p2_farmacia`.`pedido_web` SET `qtd_produto` = '3', `qtd_remedio` = '1' WHERE (`id` = '4');
UPDATE `p2_farmacia`.`pedido_web` SET `qtd_remedio` = '1' WHERE (`id` = '5');

SELECT * FROM funcionario;
SELECT * FROM cliente;
SELECT * FROM remedio;
SELECT * FROM fornecedor;

CREATE VIEW vw_nomeFornecedor
AS SELECT nome
FROM fornecedor;

SELECT nome
FROM vw_nomeFornecedor;

CREATE VIEW vw_FuncionarioVenda
AS SELECT nome
FROM funcionario
INNER JOIN pedido
ON funcionario.id = pedido.funcionario_id;

SELECT * FROM vw_FuncionarioVenda;

SELECT remedio.nome
FROM remedio
INNER JOIN fornecedor
ON remedio.fornecedor_id = fornecedor.id;

SELECT cliente.cpf
FROM cliente
INNER JOIN pedido
ON cliente.id = pedido.cliente_id;

-- Function para data-validade restante
DELIMITER //
CREATE FUNCTION data_fabricacao(data_first date) 
RETURNS int 
DETERMINISTIC
BEGIN
    DECLARE data_validade DATE;
    Select current_date()into data_validade;
    RETURN year(data_validade)-year(data_first);
END //
DELIMITER ;

SELECT id, nome, data_validade, data_fabricacao(data_fabricacao) as 'tempo de remedio' FROM remedio;

-- Function para mostrar o tempo de contrato dos funcionários
DELIMITER //
CREATE FUNCTION data_contrato(data_inicio date) 
RETURNS int 
DETERMINISTIC
BEGIN
    DECLARE data_atual DATE;
    Select current_date()into data_atual;
    RETURN year(data_atual)-year(data_inicio);
END //
DELIMITER ;

SELECT id, nome, idade, cargo_id, data_contrato(data_emissao) as 'tempo de serviço' FROM funcionario;

-- STORED PROCEDURE
CREATE PROCEDURE ver_preco_produto (var_produto smallint)
SELECT CONCAT ('O preço é ', produto.preco) AS preco
FROM produto
WHERE produto.id = var_produto;

CALL ver_preco_produto (2);

CREATE PROCEDURE ver_preco_remedio (var_remedio smallint)
SELECT CONCAT ('O preço é ', remedio.preco) AS preco
FROM remedio
WHERE remedio.id = var_remedio;

CALL ver_preco_remedio (3);

-- STORED PROCEDURE Atualizar o Estoque
DELIMITER //
  CREATE PROCEDURE SP_AtualizaEstoqueProd ( prod_id int, qtde_comprada int)
BEGIN
    declare contador int;

    SELECT count(*) into contador FROM estoque WHERE produto_id = prod_id;

    IF contador > 0 THEN
        UPDATE estoque SET Quantidade_produto = Quantidade_produto + qtde_comprada
        WHERE produto_id = prod_id;
    ELSE
        INSERT INTO estoque (produto_id, Quantidade_produto) values (prod_id, qtde_comprada);
    END IF;
END //
DELIMITER ;

-- TRIGGERS alterando o estoque
DELIMITER //
CREATE TRIGGER TRG_EntradaProduto_AI AFTER INSERT ON entradaProdutoRemedio
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoqueProd (new.produto_id, new.qtd_produto);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER TRG_EntradaProduto_AU AFTER UPDATE ON entradaProdutoRemedio
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoqueProd (new.produto_id, new.qtd_produto - old.qtd_produto);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER TRG_EntradaProduto_AD AFTER DELETE ON entradaProdutoRemedio
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoqueProd (old.produto_id, old.qtd_produto * -1);
END //
DELIMITER ;

