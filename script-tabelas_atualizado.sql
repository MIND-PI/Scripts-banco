DROP DATABASE IF EXISTS mind;
CREATE DATABASE IF NOT EXISTS mind;
USE mind;

CREATE TABLE empresa(
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_fantasia VARCHAR(255),
    razao_social VARCHAR(255),
    cnpj VARCHAR(14),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    codigo_ativacao VARCHAR(16),
    setor VARCHAR(100) DEFAULT 'fornecedor',
    tipo VARCHAR(100) DEFAULT 'fornecedor' CHECK (tipo IN ('fornecedor', 'cliente fornecedor')) NOT NULL
);

CREATE TABLE ativacao(
	idFornecedor INT,
    idCliente INT,
    PRIMARY KEY(idFornecedor, idCliente),
	
    FOREIGN KEY (idFornecedor) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (idCliente) REFERENCES empresa(idEmpresa)
);

CREATE TABLE usuario(
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(200),
    senha VARCHAR(100),
    empresaId INT,
    cargo VARCHAR(100),
    responsavel INT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    url_img VARCHAR(1000),

    CONSTRAINT fk_usuario_empresa
        FOREIGN KEY (empresaId)
        REFERENCES empresa(idEmpresa),

    CONSTRAINT fk_usuario_responsavel
        FOREIGN KEY (responsavel)
        REFERENCES usuario(idUsuario)
);

CREATE TABLE modelo(
    idmodelo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    empresaId INT,
    
    CONSTRAINT fk_modelo_empresa
        FOREIGN KEY (empresaId)
        REFERENCES empresa(idEmpresa)
);

CREATE TABLE clp(
    idClp INT AUTO_INCREMENT PRIMARY KEY,
    empresaId INT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT,
    localizacao VARCHAR(255),
    modeloId INT,

    CONSTRAINT fk_clp_empresa
        FOREIGN KEY (empresaId)
        REFERENCES empresa(idEmpresa),

    CONSTRAINT fk_clp_modelo
        FOREIGN KEY (modeloId)
        REFERENCES modelo(idmodelo)
);

CREATE TABLE tipo_medicao(
    idTipoMedicao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    unidade_medida VARCHAR(100),
    apelido VARCHAR(45),
    descricao TEXT
);

CREATE TABLE clp_medicao(
    clpId INT,
    tipoMedicaoId INT,
    ativo TINYINT,
    parametro INT,

    PRIMARY KEY (clpId, tipoMedicaoId),

    CONSTRAINT fk_clp_medicao_clp
        FOREIGN KEY (clpId)
        REFERENCES clp(idClp),

    CONSTRAINT fk_clp_medicao_tipo
        FOREIGN KEY (tipoMedicaoId)
        REFERENCES tipo_medicao(idTipoMedicao)
);


-- =======================================
-- FORNECEDORES
-- 1 = Siemens
-- 2 = Schneider Electric
-- 3 = Rockwell Automation
-- ========================================
-- CLIENTES
-- 4 = Mitsubishi Electric
-- 5 = Petrobras
-- 6 = Vale
-- 7 = Gerdau
-- 8 = Suzano
-- 9 = Braskem
-- 10 = Ambev
-- =========================================================
-- FORNECEDORES / FABRICANTES DE CLP
-- fornecedorId = NULL
-- =========================================================

INSERT INTO empresa
(idEmpresa, nome_fantasia, razao_social, cnpj, codigo_ativacao, setor, tipo)
VALUES
(1,
 'Siemens',
 'Siemens Brasil Ltda.',
 '00000000000101',
 'SIEMENS2026',
 'fornecedor',
 default),

(2,
 'Schneider Electric',
 'Schneider Electric Brasil Ltda.',
 '00000000000202',
 'SCHNEI2026',
 'fornecedor',
 default),

(3,
 'Rockwell Automation',
 'Rockwell Automation do Brasil Ltda.',
 '00000000000303',
 'ROCK2026',
 'fornecedor',
 default),


-- =========================================================
-- CLIENTES
-- =========================================================

