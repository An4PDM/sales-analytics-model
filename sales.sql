
CREATE TABLE setor (
	idS SERIAL PRIMARY KEY,
	nome VARCHAR(45),
	chefe_id INT
);

CREATE TABLE funcionario (
	idF SERIAL PRIMARY KEY,
	nome VARCHAR(45) NOT NULL,
	nascimento DATE NOT NULL,
	setor_id INT,
	FOREIGN KEY (setor_id) REFERENCES setor(idS)
);

-- Criando ENUM para cargo de funcionários
CREATE TYPE cargo_enum AS ENUM('Assistente', 'Gerente', 'Chefe','Analista');
ALTER TABLE funcionario ADD COLUMN cargo cargo_enum; 

-- Criando FK para setor (chefe_id)
ALTER TABLE setor ADD FOREIGN KEY (chefe_id) REFERENCES funcionario(idF);

CREATE TABLE categoria (
	idCateg SERIAL PRIMARY KEY,
	nome VARCHAR(45)
);

CREATE TABLE produto (
	idP SERIAL PRIMARY KEY,
	nome VARCHAR(45),
	preco DECIMAL(10,2),
	estoque_minimo INT,
	quantidade_atual INT,
	idCateg INT,
	FOREIGN KEY (idCateg) REFERENCES categoria(idCateg)
);

CREATE TABLE cliente (
	idC SERIAL PRIMARY KEY,
	nome VARCHAR(45) NOT NULL,
	nascimento DATE
);

-- Criando ENUM para pedido
CREATE TYPE pagamento_enum AS ENUM ('cartao', 'dinheiro', 'pix');

CREATE TABLE pedido (
	idP SERIAL PRIMARY KEY,
	modo_pagamento pagamento_enum NOT NULL,
	total DECIMAL(10,2),
	idC INT,
	FOREIGN KEY (idC) REFERENCES cliente(idC)
);

CREATE TABLE produto_pedido (
	idPedido INT,
	idProduto INT,
	quantidade INT NOT NULL,
	PRIMARY KEY (idPedido, idProduto),
	CONSTRAINT fk_pedido_produto_pedido FOREIGN KEY (idPedido) REFERENCES pedido(idP),
	CONSTRAINT fk_produto_produto_pedido FOREIGN KEY (idProduto) REFERENCES produto(idP)
);

-- Inserção de dados
-- Tabela setor
INSERT INTO setor (nome) VALUES ('Financeiro'), ('RH'), ('Vendas');
SELECT * FROM setor;

-- tabela funcionario
INSERT INTO funcionario (nome, nascimento, setor_id, cargo) VALUES 
							('Ana Machado', '2001-08-12', 2, 'Chefe'),
							('Maria Fatima', '1984-06-23', 2, 'Assistente'),
							('Bruno Guimaraes', '1990-07-30', 2, 'Assistente'),
							('Luana Portinari', '2000-12-20', 2, 'Analista'),
							('Matheus Jule', '1980-10-20', 2, 'Analista'),
							('Katia Silva', '1996-09-20', 3, 'Chefe'),
							('Luiz Souza', '1998-09-26', 3, 'Analista'),
							('Marisa Loures', '1994-10-11', 3, 'Assistente'),
							('Carlos Souza', '1988-09-16', 3, 'Analista'),
							('Lisa Martins', '1980-10-02', 4, 'Chefe'),
							('Alan Sousa', '1990-05-10', 4, 'Analista'),
							('Nanda Sevilla', '1988-10-12', 4, 'Analista'),
							('Katia Silva', '1996-09-20', 4, 'Assistente'),
							('Bernadete Massi', '1986-09-06', 4, 'Assistente'),
							('Julio Cesario', '1994-02-01', 4, 'Assistente'),
							('Carla Levan', '1988-04-30', 4, 'Analista');
							
