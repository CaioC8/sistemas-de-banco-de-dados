CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE clientes( 
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    identificador VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    total_pedido DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
    id SERIAL PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO 
    produtos (nome, preco) 
VALUES
    ('Camiseta', 49.90),
    ('Caneca', 25.00),
    ('Caderno', 12.50),
    ('Mouse', 89.90),
    ('Teclado', 129.90),
    ('Fone', 79.90);

INSERT INTO 
    clientes (nome, email, identificador)
VALUES
    ('Ana Silva', 'ana@example.com', '2025001'),
    ('Bruno Costa', 'bruno@example.com', '2025002'),
    ('Carla Souza', 'carla@example.com', '2025003'),
    ('Daniel Reis', 'daniel@example.com', '2025004'),
    ('Elisa Moraes', 'elisa@example.com', '2025005');

INSERT INTO 
    pedidos (cliente_id, data_pedido, total_pedido)
VALUES
    (1, '2025-10-01', 74.90),
    (2, '2025-10-03', 89.90),
    (3, '2025-09-30', 75.00),
    (1, '2025-10-05', 79.90),
    (4, '2025-10-02', 129.90),
    (5, '2025-09-29', 50.00),
    (2, '2025-10-06', 49.90),
    (3, '2025-10-07', 179.80);

INSERT INTO 
    itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES
    (1, 1, 1, 49.90),
    (1, 2, 1, 25.00),
    (2, 4, 1, 89.90),
    (3, 2, 3, 25.00),
    (4, 6, 1, 79.90),
    (5, 5, 1, 129.90),
    (6, 3, 4, 12.50),
    (7, 1, 1, 49.90),
    (8, 5, 1, 129.90),
    (8, 1, 1, 49.90);

SELECT * FROM produtos;
SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM itens_pedido;

SELECT
    p.nome,
    SUM(ip.quantidade) AS total_vendido
FROM
    itens_pedido ip
JOIN produtos p 
    ON ip.produto_id = p.id
GROUP BY
    p.nome
ORDER BY
    total_vendido DESC;

SELECT
    c.nome,
    SUM(p.total_pedido) AS faturamento
FROM
    clientes c
JOIN pedidos p
    ON p.cliente_id = c.id
GROUP BY
    c.nome
ORDER BY
    faturamento DESC;