CREATE DATABASE datamind
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
  
use datamind;


CREATE TABLE dataset (
    idDataset INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(400),
    nome VARCHAR(45),
    descricao VARCHAR(50)
);


CREATE TABLE cargo (
    idCargo INT PRIMARY KEY AUTO_INCREMENT,
    cargo VARCHAR(45)
);


CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(45),
    cnpj CHAR(14),
    fkDataset INT,
    FOREIGN KEY (fkDataset) REFERENCES dataset(idDataset)
);


CREATE TABLE filial (
    idFilial INT PRIMARY KEY AUTO_INCREMENT,
	nome varchar(200), 
    endereco VARCHAR(150),
    latitude VARCHAR(45),
    longitude VARCHAR(45),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);


CREATE TABLE funcionario (
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(20),
    telefone char(11),
    cpf CHAR(11),
    fkEmpresa INT,
    fkCargo INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo)
);


CREATE TABLE categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45)
);


CREATE TABLE recomendacoesIA (
    idRecomendacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(600),
    dtCriacao DATE,
    fkCategoria INT,
    FOREIGN KEY (fkCategoria) REFERENCES categoria(idCategoria)
);


CREATE TABLE feedback (
    idFeedback INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(1000),
    rating INT,
    fkCategoria INT,
    fkFilial INT,
    FOREIGN KEY (fkCategoria) REFERENCES categoria(idCategoria),
    FOREIGN KEY (fkFilial) REFERENCES filial(idFilial)
);

CREATE TABLE palavrasChave (
 idPalavrasChave INT PRIMARY KEY AUTO_INCREMENT,
 qualidade VARCHAR(45),
 palavras VARCHAR(400),
 fkCategoria INT,
 FOREIGN KEY (fkCategoria) REFERENCES categoria(idCategoria)
);
select * from recomendacoesIA;

INSERT INTO dataset (url, nome, descricao) VALUES
('http://dataset1.com', 'Dataset 1', 'Dados do McDonalds');

-- Inserir dados na tabela cargo
INSERT INTO cargo (cargo) VALUES
('Gerente'),
('Analista'),
('Desenvolvedor');

-- Inserir dados na tabela empresa
INSERT INTO empresa (nomeEmpresa, cnpj, fkDataset) VALUES
("McDonald's", '12345678000195', 1);

-- Inserir dados na tabela funcionario
INSERT INTO funcionario (nome, email, senha, cpf, fkEmpresa, fkCargo) VALUES
('João Silva', 'joao@mcdonalds.com', 'senha123', '12345678901', 1, 1);

-- Inserir dados na tabela categoria
INSERT INTO categoria (idCategoria, descricao) VALUES
(1, 'Qualidade do Produto'),
(2, 'Atendimento'),
(3, 'Tempo de espera'),
(4, 'Experiência no Drive-thru'),
(5, 'Experiência Geral');

CREATE USER 'datamind_adm'@'%' IDENTIFIED BY 'datamind_adm';
GRANT ALL PRIVILEGES ON *.* TO 'datamind_adm'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;