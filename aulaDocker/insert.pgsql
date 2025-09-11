INSERT INTO participante(nome, email, telefone) 
VALUES (
    'Caio',
    'caio@email.com',
    '34 9 9999-9999'
), (
    'Rafael',
    'rafael@email.com',
    '34 9 8888-8888'
), (
    'Gabriel',
    'gabriel@email.com',
    '34 9 7777-7777'
);

INSERT INTO evento(nome, descricao, local, data) 
VALUES (
    'Evento 1',
    'Evento muito fera',
    'Rua A, 12',
    '2025-10-22'
), (
    'Evento 2',
    'Evento muito legal',
    'Rua B, 655',
    '2025-08-10'
), (
    'Evento 3',
    'Evento muito bom',
    'Rua C, 87',
    '2025-05-03'
);

INSERT INTO inscricao(id_evento, id_participante, data_inscricao, status) 
VALUES (
    1,
    1,
    '2025-09-22',
    'confirmada'
), (
    2,
    2,
    '2025-07-10',
    'pendente'
), (
    2,
    2,
    '2025-04-03',
    'cancelada'
);

INSERT INTO pagamento(id_inscricao, valor, data_pagamento, status) 
VALUES (
    1,
    150.0,
    '2025-09-22',
    'pago'
), (
    2,
    76.9,
    '2025-07-10',
    'pendente'
), (
    3,
    65.77,
    '2025-04-03',
    'cancelado'
);

SELECT * FROM participante;
SELECT * FROM evento;
SELECT * FROM inscricao;
SELECT * FROM pagamento;