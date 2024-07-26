-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema alinhamentoltda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema alinhamentoltda
-- -----------------------------------------------------
DROP DATABASE alinhamentoltda;
CREATE SCHEMA IF NOT EXISTS `alinhamentoltda` DEFAULT CHARACTER SET latin1 ;
USE `alinhamentoltda` ;

-- -----------------------------------------------------
-- Table `alinhamentoltda`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`estado` (
  `id` INT NOT NULL auto_increment COMMENT 'Identificador unico do estado',
  `nm_estado` VARCHAR(45) NOT NULL COMMENT 'nome do estado',
  `sg_uf` VARCHAR(2) NOT NULL COMMENT 'Sigla de unidade federativa',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`cidade` (
  `id` INT AUTO_INCREMENT NOT NULL COMMENT 'identificador da cidade',
  `nm_cidade` VARCHAR(45) NOT NULL COMMENT 'nome da cidade',
  `id_estado` INT NOT NULL COMMENT 'identificador do estado',
  PRIMARY KEY (`id`, `id_estado`),
  INDEX `fk_cidades_estados1_idx` (`id_estado` ASC) ,
  CONSTRAINT `fk_cidades_estados1`
    FOREIGN KEY (`id_estado`)
    REFERENCES `alinhamentoltda`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador da tabela',
  `nr_cep` VARCHAR(10) NOT NULL COMMENT 'numero do cep',
  `id_cidade` INT NOT NULL COMMENT 'identificador da tabela',
  `ds_logradouro` VARCHAR(100) NOT NULL COMMENT 'descricao do logradouro',
  `ds_complemento` VARCHAR(50) CHARACTER SET 'latin1' COLLATE 'latin1_bin'  COMMENT 'descricao do complemento',
  `nm_bairro` VARCHAR(50) NOT NULL COMMENT 'nome do bairro',
  PRIMARY KEY (`id`, `id_cidade`),
  INDEX `fk_enderecos_cidades1_idx` (`id_cidade` ASC) ,
  CONSTRAINT `fk_enderecos_cidades1`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `alinhamentoltda`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador do cliente',
  `nm_cliente` VARCHAR(50) NOT NULL COMMENT 'nome do cliente',
  `nm_sobrenome` VARCHAR(50) NOT NULL COMMENT 'sobrenome do cliente',
  `nr_telefone` VARCHAR(14) NOT NULL COMMENT 'numero de telefone',
  `in_vip` TINYINT NOT NULL DEFAULT '0' COMMENT 'identificador do cliente vip',
  `id_endereco` INT NOT NULL COMMENT 'identificador do endereco',
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_endereco1_idx` (`id_endereco` ASC) ,
  CONSTRAINT `fk_cliente_endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `alinhamentoltda`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador do fornecedor',
  `cd_fornecedor` INT(10) NOT NULL COMMENT 'codigo do fornecedor ',
  `nm_fornecedor` VARCHAR(100) NOT NULL COMMENT 'nome do fornecedor',
  `tp_tipo` TINYINT NOT NULL DEFAULT '1' COMMENT 'tipo do fornecedor',
  `qt_carros` INT(4) NOT NULL COMMENT 'quantidade de carros para transporte',
  `id_endereco` INT NOT NULL COMMENT 'identificador do endereco',
  PRIMARY KEY (`id`),
  INDEX `fk_fornecedor_endereco1_idx` (`id_endereco` ASC) ,
  CONSTRAINT `fk_fornecedor_endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `alinhamentoltda`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`loja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`loja` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador da loja',
  `nm_loja` VARCHAR(100) NOT NULL COMMENT 'nome da loja',
  `tp_loja` TINYINT NOT NULL COMMENT 'tipo da loja',
  `id_endereco` INT NOT NULL COMMENT 'identificador do endereco',
  PRIMARY KEY (`id`),
  INDEX `fk_loja_endereco1_idx` (`id_endereco` ASC) ,
  CONSTRAINT `fk_loja_endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `alinhamentoltda`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`compra_loja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`compra_loja` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador da compra',
  `vl_compra` DECIMAL(7,2) NOT NULL COMMENT 'valor total da compra',
  `id_fornecedor` INT NOT NULL COMMENT 'identificador do fornecedor',
  `id_loja` INT NOT NULL COMMENT 'identificador da loja',
  PRIMARY KEY (`id`, `id_fornecedor`, `id_loja`),
  INDEX `fk_compra_loja_fornecedor1_idx` (`id_fornecedor` ASC) ,
  INDEX `fk_compra_loja_loja1_idx` (`id_loja` ASC) ,
  CONSTRAINT `fk_compra_loja_fornecedor1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `alinhamentoltda`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_loja_loja1`
    FOREIGN KEY (`id_loja`)
    REFERENCES `alinhamentoltda`.`loja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`venda_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`venda_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador da venda para o cliente',
  `vl_total_venda` DECIMAL(7,2) NOT NULL COMMENT 'valor total da venda',
  `id_loja` INT NOT NULL COMMENT 'identificador da loja',
  `id_cliente` INT NOT NULL COMMENT 'identificador do cliente',
  PRIMARY KEY (`id`, `id_cliente`, `id_loja`),
  INDEX `fk_venda_cliente_loja1_idx` (`id_loja` ASC) ,
  INDEX `fk_venda_cliente_cliente1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_venda_cliente_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `alinhamentoltda`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_cliente_loja1`
    FOREIGN KEY (`id_loja`)
    REFERENCES `alinhamentoltda`.`loja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`entrega` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador da entrega',
  `tp_status` TINYINT NOT NULL COMMENT 'tipo do estado',
  `dt_entrega` DATE NULL DEFAULT NULL COMMENT 'data da entrega',
  `id_venda_cliente` INT NOT NULL COMMENT 'identificador da venda para o cliente',
  `id_endereco` INT NOT NULL COMMENT 'identificador do endereco',
  PRIMARY KEY (`id`, `id_venda_cliente`, `id_endereco`),
  INDEX `fk_venda_cliente` (`id_venda_cliente` ASC) ,
  INDEX `fk_endereco` (`id_endereco` ASC) ,
  CONSTRAINT `entrega_ibfk_1`
    FOREIGN KEY (`id_venda_cliente`)
    REFERENCES `alinhamentoltda`.`venda_cliente` (`id`),
  CONSTRAINT `entrega_ibfk_2`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `alinhamentoltda`.`endereco` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`produto` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'identificador unico',
  `cd_produto` INT(10) NOT NULL COMMENT 'codigo do produto',
  `qt_produto` INT(255) NOT NULL COMMENT 'quantidade do produto',
  `dt_fabricado` DATE NOT NULL COMMENT 'data de fabricacao',
  `dt_validade` DATE NOT NULL COMMENT 'data de validade do produto',
  `in_refrigerado` TINYINT NOT NULL DEFAULT '0' COMMENT 'indentificador do produto',
  `nm_setor` VARCHAR(50) NOT NULL COMMENT 'nome do setor do produto',
  `id_fornecedor` INT NOT NULL COMMENT 'identificador do fornecedor do produto',
  PRIMARY KEY (`id`, `id_fornecedor`),
  INDEX `fk_fornecedor` (`id_fornecedor` ASC) ,
  CONSTRAINT `produto_ibfk_1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `alinhamentoltda`.`fornecedor` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 100
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`item_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`item_compra` (
  `id` INT NOT NULL auto_increment COMMENT 'identificador do item para compra',
  `qt_produto` INT(10) NOT NULL COMMENT 'quantidade de produtos',
  `nr_nota_fiscal` VARCHAR(50) NOT NULL COMMENT 'numero da nota fiscal',
  `id_compra_loja` INT NOT NULL COMMENT 'identificador da compra da loja',
  `id_produto` INT NOT NULL COMMENT 'identificador do produto comprado',
  `vl_item_compra` DECIMAL(7,2) NOT NULL COMMENT 'valor dos itens',
  PRIMARY KEY (`id`, `id_compra_loja`, `id_produto`),
  INDEX `fk_Itens_compra_compra_loja1_idx` (`id_compra_loja` ASC) ,
  INDEX `fk_Itens_compra_produto1_idx` (`id_produto` ASC) ,
  CONSTRAINT `fk_Itens_compra_compra_loja1`
    FOREIGN KEY (`id_compra_loja`)
    REFERENCES `alinhamentoltda`.`compra_loja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Itens_compra_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `alinhamentoltda`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `alinhamentoltda`.`item_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alinhamentoltda`.`item_venda` (
  `id` INT NOT NULL auto_increment COMMENT 'identificador do item para venda',
  `qt_produto` INT NOT NULL COMMENT 'quantidade de produto',
  `nm_nota_fiscal` VARCHAR(50) NOT NULL COMMENT 'numero da nota fiscal',
  `id_produto` INT NOT NULL COMMENT 'identificador do produto',
  `id_venda_cliente` INT NOT NULL COMMENT 'identificador da venda cliente',
  PRIMARY KEY (`id`, `id_produto`, `id_venda_cliente`),
  INDEX `fk_itens_venda_produto1_idx` (`id_produto` ASC) ,
  INDEX `fk_itens_venda_venda_cliente1_idx` (`id_venda_cliente` ASC) ,
  CONSTRAINT `fk_itens_venda_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `alinhamentoltda`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_venda_venda_cliente1`
    FOREIGN KEY (`id_venda_cliente`)
    REFERENCES `alinhamentoltda`.`venda_cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into estado(nm_estado, sg_uf) values
('São Paulo','SP'),
('Minas Gerais','MG'),
('Rio de Janeiro','RJ'),
('Paraná','PR');

insert into cidade(nm_cidade,id_estado) values
('São Paulo',1),
('São Bernado do Campo',1),
('São Jose dos Campos',1),
('Santo Andre',1),
('Uberaba',2),
('Belo Horizonte',2),
('Rio de Janeiro',3),
('Niterói',3),
('Petrópolis',3),
('Curitiba',4),
('Londrina',4),
('Foz do iguaçu',4);

insert into endereco(nr_cep,id_cidade,ds_logradouro, ds_complemento,nm_bairro) values
('05873-400',1,'Travessa João Marcelino dos Santos nº213','','Morro do Índio'),
('08220-041',1,'Viela Vinte e Cinco 15','Abaixo do escadao','Cidade Antônio Estevão de Carvalho'),
('09854-670',2,'Rua Ipê Amarelo n43','portao verde','Alvarenga'),
('09810-300',2,'Rua Francisco Carvalho Braga 321','','Assunção'),
('12229-330',3,'Rua Luiz Roberto Rodrigues 34','Acima da loja','Jardim Torrão de Ouro'),
('09271-460',4,'Rua Flamengo 30','','Parque Erasmo Assunção'),
('38041-368',5,'Rua Dezessete 15','Fabrica','Residencial Rio de Janeiro'),
('31920-135',6,'Rua Doutor Hamilton Carvalho 15','','Dom Joaquim'),
('22630-140',7,'Rua Lourenço Filho 443','','Barra da Tijuca'),
('24358-693',8,'Rua Doutor Cyro de Moraes 54','','Camboinhas'),
('24344-504',8,'Rua Betha Motta Vieira 21','','Engenho do Mato'),
('25675-221',9,'Vila José Carlos Espinola 34','','Quarteirão Ingelheim'),
('81560-170',10,'Rua Júlio Maito Sobrinho 56','Fabrica','Uberaba'),
('85862-614',11,'Rua Nelson Pancote N 21','rua de frente para a praça','Parque Residencial Lagoa Azul'),
('62868-203',11,'Avenida República Argentina 21','De frente pra praça','Vila Borges'),
('15358-453',12,'Rua Juarez Manoel Ramos Ribeiro 61','De frente pra praça','Sítio Cercado'),
('45832-129',12,'Rua José Lins do Rego 42','Fabrica','Boqueirão'),
('15258-303',12,'Rua Catulo da Paixão Cearense 87','','Jardim Naipi');

insert into cliente(nm_cliente, nm_sobrenome, nr_telefone, in_vip, id_endereco) values
('Joao','Augustino da Silva','1193245-1235',0,1),
('Gabriel','Teodoro Oliveira','1297865-8787',0,2),
('Roberto','da Silva Goncalves','13987689987',0,3),
('Andreia','Robertina Teodoro','32965427677',0,4),
('Silvia','dos Santos','32987222134',0,5),
('Elisangela','Ferreira Carvalho','2193348971',0,6);

insert into fornecedor(cd_fornecedor, nm_fornecedor, tp_tipo, qt_carros, id_endereco) values
(10,'Fabricas 2 irmaos',0,130,7),
(11,'Joaquin LTDA',0,50,8),
(12,'Thomas Fabrica',0,75,9),
(13,'Cacau Show',1,50,10),
(14,'Nestle',1,100,11),
(15,'Coca cola',1,100,12),
(17,'Cola cola',0,114,13);

insert into produto(cd_produto, qt_produto, dt_fabricado, dt_validade, in_refrigerado, nm_setor, id_fornecedor) values
(10,3230,'2023-04-23','2023-10-15',1,'Liquidos',1000),
(11,1230,'2023-04-10','2023-11-20',0,'Gondulas',1002),
(12,800,'2023-03-30','2024-03-15',0,'Gondulas',1003),
(13,2450,'2023-05-01','2024-01-05',0,'Gondulas',1004),
(14,4500,'2023-04-03','2024-01-15',0,'Gondulas',1005),
(15,3400,'2023-04-13','2023-12-28',1,'Liquidos',1006),
(16,3255,'2023-04-15','2023-11-30',1,'Liquidos',1001);

insert into loja(nm_loja, tp_loja, id_endereco) values
('Atacadao',0,14),
('Assai',0,15),
('Carrefour',0,16),
('Ayume',1,17),
('Sacolao Santo Irmao',3,18);

insert into compra_loja(vl_compra, id_fornecedor, id_loja) values
(23727.80,1000,1000),
(1787.34,1001,1001),
(1350.00,1002,1002),
(1679.80,1004,1003),
(2122.20,1005,1003);

insert into item_compra(qt_produto, nr_nota_fiscal,id_compra_loja, id_produto, vl_item_compra) values
(580,'8175327818570523',1,102,40.91),
(80,'8475955838370323',2,102,27.00),
(50,'8412957833570323',3,103,37.50),
(120,'2375927828970423',4,104,13.99),
(114,'8375957238270523',5,105,17.11);

insert into venda_cliente(vl_total_venda, id_loja,id_cliente) values
(450.25,1000,2),
(243.40,1002,3),
(837.20,1003,1),
(60.00,1003,4),
(1230.53,1004,1),
(3420.32,1001,5);

insert into item_venda(qt_produto, nm_nota_fiscal, id_produto, id_venda_cliente) values
(32,'817532781857200523',101,1002),
(15,'847332751257400523',102,1003),
(50,'819502111827620523',103,1001),
(4,'817732381857210523',104,1004),
(58,'817532781857270523',105,1001),
(89,'811572382847200523',106,1005);

-- select * from venda_cliente;
insert into entrega(tp_status, dt_entrega,id_venda_cliente,id_endereco) values
(0,'2023-05-05',1001,1),
(0,'2023-05-02',1002,2),
(1,'2023-05-03',1003,3),
(3,'2023-05-05',1004,4),
(3,'2023-05-05',1004,5),
(3,'2023-05-05',1004,6);

-- SHOW FULL COLUMNS FROM alinhamentoltda.fornecedor;

select * from information_schema.columns where table_schema = 'alinhamentoltda';

SELECT 
	TABLE_NAME, COLUMN_NAME, IS_NULLABLE, COLUMN_TYPE , COLUMN_KEY, EXTRA, CHARACTER_MAXIMUM_LENGTH, COLUMN_DEFAULT, COLUMN_COMMENT
FROM information_schema.columns
WHERE 
	table_schema = 'alinhamentoltda';
    
-- ------------------------------------------------------------- --
-- View, mostrar todos os produtos e seus fornecedores --------- --
-- ------------------------------------------------------------- --

CREATE OR REPLACE VIEW vw_produto_fornecedor as
SELECT 
	pro.id as 'produto', pro.cd_produto, pro.qt_produto, pro.dt_fabricado, pro.dt_validade, pro.in_refrigerado, pro.nm_setor, pro.id_fornecedor,
    forn.id as 'fornecedor', forn.cd_fornecedor, forn.nm_fornecedor, forn.tp_tipo, forn.qt_carros, forn.id_endereco
FROM 
	produto as pro, fornecedor as forn
WHERE
	forn.id = pro.id_fornecedor;

select * from vw_produto_fornecedor;

/*
SELECT 
	pr.cd_produto, qt_produto, dt_fabricado fabricado,dt_validade validade, in_refrigerado refrigerado, nm_setor setor, 
FROM 
	produto pr
INNER JOIN
	fornecedor fo
ON 
	pr.id_fornecedor = fo.id;
*/

-- ------------------------------------------------------------- --
-- View, mostrar fornecedores e seus endereços --
-- ------------------------------------------------------------- --

CREATE OR REPLACE VIEW vw_fornecedor_endereco as 
SELECT 
	forn.id as 'fornecedor', forn.cd_fornecedor, forn.nm_fornecedor, forn.tp_tipo, forn.qt_carros, forn.id_endereco,
    ende.id as 'endereco', ende.nr_cep ,ende.id_cidade ,ende.ds_logradouro ,ende.ds_complemento ,ende.nm_bairro 
FROM 
	fornecedor as forn, endereco as ende
WHERE 
    forn.id_endereco = ende.id;
    
select * from vw_fornecedor_endereco;

/*
SELECT 
	* 
FROM 
	fornecedor as fo 
INNER JOIN 
	endereco as en 
on 
	en.id = fo.id_endereco;
 */ 

-- ------------------------------------------------------------- --
-- View, mostrar clientes e seus endereços --
-- ------------------------------------------------------------- --

CREATE OR REPLACE VIEW vw_cliente_endereco as 
SELECT 
	clie.id as 'cliente', clie.nm_cliente, clie.nm_sobrenome, clie.nr_telefone, clie.in_vip, clie.id_endereco,
    ende.id as 'endereco', ende.nr_cep ,ende.id_cidade ,ende.ds_logradouro ,ende.ds_complemento ,ende.nm_bairro 
FROM 
	cliente as clie, endereco as ende
WHERE 
    clie.id_endereco = ende.id;
    
select * from vw_cliente_endereco;

/*
SELECT 
	* 
FROM 
	cliente as cl
INNER JOIN 
	endereco as en 
on 
	cl.id_endereco = en.id;
 */ 
 
-- ------------------------------------------------------------- --
-- View, mostrar entregas realizadas--
-- ------------------------------------------------------------- --

/*
CREATE OR REPLACE VIEW vw_entrega as 
SELECT 
	
FROM 
	cliente as clie, endereco as ende
WHERE 
    clie.id_endereco = ende.id;
    
select * from vw_cliente_endereco;
*/

SELECT 
	ent.id, ent.tp_status, ent.dt_entrega, -- entrega
    vc.vl_total_venda, vc.id_loja, vc.id_cliente, -- venda_cliente
    cl.nm_cliente, cl.nm_sobrenome, cl.nr_telefone, cl.in_vip, -- cliente 
    en.nr_cep, en.id_cidade, en.ds_logradouro, en.ds_complemento, en.nm_bairro -- endereco
    
FROM 
	entrega as ent 
INNER JOIN 
	venda_cliente as vc on vc.id = ent.id_venda_cliente
INNER JOIN 
	cliente as cl on cl.id = vc.id_cliente
INNER JOIN 
	endereco as en on en.id = cl.id_endereco;

select * from venda_cliente INNER JOIN cliente on venda_cliente.id_cliente = cliente.id;
 
-- ------------------------------------------------------------- --
-- procedure de insert endereco -------------------------------- --
-- ------------------------------------------------------------- --
DELIMITER $$
CREATE PROCEDURE insert_endereco(IN numero INT,IN cidade INT, IN logradouro varchar(100),IN complemento varchar(50), IN bairro varchar(50))
BEGIN
	insert into endereco(nr_cep,id_cidade,ds_logradouro, ds_complemento,nm_bairro) VALUES
    (numero, cidade, logradouro, complemento, bairro);
END $$
DELIMITER ;

CALL insert_endereco('05873-412',2,'Travessa João Marcelino nº213','acima da loja','Morro do Afro');

-- ------------------------------------------------------------- --
-- procedure de insert cliente -------------------------------- --
-- ------------------------------------------------------------- --

DELIMITER $$
CREATE PROCEDURE insert_cliente(in produto INT,IN quantidade INT, IN fabricado DATE,in validade DATE, in in_refrigerado TINYINT, in nm_setor varchar(50), in id_fornecedor INT)
BEGIN
	INSERT INTO cliente(nm_cliente, nm_sobrenome, nr_telefone, in_vip, id_endereco) VALUES
		(produto, quantidade, fabricado, validade, in_refrigerado, nm_setor, id_fornecedor);
END $$
DELIMITER ;

-- ------------------------------------------------------------- --
-- procedure de insert fornecedor -------------------------------- --
-- ------------------------------------------------------------- --
DELIMITER $$
CREATE PROCEDURE insert_fornecedor(in codigo INT,IN nome varchar(50), IN tipo TINYINT, in carros DATE, in endereco INT)
BEGIN
	INSERT INTO fornecedor(cd_fornecedor, nm_fornecedor, tp_tipo, qt_carros, id_endereco) VALUES
		(codigo, nome, tipo, carros, endereco);
END $$
DELIMITER ;

-- ------------------------------------------------------------- --
-- procedure de insert produto -------------------------------- --
-- ------------------------------------------------------------- --
DELIMITER $$
CREATE PROCEDURE insert_produto(in produto INT,IN quantidade INT, IN fabricado DATE,in validade DATE, in in_refrigerado TINYINT, in nm_setor varchar(50), in id_fornecedor INT)
BEGIN
	INSERT INTO produto(cd_produto, qt_produto, dt_fabricado, dt_validade, in_refrigerado, nm_setor, id_fornecedor) VALUES
		(produto, quantidade, fabricado, validade, in_refrigerado, nm_setor, id_fornecedor);
END $$
DELIMITER ;

-- ------------------------------------------------------------- --
-- procedure de venda  -------------------------------- --
-- ------------------------------------------------------------- --
DELIMITER $$
CREATE PROCEDURE venda_cliente(in total decimal(7,2),IN loja INT, IN cliente INT)
BEGIN
	INSERT INTO venda_cliente(vl_total_venda ,id_loja, id_produto, id_cliente) VALUES
		(total, loja, tipo, cliente);
END $$
DELIMITER ;


