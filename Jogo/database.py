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
            
            # Confirma a transação
            connection.commit()

            # Retorna IDs dos registros criados
            return nome_personagem,vida_atual,mana_atual
    
    except Exception as e:
        # Desfaz a transação em caso de erro
        conn.rollback()
        print(f"Erro ao criar personagem jogável: {e}")
        return None