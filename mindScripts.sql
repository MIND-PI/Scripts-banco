DROP DATABASE IF EXISTS mind;
CREATE DATABASE mind;
USE mind;

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario(
id INT AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL UNIQUE,
senha VARCHAR(50) NOT NULL,
nivel TINYINT NOT NULL DEFAULT(0),
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
id_superior INT,
CONSTRAINT pk_usuario PRIMARY KEY (id),
CONSTRAINT fk_superior FOREIGN KEY (id_superior) REFERENCES usuario(id),
CONSTRAINT chk_nivel CHECK(nivel IN (0, 1, 2, 3))
);


DROP TABLE IF EXISTS clp;
CREATE TABLE clp (
id INT AUTO_INCREMENT,
modelo VARCHAR(100) NOT NULL,
central_processamento VARCHAR(100) NOT NULL,
memoria_ram INT NOT NULL,
fonte_alimentacao VARCHAR(10),
id_usuario INT,
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_clp PRIMARY KEY (id),
CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

DROP TABLE IF EXISTS recurso; 
CREATE TABLE recurso(
id INT AUTO_INCREMENT,
nome_recurso VARCHAR(100),
unidade_medida VARCHAR(5),
descricao VARCHAR(100),
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_recurso_monitorado PRIMARY KEY(id)
);

DROP TABLE IF EXISTS recurso_monitorado;
CREATE TABLE recurso_monitorado(
id INT AUTO_INCREMENT,
id_clp INT,
id_recurso INT,
estatus TINYINT NOT NULL DEFAULT (1),
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_recurso_monitorado PRIMARY KEY(id),
CONSTRAINT fk_clp_id FOREIGN KEY (id_clp) REFERENCES clp(id),
CONSTRAINT fk_recurso_id FOREIGN KEY (id_recurso) REFERENCES recurso(id),
CONSTRAINT chk_status CHECK (estatus IN (1, 2))
);


DROP TABLE IF EXISTS alerta;
CREATE TABLE alerta(
id INT AUTO_INCREMENT,
descricao VARCHAR(255),
prioridade TINYINT DEFAULT (0) NOT NULL,
id_clp INT,
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_alertas PRIMARY KEY(id),
CONSTRAINT chk_prioridade_alerta CHECK (prioridade IN (0, 1, 2, 3)),
CONSTRAINT fk_clp_alerta FOREIGN KEY (id_clp) REFERENCES clp(id)
);

DROP TABLE IF EXISTS deteccao;
CREATE TABLE deteccao(
id INT AUTO_INCREMENT,
central_processsamento DECIMAL (5, 2) NOT NULL,
ram DECIMAL (5, 2) NOT NULL,
scan_time DECIMAL (5, 2) NOT NULL,
perda_pacote DECIMAL (5, 2) NOT NULL,
id_clp INT,
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_deteccoes PRIMARY KEY (id),
CONSTRAINT fk_clp FOREIGN KEY (id_clp) REFERENCES clp(id)
);

DROP TABLE IF EXISTS input;
CREATE TABLE input(
id INT AUTO_INCREMENT,
descricao VARCHAR(255) NOT NULL,
id_clp INT,
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_input PRIMARY KEY(id),
CONSTRAINT fk_clp_input FOREIGN KEY (id_clp) REFERENCES clp(id)
);

DROP TABLE IF EXISTS output;
CREATE TABLE output(
id INT AUTO_INCREMENT,
descricao VARCHAR(255) NOT NULL,
id_clp INT,
criado_em TIMESTAMP DEFAULT (current_timestamp()) NOT NULL,
atualizado_em TIMESTAMP,
desativado_em TIMESTAMP,
CONSTRAINT pk_output PRIMARY KEY(id),
CONSTRAINT fk_clp_output FOREIGN KEY (id_clp) REFERENCES clp(id)
);