(4,
 'Mitsubishi Electric',
 'Mitsubishi Electric do Brasil Comércio e Serviços Ltda.',
 '00000000000404',
 'MITSU2026',
 'Automação Industrial',
 'cliente fornecedor'),

(5,
 'Petrobras',
 'Petróleo Brasileiro S.A. - Petrobras',
 '00000000000505',
 'PETRO2026',
 'Óleo e Gás',
 'cliente fornecedor'),

(6,
 'Vale',
 'Vale S.A.',
 '00000000000606',
 'VALE2026',
 'Mineração',
 'cliente fornecedor'),

(7,
 'Gerdau',
 'Gerdau S.A.',
 '00000000000707',
 'GERDAU2026',
 'Siderurgia',
 'cliente fornecedor'),

(8,
 'Suzano',
 'Suzano S.A.',
 '00000000000808',
 'SUZANO2026',
 'Papel e Celulose',
 'cliente fornecedor'),

(9,
 'Braskem',
 'Braskem S.A.',
 '00000000000909',
 'BRASK2026',
 'Petroquímica',
 'cliente fornecedor'),

(10,
 'Ambev',
 'Ambev S.A.',
 '00000000001010',
 'AMBEV2026',
 'Bebidas',
 'cliente fornecedor');
 
 -- ===============================================
 -- ATIVAÇÃO
 -- ===============================================
 INSERT INTO ativacao(idFornecedor, idCliente) VALUES
 (1,4),
 (1,5),
 (2,6),
 (2,7),
 (3,8),
 (1,9),
 (3,10);
 
 -- ===============================================
 -- USUÁRIOS (inclui as proto-personas)
 -- ===============================================
INSERT INTO usuario
(idUsuario, nome, email, senha, empresaId, cargo, responsavel, url_img)
VALUES

(1,
 'Lídia Almeida',
 'lidia.almeida@siemens.com',
 '123456',
 1,
 'Gerente de Pós Venda e Suporte Técnico',
 NULL,
 '/assets/imgs/lidia.png'),

(2,
 'Rogério Andrade',
 'rogerio.andrade@mitsubishi.com',
 '123456',
 4,
 'Gestor da Operação Industrial',
 1,
 '/assets/imgs/rogerio.png'),

(3,
 'Carlos Mendes',
 'carlos.mendes@petrobras.com',
 '123456',
 5,
 'Analista de Automação',
 1,
 '/assets/imgs/carlos.png'),

(4,
 'Fernanda Costa',
 'fernanda.costa@gerdau.com',
 '123456',
 7,
 'Coordenadora de Manutenção',
 1,
 '/assets/imgs/fernanda.png');
 
 -- ============================================
 -- MODELOS DE CLP
  -- ============================================
 
 INSERT INTO modelo
(idmodelo, nome, empresaId)
VALUES

-- Modelos Siemens
(1, 'SIMATIC S7-1200', 1),
(2, 'SIMATIC S7-1500', 1),

-- Modelos Schneider
(3, 'Modicon M340', 2),
(4, 'Modicon M580', 2),

-- Modelos Rockwell
(5, 'ControlLogix', 3),
(6, 'CompactLogix', 3);
 
 -- =========================================================
-- TIPOS DE MEDIÇÃO
-- =========================================================

INSERT INTO tipo_medicao
(idTipoMedicao, nome, unidade_medida, apelido, descricao)
VALUES

-- 1
(1,
 'Utilização de CPU',
 '%',
 'CPU',
 'Percentual de utilização do processador do sistema monitorado.'),

-- 2
(2,
 'Utilização de RAM',
 '%',
 'RAM',
 'Percentual de utilização da memória RAM do sistema monitorado.'),

-- 3
(3,
 'Uptime do Sistema',
 '%',
 'UPTIME',
 'Percentual de disponibilidade do sistema durante o período monitorado.'),

-- 4
(4,
 'Utilização de Memória Swap',
 '%',
 'SWAP',
 'Percentual de utilização da memória swap do sistema.'),

-- 5
(5,
 'Scan Time',
 'ms',
 'SCAN',
 'Tempo necessário para a execução de um ciclo do sistema monitorado.'),

