 -- Drop das tabelas, se existirem
DROP TABLE IF EXISTS Instancia_NPC, NPC, Instancia_PC, PC, Dialogo, Personagem, Bioma, Mundo, Evento, Consumivel, Roupa, Acessorio, Ferramenta, Item, Modificador, Buff, Possui, Acontece, Contem, Solta, Faz_Parte_Bioma, Requer, Roupa_Tem, Acessorio_Tem, Ferramenta_Tem, Fornece, Bloco, Receita, Posicao, Faz_Parte_NPC, Instancia_Mundo;
DROP TYPE IF EXISTS Tamanho, Dificuldade, Tipo_Evento;
-- Criação das tabelas

CREATE TABLE Dialogo (
    ID_Dialogo SERIAL PRIMARY KEY,
    Texto VARCHAR(255) NOT NULL
);

CREATE TABLE Personagem (
    ID_P SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Vida INT NOT NULL
);

CREATE TABLE NPC (
    ID_NPC SERIAL,
    ID_Personagem INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Comportamento VARCHAR(255) NOT NULL,
    ID_Dialogo INT,
    PRIMARY KEY (ID_NPC),
    FOREIGN KEY (ID_Dialogo) REFERENCES Dialogo(ID_Dialogo),
    FOREIGN KEY (ID_Personagem) REFERENCES Personagem(ID_P)
);

CREATE TABLE PC (
    ID_PC SERIAL,
    ID_Personagem INT NOT NULL,
    Mana INT NOT NULL,
    PRIMARY KEY (ID_PC),
    FOREIGN KEY (ID_Personagem) REFERENCES Personagem(ID_P)
);

CREATE TABLE Instancia_PC (
    ID_Instancia_PC SERIAL PRIMARY KEY,
    VidaAtual INT NOT NULL,
    ManaAtual INT NOT NULL,
    ID_PC INT NOT NULL,
    FOREIGN KEY (ID_PC) REFERENCES PC(ID_PC)
);

CREATE TABLE Instancia_NPC (
    ID_Instancia_NPC SERIAL PRIMARY KEY,
    ID_NPC INT NOT NULL,
    VidaAtual INT NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_NPC) REFERENCES NPC(ID_NPC)
);

CREATE TABLE Bioma (
    Nome VARCHAR(255) PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL
);

CREATE TYPE Tamanho AS ENUM ('Pequeno', 'Medio', 'Grande');
CREATE TYPE Dificuldade AS ENUM ('Jornada', 'Normal', 'Expert', 'Master');

CREATE TABLE Mundo (
    ID_Mundo SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Tamanho Tamanho DEFAULT 'Medio' NOT NULL,
    Semente INT NOT NULL,
    Dificuldade Dificuldade DEFAULT 'Normal' NOT NULL,
    Clima INT NOT NULL,
    Hora_do_Dia INT NOT NULL
);

CREATE TYPE Tipo_Evento AS ENUM ('Aleatorio', 'Especial', 'Estação');

CREATE TABLE Evento (
    Nome VARCHAR(255) PRIMARY KEY,
    Tipo Tipo_Evento DEFAULT 'Aleatorio' NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Fim DATE NOT NULL
);

CREATE TABLE Item (
    Nome VARCHAR(255) PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Acumulavel BOOLEAN NOT NULL
);

