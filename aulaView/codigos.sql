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

SELECT
    p.nome,
    SUM(ip.quantidade * ip.preco_unitario) AS total_vendido
FROM
    produtos p
JOIN itens_pedido ip
    ON ip.produto_id = p.id
GROUP BY
    p.nome
ORDER BY
    total_vendido DESC;

CREATE VIEW vw_total_vendas_produtos AS
SELECT
    p.nome,
    SUM(ip.quantidade * ip.preco_unitario) AS total_vendido
FROM
    produtos p
JOIN itens_pedido ip
    ON ip.produto_id = p.id
GROUP BY
    p.nome
ORDER BY
    total_vendido DESC;

SELECT vw_total_vendas_produtos.* FROM vw_total_vendas_produtos;

CREATE VIEW vw_faturamento_clientes AS
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

SELECT vw_faturamento_clientes.* FROM vw_faturamento_clientes;

CREATE VIEW vw_total_diario AS
SELECT
    data_pedido,
    SUM(total_pedido) AS total_diario
FROM
    pedidos
GROUP BY
    data_pedido
ORDER BY
    data_pedido;

SELECT vw_total_diario.* FROM vw_total_diario;

CREATE VIEW vw_soma_itens_por_pedido AS
SELECT
    p.id,
    c.nome,
    SUM(ip.quantidade * ip.preco_unitario) AS total_itens
FROM
    pedidos p
JOIN itens_pedido ip
    ON ip.pedido_id = p.id
JOIN clientes c
    ON p.cliente_id = c.id
GROUP BY
    p.id,
    c.nome
ORDER BY
    p.id;

SELECT vw_soma_itens_por_pedido.* FROM vw_soma_itens_por_pedido;