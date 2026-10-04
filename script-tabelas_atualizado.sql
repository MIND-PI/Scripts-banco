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
    fornecedorId INT,

    CONSTRAINT fk_empresa_fornecedor
        FOREIGN KEY (fornecedorId)
        REFERENCES empresa(idEmpresa)
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

INSERT INTO empresa
(idEmpresa, nome_fantasia, razao_social, cnpj, codigo_ativacao, setor, fornecedorId)
VALUES

-- =========================================================
-- FORNECEDORES / FABRICANTES DE CLP
-- fornecedorId = NULL
-- =========================================================

(1,
 'Siemens',
 'Siemens Brasil Ltda.',
 '00000000000101',
 'SIEMENS2026',
 'fornecedor',
 NULL),

(2,
 'Schneider Electric',
 'Schneider Electric Brasil Ltda.',
 '00000000000202',
 'SCHNEI2026',
 'fornecedor',
 NULL),

(3,
 'Rockwell Automation',
 'Rockwell Automation do Brasil Ltda.',
 '00000000000303',
 'ROCK2026',
 'fornecedor',
 NULL),


-- =========================================================
-- CLIENTES
-- fornecedorId = fabricante que fornece os CLPs
-- =========================================================

(4,
 'Mitsubishi Electric',
 'Mitsubishi Electric do Brasil Comércio e Serviços Ltda.',
 '00000000000404',
 'MITSU2026',
 'Automação Industrial',
 1),

(5,
 'Petrobras',
 'Petróleo Brasileiro S.A. - Petrobras',
 '00000000000505',
 'PETRO2026',
 'Óleo e Gás',
 1),

(6,
 'Vale',
 'Vale S.A.',
 '00000000000606',
 'VALE2026',
 'Mineração',
 2),

(7,
 'Gerdau',
 'Gerdau S.A.',
 '00000000000707',
 'GERDAU2026',
 'Siderurgia',
 2),

(8,
 'Suzano',
 'Suzano S.A.',
 '00000000000808',
 'SUZANO2026',
 'Papel e Celulose',
 3),

(9,
 'Braskem',
 'Braskem S.A.',
 '00000000000909',
 'BRASK2026',
 'Petroquímica',
 1),

(10,
 'Ambev',
 'Ambev S.A.',
 '00000000001010',
 'AMBEV2026',
 'Bebidas',
 3);
 
 
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
 
 
 
 