CREATE TABLE Consumivel (
    Item_Nome VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Roupa (
    Defesa INT,
    Descricao VARCHAR(255) NOT NULL,
    eAperencia BOOLEAN NOT NULL,
    Item_Nome VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Acessorio (
    Efeito VARCHAR(255) NOT NULL,
    Defesa INT NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    Item_Nome VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Ferramenta (
    Tipo VARCHAR(50) NOT NULL,
    Poder INT,
    Eficiencia INT,
    ChanceCrit INT NOT NULL,
    Item_Nome VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Modificador (
    Nome VARCHAR(255) PRIMARY KEY,
    Efeito VARCHAR(50) NOT NULL
);

CREATE TABLE Buff (
    Nome VARCHAR(255) PRIMARY KEY,
    Duracao INT NOT NULL,
    Efeito VARCHAR(255) NOT NULL
);

CREATE TABLE Bloco (
    Tipo VARCHAR(50) NOT NULL,
    Item_Nome VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Receita (
    ID_Receita SERIAL PRIMARY KEY,
    Item_Final VARCHAR(50) NOT NULL,
	Item_1 VARCHAR(50) NOT NULL,
	Item_2 VARCHAR(50),
	Item_3 VARCHAR(50),
	Quantidade_Item_1 INT NOT NULL,
	Quantidade_Item_2 INT,
	Quantidade_Item_3 INT,
    Estacao_Bloco VARCHAR(255) NOT NULL,
    FOREIGN KEY (Estacao_Bloco) REFERENCES Bloco(Item_Nome),
	FOREIGN KEY (Item_1) REFERENCES Item(Nome),
	FOREIGN KEY (Item_2) REFERENCES Item(Nome),
	FOREIGN KEY (Item_3) REFERENCES Item(Nome),
	FOREIGN KEY (Item_Final) REFERENCES Item(Nome),
	CHECK (
        (Item_2 IS NOT NULL AND Quantidade_Item_2 IS NOT NULL) OR (Item_2 IS NULL AND Quantidade_Item_2 IS NULL)
    ),
    CHECK (
        (Item_3 IS NOT NULL AND Quantidade_Item_3 IS NOT NULL) OR (Item_3 IS NULL AND Quantidade_Item_3 IS NULL)
    )
);

CREATE TABLE Posicao (
    ID_Mundo INT NOT NULL,
    ID_Personagem INT NOT NULL,
    X INT NOT NULL,
    Y INT NOT NULL,
    PRIMARY KEY (ID_Mundo),
    FOREIGN KEY (ID_Personagem) REFERENCES Personagem(ID_P),
    FOREIGN KEY (ID_Mundo) REFERENCES Mundo(ID_Mundo)
);

CREATE TABLE Possui (
    ID_Mundo INT NOT NULL,
    Bioma_Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Mundo) REFERENCES Mundo(ID_Mundo),
    FOREIGN KEY (Bioma_Nome) REFERENCES Bioma(Nome)
);

CREATE TABLE Acontece (
    Evento_Nome VARCHAR(255) NOT NULL,
    ID_Mundo INT NOT NULL,
    FOREIGN KEY (ID_Mundo) REFERENCES Mundo(ID_Mundo),
    FOREIGN KEY (Evento_Nome) REFERENCES Evento(Nome)
);

CREATE TABLE Contem (
    Item_Nome VARCHAR(255) NOT NULL,
    ID_Instancia_PC INT NOT NULL,
    Quantidade INT NOT NULL,
    FOREIGN KEY (ID_Instancia_PC) REFERENCES Instancia_PC(ID_Instancia_PC),
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Solta (
    Item_Nome VARCHAR(255) NOT NULL,
    ID_NPC INT NOT NULL,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome),
    FOREIGN KEY (ID_NPC) REFERENCES NPC(ID_NPC)
);

CREATE TABLE Faz_Parte_Bioma (
    Item_Nome VARCHAR(255) NOT NULL,
    Bioma_Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (Bioma_Nome) REFERENCES Bioma(Nome),
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome)
);

CREATE TABLE Requer (
    ID_Receita INT NOT NULL,
    Item_Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome),
    FOREIGN KEY (ID_Receita) REFERENCES Receita(ID_Receita)
);

CREATE TABLE Roupa_Tem (
    Roupa_Nome VARCHAR(255) NOT NULL,
    Modificadores_Nome VARCHAR(255)  NOT NULL,
    FOREIGN KEY (Roupa_Nome) REFERENCES Roupa(Item_Nome),
    FOREIGN KEY (Modificadores_Nome) REFERENCES Modificador(Nome)
);

CREATE TABLE Acessorio_Tem (
    Acessorio_Nome VARCHAR(255) NOT NULL,
    Modificadores_Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (Acessorio_Nome) REFERENCES Acessorio(Item_Nome),
    FOREIGN KEY (Modificadores_Nome) REFERENCES Modificador(Nome)
);

CREATE TABLE Ferramenta_Tem (
    Ferramenta_Nome VARCHAR(255) NOT NULL,
    Modificadores_Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (Ferramenta_Nome) REFERENCES Ferramenta(Item_Nome),
    FOREIGN KEY (Modificadores_Nome) REFERENCES Modificador(Nome)
);

CREATE TABLE Fornece (
    Buff_Nome VARCHAR(255) NOT NULL,
    Consumivel_Nome VARCHAR(255) NOT NULL,
    FOREIGN KEY (Consumivel_Nome) REFERENCES Consumivel(Item_Nome),
    FOREIGN KEY (Buff_Nome) REFERENCES Buff(Nome)
);

CREATE TABLE Faz_Parte_NPC (
    ID_NPC INT NOT NULL,
    Nome_Bioma VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_NPC) REFERENCES NPC(ID_NPC),
    FOREIGN KEY (Nome_Bioma) REFERENCES Bioma(Nome)
);

CREATE TABLE Instancia_Mundo (
    ID_PC INT NOT NULL,
    a1 VARCHAR(255),
    a2 VARCHAR(255),
    a3 VARCHAR(255),
    a4 VARCHAR(255),
    b1 VARCHAR(255),
    b2 VARCHAR(255),
    b3 VARCHAR(255),
    b4 VARCHAR(255),
    c1 VARCHAR(255),
    c2 VARCHAR(255),
    c3 VARCHAR(255),
    c4 VARCHAR(255),
    d1 VARCHAR(255),
    d2 VARCHAR(255),
    d3 VARCHAR(255),
    d4 VARCHAR(255),
    FOREIGN KEY (ID_PC) REFERENCES PC(ID_PC)
);

-- Inserindo diálogos
INSERT INTO Dialogo (Texto) VALUES ('Você precisa de um pouco de equipamento melhor para enfrentar esses monstros!');
INSERT INTO Dialogo (Texto) VALUES ('Eu tenho o que você precisa, se você tiver o dinheiro hehehe....');
INSERT INTO Dialogo (Texto) VALUES ('Você precisa de um pouco de cura? Eu posso te ajudar com isso!');

-- Inserindo personagens
INSERT INTO Personagem (Nome, Vida) VALUES ('zumbi', 45);
INSERT INTO Personagem (Nome, Vida) VALUES ('slime', 14);
INSERT INTO Personagem (Nome, Vida) VALUES ('guia', 100);
INSERT INTO Personagem (Nome, Vida) VALUES ('mercador', 100); 
INSERT INTO Personagem (Nome, Vida) VALUES ('enfermeira', 100); 

-- Inserindo NPCs
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (1, 'zumbi', 'Ataca a Primeira Vista', NULL);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (2, 'slime', 'Ataca a Primeira Vista', NULL);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (3, 'guia', 'Ajuda o Jogador', 1);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (4, 'mercador', 'Vende Itens', 2);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (5, 'enfermeira', 'Cura o Jogador', 3);

-- Inserindo PC

-- Inserindo instâncias de PC

-- Inserindo biomas
INSERT INTO Bioma (Nome, Tipo) VALUES ('Pântano', 'Natural');
INSERT INTO Bioma (Nome, Tipo) VALUES ('Montanha', 'Natural');
INSERT INTO Bioma (Nome, Tipo) VALUES ('Deserto', 'Natural');
INSERT INTO Bioma (Nome, Tipo) VALUES ('Floresta', 'Natural');

-- Inserindo mundos
INSERT INTO Mundo (Nome, Tamanho, Semente, Dificuldade, Clima, Hora_do_Dia)
VALUES ('Mundo do Crepúsculo', 'Pequeno', 654321, 'Master', 10, 1800);
INSERT INTO Mundo (Nome, Tamanho, Semente, Dificuldade, Clima, Hora_do_Dia)
VALUES ('Mundo do Caos', 'Grande', 987654, 'Expert', 8, 2200);
INSERT INTO Mundo (Nome, Tamanho, Semente, Dificuldade, Clima, Hora_do_Dia)
VALUES ('Mundo da Esperança', 'Medio', 112233, 'Normal', 6, 1200);
INSERT INTO Mundo (Nome, Tamanho, Semente, Dificuldade, Clima, Hora_do_Dia)
VALUES ('Mundo das Sombras', 'Pequeno', 445566, 'Jornada', 5, 2400);

--inserindo instancias_mundo
--INSERT INTO Instancia_Mundo (ID_PC, a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4)
--VALUES (1, NULL, 'zumbi', 'zumbi', 'minerio', 'npc', 'item', 'slime', 'slime', 'zumbi', 'slime', 'zumbi', 'minerio', 'item', 'tesouro', 'npc', 'minerio'),

-- Inserindo eventos
INSERT INTO Evento (Nome, Tipo, Data_Inicio, Data_Fim)
VALUES ('Eclipse Solar', 'Aleatorio', '2024-02-15', '2024-02-15');
INSERT INTO Evento (Nome, Tipo, Data_Inicio, Data_Fim)
VALUES ('Ano Novo', 'Especial', '2024-12-31', '2025-01-01');
INSERT INTO Evento (Nome, Tipo, Data_Inicio, Data_Fim)
VALUES ('Festival da Colheita', 'Estação', '2024-09-01', '2024-09-03');
INSERT INTO Evento (Nome, Tipo, Data_Inicio, Data_Fim)
VALUES ('Chuva de Meteoros', 'Aleatorio', '2024-11-21', '2024-11-21');

-- Itens para Consumível
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Pocao de Resistencia ao Fogo', 'Consumivel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Pocao de Agilidade', 'Consumivel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Pocao de Cura', 'Consumivel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Pocao de Mana', 'Consumivel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Flecha', 'Consumivel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Gel', 'Consumivel', TRUE);

-- Itens para Roupa
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Elmo de Aço', 'Equipavel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Escudo de Prata', 'Equipavel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Armadura de Couro', 'Equipavel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Elmo de Ouro', 'Equipavel', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Capa Magica', 'Acessório', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Armadura de Ouro', 'Armadura', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Roupa de Bruxa', 'Acessório', FALSE);

