CREATE TABLE combustivel (
  combustivel_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  estoque_l NUMERIC(12,3) NOT NULL DEFAULT 0,
  CONSTRAINT combustivel_nome_uniq UNIQUE (nome)
);

CREATE TABLE funcionario (
  funcionario_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE venda (
  venda_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  data_hora TIMESTAMPTZ NOT NULL DEFAULT now(),
  funcionario_id INT REFERENCES funcionario(funcionario_id) ON DELETE SET NULL,
  total NUMERIC(12,2) NOT NULL CHECK (total >= 0)
);

CREATE TABLE venda_item (
  venda_item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  venda_id INT NOT NULL REFERENCES venda(venda_id) ON DELETE CASCADE,
  combustivel_id INT NOT NULL REFERENCES combustivel(combustivel_id),
  quantidade_l NUMERIC(12,3) NOT NULL CHECK (quantidade_l >= 0),
  preco_unitario NUMERIC(12,4) NOT NULL CHECK (preco_unitario >= 0)
);

CREATE INDEX idx_venda_data_hora ON venda (data_hora);
CREATE INDEX idx_venda_item_combustivel ON venda_item (combustivel_id);

INSERT INTO combustivel (nome, estoque_l) VALUES
('Gasolina', 10000),
('Etanol', 8000),
('Diesel', 15000);

INSERT INTO combustivel (nome, estoque_l) VALUES
('GNV', 950),
('Biodiesel', 500);

-- TESTE DE INSERÇÃO DUPLICADA
INSERT INTO combustivel (nome, estoque_l) VALUES
('Gasolina', 123);

INSERT INTO funcionario (nome, ativo) VALUES
('João Silva', true),
('Maria Oliveira', true),
('Carlos Souza', false);

INSERT INTO venda (data_hora, funcionario_id, total) VALUES
(NOW(), 1, 150.75),
(NOW(), 2, 200.00);

INSERT INTO venda_item (venda_id, combustivel_id, quantidade_l, preco_unitario) VALUES
(1, 1, 20.0, 7.5375),
(1, 2, 10.0, 5.0000),
(2, 3, 30.0, 6.6667);

-- TESTE DE INSERÇÃO COM VALOR NEGATIVO
INSERT INTO venda (data_hora, funcionario_id, total) VALUES
(NOW(), 1, -100.00);

SELECT
  c.combustivel_id,
  c.nome,
  c.estoque_l
FROM
  combustivel AS c
ORDER BY c.estoque_l DESC;

-- CONSULTAR COMBUSTÍVEIS COM ESTOQUE MAIOR QUE 1000 LITROS
SELECT
    c.combustivel_id,
    c.nome,
    c.estoque_l
FROM
    combustivel AS c
WHERE
    c.estoque_l > 1000
ORDER BY 
    c.estoque_l DESC;

SELECT * FROM venda_item;

INSERT INTO venda (data_hora, funcionario_id, total) VALUES
  ('2025-11-01 09:15:00-03', 1, 210.04),
  ('2025-11-01 10:05:00-03', 2, 150.12),
  ('2025-11-01 11:00:00-03', 1,  50.15),
  ('2025-11-01 11:30:00-03', 1,  80.28),
  ('2025-11-01 11:32:00-03', 2, 110.16),
  ('2025-11-01 12:32:00-03', 2, 217.50);

INSERT INTO venda_item (venda_id, combustivel_id, quantidade_l, preco_unitario) VALUES
  (4, 1, 35.6, 5.9),
  (5, 2, 41.7, 3.6),
  (6, 1,  8.5, 5.9),
  (7, 2, 22.3, 3.6),
  (8, 2, 30.6, 3.6),
  (9, 3, 37.5, 5.8);

-- CONSULTAR TOTAL VENDIDO POR FUNCIONÁRIO EM NOVEMBRO DE 2025
SELECT
  f.nome,
  SUM(v.total) as total_funcionario
FROM
  funcionario f
JOIN
  venda v
  ON v.funcionario_id = f.funcionario_id
WHERE
    v.data_hora >= '2025-11-01 00:00:00-03'
    AND v.data_hora < '2025-12-01 00:00:00-03'
GROUP BY
  f.nome
ORDER BY
  total_funcionario DESC;

-- CONSULTAR COMBUSTÍVEIS COM VENDAS MAIORES QUE R$ 400,00
SELECT
  c.combustivel_id,
  c.nome,
  ROUND(SUM(vi.quantidade_l * vi.preco_unitario), 2)::NUMERIC(12,2) AS total_vendido
FROM 
  combustivel c
JOIN venda_item vi
  ON vi.combustivel_id = c.combustivel_id
GROUP BY
  c.combustivel_id, c.nome
HAVING
  ROUND(SUM(vi.quantidade_l * vi.preco_unitario), 2)::NUMERIC(12,2) > 400
ORDER BY
  total_vendido DESC;

-- CRIAR UMA VIEW PARA RESUMO DE VENDAS POR COMBUSTÍVEL
CREATE VIEW resumo_venda_combustivel AS
SELECT
  c.combustivel_id,
  c.nome,
  SUM(vi.quantidade_l) AS litros_vendidos,
  ROUND(SUM(vi.quantidade_l * vi.preco_unitario), 2)::NUMERIC(12,2) AS valor_vendido
FROM 
  combustivel c
JOIN venda_item vi
  ON vi.combustivel_id = c.combustivel_id
GROUP BY 
  c.combustivel_id, c.nome
ORDER BY
  valor_vendido DESC;

-- ATUALIZAR A VIEW PARA INCLUIR VALOR MÉDIO POR LITRO VENDIDO
CREATE OR REPLACE VIEW resumo_venda_combustivel AS
SELECT
  c.combustivel_id,
  c.nome,
  SUM(vi.quantidade_l) AS litros_vendidos,
  ROUND(SUM(vi.quantidade_l * vi.preco_unitario), 2)::NUMERIC(12,2) AS valor_vendido,
  ROUND(ROUND(SUM(vi.quantidade_l * vi.preco_unitario), 2)::NUMERIC(12,2) / NULLIF(SUM(vi.quantidade_l), 0), 2) AS valor_medio_litro
FROM 
  combustivel c
JOIN venda_item vi
  ON vi.combustivel_id = c.combustivel_id
GROUP BY 
  c.combustivel_id, c.nome
ORDER BY
  valor_vendido DESC;

SELECT * FROM resumo_venda_combustivel;

-- CONSULTAR FUNCIONÁRIOS SEM VENDAS REGISTRADAS USANDO LEFT JOIN E RIGHT JOIN
SELECT 
    f.nome,
    v.total
FROM
    funcionario f
LEFT JOIN
    venda v 
ON f.funcionario_id = v.funcionario_id
WHERE
    v.total IS NULL;

-- CONSULTAR FUNCIONÁRIOS SEM VENDAS REGISTRADAS USANDO RIGHT JOIN
SELECT 
    f.nome,
    v.total
FROM
    venda v
RIGHT JOIN
    funcionario f 
ON f.funcionario_id = v.funcionario_id
WHERE
    v.total IS NULL;