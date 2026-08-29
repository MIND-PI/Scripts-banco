USE mind;

-- 1. Tabela: usuario
INSERT INTO usuario (nome, email, senha, nivel, id_superior) VALUES
('Carlos Silva', 'carlos.silva@mind.com', 'hash_senha_123', 3, NULL), -- Administrador Geral
('Ana Oliveira', 'ana.oliveira@mind.com', 'hash_senha_456', 2, 1),    -- Gerente de Infraestrutura
('Bruno Costa', 'bruno.costa@mind.com', 'hash_senha_789', 1, 2),     -- Operador
('Mariana Souza', 'mariana.souza@mind.com', 'hash_senha_321', 0, 2); -- Usuário Leitor

-- 2. Tabela: clp
INSERT INTO clp (modelo, central_processamento, memoria_ram, fonte_alimentacao, id_usuario) VALUES
('Siemens S7-1200', 'CPU 1214C DC/DC/DC', 125, '24VDC', 2),
('Rockwell Micro850', '2080-LC50-24QBB', 256, '24VDC', 3),
('Schneider Modicon M221', 'TM221CE16T', 512, '220VAC', 3);

-- 3. Tabela: recurso
INSERT INTO recurso (nome_recurso, unidade_medida, descricao) VALUES
('Uso de CPU', '%', 'Percentual de processamento utilizado pelo CLP'),
('Uso de Memória RAM', '%', 'Percentual de memória temporária consumida'),
('Tempo de Scan', 'ms', 'Tempo de ciclo de execução da varredura'),
('Perda de Pacotes', '%', 'Taxa de descarte de pacotes de rede');

-- 4. Tabela: recurso_monitorado (estatus: 1 = Ativo, 2 = Inativo)
INSERT INTO recurso_monitorado (id_clp, id_recurso, estatus) VALUES
(1, 1, 1), -- CLP 1 monitora CPU
(1, 2, 1), -- CLP 1 monitora RAM
(1, 3, 1), -- CLP 1 monitora Scan Time
(2, 1, 1), -- CLP 2 monitora CPU
(2, 4, 1), -- CLP 2 monitora Perda de Pacotes
(3, 1, 2); -- CLP 3 com monitoramento inativo

-- 5. Tabela: alerta (prioridade: 0 = Baixa, 1 = Média, 2 = Alta, 3 = Crítica)
INSERT INTO alerta (descricao, prioridade, id_clp) VALUES
('Aviso de rotina: Inicialização do sistema concluída', 0, 1),
('Uso de memória acima de 80%', 1, 1),
('Tempo de scan acima do limite operacional (15ms)', 2, 2),
('Falha de comunicação: Perda total de pacotes por 5s', 3, 2);

-- 6. Tabela: deteccao
INSERT INTO deteccao (central_processsamento, ram, scan_time, perda_pacote, id_clp) VALUES
(45.50, 60.20, 12.30, 0.00, 1),
(88.10, 75.40, 14.80, 0.50, 1),
(12.30, 30.00, 8.50, 0.00, 2),
(95.00, 92.10, 22.10, 4.20, 2);

-- 7. Tabela: input
INSERT INTO input (descricao, id_clp) VALUES
('Sensor de Temperatura Digital - Entrada I0.0', 1),
('Botão de Parada de Emergência - Entrada I0.1', 1),
('Chave Fim de Curso - Entrada I0.2', 2),
('Sensor Indutivo de Presença - Entrada I0.3', 3);

-- 8. Tabela: output
INSERT INTO output (descricao, id_clp) VALUES
('Atuador Válvula Solenóide - Saída Q0.0', 1),
('Sinaleiro de Alarme Sonoro - Saída Q0.1', 1),
('Motor da Esteira Principal - Saída Q0.2', 2),
('Relé de Proteção Térmica - Saída Q0.3', 3);