-- Itens para Acessório
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Anel de Velocidade', 'Acessorio', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Colar de Fogo', 'Acessorio', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Amuleto de Mana', 'Acessorio', TRUE);

-- Itens para Ferramenta
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Machado de Ferro', 'Ferramenta', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Serra de Madeira', 'Ferramenta', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Picareta de Ouro', 'Ferramenta', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Martelo de Prata', 'Ferramenta', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Arco de Madeira', 'Ferramenta', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Espada de Diamante', 'Arma', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Espada de Ferro', 'Arma', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Braco de zumbi', 'Arma', FALSE);

-- Itens para Bloco
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Bloco de Madeira', 'Bloco', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Bloco de Ferro', 'Bloco', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Bloco de Pedra', 'Bloco', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Bloco de Ouro', 'Bloco', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Forja', 'Bloco', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Mesa de Trabalho', 'Bloco', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Estante do Mago', 'Bloco', FALSE);

-- Itens Para Receita
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Diamante', 'Material', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Madeira', 'Material', TRUE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Lona', 'Material', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Ferro', 'Material', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Ouro', 'Material', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Couro', 'Material', FALSE);
INSERT INTO Item (Nome, Tipo, Acumulavel) VALUES ('Tecido', 'Material', TRUE);


-- Inserindo consumíveis
INSERT INTO Consumivel (Item_Nome) VALUES ('Pocao de Resistencia ao Fogo');
INSERT INTO Consumivel (Item_Nome) VALUES ('Pocao de Agilidade');
INSERT INTO Consumivel (Item_Nome) VALUES ('Pocao de Cura');
INSERT INTO Consumivel (Item_Nome) VALUES ('Pocao de Mana');
INSERT INTO Consumivel (Item_Nome) VALUES ('Gel');