-- Tabela categoria
INSERT INTO categoria (nome) VALUES ('Eletrônicos'), ('Roupas'), ('Livros'), ('Alimentos');

-- Tabela produto
INSERT INTO produto (nome, preco, estoque_minimo, quantidade_atual, idCateg) VALUES 
				('Notebook', 4580.90, 30, 18, 1),
				('Camisa', 19.99, 11, 64, 2),
				('Livro A', 45.90, 19, 73, 3),
				('Livro B', 15.50, 18, 79, 3),
				('Chocolate', 25.80, 13, 78, 4),
				('Celular', 3200, 19, 11, 1),
				('Calça', 89.99, 11, 61, 2),
				('Tablet', 470, 12, 32, 1),
				('Fone', 30.90, 5, 17, 1),
				('Sapato', 220.90, 15, 43, 2),
				('TV', 3500.99, 10, 55, 1),
				('Smartwatch', 59.90, 6, 9, 1);
				
-- Tabela cliente
INSERT INTO cliente (nome, nascimento) VALUES 
				  ('João', '1985-10-12'),
				  ('Paula', '1997-12-16'),
				  ('Ricardo', '1972-03-28'),
				  ('Aline', '1989-12-31'),
				  ('Sérgio', '1977-07-11'),
				  ('Juliana', '1971-11-10'),
				  ('Renato', '1998-10-27'),
				  ('Clara', '1985-08-19'),
				  ('Thiago', '1982-08-10'),
				  ('Vanessa', '1990-08-17'),
				  ('Eduardo', '1987-04-06'),
				  ('Larissa', '1985-11-10'),
				  ('Bruno', '1977-11-09'),
				  ('Carla', '1999-02-17'),
				  ('Felipe', '1989-06-24');

-- Tabela pedido
INSERT INTO pedido (modo_pagamento, idC) VALUES 
				  ('cartao', 1),
				  ('dinheiro', 2),
				  ('pix', 3),
				  ('dinheiro', 4),
				  ('pix', 5),
				  ('pix', 6),
				  ('dinheiro', 7),
				  ('dinheiro', 8),
				  ('pix', 9),
				  ('pix', 10),
				  ('pix', 11),
				  ('pix', 12),
				  ('dinheiro', 13),
				  ('cartao', 14),
				  ('pix', 15);

-- Tabela produto_pedido
INSERT INTO produto_pedido (idPedido, idProduto, quantidade) VALUES 
				  (1, 5, 4),
				  (1, 7, 4),
				  (2, 8, 4),
				  (2, 10, 2),
				  (2, 9, 4),
				  (3, 1, 2),
				  (4, 1, 2),
				  (5, 3, 4),
				  (5, 9, 1),
				  (5, 11, 1),
				  (6, 11, 2),
				  (6, 2, 2),
				  (7, 2, 3),
				  (7, 1, 1),
				  (8, 1, 2),
				  (9, 1, 2),
				  (10, 3, 4),
				  (10, 9, 1),
				  (11, 11, 1),
				  (12, 11, 2),
				  (13, 2, 2),
				  (14, 2, 3),
				  (15, 2, 4);


-- Consultas
SELECT * FROM produto; 
SELECT * FROM pedido;
SELECT * FROM setor; 
SELECT * FROM funcionario; 
SELECT * FROM cliente;
SELECT * FROM categoria; 
SELECT * FROM produto_pedido;


-- Calculo do total gasto por cada cliente
WITH preco_quantidade AS 
	(
	SELECT c.nome, (p.preco * pp.quantidade) AS preco FROM produto p
	INNER JOIN produto_pedido pp ON p.idP = pp.idProduto
	INNER JOIN pedido ped ON pp.idPedido = ped.idP
	INNER JOIN cliente c ON c.idC = ped.idC
	) SELECT nome, SUM(preco) AS total FROM preco_quantidade
	  GROUP BY nome;

-- Gatilho para inserir o total automaticamente nos pedidos