-- 6
(6,
 'Latência de Rede',
 'ms',
 'PING',
 'Tempo de resposta da comunicação entre o sistema monitorado e o destino configurado.'),

-- 7
(7,
 'Perda de Pacotes',
 'pacotes',
 'LOSS',
 'Quantidade de erros de entrada e saída registrados na comunicação de rede.'),

-- 8
(8,
 'Dados Enviados',
 'GB',
 'UPLOAD',
 'Quantidade acumulada de dados enviados pela interface de rede.'),

-- 9
(9,
 'Dados Recebidos',
 'GB',
 'DOWNLOAD',
 'Quantidade acumulada de dados recebidos pela interface de rede.'),

-- 10
(10,
 'Processos de Maior Consumo',
 'processos',
 'PROCESSOS',
 'Ranking dos processos que apresentam maior utilização de CPU no sistema monitorado.')
;

-- =========================================================
-- CLPs DOS CLIENTES
-- =========================================================

INSERT INTO clp
(idClp, empresaId, status, localizacao, modeloId)
VALUES

-- =========================================================
-- MITSUBISHI ELECTRIC
-- Cliente: Siemens
-- =========================================================

(1,
 4,
 1,
 'Planta Industrial - Linha de Produção 01',
 1),

(2,
 4,
 1,
 'Planta Industrial - Linha de Produção 02',
 2),

(3,
 4,
 0,
 'Planta Industrial - Área de Envase',
 1),


-- =========================================================
-- PETROBRAS
-- =========================================================

(4,
 5,
 1,
 'Plataforma Offshore - Sala de Controle',
 2),

(5,
 5,
 1,
 'Plataforma Offshore - Sistema de Compressão',
 2),

(6,
 5,
 0,
 'Plataforma Offshore - Sistema de Bombeamento',
 1),


-- =========================================================
-- VALE
-- =========================================================

(7,
 6,
 1,
 'Complexo Industrial - Britagem',
 4),

(8,
 6,
 1,
 'Complexo Industrial - Correias Transportadoras',
 3),

(9,
 6,
 0,
 'Complexo Industrial - Beneficiamento',
 4),


-- =========================================================
-- GERDAU
-- =========================================================

(10,
 7,
 1,
 'Usina - Linha de Laminação',
 3),

(11,
 7,
 1,
 'Usina - Forno Industrial',
 4),


-- =========================================================
-- SUZANO
-- =========================================================

(12,
 8,
 1,
 'Unidade Industrial - Linha de Celulose',
 5),

(13,
 8,
 0,
 'Unidade Industrial - Caldeira',
 6),


-- =========================================================
-- BRASKEM
-- =========================================================

(14,
 9,
 1,
 'Polo Petroquímico - Unidade de Produção',
 1),

(15,
 9,
 1,
 'Polo Petroquímico - Sistema de Resfriamento',
 2),


-- =========================================================
-- AMBEV
-- =========================================================

(16,
 10,
 1,
 'Fábrica - Linha de Envase',
 5),

(17,
 10,
 1,
 'Fábrica - Linha de Produção',
 6);
 
 
 -- Mitsubishi — CLP 1
 INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

(1, 1, 1, 80),   -- CPU
(1, 2, 1, 80),   -- RAM
(1, 3, 1, 95),   -- Uptime
(1, 4, 1, 80),   -- Swap
(1, 5, 1, 100),  -- Scan Time
(1, 6, 1, 100),  -- Latência
(1, 7, 1, 1),    -- Perda de pacotes
(1, 8, 1, 0),    -- Upload
(1, 9, 1, 0),    -- Download
(1, 10, 1, 3);   -- Top 3 processos

-- Mitsubishi — CLP 2
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

(2, 1, 1, 80),
(2, 2, 1, 80),
(2, 3, 1, 95),
(2, 4, 1, 80),
(2, 5, 1, 100),
(2, 6, 1, 100),
(2, 10, 1, 3);


-- Mitsubishi — CLP 3
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

