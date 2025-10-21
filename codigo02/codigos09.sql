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

SELECT
    p.id AS produto_id,
    p.nome AS produto_nome,
    SUM(ip.quantidade) AS quantidade_vendida
FROM
    produtos p
LEFT JOIN 
    itens_pedido ip
ON 
    ip.id_produto = p.id
GROUP BY
    p.id,
    p.nome
ORDER BY
    p.id ASC;

SELECT * FROM itens_pedido ORDER BY id_produto;

SELECT
    ip.id_pedido,
    ip.id_produto,
    p.nome AS produto_nome,
    ip.quantidade,
    ip.preco_unitario
FROM
    itens_pedido ip
INNER JOIN produtos p
    ON ip.id_produto = p.id
ORDER BY
    ip.id_pedido;