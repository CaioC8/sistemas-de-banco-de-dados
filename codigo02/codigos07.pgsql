CREATE DATABASE empresa;

CREATE TABLE fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    site VARCHAR(100),
    telefone VARCHAR(15)
);

CREATE TABLE produtos(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(12, 2),
    estoque INT DEFAULT 0,
    fornecedor_id INT NOT NULL,
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

CREATE TABLE clientes(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cidade VARCHAR(150),
    data_nascimento DATE
)

CREATE TABLE pedidos(
    id SERIAL PRIMARY KEY,
    data_pedido DATE DEFAULT CURRENT_DATE,
    valor_total NUMERIC(12, 2),
    cliente_id INT,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido(
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario NUMERIC(12, 2) NOT NULL,
    CONSTRAINT pk_itens_pedido PRIMARY KEY (pedido_id, produto_id),
    CONSTRAINT fk_item_pedido_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    CONSTRAINT fk_item_pedido_produto FOREIGN KEY (produto_id) REFERENCES produtos(id)
);