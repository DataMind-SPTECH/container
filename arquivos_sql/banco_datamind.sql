create database datamind;
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
    endereco VARCHAR(45),
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
    descricao VARCHAR(500),
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




INSERT INTO dataset (url, nome, descricao) VALUES
('http://dataset1.com', 'Dataset 1', 'Dados de exemplo'),
('http://dataset2.com', 'Dataset 2', 'Mais dados');

-- Inserir dados na tabela cargo
INSERT INTO cargo (cargo) VALUES
('Gerente'),
('Analista'),
('Desenvolvedor');

-- Inserir dados na tabela empresa
INSERT INTO empresa (nomeEmpresa, cnpj, fkDataset) VALUES
('Empresa A', '12345678000195', 1),
('Empresa B', '98765432000176', 2);

-- Inserir dados na tabela filial
INSERT INTO filial (endereco, latitude, longitude, fkEmpresa) VALUES
('Rua A, 123', '-23.561684', '-46.625378', 2),
('Avenida B, 456', '-22.903539', '-43.209587', 2);

-- Inserir dados na tabela funcionario
INSERT INTO funcionario (nome, email, senha, cpf, fkEmpresa, fkCargo) VALUES
('João Silva', 'joao@empresa.com', 'senha123', '12345678901', 1, 1),
('Maria Oliveira', 'maria@empresa.com', 'senha456', '98765432100', 2, 2);

-- Inserir dados na tabela categoria
INSERT INTO categoria (descricao) VALUES
('Qualidade do Produto'),
('Atendimento'),
('Tempo de espera'),
('Experiência no Drive-thru'),
('Experiência Geral');

-- Inserir dados na tabela recomendacoesIA
INSERT INTO recomendacoesIA (descricao, dtCriacao, fkCategoria) VALUES
('Recomendação para otimizar vendas', '2024-11-15', 1),
('Recomendação de redução de custos', '2024-11-14', 2);

-- Inserir dados na tabela feedback
INSERT INTO feedback (descricao, rating, fkCategoria, fkFilial) VALUES
('Ótimo atendimento na filial', 5, 1, 1),
('Demora no atendimento', 2, 2, 2),
('Produto veio com ótima qualidade', 5, 1, 1),
('Embalagem estava danificada', 2, 1, 2),
('Equipe foi muito atenciosa e prestativa', 4, 2, 1),
('Funcionários estavam desorganizados', 1, 2, 2),
('Tempo de espera foi menor do que o esperado', 5, 3, 1),
('Atraso no pedido gerou frustração', 2, 3, 2),
('Drive-thru foi rápido e eficiente', 5, 4, 1),
('Drive-thru estava confuso e lento', 2, 4, 2),
('A experiência geral foi excelente', 5, 5, 1),
('Faltou atenção aos detalhes na experiência geral', 3, 5, 2),
('Produto de alta qualidade e bem embalado', 5, 1, 1),
('Produto chegou com defeito', 1, 1, 2),
('Equipe foi educada, mas parecia desorganizada', 3, 2, 1),
('Atendimento rápido e eficiente', 5, 2, 2),
('Demora acima do esperado no preparo do pedido', 2, 3, 1),
('Tempo de espera foi razoável, mas pode melhorar', 4, 3, 2),
('Drive-thru prático e bem organizado', 5, 4, 1),
('Confusão no atendimento no drive-thru', 2, 4, 2),
('A experiência geral foi excelente, sem problemas', 5, 5, 1),
('Alguns pontos da experiência geral poderiam melhorar', 3, 5, 2),
('A qualidade do produto superou as expectativas', 5, 1, 2),
('Houve atraso na entrega do pedido', 1, 3, 1),
('Os funcionários foram prestativos e educados', 4, 2, 2),
('O atendimento não foi satisfatório', 2, 2, 1),
('Demora para receber o pedido no drive-thru', 3, 4, 2),
('A experiência geral foi ruim devido à espera', 2, 5, 1),
('Produto veio sem o acompanhamento pedido', 2, 1, 1),
('Tempo de espera foi extremamente longo', 1, 3, 2),
('Drive-thru bem rápido e eficiente, recomendo', 5, 4, 1),
('A experiência geral foi agradável e sem problemas', 4, 5, 2),
('Os funcionários resolveram meu problema rapidamente', 5, 2, 1),
('O produto chegou quente e bem preparado', 4, 1, 2),
('Atendimento demorado e sem explicações claras', 2, 2, 2),
('O tempo de espera foi acima do esperado', 3, 3, 1),
('Atendimento no drive-thru foi excelente', 5, 4, 2),
('A experiência geral precisa melhorar em vários aspectos', 2, 5, 1),
('Produto chegou com apresentação impecável', 5, 1, 1),
('Faltou atenção ao pedido, itens vieram errados', 1, 3, 2),
('Drive-thru com bom fluxo e organização', 4, 4, 1),
('Funcionários foram simpáticos, mas não resolveram o problema', 3, 2, 1);
