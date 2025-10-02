SELECT * FROM vendas_itens2 ORDER BY produto_id;


SELECT
    venda_id,
    ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS total_vendas
FROM
    vendas_itens2
GROUP BY
    venda_id
ORDER BY
    venda_id;


SELECT
    ROUND(AVG(total_vendas)::numeric, 2) AS media_total_vendas
FROM
    (
    SELECT
        venda_id,
        ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS total_vendas
    FROM
        vendas_itens2
    GROUP BY
        venda_id
    ) 
AS 
    total_vendas;


SELECT
    MIN(total_vendas) AS menor_valor_venda,
    MAX(total_vendas) AS maior_valor_venda
FROM
    (
    SELECT
        venda_id,
        ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS total_vendas
    FROM
        vendas_itens2
    GROUP BY
        venda_id
    )
AS
    total_vendas;


SELECT
    venda_id,
    valor_menor_venda
FROM 
    (
    SELECT
        venda_id,
        ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS valor_menor_venda
    FROM
        vendas_itens2
    GROUP BY
        venda_id
    )
AS
    vendas_totais
WHERE
    valor_menor_venda = (
        SELECT
            MIN(valor_menor_venda)
        FROM
            (
            SELECT
                venda_id,
                ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS valor_menor_venda
            FROM
                vendas_itens2
            GROUP BY
                venda_id
            ) 
        AS
            venda_minima
    );


SELECT
    venda_id,
    valor_maior_venda
FROM 
    (
    SELECT
        venda_id,
        ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS valor_maior_venda
    FROM
        vendas_itens2
    GROUP BY
        venda_id
    )
AS
    vendas_totais
WHERE
    valor_maior_venda = (
        SELECT
            MAX(valor_maior_venda)
        FROM
            (
            SELECT
                venda_id,
                ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS valor_maior_venda
            FROM
                vendas_itens2
            GROUP BY
                venda_id
            ) 
        AS
            venda_minima
    );


SELECT 
    produto_id,
    ROUND(SUM(quantidade * valor_unitario)::numeric, 2) AS total_vendas,
    ROUND(SUM(quantidade)::numeric, 2) AS qtde_total,
    ROUND((SUM(quantidade * valor_unitario) / SUM(quantidade))::numeric, 4) AS valor_medio_unidade
FROM
    vendas_itens2
GROUP BY
    produto_id
ORDER BY
    produto_id;


SELECT 
    produto_id,
    ROUND(total_vendas::numeric, 2) AS total_vendas,
    ROUND(qtde_total::numeric, 2) AS qtde_total,
    ROUND((total_vendas / NULLIF(qtde_total, 0))::numeric, 4) AS valor_medio_unidade
FROM
    (
        SELECT
            produto_id,
            SUM(quantidade * valor_unitario) AS total_vendas,
            SUM(quantidade) AS qtde_total
        FROM 
            vendas_itens2
        GROUP BY
            produto_id
    )
AS
    variacao_media_valor
ORDER BY
    produto_id;