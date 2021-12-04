-- CRIANDO O BANCO
CREATE DATABASE BigBike;
USE BiGBike;

-- CRIANDO TABELAS

-- cargos
CREATE TABLE CARGOS
(
	id_cargo		INT AUTO_INCREMENT NOT NULL,
    nome_cargo		VARCHAR (50) NOT NULL,
    descri_cargo	VARCHAR (200) NOT NULL,
    
    PRIMARY KEY (id_cargo)
);
-- funcionários
CREATE TABLE FUNCIONARIOS
(
	id_func			INT AUTO_INCREMENT NOT NULL,
    id_cargo		INT NOT NULL,
    nome_func		VARCHAR (50) NOT NULL,
    cpf_func		VARCHAR (27) NOT NULL,
    email_func		VARCHAR (50) NOT NULL,
    dt_reg_func		DATETIME,
    
    PRIMARY KEY (id_func),
    FOREIGN KEY (id_cargo) REFERENCES CARGOS (id_cargo)
    ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE FUNCIONARIOS ADD COLUMN ganho_hora DECIMAL (12,3);
-- estados
CREATE TABLE ESTADOS
(
	id_estado		INT AUTO_INCREMENT NOT NULL,
    nome_estado		VARCHAR (30) NOT NULL,
    descri_estado	VARCHAR (200) NOT NULL,
    
    PRIMARY KEY	(id_estado)
);
-- cidades
CREATE TABLE CIDADES
(
	id_cidade		INT AUTO_INCREMENT NOT NULL,
    id_estado		INT NOT NULL,
    nome_cidade		VARCHAR (30) NOT NULL,
    descri_cidade	VARCHAR (200) NOT NULL,
    
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (id_estado) REFERENCES ESTADOS (id_estado)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- 	endereço do funcionário
CREATE TABLE ENDERECO_FUNC
(
	id_end_func				INT AUTO_INCREMENT NOT NULL,
    id_func					INT NOT NULL,
    id_cidade				INT NOT NULL,
    cep_end_func			VARCHAR (9),
    num_end_func			INT NOT NULL,
    complemento_end_func	VARCHAR (300),
    
    PRIMARY KEY (id_end_func),
    
    FOREIGN KEY (id_func) REFERENCES FUNCIONARIOS (id_func)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_cidade) REFERENCES CIDADES (id_cidade)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- tabela dos clientes \(￣︶￣*\))
CREATE TABLE CLIENTES
(
	id_cl		INT AUTO_INCREMENT NOT NULL,
    nome_cl		VARCHAR (50) NOT NULL,
    cpf_cl		VARCHAR (27),
    sexo_cl		CHAR (1),
    cnpj_cl		VARCHAR (27),
    dt_nasc_cl	DATE,
    dt_reg_cl	DATETIME NOT NULL,
    
    PRIMARY KEY (id_cl)
);
-- tabela de endereço dos criente foda >:) 
CREATE TABLE ENDERECO_CL
(
	id_end_cl				INT AUTO_INCREMENT NOT NULL,
    id_cl					INT NOT NULL,
    id_cidade				INT NOT NULL,
    cep_end_cl				VARCHAR (9) NOT NULL,
    num_end_cl				INT NOT NULL,
    complemento_end_cl		VARCHAR (200),
    
    PRIMARY KEY (id_end_cl),
    
    FOREIGN KEY (id_cl) REFERENCES CLIENTES (id_cl)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_cidade) REFERENCES CIDADES (id_cidade)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- table de telefone dos clientes ╰（‵□′）╯
