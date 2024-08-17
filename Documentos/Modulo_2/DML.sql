-- Inserindo diálogos
INSERT INTO Dialogo (Texto) VALUES ('Que dia lindo para uma aventura!');
INSERT INTO Dialogo (Texto) VALUES ('Parece que uma tempestade está se aproximando.');
INSERT INTO Dialogo (Texto) VALUES ('Cuidado, não vá muito longe na floresta!');
INSERT INTO Dialogo (Texto) VALUES ('Voce ouviu aquele som? Algo está se aproximando...');

-- Inserindo personagens
INSERT INTO Personagem (Nome, Vida) VALUES ('Guerreiro', 300);
INSERT INTO Personagem (Nome, Vida) VALUES ('Espectro', 150);
INSERT INTO Personagem (Nome, Vida) VALUES ('Dragão', 500);
INSERT INTO Personagem (Nome, Vida) VALUES ('Mago', 200);

-- Inserindo NPCs
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (1, 'Guerreiro', 'Defende a vila', 1);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (2, 'Espectro', 'Ataca à noite', 2);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (3, 'Dragão', 'Guardião da montanha', 3);
INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
VALUES (4, 'Mago', 'Conselheiro sábio', 4);

-- Inserindo PCs
INSERT INTO PC (ID_Personagem, Mana) VALUES (1, 250);
INSERT INTO PC (ID_Personagem, Mana) VALUES (2, 180);
INSERT INTO PC (ID_Personagem, Mana) VALUES (3, 300);
INSERT INTO PC (ID_Personagem, Mana) VALUES (4, 350);

-- Inserindo instâncias de PC
INSERT INTO Instancia_PC (VidaAtual, ManaAtual, ID_PC) VALUES (270, 200, 1);
INSERT INTO Instancia_PC (VidaAtual, ManaAtual, ID_PC) VALUES (260, 150, 2);
INSERT INTO Instancia_PC (VidaAtual, ManaAtual, ID_PC) VALUES (500, 250, 3);
INSERT INTO Instancia_PC (VidaAtual, ManaAtual, ID_PC) VALUES (180, 320, 4);

-- Inserindo instâncias de NPC
INSERT INTO Instancia_NPC (ID_NPC, VidaAtual, Nome)
VALUES (1, 290, 'Guerreiro');
INSERT INTO Instancia_NPC (ID_NPC, VidaAtual, Nome)
VALUES (2, 140, 'Espectro');
INSERT INTO Instancia_NPC (ID_NPC, VidaAtual, Nome)
VALUES (3, 450, 'Dragão');
INSERT INTO Instancia_NPC (ID_NPC, VidaAtual, Nome)
VALUES (4, 190, 'Mago');

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

-- Inserindo posições
INSERT INTO Posicao (ID_Mundo, ID_Personagem, X, Y)
VALUES (2, 1, 300, 400);
INSERT INTO Posicao (ID_Mundo, ID_Personagem, X, Y)
VALUES (3, 2, 500, 600);
INSERT INTO Posicao (ID_Mundo, ID_Personagem, X, Y)
VALUES (4, 3, 700, 800);
INSERT INTO Posicao (ID_Mundo, ID_Personagem, X, Y)
VALUES (1, 4, 900, 1000);

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
INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
VALUES ('Flecha', 3, 50);
INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
VALUES ('Pocao de Resistencia ao Fogo', 4, 2);
INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
VALUES ('Arco de Madeira', 2, 1);
INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
VALUES ('Machado de Ferro', 1, 1);

-- Inserindo itens soltos por NPCs
INSERT INTO Solta (Item_Nome, ID_Instancia_NPC)
VALUES ('Elmo de Aço', 1);
INSERT INTO Solta (Item_Nome, ID_Instancia_NPC)
VALUES ('Machado de Ferro', 2);
INSERT INTO Solta (Item_Nome, ID_Instancia_NPC)
VALUES ('Colar de Fogo', 3);
INSERT INTO Solta (Item_Nome, ID_Instancia_NPC)
VALUES ('Anel de Velocidade', 4);

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