-- Inserindo roupas
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (7, 'Elmo de Aço', FALSE, 'Elmo de Aço');
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (6, 'Escudo de Prata', FALSE, 'Escudo de Prata');
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (4, 'Armadura de Couro', FALSE, 'Armadura de Couro');
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (5, 'Elmo de Ouro', FALSE, 'Elmo de Ouro');
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (8, 'Armadura De Ouro', FALSE, 'Armadura de Ouro');
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (0, 'Roupa De Bruxa', TRUE, 'Roupa de Bruxa');
INSERT INTO Roupa (Defesa, Descricao, eAperencia, Item_Nome)
VALUES (0, 'Capa Magica', TRUE, 'Capa Magica');

-- Inserindo acessórios
INSERT INTO Acessorio (Efeito, Defesa, Descricao, Item_Nome)
VALUES ('Aumenta a defesa contra flechas', 5, 'Escudo de Prata', 'Escudo de Prata');
INSERT INTO Acessorio (Efeito, Defesa, Descricao, Item_Nome)
VALUES ('Aumenta a velocidade de ataque', 2, 'Anel de Velocidade', 'Anel de Velocidade');
INSERT INTO Acessorio (Efeito, Defesa, Descricao, Item_Nome)
VALUES ('Aumenta a resistência ao fogo', 3, 'Colar de Fogo', 'Colar de Fogo');
INSERT INTO Acessorio (Efeito, Defesa, Descricao, Item_Nome)
VALUES ('Aumenta a regeneração de mana', 4, 'Amuleto de Mana', 'Amuleto de Mana');

