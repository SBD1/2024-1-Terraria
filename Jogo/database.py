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
            random.shuffle(mundo)

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