(3, 1, 1, 80),
(3, 2, 1, 80),
(3, 5, 1, 100),
(3, 6, 1, 100),
(3, 7, 1, 1);


-- Petrobras — CLPs 4, 5 e 6
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

-- CLP 4
(4, 1, 1, 80),
(4, 2, 1, 80),
(4, 3, 1, 95),
(4, 4, 1, 80),
(4, 5, 1, 100),
(4, 6, 1, 100),
(4, 7, 1, 1),
(4, 8, 1, 0),
(4, 9, 1, 0),
(4, 10, 1, 3),

-- CLP 5
(5, 1, 1, 80),
(5, 2, 1, 80),
(5, 3, 1, 95),
(5, 4, 1, 80),
(5, 5, 1, 100),
(5, 6, 1, 100),
(5, 7, 1, 1),
(5, 10, 1, 3),

-- CLP 6
(6, 1, 1, 80),
(6, 2, 1, 80),
(6, 5, 1, 100),
(6, 6, 1, 100),
(6, 7, 1, 1);


-- Vale — CLPs 7, 8 e 9
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

-- CLP 7
(7, 1, 1, 80),
(7, 2, 1, 80),
(7, 3, 1, 95),
(7, 4, 1, 80),
(7, 5, 1, 100),
(7, 6, 1, 100),
(7, 10, 1, 3),

-- CLP 8
(8, 1, 1, 80),
(8, 2, 1, 80),
(8, 5, 1, 100),
(8, 6, 1, 100),
(8, 7, 1, 1),
(8, 8, 1, 0),
(8, 9, 1, 0),

-- CLP 9
(9, 1, 1, 80),
(9, 2, 1, 80),
(9, 4, 1, 80),
(9, 5, 1, 100),
(9, 6, 1, 100);


-- Gerdau — CLPs 10 e 11
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

-- CLP 10
(10, 1, 1, 80),
(10, 2, 1, 80),
(10, 3, 1, 95),
(10, 4, 1, 80),
(10, 5, 1, 100),
(10, 6, 1, 100),
(10, 7, 1, 1),
(10, 10, 1, 3),

-- CLP 11
(11, 1, 1, 80),
(11, 2, 1, 80),
(11, 5, 1, 100),
(11, 6, 1, 100),
(11, 8, 1, 0),
(11, 9, 1, 0);

-- Suzano — CLPs 12 e 13
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

-- CLP 12
(12, 1, 1, 80),
(12, 2, 1, 80),
(12, 3, 1, 95),
(12, 4, 1, 80),
(12, 5, 1, 100),
(12, 6, 1, 100),
(12, 7, 1, 1),
(12, 10, 1, 3),

-- CLP 13
(13, 1, 1, 80),
(13, 2, 1, 80),
(13, 5, 1, 100),
(13, 6, 1, 100),
(13, 7, 1, 1);

-- Braskem — CLPs 14 e 15
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

-- CLP 14
(14, 1, 1, 80),
(14, 2, 1, 80),
(14, 3, 1, 95),
(14, 4, 1, 80),
(14, 5, 1, 100),
(14, 6, 1, 100),
(14, 7, 1, 1),
(14, 8, 1, 0),
(14, 9, 1, 0),
(14, 10, 1, 3),

-- CLP 15
(15, 1, 1, 80),
(15, 2, 1, 80),
(15, 5, 1, 100),
(15, 6, 1, 100),
(15, 10, 1, 3);

-- Ambev — CLPs 16 e 17
INSERT INTO clp_medicao
(clpId, tipoMedicaoId, ativo, parametro)
VALUES

-- CLP 16
(16, 1, 1, 80),
(16, 2, 1, 80),
(16, 3, 1, 95),
(16, 4, 1, 80),
(16, 5, 1, 100),
(16, 6, 1, 100),
(16, 7, 1, 1),
(16, 8, 1, 0),
(16, 9, 1, 0),
(16, 10, 1, 3),

-- CLP 17
(17, 1, 1, 80),
(17, 2, 1, 80),
(17, 5, 1, 100),
(17, 6, 1, 100),
(17, 7, 1, 1),
(17, 10, 1, 3);




 
 