-- Inserindo ferramentas
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Machado', 60, 75, 15, 'Machado de Ferro');
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Serra', 55, 65, 20, 'Serra de Madeira');
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Picareta', 70, 80, 25, 'Picareta de Ouro');
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Martelo', 50, 60, 10, 'Martelo de Prata');
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Espada', 70, 0, 4, 'Espada de Ferro');
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Espada', 100, 0, 4, 'Espada de Diamante');
INSERT INTO Ferramenta (Tipo, Poder, Eficiencia, ChanceCrit, Item_Nome)
VALUES ('Braco', 10, 0, 4, 'Braco de zumbi');

-- Inserindo modificadores
INSERT INTO Modificador (Nome, Efeito)
VALUES ('Rápido', 'Aumenta a velocidade de ataque');
INSERT INTO Modificador (Nome, Efeito)
VALUES ('Robusto', 'Aumenta a resistência a danos');
INSERT INTO Modificador (Nome, Efeito)
VALUES ('Afiado', 'Aumenta o dano crítico');
INSERT INTO Modificador (Nome, Efeito)
VALUES ('Pesado', 'Aumenta o dano, mas reduz a velocidade');

-- Inserindo buffs
INSERT INTO Buff (Nome, Duracao, Efeito)
VALUES ('Velocidade de Movimento', 300, 'Aumenta a velocidade de movimento');
INSERT INTO Buff (Nome, Duracao, Efeito)
VALUES ('Resistência ao Fogo', 400, 'Reduz dano de fogo');
INSERT INTO Buff (Nome, Duracao, Efeito)
VALUES ('Força Amplificada', 500, 'Aumenta o dano de ataque');
INSERT INTO Buff (Nome, Duracao, Efeito)
VALUES ('Regeneração Rápida', 350, 'Aumenta a velocidade de regeneração de vida');