CREATE TABLE TELS_CLI
(
	id_tel_cl		INT AUTO_INCREMENT NOT NULL,
    id_cl			INT NOT NULL,
    num_tel_cl		INT NOT NULL,
	dd_tel_cl		INT NOT NULL,
    
    PRIMARY KEY (id_tel_cl),
    
    FOREIGN KEY (id_cl) REFERENCES CLIENTES (id_cl)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- tabela do fornecedores (〜￣▽￣)〜
CREATE TABLE FORNECEDORES
(
	id_forn			INT AUTO_INCREMENT NOT NULL,
    cnpj_forn		VARCHAR (27),
    nome_forn		VARCHAR (50) NOT NULL,
    email_forn 		VARCHAR (50),
    
    PRIMARY KEY (id_forn)
);
-- tabela telefones do fornecedores ring ring ლ(╹◡╹ლ)
CREATE TABLE TELS_FORN
(
	id_tel_forn		INT AUTO_INCREMENT NOT NULL,
    id_forn			INT NOT NULL,
    num_tel_forn	INT NOT NULL,
    dd_tel_forn		INT NOT NULL,
    
    PRIMARY KEY (id_tel_forn),
    
    FOREIGN KEY (id_forn) REFERENCES FORNECEDORES (id_forn)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- tabela de enreço dos fornecedores fon fon 〜(￣▽￣〜)
CREATE TABLE ENDERECO_FORN
(
	id_end_forn				INT AUTO_INCREMENT NOT NULL,
    id_forn					INT NOT NULL,
    id_cidade				INT NOT NULL,
    cep_end_forn			VARCHAR (9) NOT NULL,
    num_end_forn			INT NOT NULL,
    complemente_end_forn	VARCHAR (200),
    
    PRIMARY KEY (id_end_forn),
    
    FOREIGN KEY (id_forn) REFERENCES FORNECEDORES (id_forn)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_cidade) REFERENCES CIDADES (id_cidade)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- tabela de tipo serviço (>'-'<)
CREATE TABLE TP_SERVICOS
(
	id_tp_servico		INT AUTO_INCREMENT NOT NULL,
    nome_tp_servico		VARCHAR (50) NOT NULL,
    descri_tp_servico	VARCHAR (200) NOT NULL,
    
    PRIMARY KEY (id_tp_servico)
);
-- tabela de serviços, trabaio dale dale （︶^︶）
CREATE TABLE SERVICOS
(
	id_servico			INT AUTO_INCREMENT NOT NULL,
    id_func				INT NOT NULL,
    id_cl				INT NOT NULL,
    id_tp_servico		INT NOT NULL,
	cpf_cl				VARCHAR (27),
    cnpj_cl				VARCHAR (27),
    dt_reg_servico		DATETIME NOT NULL,
    
    PRIMARY KEY (id_servico),
    
    FOREIGN KEY (id_func) REFERENCES FUNCIONARIOS (id_func)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_cl) REFERENCES CLIENTES (id_cl)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_tp_servico) REFERENCES TP_SERVICOS (id_tp_servico)
    ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE SERVICOS ADD COLUMN dt_entrega_servico DATE;
-- tabela de estoque de peças fofnon 🤝🏼🙂
CREATE TABLE ESTOQUE_PECAS
(
	id_peca				INT AUTO_INCREMENT NOT NULL,
    id_forn				INT, -- deixei sem not null, pq as vezes a peça foi pega de um lugar nada a ver
    valor_unit			DECIMAL (12,3) NOT NULL,
    quantidade_peca		INT NOT NULL,
    valor_min_peca		INT NOT NULL, 
    -- coloquei esse atributo, pq futuramente a pesseoa que desenvolver o sistema, 
    -- pode dar a opção de escolher a quantidade minímina de estoque para o produto.
    nome_peca			VARCHAR (50) NOT NULL,
    
    PRIMARY KEY (id_peca),
	
    FOREIGN KEY (id_forn) REFERENCES FORNECEDORES (id_forn) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE ESTOQUE_PECAS ADD COLUMN custo_unit_peca DECIMAL (12,3);
-- tabela que armazenas a bike que ficaram para manutenção (∪.∪ )...zzz
CREATE TABLE BIKES_MANUTENCAO
(
	id_bike_manuten			INT AUTO_INCREMENT NOT NULL,
    id_servico				INT NOT NULL,
    descri_bike_manuten		VARCHAR (200),
    valor_final_bike_manu	DECIMAL (12,3) NOT NULL,
    
    PRIMARY KEY (id_bike_manuten),
    
    FOREIGN KEY (id_servico) REFERENCES SERVICOS (id_servico)
    ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE BIKES_MANUTENCAO ADD COLUMN quantidade_hora_bike_manu INT;
-- criando a tabela que armazena os items que foram utilizados para a manutenção ( ´･･)ﾉ(._.`)
CREATE TABLE ITEMS_MANUTECAO 
(
	id_item_manuten			INT AUTO_INCREMENT NOT NULL,
    id_bike_manuten			INT NOT NULL,
    id_peca					INT NOT NULL,
    quantidade_peca_manu	INT NOT NULL,
    valor_total_peca_manu	DECIMAL (12,3) NOT NULL,
    
    PRIMARY KEY (id_item_manuten),
    
    FOREIGN KEY (id_bike_manuten) REFERENCES BIKES_MANUTENCAO (id_bike_manuten)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_peca) REFERENCES ESTOQUE_PECAS (id_peca)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- tabela que armazena as compras, caso do este o serviço ＼(ﾟｰﾟ＼)
CREATE TABLE COMPRAS
(
	id_compra			INT AUTO_INCREMENT NOT NULL,
    id_servico			INT NOT NULL,
    valor_final_compra	DECIMAL (12,3) NOT NULL,
    descri_compra		VARCHAR (200),
    
    PRIMARY KEY (id_compra),
    
    FOREIGN KEY (id_servico) REFERENCES SERVICOS (id_servico)
    ON DELETE CASCADE ON UPDATE CASCADE
); 
-- tabela que armazena todos os items relacionado a compra o(*￣▽￣*)ブ
CREATE TABLE ITEMS_COMPRA 
(
	id_item_compra			INT AUTO_INCREMENT NOT NULL,
    id_compra				INT NOT NULL,
    id_peca					INT NOT NULL,
    quantidade_peca_compra	INT NOT NULL,
    valor_total_peca_compra	DECIMAL (12,3) NOT NULL,
    
    PRIMARY KEY (id_item_compra),
    
    FOREIGN KEY (id_compra) REFERENCES COMPRAS (id_compra)
    ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_peca) REFERENCES ESTOQUE_PECAS (id_peca)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- tp_pagamento
CREATE TABLE TP_PAGAMENTO
(
	id_tp_pagamento		INT AUTO_INCREMENT NOT NULL,
    nome_pagamento		VARCHAR(40),
    
    PRIMARY KEY (id_tp_pagamento)
);

-- parcelas
CREATE TABLE PARCELAS
(
	id_parcela		INT AUTO_INCREMENT NOT NULL,
    id_servico		INT NOT NULL,
    qntd_parcelas	INT NOT NULL,
    pagas_parcelas	INT,
    valor_parcela 	DECIMAL (6,2),
    
    PRIMARY KEY (id_parcela),
    FOREIGN KEY (id_servico) REFERENCES SERVICOS (id_servico)
);
-- INSERINDO OS DADOS

-- cargos
INSERT INTO CARGOS (id_cargo, nome_cargo, descri_cargo) VALUES
				   (default, 'Dono', 'Faz multiplas funções, e gerencia tudo.'),
                   (default, 'Funcionário', 'Faz multiplas funções.');
                   
-- funcionarios
INSERT INTO FUNCIONARIOS (id_func, id_cargo, nome_func, cpf_func, email_func, dt_reg_func) VALUES
			(default, 1, 'Dono', '12345678910', 'Dono@dono.com', NOW()),
            (default, 2, 'Funcionário 1', '12345678911', 'Func1@funci.com', NOW()),
            (default, 2, 'Funcionário 2', '12335678911', 'Func2@func.com', NOW());

-- ajuses que fiz no mer e no der
UPDATE FUNCIONARIOS SET ganho_hora = 10.00 WHERE id_func = 2;
UPDATE FUNCIONARIOS SET ganho_hora = 10.00 WHERE id_func = 3;
UPDATE FUNCIONARIOS SET ganho_hora = 25.00 WHERE id_func = 1;
-- estados
INSERT INTO ESTADOS (id_estado, nome_estado, descri_estado) VALUES
			(default, 'Paraná', 'Mato mato mato.'),
            (default, 'Sata Catarina', 'Só as praia doida.'),
            (default, 'Rio Grade do Sul', 'Só muié bonita.'),
            (default, 'São Paulo', 'Poluição, cof-cof.'),
            (default, 'Rio de Janeiro', 'Famoso que só a desgraça.');

-- cidades
INSERT INTO CIDADES (id_cidade, id_estado, nome_cidade, descri_cidade) VALUES
			(default, 1, 'Curitiba', 'O lugarzin bom de morar!'),
            (default, 1, 'Coronel Vivida', 'Slk, o bagulho lá é mato hein.'),
            (default, 4, 'São Paulo', 'Poluição 2 cof-cof.'),
            (default, 3, 'Porto Alegre', 'Weeeeeee ＜（＾－＾）＞'),
            (default, 5, 'Lebon', 'Só os mano rico fi.');
-- endereco_func
INSERT INTO ENDERECO_FUNC (id_end_func, id_func, id_cidade, cep_end_func, num_end_func, complemento_end_func) VALUES
			(default, 2, 1, '82110480', 12, 'Slk, o maluko ganha bem （︶^︶）.'),
            (default, 3, 1, '82110481', 15, 'Chalézin no jeito.'),
            (default, 1, 1, '82110482', 379, 'Casa de rico.');
-- clientes
INSERT INTO CLIENTES (id_cl, nome_cl, cpf_cl, sexo_cl, cnpj_cl, dt_nasc_cl, dt_reg_cl) VALUES
			(default, 'Mario', '12345678910', 'M', '', '2002-10-01', NOW()),
            (default, 'Jorge', '', 'M', '123446789106874', '1997-07-12', NOW()),
            (default, 'Maria', '12345678911', 'F', '', '2002-11-17', NOW()),
            (default, 'Reginaldo', '12345678999', 'M', '', '2000-01-01', NOW()),
            (default, 'Alex', '', 'M', '123447788106879', '1998-03-13', NOW()),
            (default, 'Regina', '12345678910', 'F', '', '2002-02-27', NOW()),
            (default, 'Eduarda', '12345678910', 'F', '', '2001-03-15', NOW()),
            (default, 'Cleiton', '', 'M', '123776889106874', '2000-12-01', NOW());
            
-- endereco_cl
INSERT INTO ENDERECO_CL (id_end_cl, id_cl, id_cidade, cep_end_cl, num_end_cl, complemento_end_cl) VALUES
			(default, 1, 2, '82110489', 16, 'Casa bonita, confia (^人^)'),
            (default, 2, 1, '82110457', 457, 'Casa de rico 1 §(*￣▽￣*)§'),
            (default, 2, 1, '83170483', 78, 'Casa de mais rico ainda ◑﹏◐'),
            (default, 3, 2, '82110789', 652, 'Casa de cor azul escuro.'),
            (default, 4, 1, '82174223', 354, 'Casa verde com garagem cromada no crime (⓿_⓿)'),
            (default, 5, 1, '82117489', 35, 'Casa azul calcinha.'),
            (default, 6, 1, '89789456', 2, 'Casa legal.'),
            (default, 7, 1, '49854563', 748, 'Casa estilosa, toda preta (。・ω・。)'),
            (default, 8, 1, '45645642', 1570, 'Casa cinza.');

-- fonecedores
INSERT INTO FORNECEDORES (id_forn, cnpj_forn, nome_forn, email_forn) VALUES
			(default, '658742351987546', 'Jailson peças e motores', 'jailson@quedelicia.com'),
            (default, '154789635874201', 'Joaquin factory', 'joaquin@lindo.com'),
            (default, '059490456456878', 'Maria, rainha das bike', 'maria@mariafoda.com'),
            (default, '456151066545674', 'Fonfon, buzinas e lanches', 'buzinasdoze@gamer.com'),
            (default, '411650567456132', 'Mario, o rei das peças do amarmário', 'mario@armario.com'),
            (default, '456065654567563', 'Ana petrólhos', 'ana@class.com');

-- tels_forn
INSERT INTO TELS_FORN (id_tel_forn, id_forn, num_tel_forn, dd_tel_forn) VALUES
			(default, 1, 999999999, 41),
            (default, 2, 899999999, 41),
            (default, 2, 899997999, 41),
            (default, 3, 788889999, 41),
            (default, 4, 688888771, 41),
            (default, 4, 789875324, 44),
            (default, 5, 789865213, 41),
            (default, 6, 789754321, 41),
            (default, 6, 994561233, 42);

UPDATE TELS_FORN SET dd_tel_forn = 44 WHERE dd_tel_forn = 42; -- AJUSETE

-- endereco_forn
ALTER TABLE ENDERECO_FORN CHANGE COLUMN complemente_end_forn complemento_end_forn VARCHAR (200);

INSERT INTO ENDERECO_FORN (id_end_forn, id_forn, id_cidade, cep_end_forn, num_end_forn, complemento_end_forn) VALUES
			(default, 1, 1, '58745398', 24, 'Do lado da panificadora, roliçõs (ง •_•)ง'),
            (default, 2, 1, '98756341', 875, 'Sem complemento.'),
            (default, 2, 1, '98756347', 1050, 'Sem complemento.'),
            (default, 3, 1, '45413247', 7485, 'Galpão vermelho.'),
            (default, 4, 1, '74145348', 7896, 'Sem complemento.'),
            (default, 4, 2, '74564123', 45, 'Balcão verde com preto (〜￣▽￣)〜'),
            (default, 5, 1, '94561327', 789, 'Sem complemento.'),
            (default, 6, 1, '84548643', 45, 'Sem complemento.'),
            (default, 6, 2, '45456457', 13, 'Na frente do Condor.');
            
-- estoque_pecas
ALTER TABLE ESTOQUE_PECAS CHANGE COLUMN valor_unit valor_unit_peca DECIMAL (12,3);

INSERT INTO ESTOQUE_PECAS (id_peca, id_forn, valor_unit_peca, quantidade_peca, valor_min_peca, nome_peca, custo_unit_peca) VALUES
			(default, 1, 23.50, 15, 2, 'Guidão', 10.00),
            (default, 1, 12.75, 13, 2, 'Luva para guidão', 5.00),
            (default, 2, 50.00, 8, 2, 'Corpo da bicicleta', 15.00),
            (default, 3, 23.99, 6, 2, 'Corrente de bicicleta', 10.00),
            (default, 4, 31.75, 72, 5, 'Buzina para bicicleta', 10.00),
            (default, 5, 14.50, 9, 2, 'Banco de bicicleta', 5.00),
            (default, 6, 12.00, 32, 5, 'Borracha de freio', 4.00),
            (default, 6, 29.99, 9, 12, 'Pneu de bicicleta', 12.00);
            
-- tipo_servico
INSERT INTO TP_SERVICOS (id_tp_servico, nome_tp_servico, descri_tp_servico) VALUES
			(default, 'Venda', 'Serviço relacionado a vendas'),
            (default, 'Manutenção', 'Serviço relacionado a manutenção das bicicletas');
            
-- tp_pagamento
INSERT INTO TP_PAGAMENTO (id_tp_pagamento, nome_pagamento) VALUES
			(default, 'Dinheiro - avista.'),
            (default, 'Cheque - parcelado.');
            
-- servicos
INSERT INTO SERVICOS (id_servico, id_func, id_cl, id_tp_servico, cpf_cl, cnpj_cl, dt_reg_servico, dt_entrega_servico) VALUES
			(default, 2, 1, 1, '12345678910', '', NOW(), '2021-11-24'),
            (default, 3, 2, 2, '', '123446789106874', NOW(), '2021-11-30'),
            (default, 2, 3, 1, '12345678911', '', NOW(), '2021-11-24'),
            (default, 1, 4, 2, '12345678999', '', NOW(), '2021-12-02'),
            (default, 2, 5, 1, '', '123447788106879', NOW(), '2021-11-24'),
            (default, 1, 6, 2, '12345678910', '', NOW(), '2021-11-29'),
            (default, 3, 7, 1, '12345678910', '', NOW(), '2021-11-24'),
            (default, 2, 8, 2, '', '123776889106874', NOW(), '2021-11-25');

ALTER TABLE SERVICOS ADD COLUMN id_tp_pagamento INT NOT NULL;

-- fiz esses update, pois fiz algumas atualizações na estrutura no banco
UPDATE SERVICOS SET id_tp_servico = 2 WHERE id_servico = 3;
UPDATE SERVICOS SET id_tp_servico = 2 WHERE id_servico = 4;
UPDATE SERVICOS SET id_tp_servico = 2 WHERE id_servico = 6;
UPDATE SERVICOS SET id_tp_servico = 2 WHERE id_servico = 7;

UPDATE SERVICOS SET id_tp_servico = 1 WHERE id_servico = 1;
UPDATE SERVICOS SET id_tp_servico = 1 WHERE id_servico = 2;
UPDATE SERVICOS SET id_tp_servico = 1 WHERE id_servico = 5;
UPDATE SERVICOS SET id_tp_servico = 1 WHERE id_servico = 8;


UPDATE SERVICOS SET id_tp_pagamento = 2 WHERE id_servico = 1;
UPDATE SERVICOS SET id_tp_pagamento = 2 WHERE id_servico = 4;
UPDATE SERVICOS SET id_tp_pagamento = 2 WHERE id_servico = 6;
UPDATE SERVICOS SET id_tp_pagamento = 2 WHERE id_servico = 8;
UPDATE SERVICOS SET id_tp_pagamento = 2 WHERE id_servico = 7;

UPDATE SERVICOS SET id_tp_pagamento = 1 WHERE id_tp_pagamento != 2;

-- compras
INSERT INTO COMPRAS (id_compra, id_servico, valor_final_compra, descri_compra) VALUES
			(default, 1, 73.50, 'Guidão, bonitão + corpo.'),
            (default, 2, 50, 'Corpão violão'),
            (default, 5, 24, 'Borracha rosa'),
            (default, 8, 63.50, 'Buzinas de palhaço');

-- items_compra
INSERT INTO ITEMS_COMPRA (id_item_compra, id_compra, id_peca, quantidade_peca_compra, valor_total_peca_compra) VALUES
			(default, 1, 1, 1, 23.50),
            (default, 1, 3, 1, 50),
            (default, 2, 3, 1, 50),
            (default, 3, 7, 2, 24),
            (default, 4, 5, 2, 63.50);
            
-- bike_manutencao
INSERT INTO BIKES_MANUTENCAO (id_bike_manuten, id_servico, descri_bike_manuten, valor_final_bike_manu, quantidade_hora_bike_manu) VALUES
			(default, 3, 'Troca de banco', 14.50, 1),
            (default, 4, 'Troca de freios', 24, 1),
            (default, 6, 'Troca de buzina e freios', 55.5, 2),
            (default, 7, 'Instalação de buzina e troca de pneus', 91.55, 4);

-- items_manutencao
INSERT INTO ITEMS_MANUTECAO (id_item_manuten, id_bike_manuten, id_peca, quantidade_peca_manu, valor_total_peca_manu) VALUES
			(default, 1, 6, 1,14.5),
            (default, 2, 7, 2, 24),
            (default, 3, 5, 1, 31.75),
            (default, 3, 7, 2, 24),
            (default, 4, 5, 1, 31.75),
            (default, 4, 8, 2, 59.8);

-- parcelas
INSERT INTO PARCELAS (id_parcela, id_servico, qntd_parcelas, pagas_parcelas, valor_parcela) VALUES
			(default, 1, 2, 1, 36.75),
			(default, 4, 2, 1, 12),
            (default, 6, 3, 2, 18.5),
            (default, 7, 4, 1, 23),
            (default, 8, 2, 1, 31.75);

-- alterando a tabela servicos
ALTER TABLE SERVICOS ADD COLUMN valor_final_servico DECIMAL(12,3);

ALTER TABLE SERVICOS ADD COLUMN dt_estivativa_servico DATE;

ALTER TABLE SERVICOS DROP COLUMN dt_estivativa_servico;

ALTER TABLE BIKES_MANUTENCAO ADD COLUMN dt_estivativa_manu DATE;

SELECT * FROM SERVICOS WHERE id_tp_servico = 2;

UPDATE SERVICOS SET valor_final_servico = 23.5 WHERE id_servico = 1;
UPDATE SERVICOS SET valor_final_servico = 50 WHERE id_servico = 2;
UPDATE SERVICOS SET valor_final_servico = 14.5 WHERE id_servico = 3;
UPDATE SERVICOS SET valor_final_servico = 24 WHERE id_servico = 4;
UPDATE SERVICOS SET valor_final_servico = 24 WHERE id_servico = 5;
UPDATE SERVICOS SET valor_final_servico = 55.5 WHERE id_servico = 6;
UPDATE SERVICOS SET valor_final_servico = 91.55 WHERE id_servico = 7;
UPDATE SERVICOS SET valor_final_servico = 63.50 WHERE id_servico = 8;

-- utilizar aqui para atualizar para o dia 01
UPDATE SERVICOS SET dt_reg_servico = '2021-11-23' WHERE id_servico = 1;
UPDATE SERVICOS SET dt_reg_servico = '2021-11-24' WHERE id_servico = 2;
UPDATE SERVICOS SET dt_reg_servico = '2021-11-25' WHERE id_servico = 3;
UPDATE SERVICOS SET dt_reg_servico = '2021-11-24' WHERE id_servico = 4;
UPDATE SERVICOS SET dt_reg_servico = '2021-11-25' WHERE id_servico = 5;
UPDATE SERVICOS SET dt_reg_servico = '2021-11-25' WHERE id_servico = 6;
UPDATE SERVICOS SET dt_reg_servico = '2021-12-01' WHERE id_servico = 7;
UPDATE SERVICOS SET dt_reg_servico = '2021-12-01' WHERE id_servico = 8;

-- utilizar aqui para atualizar para o dia 01
UPDATE BIKES_MANUTENCAO SET dt_estivativa_manu = '2021-11-25' WHERE id_bike_manuten = 1;
UPDATE BIKES_MANUTENCAO SET dt_estivativa_manu = '2021-11-01' WHERE id_bike_manuten = 2;
UPDATE BIKES_MANUTENCAO SET dt_estivativa_manu = '2021-11-25' WHERE id_bike_manuten = 3;
UPDATE BIKES_MANUTENCAO SET dt_estivativa_manu = '2021-11-24' WHERE id_bike_manuten = 4;

-- FAZENDO OS COMANDOS QUE O DONO PEDIU
SELECT * FROM SERVICOS;
-- quanto entrou em caixa por dia
CREATE VIEW day_left
AS
	SELECT SUM(c.valor_final_compra) + SUM(bm.valor_final_bike_manu) FROM SERVICOS AS S
			LEFT JOIN COMPRAS AS c ON
			s.id_servico = C.id_servico
			LEFT JOIN BIKES_MANUTENCAO AS bm ON
			s.id_servico = bm.id_servico
	WHERE DAY(dt_reg_servico) = DAY(CURDATE());
;
SELECT * FROM day_left;

-- quanto entrou em caixa por mês
CREATE VIEW month_left
AS
	SELECT SUM(c.valor_final_compra) + SUM(bm.valor_final_bike_manu) FROM SERVICOS AS S
			LEFT JOIN COMPRAS AS c ON
			s.id_servico = C.id_servico
			LEFT JOIN BIKES_MANUTENCAO AS bm ON
			s.id_servico = bm.id_servico
	WHERE MONTH(dt_reg_servico) = MONTH(CURDATE());
;
SELECT * FROM month_left;

-- quanto entrou em caixa por mês
CREATE VIEW year_left
AS
	SELECT SUM(c.valor_final_compra) + SUM(bm.valor_final_bike_manu) FROM SERVICOS AS S
			LEFT JOIN COMPRAS AS c ON
			s.id_servico = C.id_servico
			LEFT JOIN BIKES_MANUTENCAO AS bm ON
			s.id_servico = bm.id_servico
	WHERE YEAR(dt_reg_servico) = YEAR(CURDATE());
;
SELECT * FROM year_left;

-- quantas bicicletas passam pela manutenção por dia
CREATE VIEW bikes_day_left
AS
	SELECT COUNT(s.id_servico) AS 'Bicicletas para a manutenção (DIA)' FROM SERVICOS AS s
	INNER JOIN BIKES_MANUTENCAO AS bm ON
	s.id_servico = bm.id_servico
	WHERE DAY(s.dt_reg_servico) = DAY(CURDATE());
;
SELECT * FROM bikes_day_left;

-- a média de quantas horas por bicicleta um mecânico precisa para fazer a manutenção
CREATE VIEW bikes_horas_media
AS
	SELECT ROUND(AVG(bm.quantidade_hora_bike_manu), 2) AS 'Média de horas' FROM SERVICOS AS s
	INNER JOIN BIKES_MANUTENCAO AS bm ON
	s.id_servico = bm.id_servico
	WHERE DAY(s.dt_reg_servico) = DAY(CURDATE());
;
SELECT * FROM bikes_horas_media;

-- a média de horas da manutenção | o valor médio do valor pago na manutenção | o valor médio pago em horas pro funcionário
CREATE VIEW med_horas_valorManu_valorFunc
AS
	SELECT	ROUND(AVG(bm.quantidade_hora_bike_manu)) AS 'MÉDIA DE HORAS',
			ROUND(AVG(s.valor_final_servico), 2) AS 'MÉDIA DO VALOR',
			ROUND(AVG(f.ganho_hora), 2) AS 'MÉDIA DO GANHO HORA DOS FUNCS'
	FROM SERVICOS AS s
		INNER JOIN BIKES_MANUTENCAO AS bm ON
		s.id_servico = bm.id_servico
		INNER JOIN FUNCIONARIOS AS f ON
		f.id_func = s.id_func
		WHERE id_tp_pagamento = 2;
;
SELECT * FROM med_horas_valorManu_valorFunc;

-- quanto entra por setor (vendas | manutenção)
CREATE VIEW entrada_venda_manuten
AS 
	SELECT 	COUNT(c.id_compra) AS 'QUANTIDADE COMPRAS',
			SUM(c.valor_final_compra) AS 'VALOR FINAL DAS COMPRAS',
			COUNT(bm.id_bike_manuten) AS 'QUANTIDADE BIKES MANUTENÇÃO',
			SUM(bm.valor_final_bike_manu) AS 'VALOR FINAL DAS MANUTENÇÕES'
	FROM SERVICOS AS s
		LEFT JOIN COMPRAS AS c ON
		s.id_servico = C.id_servico
		LEFT JOIN BIKES_MANUTENCAO AS bm ON
		s.id_servico = bm.id_servico;
;
SELECT * FROM entrada_venda_manuten;

-- quanto sai (custo de funcionários); 
CREATE VIEW saida_custo_func
AS
	SELECT 	COUNT(c.id_compra) AS 'QUANTIDADE COMPRAS',
			SUM(c.valor_final_compra - f.ganho_hora) AS 'VALOR FINAL DAS COMPRAS',
			COUNT(bm.id_bike_manuten) AS 'QUANTIDADE BIKES MANUTENÇÃO',
			SUM(bm.valor_final_bike_manu - f.ganho_hora) AS 'VALOR FINAL DAS MANUTENÇÕES'
	FROM SERVICOS AS s
		LEFT JOIN COMPRAS AS c ON
		s.id_servico = C.id_servico
		LEFT JOIN BIKES_MANUTENCAO AS bm ON
		s.id_servico = bm.id_servico
		RIGHT JOIN FUNCIONARIOS AS f ON 
		f.id_func = s.id_func;
;
SELECT * FROM saida_custo_func;

-- quanto gera de lucro nas vendas de peças
CREATE VIEW lucro_venda_pecas
AS
	SELECT 	c.id_compra AS 'COMPRA',
			SUM(c.valor_final_compra) AS 'VALOR FINAL DA VENDA',
			SUM(ep.custo_unit_peca) AS 'SOMA DO VALOR DAS UNIDADES',
			SUM(valor_final_compra - (ep.custo_unit_peca * ic.quantidade_peca_compra)) AS 'LUCRO' 
	FROM ITEMS_COMPRA AS ic
		INNER JOIN COMPRAS AS c ON
		c.id_compra = ic.id_compra
		LEFT JOIN ESTOQUE_PECAS AS ep ON
		ic.id_peca = ep.id_peca
		GROUP BY c.id_compra;
;
SELECT * FROM lucro_venda_pecas;

-- quantas bicicletas saem fora do prazo na devolução pro cliente
CREATE VIEW manu_fora_prazo
AS
	SELECT 	COUNT(bm.id_bike_manuten) AS 'ENTREGUES FORA DO PRAZO'
	FROM SERVICOS AS s
		INNER JOIN BIKES_MANUTENCAO AS bm ON
		s.id_servico = bm.id_servico
		WHERE s.dt_entrega_servico > bm.dt_estivativa_manu;
;
SELECT * FROM manu_fora_prazo;

-- FIM :)
SHOW TABLES;