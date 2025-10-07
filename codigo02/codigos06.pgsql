SELECT * FROM vendas_itens2;


SELECT
    venda_id,
    ROUND(SUM(quantidade * valor_unitario), 2) AS total_venda,
    data_venda
FROM
    vendas_itens2
GROUP BY
    venda_id,
    data_venda
ORDER BY
    total_venda DESC;


SELECT * FROM vendas_itens2 WHERE unidade LIKE '%U';


SELECT
    *
FROM
    vendas_itens2
WHERE
    unidade LIKE '%G%'
    OR
    unidade LIKE '%g%'
ORDER BY
    valor_unitario ASC
LIMIT 20;


ALTER TABLE vendas_itens2 ADD COLUMN custo_total NUMERIC(12, 2);


UPDATE vendas_itens2 SET custo_total = ROUND((quantidade * valor_unitario), 2);


SELECT
    venda_id,
    SUM(custo_total) AS total_venda,
    data_venda
FROM
    vendas_itens2
GROUP BY
    venda_id,
    data_venda
ORDER BY
    total_venda DESC;


SELECT
    count(*) AS total_registros
FROM
    vendas_itens2;


SELECT
    count(DISTINCT venda_id) AS qtde_vendas
FROM
    vendas_itens2;


SELECT
    count(DISTINCT produto_id) AS qtde_produtos
FROM
    vendas_itens2;


SELECT
    count(produto_id) AS qtde_produtos
FROM
    vendas_itens2
WHERE
    produto_id = 1;


SELECT
    venda_id,
    count(produto_id) AS qtde_produtos
FROM
    vendas_itens2
WHERE
    produto_id = 1
GROUP BY
    venda_id;


SELECT
    produto_id,
    SUM(quantidade) AS total_unidade_vendidas,
    SUM(custo_total) AS total_venda,
    count(DISTINCT venda_id)
FROM
    vendas_itens2
GROUP BY
    produto_id
ORDER BY
    produto_id;


SELECT
    venda_id,
    SUM(custo_total) AS total_venda,
    data_venda
FROM
    vendas_itens2
GROUP BY
    venda_id,
    data_venda
HAVING
    SUM(custo_total) > 500
ORDER BY
    total_venda ASC;
    

UPDATE vendas_itens2 SET custo_total = custo_total * 1.05;


SELECT * FROM vendas_itens2;