-- Inserindo blocos
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Construção', 'Bloco de Madeira');
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Construção', 'Bloco de Ferro');
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Construção', 'Bloco de Pedra');
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Construção', 'Bloco de Ouro');
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Criacao', 'Forja');
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Criacao', 'Mesa de Trabalho');
INSERT INTO Bloco (Tipo, Item_Nome)
VALUES ('Criacao', 'Estante do Mago');


-- Inserindo receitas
INSERT INTO Receita (Item_Final, Item_1, Item_2, Item_3, Quantidade_Item_1, Quantidade_Item_2, Quantidade_Item_3, Estacao_Bloco)
VALUES ('Espada de Diamante', 'Diamante', 'Madeira', 'Lona', 10, 5, 3, 'Mesa de Trabalho');

-- Inserção de uma receita com apenas Item_1 e Item_2
INSERT INTO Receita (Item_Final, Item_1, Item_2, Quantidade_Item_1, Quantidade_Item_2, Estacao_Bloco)
VALUES ('Machado de Ferro', 'Ferro', 'Madeira', 7, 10, 'Mesa de Trabalho');

-- Inserção de uma receita com apenas Item_1
INSERT INTO Receita (Item_Final, Item_1, Quantidade_Item_1, Estacao_Bloco)
VALUES ('Espada de Ferro', 'Ferro', 5, 'Mesa de Trabalho');

-- Inserção de uma receita com todos os itens especificados
INSERT INTO Receita (Item_Final, Item_1, Item_2, Item_3, Quantidade_Item_1, Quantidade_Item_2, Quantidade_Item_3, Estacao_Bloco)
VALUES ('Armadura de Ouro', 'Ouro', 'Couro', 'Tecido', 20, 10, 5, 'Forja');

-- Inserção de uma receita com apenas Item_3
INSERT INTO Receita (Item_Final, Item_1, Quantidade_Item_1, Estacao_Bloco)
VALUES ('Capa Magica', 'Tecido', 2, 'Estante do Mago');

-- Inserindo relações 'Possui'
INSERT INTO Possui (ID_Mundo, Bioma_Nome)
VALUES (2, 'Pântano');
INSERT INTO Possui (ID_Mundo, Bioma_Nome)
VALUES (3, 'Montanha');
INSERT INTO Possui (ID_Mundo, Bioma_Nome)
VALUES (4, 'Deserto');
INSERT INTO Possui (ID_Mundo, Bioma_Nome)
VALUES (1, 'Floresta');

-- Inserindo relações 'Acontece'
INSERT INTO Acontece (Evento_Nome, ID_Mundo)
VALUES ('Eclipse Solar', 2);
INSERT INTO Acontece (Evento_Nome, ID_Mundo)
VALUES ('Ano Novo', 3);
INSERT INTO Acontece (Evento_Nome, ID_Mundo)
VALUES ('Festival da Colheita', 1);
INSERT INTO Acontece (Evento_Nome, ID_Mundo)
VALUES ('Chuva de Meteoros', 4);

-- Inserindo conteúdos em Instancia_PC
--INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
--VALUES ('Flecha', 3, 50);

-- Inserindo itens soltos por NPCs
INSERT INTO Solta (Item_Nome, ID_NPC)
VALUES ('Braco de zumbi', 1);
INSERT INTO Solta (Item_Nome, ID_NPC)
VALUES ('Gel', 2);

-- Inserindo partes de biomas
INSERT INTO Faz_Parte_Bioma (Item_Nome, Bioma_Nome)
VALUES ('Bloco de Madeira', 'Pântano');
INSERT INTO Faz_Parte_Bioma (Item_Nome, Bioma_Nome)
VALUES ('Bloco de Ferro', 'Montanha');
INSERT INTO Faz_Parte_Bioma (Item_Nome, Bioma_Nome)
VALUES ('Bloco de Pedra', 'Deserto');
INSERT INTO Faz_Parte_Bioma (Item_Nome, Bioma_Nome)
VALUES ('Bloco de Ouro', 'Floresta');

