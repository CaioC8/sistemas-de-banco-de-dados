-- Ativa foregins keys no inicio do script
PRAGMA foregin_keys = NO;

-- Tabela usuario

CREATE TABLE usuario(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL,
    senha TEXT NOT NULL
);

-- Tabela cliente
CREATE TABLE cliente(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    telefone TEXT,
    usuario_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

-- Tabela produto
CREATE TABLE produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    preco REAL NOT NULL CHECK (preco >= 0),
    nome TEXT NOT NULL,
    descricao TEXT
);

-- Tabela venda
CREATE TABLE venda(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    usuario_id INTEGER NOT NULL UNIQUE,
    cliente_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE SET NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE SET NULL
);

-- Tabela venda_produto tabela associativa N:M produto <-> venda
CREATE TABLE venda_produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    -- PRIMARY KEY (venda_id, produto_id), -- chave composta
    FOREIGN KEY (venda_id) REFERENCES venda(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE
);

-- Inserir dados na tablea usuario
INSERT INTO usuario (nome, email, senha) VALUES ('Caio', 'caio@email.com', '123');
INSERT INTO usuario (nome, email, senha) VALUES ('Rafael', 'rafael@email.com', '456');
INSERT INTO usuario (nome, email, senha) VALUES ('Lucas', 'lucas@email.com', '789');

-- Inserir dados na tablea cliente
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Caio César', '123456', 1);
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Rafael Silva', '654321', 2);
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Lucas Borges', '098765', 3);

-- Inserir dados na tablea produto
INSERT INTO produto (preco, nome, descricao) VALUES (12.9, 'Faca', 'Faca tramontina');
INSERT INTO produto (preco, nome, descricao) VALUES (15.5, 'Colher de pau', 'Colher de pau, perfeita para fazer doce de leite');
INSERT INTO produto (preco, nome, descricao) VALUES (100.99, 'Panela de pressão', 'Panela de pressão tramontina, melhor do mercado');

INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('12/09', 1, 1);
INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('27/04', 2, 2);
INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('05/11', 3, 3);

-- Altera data da tabela venda
UPDATE venda SET data = '2025-09-12' WHERE usuario_id = 1;
UPDATE venda SET data = '2025-04-27' WHERE usuario_id = 2;
UPDATE venda SET data = '2025-11-05' WHERE usuario_id = 3;

-- Inserir dados na tablea venda_produto
INSERT INTO venda_produto (quantidade, venda_id, produto_id) VALUES (2, 1, 1);
INSERT INTO venda_produto (quantidade, venda_id, produto_id) VALUES (1, 1, 2);
INSERT INTO venda_produto (quantidade, venda_id, produto_id) VALUES (1, 2, 3);
INSERT INTO venda_produto (quantidade, venda_id, produto_id) VALUES (3, 2, 2);
INSERT INTO venda_produto (quantidade, venda_id, produto_id) VALUES (4, 3, 1);
INSERT INTO venda_produto (quantidade, venda_id, produto_id) VALUES (1, 3, 3);

-- Busca todos os dados de um usuario
SELECT
    u.id AS usuario_id,
    u.nome AS usuario_nome,
    u.email,
    u.senha,
    c.id AS cliente_id,
    c.nome AS cliente_nome,
    c.telefone
FROM
    usuario u
INNER JOIN
    cliente c ON u.id = c.usuario_id;

ALTER TABLE venda_produto ADD COLUMN preco_unitario REAL DEFAULT 0.0;

UPDATE venda_produto SET preco_unitario = 12.9 WHERE produto_id = 1;
UPDATE venda_produto SET preco_unitario = 15.5 WHERE produto_id = 2;
UPDATE venda_produto SET preco_unitario = 100.99 WHERE produto_id = 3;

-- Resposta:
-- 1|Caio|caio@email.com|123|1|Caio César|123456
-- 2|Rafael|rafael@email.com|456|2|Rafael Silva|654321
-- 3|Lucas|lucas@email.com|789|3|Lucas Borges|098765

-- UPDATE usuario SET nome = 'João' WHERE id = 3;

-- DROP TABLE produto;

-- DELETE FROM produto WHERE id = 5;
-- DELETE FROM produto WHERE id = 6;
-- DELETE FROM produto WHERE id = 7;
-- DELETE FROM produto WHERE id = 8;

-- DELETE FROM produto WHERE id IN (4, 5, 6, 7, 8);