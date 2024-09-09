import cmd
import sys
import os
import time
import random
import psycopg2

def create_connection():
    connection = psycopg2.connect(
        dbname="polls",
        user="postgres",
        password="Postgres2021!",
        host="localhost",
        port="5432"
    )
    return connection

def criar_personagem_jogavel(connection, nome_personagem):
    vida_inicial = 100
    mana_inicial = 20
    vida_atual = vida_inicial
    mana_atual = mana_inicial
    
    try:
        # Inicia uma transação
        with connection.cursor() as cur:
            # Insere o personagem na tabela "personagem"

            cur.execute("""
                INSERT INTO personagem (nome, vida)
                VALUES (%s, %s)
                RETURNING id_p;
            """, (nome_personagem, vida_inicial))
            
            # Obtém o id do personagem recém-inserido
            id_personagem = cur.fetchone()[0]
            
            # Insere o personagem jogável (PC) na tabela "pc"
            cur.execute("""
                INSERT INTO pc (id_personagem, mana)
                VALUES (%s, %s)
                RETURNING id_pc;
            """, (id_personagem, mana_inicial))
            
            # Obtém o id do PC recém-inserido
            id_pc = cur.fetchone()[0]
            
            # Insere a instância do personagem jogável (instancia_pc)
            cur.execute("""
                INSERT INTO instancia_pc (id_pc, vidaAtual, manaAtual)
                VALUES (%s, %s, %s)
                RETURNING id_instancia_pc;
            """, (id_pc, vida_atual, mana_atual))

            mundo = ['enfermeira', 'minerio', 'zumbi', 'guia', 'tesouro', 'item', 'slime', 'zumbi', 'minerio', 'mercador', 'zumbi', 'item', 'zumbi', 'minerio', 'slime']

            cur.execute('SELECT nome FROM item')
            lista_itens = [row[0] for row in cur.fetchall()]
            for i in range(len(mundo)):
                if mundo[i] == 'item':
                    temp = str(random.choice(lista_itens))
                    mundo[i] = temp
            
            cur.execute("SELECT nome FROM item WHERE tipo = 'Material'")
            lista_itens = [row[0] for row in cur.fetchall()]
            for i in range(len(mundo)):
                if mundo[i] == 'minerio':
                    temp = str(random.choice(lista_itens))
                    mundo[i] = temp

            cur.execute("SELECT nome FROM item WHERE tipo = 'Ferramenta' OR tipo = 'Equipavel'")
            lista_itens = [row[0] for row in cur.fetchall()]
            for i in range(len(mundo)):
                if mundo[i] == 'tesouro':
                    temp = str(random.choice(lista_itens))
                    mundo[i] = temp

            random.shuffle(mundo)
            print(mundo)
            cur.execute(""" 
                INSERT INTO instancia_mundo (ID_PC, a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (id_pc, None, mundo[0], mundo[1], mundo[2], mundo[3], mundo[4], mundo[5], mundo[6], mundo[7], mundo[8], mundo[9], mundo[10], mundo[11], mundo[12], mundo[13], mundo[14]))
            
            # Confirma a transação
            connection.commit()

            # Retorna atributos necessarios do PC para o jogo
            return nome_personagem,vida_atual,mana_atual,id_pc
    
    except Exception as e:
        # Desfaz a transação em caso de erro
        connection.rollback()
        print(f"Erro ao criar personagem jogável: {e}")
        return None

def set_posicao_personagem_criado(connection,id_pc,id_m):
    try:
        cur = connection.cursor()
        x_padrao = 1
        y_padrao = 1

        cur.execute("""
            SELECT id_p FROM personagem
            JOIN pc ON id_p = id_personagem
            WHERE id_pc = (%s)
        """, (id_pc,))

        id_personagem = cur.fetchone()[0]

        if id_personagem is None:
            raise ValueError("Nenhum personagem encontrado para o id_pc fornecido.")

        # Insere a posição incial do personagem criado
        cur.execute("""
            INSERT INTO posicao (id_mundo,id_personagem, x, y)
            VALUES (%s, %s, %s,%s)
        """, (id_m, id_personagem, x_padrao,y_padrao))

        connection.commit()

    except Exception as e:
        # Desfaz a transação em caso de erro
        connection.rollback()
        print(f"Erro ao setar a posição inicial do personagem: {e}")
        return None

def criar_mundo(connection, nome_mundo,tamanho_mundo,dificuldade_mundo):
    
    try:
        cur = connection.cursor()

        # Gerar uma semente aleatória de 6 dígitos
        semente_aleatoria = random.randint(100000, 999999)
        clima_mundo = 4
        Hora_do_Dia_mundo = 12
        
        # Inserir o novo mundo com a semente aleatória
        cur.execute("""
            INSERT INTO Mundo (Nome, tamanho, semente, dificuldade, clima, Hora_do_Dia)
            VALUES (%s, %s, %s, %s, %s, %s)
            RETURNING ID_Mundo;
        """, (nome_mundo,tamanho_mundo,semente_aleatoria,dificuldade_mundo,clima_mundo,Hora_do_Dia_mundo))

        # Obter o ID do novo mundo criado
        id_mundo = cur.fetchone()[0]

        # Confirmar a transação
        connection.commit()

        return id_mundo #nome_mundo,tamanho_mundo,semente_aleatoria,dificuldade_mundo,clima_mundo,Hora_do_Dia_mundo

    except Exception as e:
        # Desfaz a transação em caso de erro
        connection.rollback()
        print(f"Erro ao criar novo mundo: {e}")
        return None

def fabricar_item(connection, id_instancia_pc, id_receita):
    try:
        with connection.cursor() as cur:
            # 1. Recuperar a receita a partir do ID da receita
            cur.execute("""
                SELECT Item_Final, Item_1, Quantidade_Item_1, Item_2, Quantidade_Item_2, Item_3, Quantidade_Item_3 
                FROM Receita 
                WHERE ID_Receita = %s;
            """, (id_receita,))
            receita = cur.fetchone()

            if receita is None:
                raise ValueError("Receita não encontrada.")
            
            item_final, item_1, qtde_1, item_2, qtde_2, item_3, qtde_3 = receita

            # 2. Verificar se o personagem tem os itens necessários no inventário
            # Item 1
            cur.execute("""
                SELECT Quantidade FROM Contem 
                WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
            """, (item_1, id_instancia_pc))
            inventario_1 = cur.fetchone()

            if inventario_1 is None or inventario_1[0] < qtde_1:
                raise ValueError(f"Você não tem itens suficientes de {item_1}.")

            # Item 2 (se existir)
            if item_2:
                cur.execute("""
                    SELECT Quantidade FROM Contem 
                    WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                """, (item_2, id_instancia_pc))
                inventario_2 = cur.fetchone()

                if inventario_2 is None or inventario_2[0] < qtde_2:
                    raise ValueError(f"Você não tem itens suficientes de {item_2}.")
            
            # Item 3 (se existir)
            if item_3:
                cur.execute("""
                    SELECT Quantidade FROM Contem 
                    WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                """, (item_3, id_instancia_pc))
                inventario_3 = cur.fetchone()

                if inventario_3 is None or inventario_3[0] < qtde_3:
                    raise ValueError(f"Você não tem itens suficientes de {item_3}.")

            # 3. Reduzir a quantidade dos itens usados na receita ou deletar se a quantidade chegar a 0
            # Atualizar Item 1
            nova_qtde_1 = inventario_1[0] - qtde_1
            if nova_qtde_1 > 0:
                cur.execute("""
                    UPDATE Contem SET Quantidade = %s 
                    WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                """, (nova_qtde_1, item_1, id_instancia_pc))
            else:
                cur.execute("""
                    DELETE FROM Contem WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                """, (item_1, id_instancia_pc))

            # Atualizar Item 2
            if item_2:
                nova_qtde_2 = inventario_2[0] - qtde_2
                if nova_qtde_2 > 0:
                    cur.execute("""
                        UPDATE Contem SET Quantidade = %s 
                        WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                    """, (nova_qtde_2, item_2, id_instancia_pc))
                else:
                    cur.execute("""
                        DELETE FROM Contem WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                    """, (item_2, id_instancia_pc))

            # Atualizar Item 3
            if item_3:
                nova_qtde_3 = inventario_3[0] - qtde_3
                if nova_qtde_3 > 0:
                    cur.execute("""
                        UPDATE Contem SET Quantidade = %s 
                        WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                    """, (nova_qtde_3, item_3, id_instancia_pc))
                else:
                    cur.execute("""
                        DELETE FROM Contem WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                    """, (item_3, id_instancia_pc))

            # 4. Inserir o item final no inventário
            cur.execute("""
                SELECT Quantidade FROM Contem WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
            """, (item_final, id_instancia_pc))
            inventario_final = cur.fetchone()

            if inventario_final:
                # Atualizar quantidade do item final
                cur.execute("""
                    UPDATE Contem SET Quantidade = Quantidade + 1 
                    WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                """, (item_final, id_instancia_pc))
            else:
                # Inserir novo item no inventário
                cur.execute("""
                    INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade) 
                    VALUES (%s, %s, 1);
                """, (item_final, id_instancia_pc))

            connection.commit()
            print("Item fabricado com sucesso!")

    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Erro: {error}")
        connection.rollback()

def adicionar_itens_para_receita(connection, id_instancia_pc, id_receita):
    with connection.cursor() as cur:
        # Buscar os ingredientes e quantidades necessárias para a receita de id_receita
        cur.execute("""
            SELECT Item_1, Quantidade_Item_1, Item_2, Quantidade_Item_2, Item_3, Quantidade_Item_3
            FROM Receita
            WHERE ID_Receita = %s;
        """, (id_receita,))
        receita = cur.fetchone()

        if not receita:
            print(f"Receita com ID {id_receita} não encontrada.")
            return
        
        item_1, quantidade_1, item_2, quantidade_2, item_3, quantidade_3 = receita

        # Função auxiliar para adicionar ou atualizar um item no inventário
        def adicionar_ou_atualizar_item(item, quantidade):
            if item is not None and quantidade is not None:
                # Verificar se o item já está no inventário
                cur.execute("""
                    SELECT Quantidade FROM Contem
                    WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                """, (item, id_instancia_pc))
                resultado = cur.fetchone()

                if resultado:
                    # Se o item já existe, atualizamos a quantidade
                    nova_quantidade = resultado[0] + quantidade
                    cur.execute("""
                        UPDATE Contem
                        SET Quantidade = %s
                        WHERE Item_Nome = %s AND ID_Instancia_PC = %s;
                    """, (nova_quantidade, item, id_instancia_pc))
                    print(f"Quantidade de {item} atualizada para {nova_quantidade}.")
                else:
                    # Se o item não existe, inserimos um novo registro
                    cur.execute("""
                        INSERT INTO Contem (Item_Nome, ID_Instancia_PC, Quantidade)
                        VALUES (%s, %s, %s);
                    """, (item, id_instancia_pc, quantidade))
                    print(f"Adicionado {quantidade}x {item} ao inventário.")

        # Adicionar ou atualizar os itens necessários no inventário
        adicionar_ou_atualizar_item(item_1, quantidade_1)
        adicionar_ou_atualizar_item(item_2, quantidade_2)
        adicionar_ou_atualizar_item(item_3, quantidade_3)

        # Confirmar a transação
        connection.commit()

        print(f"Todos os itens necessários para a receita {id_receita} foram adicionados ao inventário.")