-- Inserindo requisitos de receitas
INSERT INTO Requer (ID_Receita, Item_Nome)
VALUES (2, 'Bloco de Ferro');
INSERT INTO Requer (ID_Receita, Item_Nome)
VALUES (3, 'Bloco de Madeira');
INSERT INTO Requer (ID_Receita, Item_Nome)
VALUES (4, 'Bloco de Ouro');
INSERT INTO Requer (ID_Receita, Item_Nome)
VALUES (1, 'Bloco de Ferro');

-- Inserindo modificações em roupas
INSERT INTO Roupa_Tem (Roupa_Nome, Modificadores_Nome)
VALUES ('Elmo de Aço', 'Robusto');
INSERT INTO Roupa_Tem (Roupa_Nome, Modificadores_Nome)
VALUES ('Escudo de Prata', 'Robusto');
INSERT INTO Roupa_Tem (Roupa_Nome, Modificadores_Nome)
VALUES ('Armadura de Couro', 'Afiado');
INSERT INTO Roupa_Tem (Roupa_Nome, Modificadores_Nome)
VALUES ('Elmo de Ouro', 'Pesado');

-- Inserindo modificações em acessórios
INSERT INTO Acessorio_Tem (Acessorio_Nome, Modificadores_Nome)
VALUES ('Anel de Velocidade', 'Rápido');
INSERT INTO Acessorio_Tem (Acessorio_Nome, Modificadores_Nome)
VALUES ('Escudo de Prata', 'Robusto');
INSERT INTO Acessorio_Tem (Acessorio_Nome, Modificadores_Nome)
VALUES ('Colar de Fogo', 'Pesado');
INSERT INTO Acessorio_Tem (Acessorio_Nome, Modificadores_Nome)
VALUES ('Amuleto de Mana', 'Afiado');

-- Inserindo modificações em ferramentas
INSERT INTO Ferramenta_Tem (Ferramenta_Nome, Modificadores_Nome)
VALUES ('Machado de Ferro', 'Rápido');
INSERT INTO Ferramenta_Tem (Ferramenta_Nome, Modificadores_Nome)
VALUES ('Serra de Madeira', 'Afiado');
INSERT INTO Ferramenta_Tem (Ferramenta_Nome, Modificadores_Nome)
VALUES ('Picareta de Ouro', 'Pesado');
INSERT INTO Ferramenta_Tem (Ferramenta_Nome, Modificadores_Nome)
VALUES ('Martelo de Prata', 'Robusto');

-- Inserindo buffs fornecidos por consumíveis
INSERT INTO Fornece (Buff_Nome, Consumivel_Nome)
VALUES ('Velocidade de Movimento', 'Pocao de Agilidade');
INSERT INTO Fornece (Buff_Nome, Consumivel_Nome)
VALUES ('Resistência ao Fogo', 'Pocao de Resistencia ao Fogo');
INSERT INTO Fornece (Buff_Nome, Consumivel_Nome)
VALUES ('Força Amplificada', 'Pocao de Cura');
INSERT INTO Fornece (Buff_Nome, Consumivel_Nome)
VALUES ('Regeneração Rápida', 'Pocao de Mana');

-- Inserindo relações entre NPCs e biomas
INSERT INTO Faz_Parte_NPC (ID_NPC, Nome_Bioma)
VALUES (1, 'Montanha');
INSERT INTO Faz_Parte_NPC (ID_NPC, Nome_Bioma)
VALUES (2, 'Pântano');
INSERT INTO Faz_Parte_NPC (ID_NPC, Nome_Bioma)
VALUES (3, 'Deserto');
INSERT INTO Faz_Parte_NPC (ID_NPC, Nome_Bioma)
VALUES (4, 'Floresta');