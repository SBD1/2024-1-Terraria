-- Consultar todos os detalhes dos NPCs, incluindo o diálogo associado:
SELECT 
    NPC.ID_NPC, 
    Personagem.Nome AS Nome_Personagem, 
    NPC.Tipo, 
    NPC.Comportamento, 
    Dialogo.Texto AS Dialogo_Associado
FROM 
    NPC
JOIN 
    Personagem ON NPC.ID_Personagem = Personagem.ID_P
JOIN 
    Dialogo ON NPC.ID_Dialogo = Dialogo.ID_Dialogo;

-- Listar todos os itens que fazem parte de um determinado bioma:
SELECT 
    Item.Nome AS Nome_Item, 
    Bioma.Nome AS Nome_Bioma, 
    Bioma.Tipo AS Tipo_Bioma
FROM 
    Faz_Parte_Bioma
JOIN 
    Item ON Faz_Parte_Bioma.Item_Nome = Item.Nome
JOIN 
    Bioma ON Faz_Parte_Bioma.Bioma_Nome = Bioma.Nome
WHERE 
    Bioma.Nome = 'Floresta';

-- Consultar todos os personagens e suas posições no mundo:
SELECT 
    Personagem.Nome AS Nome_Personagem, 
    Mundo.Nome AS Nome_Mundo, 
    Posicao.X, 
    Posicao.Y
FROM 
    Posicao
JOIN 
    Personagem ON Posicao.ID_Personagem = Personagem.ID_P
JOIN 
    Mundo ON Posicao.ID_Mundo = Mundo.ID_Mundo;

-- Listar todos os eventos que ocorrem em um determinado mundo:
SELECT 
    Evento.Nome AS Nome_Evento, 
    Evento.Tipo, 
    Evento.Data_Inicio, 
    Evento.Data_Fim, 
    Mundo.Nome AS Nome_Mundo
FROM 
    Acontece
JOIN 
    Evento ON Acontece.Evento_Nome = Evento.Nome
JOIN 
    Mundo ON Acontece.ID_Mundo = Mundo.ID_Mundo
WHERE 
    Mundo.Nome = 'Mundo do Caos';  -- Substitua 'Mundo1' pelo nome do mundo desejado

-- Consultar todas as receitas que utilizam um determinado item:
SELECT 
    r.ID_Receita,
    r.Item_Final,
    r.Item_1,
    r.Quantidade_Item_1,
    r.Item_2,
    r.Quantidade_Item_2,
    r.Item_3,
    r.Quantidade_Item_3,
    r.Estacao_Bloco
FROM 
    Receita r
WHERE 
    r.Item_1 = 'Ferro'
    OR r.Item_2 = 'Ferro'
    OR r.Item_3 = 'Ferro';
	
-- Listar todos os modificadores aplicados a uma ferramenta específica:
SELECT 
    Ferramenta.Item_Nome AS Nome_Ferramenta, 
    Modificador.Nome AS Nome_Modificador, 
    Modificador.Efeito
FROM 
    Ferramenta_Tem
JOIN 
    Ferramenta ON Ferramenta_Tem.Ferramenta_Nome = Ferramenta.Item_Nome
JOIN 
    Modificador ON Ferramenta_Tem.Modificadores_Nome = Modificador.Nome
WHERE 
    Ferramenta.Item_Nome = 'Picareta de Ouro';
	
-- Consultar todos os buffs fornecidos por um consumível específico:

SELECT 
    Consumivel.Item_Nome AS Nome_Consumivel, 
    Buff.Nome AS Nome_Buff, 
    Buff.Duracao, 
    Buff.Efeito
FROM 
    Fornece
JOIN 
    Consumivel ON Fornece.Consumivel_Nome = Consumivel.Item_Nome
JOIN 
    Buff ON Fornece.Buff_Nome = Buff.Nome
WHERE 
    Consumivel.Item_Nome = 'Pocao de Resistencia ao Fogo';

-- Consulta todos os intens possuidos por cada um dos PC's existentes
SELECT
    ipc.ID_PC AS ID_PC,
    i.Nome AS Item,
    c.Quantidade AS Quantidade
FROM
    Contem c
JOIN
    Instancia_PC ipc ON c.ID_Instancia_PC = ipc.ID_Instancia_PC
JOIN
    Item i ON c.Item_Nome = i.Nome
ORDER BY
    ipc.ID_PC;