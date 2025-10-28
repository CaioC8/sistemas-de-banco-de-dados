SELECT 
    pc.pessoa_id,
    p.nome,
    p.cpf,
    p.data_nascimento,
    p.telefone,
    p.email,
    p.endereco,
    pc.numero_cartao,
    pc.data_cadastro
FROM 
    pessoa p
JOIN paciente pc
    ON pc.pessoa_id = p.id;

SELECT 
    m.pessoa_id,
    p.nome,
    p.cpf,
    p.data_nascimento,
    p.telefone,
    p.email,
    p.endereco,
    m.crm,
    m.especialidade
FROM 
    pessoa p
JOIN medico m
    ON m.pessoa_id = p.id;

SELECT
    p.id AS pessoa_id,
    p.nome,
    p.cpf,
    p.email,
    c.data_consulta
FROM 
    pessoa p
LEFT JOIN consulta c
    ON c.paciente_id = p.id
WHERE
    c.paciente_id IS NULL;

SELECT 
    p.id AS pessoa_id,
    p.nome,
    p.cpf,
    pc.numero_cartao
FROM 
    pessoa p
JOIN paciente pc
    ON pc.pessoa_id = p.id
LEFT JOIN consulta c
    ON c.paciente_id = p.id
WHERE
    c.paciente_id IS NULL;

ALTER TABLE paciente ALTER COLUMN numero_cartao SET NOT NULL;
ALTER TABLE paciente ADD CONSTRAINT uq_paciente_numero_cartao UNIQUE (numero_cartao);
ALTER TABLE medico ALTER COLUMN crm SET NOT NULL;
ALTER TABLE medico ADD CONSTRAINT uq_medico_crm UNIQUE (crm);
ALTER TABLE pessoa ALTER COLUMN data_nascimento SET NOT NULL;