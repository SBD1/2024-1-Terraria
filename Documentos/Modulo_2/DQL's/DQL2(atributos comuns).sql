-- Consulta para a Tabela Dialogo
SELECT
    ID_Dialogo,
    Texto
FROM
    Dialogo;

-- Consulta para a Tabela Personagem
SELECT
    ID_P
    Nome,
    Vida
FROM
    Personagem;

-- Consulta para a Tabela NPC
SELECT
    ID_NPC,
    ID_Personagem,
    Tipo,
    Comportamento,
    ID_Dialogo
FROM
    NPC;

-- Consulta para a Tabela PC
SELECT
    ID_Personagem,
    Mana
FROM
    PC;

-- Consulta para a Tabela Instancia_PC
SELECT
    ID_Instancia_PC,
    VidaAtual,
    ManaAtual,
    ID_PC
FROM
    Instancia_PC;

-- Consulta para a Tabela Instancia_NPC
SELECT
    ID_Instancia_NPC,
    ID_NPC,
    VidaAtual,
    Nome
FROM
    Instancia_NPC;

-- Consulta para a Tabela Bioma
SELECT
    Nome,
    Tipo
FROM
    Bioma;

-- Consulta para a Tabela Mundo
SELECT
    Nome,
    Tamanho,
    Semente,
    Dificuldade,
    Clima,
    Hora_do_Dia
FROM
    Mundo;

-- Consulta para a Tabela Evento
SELECT
    Nome,
    Tipo,
    Data_Inicio,
    Data_Fim
FROM
    Evento;

-- Consulta para a Tabela Item
SELECT
    Nome,
    Tipo,
    Acumulavel
FROM
    Item;

-- Consulta para a Tabela Consumivel
SELECT
    Item_Nome
FROM
    Consumivel;

-- Consulta para a Tabela Roupa
SELECT
    Defesa,
    Descricao,
    eAperencia,
    Item_Nome
FROM
    Roupa;

-- Consulta para a Tabela Acessorio
SELECT
    Efeito,
    Defesa,
    Descricao,
    Item_Nome
FROM
    Acessorio;

-- Consulta para a Tabela Ferramenta
SELECT
    Tipo,
    Poder,
    Eficiencia,
    ChanceCrit,
    Item_Nome
FROM
    Ferramenta;

-- Consulta para a Tabela Bloco
SELECT
    Tipo,
    Item_Nome
FROM
    Bloco;

-- Consulta para a Tabela Receita
SELECT
    Item_Final,
    Item_1,
    Item_2,
    Item_3,
    Quantidade_Item_1,
    Quantidade_Item_2,
    Quantidade_Item_3,
    Estacao_Bloco
FROM
    Receita;

-- Consulta para a Tabela Posicao
SELECT
    ID_Mundo,
    ID_Personagem,
    X,
    Y
FROM
    Posicao;

-- Consulta para a Tabela Possui
SELECT
    ID_Mundo,
    Bioma_Nome
FROM
    Possui;

-- Consulta para a Tabela Acontece
SELECT
    Evento_Nome,
    ID_Mundo
FROM
    Acontece;

-- Consulta para a Tabela Contem
SELECT
    Item_Nome,
    ID_Instancia_PC,
    Quantidade
FROM
    Contem;

-- Consulta para a Tabela Solta
SELECT
    Item_Nome,
    ID_Instancia_NPC
FROM
    Solta;

-- Consulta para a Tabela Faz_Parte_Bioma
SELECT
    Item_Nome,
    Bioma_Nome
FROM
    Faz_Parte_Bioma;

-- Consulta para a Tabela Requer
SELECT
    ID_Receita,
    Item_Nome
FROM
    Requer;

-- Consulta para a Tabela Roupa_Tem
SELECT
    Roupa_Nome,
    Modificadores_Nome
FROM
    Roupa_Tem;

-- Consulta para a Tabela Acessorio_Tem
SELECT
    Acessorio_Nome,
    Modificadores_Nome
FROM
    Acessorio_Tem;

-- Consulta para a Tabela Ferramenta_Tem
SELECT
    Ferramenta_Nome,
    Modificadores_Nome
FROM
    Ferramenta_Tem;

-- Consulta para a Tabela Fornece
SELECT
    Buff_Nome,
    Consumivel_Nome
FROM
    Fornece;

-- Consulta para a Tabela Faz_Parte_NPC
SELECT
    ID_NPC,
    Nome_Bioma
FROM
    Faz_Parte_NPC;