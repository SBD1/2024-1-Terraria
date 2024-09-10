# Triggers e Stored Procedures (SPs)

Triggers e Stored Procedures (SPs) são ferramentas importantes nos bancos de dados para automação de processos, execução de regras de negócio e manutenção da integridade dos dados. Abaixo está uma explicação detalhada de ambos os conceitos, com exemplos.

---

## Triggers

Um **Trigger** (gatilho) é um bloco de código SQL que é executado automaticamente **antes** ou **depois** de uma ação específica no banco de dados, como um `INSERT`, `UPDATE` ou `DELETE`. Ele é acionado sempre que uma dessas operações ocorre em uma tabela.

### Quando usar triggers?
- **Validação de dados**: Garante que certas condições sejam atendidas ao inserir ou modificar dados.
- **Auditoria**: Registra automaticamente quem fez alterações em uma tabela ou quais alterações foram feitas.
- **Atualização de dados relacionados**: Mantém dados consistentes entre tabelas relacionadas.
### Como fuciona:
- O trigger é acionado após um INSERT em uma determinda tabela e atualiza comforme os comandos estabelecidos.

## Stored Procedures (SPs)
Uma Stored Procedure (Procedimento Armazenado) é um bloco de código SQL que pode ser armazenado no banco de dados e executado sob demanda. Diferente de um trigger, uma SP não é acionada automaticamente, mas sim invocada explicitamente.

### Quando usar Stored Procedures?
- **Automação de processos complexos: Realiza operações complexas com múltiplas etapas de uma só vez.
- ** Reutilização de código: Reutiliza lógica comum de forma eficiente.
- ** Melhoria de desempenho: Reduz a transferência de dados entre a aplicação e o banco de dados, melhorando a performance.

### Como funciona:
- Quando a SP é chamada, ela pode inserir uma nova informação nos campos que for informado nela.

# Triggers e Stored Procedures utilizado no projeto

