CREATE DATABASE datamind;
USE datamind;

CREATE TABLE cargo (
  idCargo INT PRIMARY KEY AUTO_INCREMENT,
  nomeCargo VARCHAR(45)
);

CREATE TABLE dataset (
    idDataset INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(400),
    nome VARCHAR(45),
	descricao VARCHAR(50)
);

INSERT INTO dataset(idDataset, url, nome, descricao) VALUES (1, "datasetmac.com", "Mc Donald's dados", "50 feedbacks");

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(45),
    cnpj CHAR(14),
    cep CHAR(8),
    rua VARCHAR(45),
    bairro VARCHAR(45),
    complemento VARCHAR(45),
    cidade VARCHAR(20),
    estado VARCHAR(20),
    numero VARCHAR(5),
    fkDataset INT,
    fkMatriz INT,
    FOREIGN KEY (fkDataset) REFERENCES dataset(idDataset),
	FOREIGN KEY (fkMatriz) REFERENCES empresa(idEmpresa)
);

INSERT INTO empresa (idEmpresa, nomeEmpresa, cnpj, cep, rua, bairro, complemento, cidade, estado, numero, fkDataset, fkMatriz) VALUES (1, "Mc Donalds", "42591651000143" , "06333272", "Avenida Paulista", "Cerqueira Cesar", "Andar 1", "São Paulo", "São Paulo", "1000", 1, null);

CREATE TABLE funcionario (
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(20),
    telefone CHAR(11),
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
    descricao VARCHAR(500),
	dtCriacao DATE,
    fkCategoria INT,
	FOREIGN KEY (fkCategoria) REFERENCES categoria(idCategoria)
);

INSERT INTO cargo (idCargo, nomeCargo) VALUES (1, "Responsável Legal");
