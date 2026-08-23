USE mind;

-- 1. INSERTS NA TABELA: usuario (Hierarquia de usuários)
INSERT INTO usuario (nome, email, senha, nivel, id_superior) VALUES
('Carlos Andrade', 'carlos.admin@mind.com', 'hash_senha_123', 3, NULL),
('Mariana Lima', 'mariana.sup@mind.com', 'hash_senha_456', 2, 1),
('Roberto Alves', 'roberto.analista@mind.com', 'hash_senha_789', 1, 2),
('Fernanda Costa', 'fernanda.operadora@mind.com', 'hash_senha_101', 0, 2),
('Lucas Martins', 'lucas.operador@mind.com', 'hash_senha_202', 0, 2);

-- 2. INSERTS NA TABELA: clp (Controladores Lógicos Programáveis vinculados aos usuários)
INSERT INTO clp (modelo, central_processamento, memoria_ram, fonte_alimentacao, id_usuario) VALUES
('Siemens S7-1200', 'ARM Cortex-A9', 1024, '24VDC', 4),
('Rockwell CompactLogix', 'Dual Core 1GHz', 2048, '220VAC', 5),
('Schneider Modicon M241', 'MIPS 500MHz', 512, '24VDC', 4),
('ABB AC500', 'ARM32', 2048, '110VAC', 3);

-- 3. INSERTS NA TABELA: alerta (Vinculados aos CLPs)
INSERT INTO alerta (descricao, prioridade, id_clp) VALUES
('Uso normal do sistema', 0, 1),
('Uso moderado de CPU acima de 70%', 1, 1),
('Perda de pacotes detectada na rede', 2, 2),
('Falha crítica de comunicação no CLP', 3, 3),
('Temperatura do gabinete elevada', 2, 4);

-- 4. INSERTS NA TABELA: deteccao (Métricas de desempenho vinculadas aos CLPs)
INSERT INTO deteccao (central_processsamento, ram, scan_time, perda_pacote, id_clp) VALUES
(25.50, 42.10, 12.30, 0.00, 1),
(68.20, 75.40, 24.10, 0.50, 1),
(92.80, 88.90, 45.00, 3.20, 2),
(99.90, 95.00, 80.50, 12.80, 3),
(15.10, 30.00, 10.00, 0.00, 4);

-- 5. INSERTS NA TABELA: input (Sinais de Entrada)
INSERT INTO input (descricao, id_clp) VALUES
('Sensor Optico de Presenca - Esteira 1', 1),
('Sensor de Temperatura Interna', 1),
('Botao de Emergencia - Painel Principal', 1),
('Chave Fim de Curso - Atuador Z', 2),
('Sensor de Pressao Hidraulica', 2),
('Medidor de Vazao de Agua', 3);

-- 6. INSERTS NA TABELA: output (Sinais de Saída)
INSERT INTO output (descricao, id_clp) VALUES
('Motor Principal Esteira 1', 1),
('Luz Indicadora de Status (Verde)', 1),
('Sirene de Alarme Sonoro', 2),
('Valvula Solenoide de Descarga', 2),
('Relé de Bloqueio de Segurança', 3),
('Inversor de Frequencia Bomba 2', 4);