```sql
---Dialogo
CREATE OR REPLACE PROCEDURE sp_inserir_dialogo(
    IN id_dialogo INT,
    IN texto TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Dialogo (ID_Dialogo, Texto)
    VALUES (id_dialogo, texto);
END;
$$;
CREATE OR REPLACE FUNCTION check_dialogo_content()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.texto) = 0 THEN
        RAISE EXCEPTION 'O diálogo não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_dialogo_before_insert
BEFORE INSERT ON Dialogo
FOR EACH ROW
EXECUTE FUNCTION check_dialogo_content();


 ---Personagem

 CREATE OR REPLACE PROCEDURE sp_inserir_personagem(
    IN id_personagem INT,
    IN nome VARCHAR(100),
    IN vida INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Personagem (ID_P, Nome, vida)
    VALUES (id_personagem, nome, vida);
END;
$$;
CREATE OR REPLACE FUNCTION check_personagem_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome do personagem não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_personagem_before_insert
BEFORE INSERT ON Personagem
FOR EACH ROW
EXECUTE FUNCTION check_personagem_data();



---NPC

CREATE OR REPLACE PROCEDURE sp_inserir_npc(
    IN id_personagem INT,
    IN tipo VARCHAR(50),
    IN comportamento TEXT,
    IN id_dialogo INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO NPC (ID_Personagem, Tipo, Comportamento, ID_Dialogo)
    VALUES (id_personagem, tipo, comportamento, id_dialogo);
END;
$$;
CREATE OR REPLACE FUNCTION check_npc_data()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o Personagem existe
    IF NOT EXISTS (SELECT 1 FROM Personagem WHERE ID_P = NEW.ID_Personagem) THEN
        RAISE EXCEPTION 'Personagem % não encontrado', NEW.ID_Personagem;
    END IF;
    -- Verifica se o Diálogo existe
    IF NOT EXISTS (SELECT 1 FROM Dialogo WHERE ID_Dialogo = NEW.ID_Dialogo) THEN
        RAISE EXCEPTION 'Diálogo % não encontrado', NEW.ID_Dialogo;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_npc_before_insert
BEFORE INSERT ON NPC
FOR EACH ROW
EXECUTE FUNCTION check_npc_data();



---PC

CREATE OR REPLACE PROCEDURE sp_inserir_pc(
    IN id_personagem INT,
    IN mana INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO PC (ID_Personagem, Mana)
    VALUES (id_personagem, mana);
END;
$$;

CREATE OR REPLACE TRIGGER trg_pc_before_insert
BEFORE INSERT ON PC
FOR EACH ROW
EXECUTE FUNCTION check_pc_data();

CREATE OR REPLACE FUNCTION check_pc_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.mana < 1 THEN
        RAISE EXCEPTION 'A mana do PC chegou a 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


---Instancia_NPC

CREATE OR REPLACE PROCEDURE sp_inserir_instancia_npc(
    IN id_npc INT,
    IN id_instancia_npc INT,
    IN vida_atual INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Instancia_NPC (ID_NPC, ID_Instancia_NPC, VidaAtual)
    VALUES (id_npc, id_instancia_npc, vida_atual);
END;
$$;
CREATE OR REPLACE FUNCTION check_instancia_npc()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o NPC existe
    IF NOT EXISTS (SELECT 1 FROM NPC WHERE ID_NPC = NEW.ID_NPC) THEN
        RAISE EXCEPTION 'NPC % não encontrado', NEW.ID_NPC;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_instancia_npc_before_insert
BEFORE INSERT ON Instancia_NPC
FOR EACH ROW
EXECUTE FUNCTION check_instancia_npc();




---Instancia_PC

CREATE OR REPLACE PROCEDURE sp_inserir_instancia_pc(
    IN id_pc INT,
    IN vida_atual INT,
    IN id_instancia_pc INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Instancia_PC (ID_PC, VidaAtual, ID_Instancia_PC)
    VALUES (id_pc, vida_atual, id_instancia_pc);
END;
$$;
CREATE OR REPLACE FUNCTION check_instancia_pc()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o PC existe
    IF NOT EXISTS (SELECT 1 FROM PC WHERE ID_PC = NEW.ID_PC) THEN
        RAISE EXCEPTION 'PC % não encontrado', NEW.ID_PC;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_instancia_pc_before_insert
BEFORE INSERT ON Instancia_PC
FOR EACH ROW
EXECUTE FUNCTION check_instancia_pc();




---Bioma

CREATE OR REPLACE PROCEDURE sp_inserir_bioma(
    IN tipo VARCHAR(50),
    IN nome VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Bioma (Tipo, Nome)
    VALUES (tipo, nome);
END;
$$;
CREATE OR REPLACE FUNCTION check_bioma_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome do bioma não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_bioma_before_insert
BEFORE INSERT ON Bioma
FOR EACH ROW
EXECUTE FUNCTION check_bioma_data();


---Mundo

CREATE OR REPLACE PROCEDURE sp_inserir_mundo(
    IN id_mundo INT,
    IN nome VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Mundo (ID_Mundo, Nome)
    VALUES (id_mundo, nome);
END;
$$;
CREATE OR REPLACE FUNCTION check_mundo_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome do mundo não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_mundo_before_insert
BEFORE INSERT ON Mundo
FOR EACH ROW
EXECUTE FUNCTION check_mundo_data();




---Item

CREATE OR REPLACE PROCEDURE sp_inserir_item(
    IN nome VARCHAR(100),
    IN tipo VARCHAR(50),
    IN acumulavel BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Item (Nome, Tipo, Acumulavel)
    VALUES (nome, tipo, acumulavel);
END;
$$;
CREATE OR REPLACE FUNCTION check_item_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome do item não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_item_before_insert
BEFORE INSERT ON Item
FOR EACH ROW
EXECUTE FUNCTION check_item_data();


---Cosumivel

CREATE OR REPLACE PROCEDURE sp_inserir_consumivel(
    IN item_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE ID_Item = id_item) THEN
        RAISE EXCEPTION 'Item não existe';
    END IF;

    -- Insere o consumível
    INSERT INTO Consumivel (Item_Nome)
    VALUES (item_nome);
END;
$$;
CREATE OR REPLACE FUNCTION check_consumivel_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Item WHERE ID_Item = NEW.ID_Item) THEN
        RAISE EXCEPTION 'Item não existe';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_consumivel_before_insert
BEFORE INSERT ON Consumivel
FOR EACH ROW
EXECUTE FUNCTION check_consumivel_data();



---Roupa

CREATE OR REPLACE PROCEDURE sp_inserir_roupa(
    IN item_nome VARCHAR(255),
    IN defesa INT,
    IN descricao VARCHAR(255),
    IN eaparencia BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE ID_Item = id_item) THEN
        RAISE EXCEPTION 'Item não existe';
    END IF;

    -- Insere a roupa
    INSERT INTO Roupa (Defesa, Descriacao, eAparencia, Item_Nome)
    VALUES (defesa, descricao, eaparencia, item_nome);
END;
$$;
CREATE OR REPLACE FUNCTION check_roupa_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Item WHERE ID_Nome = NEW.ID_Nome) THEN
        RAISE EXCEPTION 'Item não existe';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_roupa_before_insert
BEFORE INSERT ON Roupa
FOR EACH ROW
EXECUTE FUNCTION check_roupa_data();




---Acessorio

CREATE OR REPLACE PROCEDURE sp_inserir_acessorio(
    IN defesa INT,
    IN item_nome VARCHAR(100),
    IN efeito VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Acessorio (Efeito, Defesa, Item_Nome)
    VALUES (efeito, defesa, item_nome);
END;
$$;
CREATE OR REPLACE FUNCTION check_acessorio_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.item_nome) = 0 THEN
        RAISE EXCEPTION 'O nome do acessório não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_acessorio_before_insert
BEFORE INSERT ON Acessorio
FOR EACH ROW
EXECUTE FUNCTION check_acessorio_data();




---Ferramenta

CREATE OR REPLACE PROCEDURE sp_inserir_ferramenta(
    IN tipo VARCHAR(50),
    IN nome VARCHAR(255),
    IN poder INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Ferramenta (Tipo, Item_Nome, Poder)
    VALUES (tipo, nome, poder);
END;
$$;
CREATE OR REPLACE FUNCTION check_ferramenta_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome da ferramenta não pode estar vazio';
    END IF;
    IF NEW.poder <= 0 THEN
        RAISE EXCEPTION 'O poder da ferramenta deve ser maior que 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_ferramenta_before_insert
BEFORE INSERT ON Ferramenta
FOR EACH ROW
EXECUTE FUNCTION check_ferramenta_data();



---Modificador

CREATE OR REPLACE PROCEDURE sp_inserir_modificador(
    IN nome VARCHAR(100),
    IN efeito VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Modificador (Nome, Efeito)
    VALUES (nome, efeito);
END;
$$;
CREATE OR REPLACE FUNCTION check_modificador_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome do modificador não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_modificador_before_insert
BEFORE INSERT ON Modificador
FOR EACH ROW
EXECUTE FUNCTION check_modificador_data();




---Buff

CREATE OR REPLACE PROCEDURE sp_inserir_buff(
    IN nome VARCHAR(255),
    IN duracao INT,
    IN efeito VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Buff (Nome, Duracao, Efeito)
    VALUES (nome, duracao, efeito);
END;
$$;
CREATE OR REPLACE FUNCTION check_buff_data()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.nome) = 0 THEN
        RAISE EXCEPTION 'O nome do buff não pode estar vazio';
    END IF;
    IF NEW.duracao <= 0 THEN
        RAISE EXCEPTION 'A duração do buff deve ser maior que 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_buff_before_insert
BEFORE INSERT ON Buff
FOR EACH ROW
EXECUTE FUNCTION check_buff_data();


---Bloco

CREATE OR REPLACE PROCEDURE sp_inserir_bloco(
    IN tipo VARCHAR(50),
     item_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Bloco (Tipo, Item_Nome)
    VALUES (tipo, item_nome);
END;
$$;
CREATE OR REPLACE FUNCTION check_bloco_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.item_nome <= 0 THEN
        RAISE EXCEPTION 'o nome não pode estar vazio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_bloco_before_insert
BEFORE INSERT ON Bloco
FOR EACH ROW
EXECUTE FUNCTION check_bloco_data();


---Posição

CREATE OR REPLACE PROCEDURE sp_inserir_posicao(
    IN x INT,
    IN y INT,
    IN id_mundo INT,
    IN id_personagem INT
)
LANGUAGE plpgsql
AS $Posicao$
BEGIN
    INSERT INTO Posicao (ID_Mundo, ID_Persongem, X, Y)
    VALUES (id_mundo, id_personagem, x, y);
END;
$Posicao$;
CREATE OR REPLACE FUNCTION check_posicao_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.x IS NULL OR NEW. IS NULL THEN
        RAISE EXCEPTION 'Coordenadas X e Y não podem ser nulas';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_posicao_before_insert
BEFORE INSERT ON Posicao
FOR EACH ROW
EXECUTE FUNCTION check_posicao_data();




---Possui


CREATE OR REPLACE PROCEDURE sp_inserir_possui(
    IN id_mundo INT,
    IN bioma_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o mundo existe
    IF NOT EXISTS (SELECT 1 FROM Mundo WHERE ID_Mundo = id_mundo) THEN
        RAISE EXCEPTION 'Mundo com ID % não existe', id_mundo;
    END IF;

    -- Verifica se o bioma existe
    IF NOT EXISTS (SELECT 1 FROM Bioma WHERE Nome = bioma_nome) THEN
        RAISE EXCEPTION 'Bioma % não existe', bioma_nome;
    END IF;

    -- Insere a relação na tabela Possui
    INSERT INTO Possui (ID_Mundo, Bioma_Nome)
    VALUES (id_mundo, bioma_nome);
END;
$$;

-- Função do Trigger
CREATE OR REPLACE FUNCTION trg_possui_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a relação já existe
    IF EXISTS (SELECT 1 FROM Possui WHERE ID_Mundo = NEW.ID_Mundo AND Bioma_Nome = NEW.Bioma_Nome) THEN
        RAISE EXCEPTION 'Relação entre Mundo % e Bioma % já existe', NEW.ID_Mundo, NEW.Bioma_Nome;
    END IF;

    -- Log da inserção (opcional)
    RAISE NOTICE 'Inserindo nova relação: Mundo % - Bioma %', NEW.ID_Mundo, NEW.Bioma_Nome;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_possui_insert
BEFORE INSERT ON Possui
FOR EACH ROW
EXECUTE FUNCTION trg_possui_before_insert();


---Acontece

CREATE OR REPLACE PROCEDURE sp_inserir_acontece(
    IN evento_nome VARCHAR(255),
    IN id_mundo INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o evento e o bioma existem
    IF NOT EXISTS (SELECT 1 FROM Mundo WHERE ID_Mundo = id_mundo) THEN
        RAISE EXCEPTION 'Mundo não existe';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Evento WHERE Nome = evento_nome) THEN
        RAISE EXCEPTION 'evento não existe';
    END IF;

    INSERT INTO Acontece (Evento_Nome, ID_Mundo)
    VALUES (evento_nome, id_mundo);
END;
$$;
CREATE OR REPLACE FUNCTION check_acontece_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Evento WHERE Nome = NEW.Evento_Nome) THEN
        RAISE EXCEPTION 'Evento não existe';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Mundo WHERE ID_Mundo = NEW.ID_Mundo) THEN
        RAISE EXCEPTION 'Mundo não existe';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_acontece_before_insert
BEFORE INSERT ON Acontece
FOR EACH ROW
EXECUTE FUNCTION check_acontece_data();




---Contem

CREATE OR REPLACE PROCEDURE sp_inserir_contem(
    IN p_item_nome VARCHAR(255),
    IN p_id_instancia_pc INT,
    IN p_quantidade INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = p_item_nome) THEN
        RAISE EXCEPTION 'Item % não existe', p_item_nome;
    END IF;

    -- Verifica se a instância do PC existe
    IF NOT EXISTS (SELECT 1 FROM Instancia_PC WHERE ID_Instancia_PC = p_id_instancia_pc) THEN
        RAISE EXCEPTION 'Instância PC com ID % não existe', p_id_instancia_pc;
    END IF;

    -- Verifica se a quantidade é positiva
    IF p_quantidade <= 0 THEN
        RAISE EXCEPTION 'Quantidade deve ser positiva';
    END IF;

    -- Insere a relação na tabela Contem
    INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
    VALUES (p_item_nome, p_id_instancia_pc, p_quantidade);
END;
$$;
-- Função do Trigger
CREATE OR REPLACE FUNCTION trg_contem_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a quantidade é positiva
    IF NEW.Quantidade <= 0 THEN
        RAISE EXCEPTION 'Quantidade de itens deve ser maior que zero';
    END IF;

    -- Log da inserção (opcional)
    RAISE NOTICE 'Inserindo nova relação: Item % - Instância_PC % - Quantidade %', NEW.Item_Nome, NEW.ID_Instancia_PC, NEW.Quantidade;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_contem_insert
BEFORE INSERT ON Contem
FOR EACH ROW
EXECUTE FUNCTION trg_contem_before_insert();


---Solta

CREATE OR REPLACE PROCEDURE sp_inserir_solta(
    IN p_item_nome VARCHAR(255),
    IN p_id_instancia_npc INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o item existe na tabela Item
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = p_item_nome) THEN
        RAISE EXCEPTION 'Item % não existe', p_item_nome;
    END IF;

    -- Verifica se a instância do NPC existe na tabela Instancia_NPC
    IF NOT EXISTS (SELECT 1 FROM Instancia_NPC WHERE ID_Instancia_NPC = p_id_instancia_npc) THEN
        RAISE EXCEPTION 'Instância de NPC com ID % não existe', p_id_instancia_npc;
    END IF;

    -- Insere a relação na tabela Solta
    INSERT INTO Solta (Item_Nome, ID_Instancia_NPC)
    VALUES (p_item_nome, p_id_instancia_npc);
END;
$$;
-- Função do Trigger
CREATE OR REPLACE FUNCTION trg_solta_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = NEW.Item_Nome) THEN
        RAISE EXCEPTION 'Item % não existe', NEW.Item_Nome;
    END IF;

    -- Verifica se a instância do NPC existe
    IF NOT EXISTS (SELECT 1 FROM Instancia_NPC WHERE ID_Instancia_NPC = NEW.ID_Instancia_NPC) THEN
        RAISE EXCEPTION 'Instância de NPC com ID % não existe', NEW.ID_Instancia_NPC;
    END IF;

    -- Log da inserção (opcional)
    RAISE NOTICE 'Inserindo nova relação: Item % - Instância_NPC %', NEW.Item_Nome, NEW.ID_Instancia_NPC;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_solta_insert
BEFORE INSERT ON Solta
FOR EACH ROW
EXECUTE FUNCTION trg_solta_before_insert();



---Faz_Parte_Bioma

CREATE OR REPLACE PROCEDURE sp_inserir_faz_parte_bioma(
    IN p_item_nome VARCHAR(255),
    IN p_bioma_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = p_item_nome) THEN
        RAISE EXCEPTION 'Item % não existe', p_item_nome;
    END IF;

    -- Verifica se o bioma existe
    IF NOT EXISTS (SELECT 1 FROM Bioma WHERE Nome = p_bioma_nome) THEN
        RAISE EXCEPTION 'Bioma % não existe', p_bioma_nome;
    END IF;

    -- Insere na tabela Faz_Parte_Bioma
    INSERT INTO Faz_Parte_Bioma (Item_Nome, Bioma_Nome)
    VALUES (p_item_nome, p_bioma_nome);
END;
$$;
CREATE OR REPLACE FUNCTION trg_faz_parte_bioma_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = NEW.Item_Nome) THEN
        RAISE EXCEPTION 'Item % não existe', NEW.Item_Nome;
    END IF;

    -- Verifica se o bioma existe
    IF NOT EXISTS (SELECT 1 FROM Bioma WHERE Nome = NEW.Bioma_Nome) THEN
        RAISE EXCEPTION 'Bioma % não existe', NEW.Bioma_Nome;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_faz_parte_bioma_insert
BEFORE INSERT ON Faz_Parte_Bioma
FOR EACH ROW
EXECUTE FUNCTION trg_faz_parte_bioma_before_insert();


---Requer

CREATE OR REPLACE PROCEDURE sp_inserir_requer(
    IN p_id_receita INT,
    IN p_item_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se a receita existe
    IF NOT EXISTS (SELECT 1 FROM Receita WHERE ID_Receita = p_id_receita) THEN
        RAISE EXCEPTION 'Receita com ID % não existe', p_id_receita;
    END IF;

    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = p_item_nome) THEN
        RAISE EXCEPTION 'Item % não existe', p_item_nome;
    END IF;

    -- Insere na tabela Requer
    INSERT INTO Requer (ID_Receita, Item_Nome)
    VALUES (p_id_receita, p_item_nome);
END;
$$;
CREATE OR REPLACE FUNCTION trg_requer_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a receita existe
    IF NOT EXISTS (SELECT 1 FROM Receita WHERE ID_Receita = NEW.ID_Receita) THEN
        RAISE EXCEPTION 'Receita com ID % não existe', NEW.ID_Receita;
    END IF;

    -- Verifica se o item existe
    IF NOT EXISTS (SELECT 1 FROM Item WHERE Nome = NEW.Item_Nome) THEN
        RAISE EXCEPTION 'Item % não existe', NEW.Item_Nome;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_requer_insert
BEFORE INSERT ON Requer
FOR EACH ROW
EXECUTE FUNCTION trg_requer_before_insert();


---Roupa_Tem

CREATE OR REPLACE PROCEDURE sp_inserir_roupa_tem(
    IN p_roupa_nome VARCHAR(255),
    IN p_modificadores_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se a roupa existe
    IF NOT EXISTS (SELECT 1 FROM Roupa WHERE Item_Nome = p_roupa_nome) THEN
        RAISE EXCEPTION 'Roupa % não existe', p_roupa_nome;
    END IF;

    -- Verifica se o modificador existe
    IF NOT EXISTS (SELECT 1 FROM Modificador WHERE Nome = p_modificadores_nome) THEN
        RAISE EXCEPTION 'Modificador % não existe', p_modificadores_nome;
    END IF;

    -- Insere na tabela Roupa_Tem
    INSERT INTO Roupa_Tem (Roupa_Nome, Modificadores_Nome)
    VALUES (p_roupa_nome, p_modificadores_nome);
END;
$$;
CREATE OR REPLACE FUNCTION trg_roupa_tem_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a roupa existe
    IF NOT EXISTS (SELECT 1 FROM Roupa WHERE Item_Nome = NEW.Roupa_Nome) THEN
        RAISE EXCEPTION 'Roupa % não existe', NEW.Roupa_Nome;
    END IF;

    -- Verifica se o modificador existe
    IF NOT EXISTS (SELECT 1 FROM Modificador WHERE Nome = NEW.Modificadores_Nome) THEN
        RAISE EXCEPTION 'Modificador % não existe', NEW.Modificadores_Nome;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_roupa_tem_insert
BEFORE INSERT ON Roupa_Tem
FOR EACH ROW
EXECUTE FUNCTION trg_roupa_tem_before_insert();


---Ferramenta_Tem

CREATE OR REPLACE PROCEDURE sp_inserir_ferramenta_tem(
    IN p_ferramenta_nome VARCHAR(255),
    IN p_modificadores_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se a ferramenta existe
    IF NOT EXISTS (SELECT 1 FROM Ferramenta WHERE Item_Nome = p_ferramenta_nome) THEN
        RAISE EXCEPTION 'Ferramenta % não existe', p_ferramenta_nome;
    END IF;

    -- Verifica se o modificador existe
    IF NOT EXISTS (SELECT 1 FROM Modificador WHERE Nome = p_modificadores_nome) THEN
        RAISE EXCEPTION 'Modificador % não existe', p_modificadores_nome;
    END IF;

    -- Insere na tabela Ferramenta_Tem
    INSERT INTO Ferramenta_Tem (Ferramenta_Nome, Modificadores_Nome)
    VALUES (p_ferramenta_nome, p_modificadores_nome);
END;
$$;
CREATE OR REPLACE FUNCTION trg_ferramenta_tem_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a ferramenta existe
    IF NOT EXISTS (SELECT 1 FROM Ferramenta WHERE Item_Nome = NEW.Ferramenta_Nome) THEN
        RAISE EXCEPTION 'Ferramenta % não existe', NEW.Ferramenta_Nome;
    END IF;

    -- Verifica se o modificador existe
    IF NOT EXISTS (SELECT 1 FROM Modificador WHERE Nome = NEW.Modificadores_Nome) THEN
        RAISE EXCEPTION 'Modificador % não existe', NEW.Modificadores_Nome;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ferramenta_tem_insert
BEFORE INSERT ON Ferramenta_Tem
FOR EACH ROW
EXECUTE FUNCTION trg_ferramenta_tem_before_insert();



---Acessorio_Tem

CREATE OR REPLACE PROCEDURE sp_inserir_acessorio_tem(
    IN p_acessorio_nome VARCHAR(255),
    IN p_modificadores_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o acessório existe
    IF NOT EXISTS (SELECT 1 FROM Acessorio WHERE Item_Nome = p_acessorio_nome) THEN
        RAISE EXCEPTION 'Acessório % não existe', p_acessorio_nome;
    END IF;

    -- Verifica se o modificador existe
    IF NOT EXISTS (SELECT 1 FROM Modificador WHERE Nome = p_modificadores_nome) THEN
        RAISE EXCEPTION 'Modificador % não existe', p_modificadores_nome;
    END IF;

    -- Insere na tabela Acessorio_Tem
    INSERT INTO Acessorio_Tem (Acessorio_Nome, Modificadores_Nome)
    VALUES (p_acessorio_nome, p_modificadores_nome);
END;
$$;
CREATE OR REPLACE FUNCTION trg_acessorio_tem_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o acessório existe
    IF NOT EXISTS (SELECT 1 FROM Acessorio WHERE Item_Nome = NEW.Acessorio_Nome) THEN
        RAISE EXCEPTION 'Acessório % não existe', NEW.Acessorio_Nome;
    END IF;

    -- Verifica se o modificador existe
    IF NOT EXISTS (SELECT 1 FROM Modificador WHERE Nome = NEW.Modificadores_Nome) THEN
        RAISE EXCEPTION 'Modificador % não existe', NEW.Modificadores_Nome;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_acessorio_tem_insert
BEFORE INSERT ON Acessorio_Tem
FOR EACH ROW
EXECUTE FUNCTION trg_acessorio_tem_before_insert();


---Fornece

CREATE OR REPLACE PROCEDURE sp_inserir_fornece(
    IN p_buff_nome VARCHAR(255),
    IN p_consumivel_nome VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o buff existe
    IF NOT EXISTS (SELECT 1 FROM Buff WHERE Nome = p_buff_nome) THEN
        RAISE EXCEPTION 'Buff % não existe', p_buff_nome;
    END IF;

    -- Verifica se o consumível existe
    IF NOT EXISTS (SELECT 1 FROM Consumivel WHERE Item_Nome = p_consumivel_nome) THEN
        RAISE EXCEPTION 'Consumível % não existe', p_consumivel_nome;
    END IF;

    -- Insere na tabela Fornece
    INSERT INTO Fornece (Buff_Nome, Consumivel_Nome)
    VALUES (p_buff_nome, p_consumivel_nome);
END;
$$;
CREATE OR REPLACE FUNCTION trg_fornece_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o buff existe
    IF NOT EXISTS (SELECT 1 FROM Buff WHERE Nome = NEW.Buff_Nome) THEN
        RAISE EXCEPTION 'Buff % não existe', NEW.Buff_Nome;
    END IF;

    -- Verifica se o consumível existe
    IF NOT EXISTS (SELECT 1 FROM Consumivel WHERE Item_Nome = NEW.Consumivel_Nome) THEN
        RAISE EXCEPTION 'Consumível % não existe', NEW.Consumivel_Nome;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_fornece_insert
BEFORE INSERT ON Fornece
FOR EACH ROW
EXECUTE FUNCTION trg_fornece_before_insert();


---Faz_Parte_NPC

CREATE OR REPLACE PROCEDURE sp_inserir_faz_parte_npc(
    IN p_id_npc INT,
    IN p_nome_bioma VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o NPC existe
    IF NOT EXISTS (SELECT 1 FROM NPC WHERE ID_NPC = p_id_npc) THEN
        RAISE EXCEPTION 'NPC com ID % não existe', p_id_npc;
    END IF;

    -- Verifica se o bioma existe
    IF NOT EXISTS (SELECT 1 FROM Bioma WHERE Nome = p_nome_bioma) THEN
        RAISE EXCEPTION 'Bioma % não existe', p_nome_bioma;
    END IF;

    -- Insere na tabela Faz_Parte_NPC
    INSERT INTO Faz_Parte_NPC (ID_NPC, Nome_Bioma)
    VALUES (p_id_npc, p_nome_bioma);
END;
$$;
CREATE OR REPLACE FUNCTION trg_faz_parte_npc_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o NPC existe
    IF NOT EXISTS (SELECT 1 FROM NPC WHERE ID_NPC = NEW.ID_NPC) THEN
        RAISE EXCEPTION 'NPC com ID % não existe', NEW.ID_NPC;
    END IF;

    -- Verifica se o bioma existe
    IF NOT EXISTS (SELECT 1 FROM Bioma WHERE Nome = NEW.Nome_Bioma) THEN
        RAISE EXCEPTION 'Bioma % não existe', NEW.Nome_Bioma;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_faz_parte_npc_insert
BEFORE INSERT ON Faz_Parte_NPC
FOR EACH ROW
EXECUTE FUNCTION trg_faz_parte_npc_before_insert();

````

|   Data   | Versão |        Descrição         |                   Autor                    |
| :------: | :----: | :----------------------: | :----------------------------------------: |
| 09/09/24 |  1.0   |   Criação do documento   | [Eduardo](https://github.com/edudsan) |
