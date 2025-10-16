INSERT INTO 
    clientes (id, nome, email, cidade, data_nascimento) 
VALUES 
    (6, 'Caio', 'caio@email.com', 'João Pinheiro', '2005-04-08');

SELECT
    p.id AS pedido_id,
    p.data_pedido,
    c.id AS cliente_id,
    c.nome AS cliente_nome
FROM
    pedidos p
LEFT JOIN clientes c
    ON p.id_cliente = c.id;

SELECT
    c.nome AS cliente_nome,
    c.id AS cliente_id,
    p.id AS pedido_id,
    p.data_pedido
FROM
    clientes c
LEFT JOIN pedidos p
    ON p.id_cliente = c.id;

SELECT
    p.id AS pedido_id,
    p.data_pedido,
    c.id AS cliente_id,
    c.nome AS cliente_nome
FROM
    pedidos p
INNER JOIN clientes c
    ON p.id_cliente = c.id;

SELECT
    p.id AS pedido_id,
    p.data_pedido,
    c.id AS cliente_id,
    c.nome AS cliente_nome
FROM
    clientes c
INNER JOIN pedidos p
    ON p.id_cliente = c.id;

SELECT
    p.id AS pedido_id,
    p.data_pedido,
    c.id AS cliente_id,
    c.nome AS cliente_nome
FROM
    pedidos p
RIGHT JOIN clientes c
    ON p.id_cliente = c.id;

SELECT
    p.id AS pedido_id,
    p.data_pedido,
    c.id AS cliente_id,
    c.nome AS cliente_nome
FROM
    clientes c
RIGHT JOIN pedidos p
    ON p.id_cliente = c.id;