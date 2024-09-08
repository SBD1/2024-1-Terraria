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
    ID_Dialogo INT NOT NULL,
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
    ID_Instancia_NPC INT NOT NULL,
    FOREIGN KEY (Item_Nome) REFERENCES Item(Nome),
    FOREIGN KEY (ID_Instancia_NPC) REFERENCES Instancia_NPC(ID_Instancia_NPC)
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

