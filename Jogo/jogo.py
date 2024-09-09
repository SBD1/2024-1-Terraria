from database import *
import cmd
import sys
import os
import time
import random
import psycopg2

connection = create_connection()

try:
    cur = connection.cursor()
except psycopg2.OperationalError:
    print("erro")
    pass

screen_width = 100
cur.execute('SELECT x, y from posicao where id_personagem = 1')
teste = cur.fetchall()



ID_PC = 0
ID_M = None
Lista_itens = []


##### Title Screen #####
def title_screen_selections():
    option = input("> ")
    if option.lower() == ("play"):
        setup_game() # placeholder until written
    elif option. lower() == ("help"):
        help_menu()
    elif option. lower() == ("quit"):
        sys.exit()
    while option.lower() not in ['play', 'help', 'quit']:
        print("Entre um comando valido.")
        option = input("> ")
        if option.lower() == ("play"):
            setup_game() # placeholder until written
        elif option. lower() == ("help"):
            help_menu()
        elif option. lower() == ("quit"):
            sys.exit()

def title_screen():
    #os.system('clear')
    print('############################')
    print('# Bem vindo ao Text Terraria! #')
    print('############################')
    print('- Play -')
    print('- Help -')
    print('- Quit -')

    title_screen_selections()
    
def help_menu():
    print('# Bem vindo ao Text Terraria!') 
    print('############################')
    print('- Use up, down, left, right para se mover') 
    print('-Digite seu comando para realizar-los') 
    print('Use olhar para interagir com itens') 
    print('Use craft para fazer itens novos')
    print('Boa sorte e divirta-se!') 
    title_screen_selections()


ZONENAME = ''
DESCRIPTION = 'description'
EXAMINATION = "examine"
SOLVED = False
UP = 'up', 'north'
DOWN = 'down', 'south' 
LEFT ='left', 'west' 
RIGHT ='right', 'east'

solved_places = {'11': False, '12': False, '13': False, '14': False,
                 '21': False, '22': False, '23': False, '24': False,
                 '31': False, '32': False, '33': False, '34': False,
                 '41': False, '42': False, '43': False, '44': False}

def prompt():
    print("\n" + "===============================")
    display_text("O que você gostaria de fazer?")
    cur.execute("""
            SELECT id_p FROM personagem
            JOIN pc ON id_p = id_personagem
            WHERE id_pc = (%s)
        """, (ID_PC,))
    id_personagem = cur.fetchone()[0]
    cur.execute("SELECT x, y FROM posicao WHERE id_personagem = (%s)", [id_personagem])
    posicao = cur.fetchone()
    display_text(f"Você está na posição x: {posicao[0]} y: {posicao[1]}")
    action = input(">")
    acceptable_actions = ['move', 'go', 'travel', 'walk', 'quit', 'examine', 'inspect', 'interact', 'look','craft','crafting','criar','criar item']
    while action.lower() not in acceptable_actions:
        print("Unknown action, try again.\n")
        action = input(">")
    if action.lower() == 'quit':
        sys.exit()
    elif action.lower() in ['move', 'go', 'travel', 'walk', 'andar', 'mover', 'ir']:
        player_move(action.lower())
    elif action. lower() in ['examine', 'inspect', 'interact', 'look', 'olhar', 'examinar', 'pegar']:
        print('Desenvolvimento')
    elif action. lower() in ['craft','crafting','criar','criar item']:
        escolher_receita()


def player_move(myAction):
    ask= "Para onde você gostaria de ir?\n"
    dest = input (ask)
    if dest in ['up', 'north', 'cima', 'norte']:
        movement_handler(1, 'y')
    elif dest in ['left', 'west', 'esquerda', 'oeste']:
        movement_handler(-1, 'x')
    elif dest in ['east', 'right', 'leste', 'direita']:
        movement_handler(1, 'x')
    elif dest in ['south', 'down', 'sul', 'baixo']:
        movement_handler(-1, 'y')

def movement_handler(ammount, side):
    global ID_PC
    encontro = ''
    cur.execute("""
            SELECT id_p FROM personagem
            JOIN pc ON id_p = id_personagem
            WHERE id_pc = (%s)
        """, (ID_PC,))
    id_personagem = cur.fetchone()[0]
    cur.execute('SELECT x, y from posicao where id_personagem = (%s)', [id_personagem])
    posicao = cur.fetchall()

    x = posicao[0][0]
    y = posicao[0][1]
    if ammount == 1 and side == 'y' and y == 4:
        print("Não da para seguir nessa direção")
    elif ammount == 1 and side == 'x' and x == 4:
        print("Não da para seguir nessa direção")
    elif ammount == -1 and side == 'y' and y == 1:
        print("Não da para seguir nessa direção")
    elif ammount == -1 and side == 'x' and x == 1:
        print("Não da para seguir nessa direção")
    else:
        if ammount > 0:
            if side == 'x':
                print('direita')
                x = x + 1
            if side == 'y':
                print('cima')
                y = y + 1
        if ammount < 0:
            if side == 'x':
                print('esquerda')
                x = x - 1
            if side == 'y':
                print('baixo')
                y = y - 1


        cur.execute('UPDATE posicao SET x = (%s), y = (%s) WHERE id_personagem = (%s)',(x, y, id_personagem))
        connection.commit()
        print("\n" + "Você se moveu para a posição: " + str(x) + str(y) + ".")

        if x == 1:
            sala = 'a' + str(y)
            cur.execute("SELECT " + sala + " FROM instancia_Mundo where id_pc = (%s);", [ID_PC])
            encontro = cur.fetchone()[0]
            if encontro != None:
                encontro_handler(encontro, sala)
            else:
                print("Não tem nada nessa sala")
        if x == 2:
            sala = 'b' + str(y)
            cur.execute("SELECT " + sala + " FROM instancia_Mundo where id_pc = (%s);", [ID_PC])
            encontro = cur.fetchone()[0]
            if encontro != None:
                encontro_handler(encontro, sala)
            else:
                print("Não tem nada nessa sala")
        if x == 3:
            sala = 'c' + str(y)
            cur.execute("SELECT " + sala + " FROM instancia_Mundo where id_pc = (%s);", [ID_PC])
            encontro = cur.fetchone()[0]
            if encontro != None:
                encontro_handler(encontro, sala)
            else:
                print("Não tem nada nessa sala")
        if x == 4:
            sala = 'd' + str(y)
            cur.execute("SELECT " + sala + " FROM instancia_Mundo where id_pc = (%s);", [ID_PC])
            encontro = cur.fetchone()[0]
            if encontro != None:
                encontro_handler(encontro, sala)
            else:
                print("Não tem nada nessa sala")
        
def encontro_handler(encontro, sala):
    print(encontro)

    Combate = ['slime', 'zumbi']
    npc = ['guia', 'mercador', 'enfermeira']
    item = ['minerio', 'item', 'tesouro']

    if encontro in npc:
        cur.execute("""SELECT texto FROM dialogo 
                    JOIN npc ON tipo = (%s) 
                    WHERE dialogo.id_dialogo = npc.id_dialogo
                    """, [encontro])
        dialogo = cur.fetchone()[0]
        display_text(dialogo)
        if encontro == 'enfermeira':
            cur.execute('SELECT vidaatual FROM instancia_pc WHERE id_pc = (%s)', [ID_PC])
            vidaPlayer = cur.fetchone()[0]
            display_text(f"Você gostaria de se curar? Sua vida está em {vidaPlayer}")
            resposta = input("Sim ou nao?\n")
            if resposta.lower() == 'sim':
                display_text("Isso vai demorar só um segundo")
                cur.execute(f'UPDATE instancia_pc SET vidaatual = {100} WHERE id_pc = {ID_PC}')
                display_text("Sua vida agora é 100")
            else:
                display_text("Ok, tenha uma boa aventura!")
        connection.commit()


    elif encontro in Combate:
        turno = 1
        luta = True
        cur.execute("""SELECT id_npc FROM npc WHERE (%s) = tipo""", [encontro])
        id_npc = cur.fetchone()[0]
        cur.execute("""SELECT vida FROM personagem WHERE (%s) = nome""", [encontro])
        vidaMonstro = cur.fetchone()[0]
        cur.execute('SELECT vidaatual FROM instancia_pc WHERE id_pc = (%s)', [ID_PC])
        vidaPlayer = cur.fetchone()[0]
        cur.execute("""
                INSERT INTO instancia_npc (id_npc, vidaatual, nome)
                VALUES (%s, %s, %s)
                RETURNING id_instancia_npc;
            """, (id_npc, vidaMonstro, encontro))
        id_instancia = cur.fetchone()[0]
        
        cur.execute("""SELECT MAX(poder) FROM ferramenta
                    JOIN contem ON contem.id_instancia_pc = (%s)
                     WHERE ferramenta.item_nome = contem.item_nome""", [ID_PC])
        dano = cur.fetchone()[0]
        if dano == None:
            dano = 10
        print(dano)

      
        dialogo = "Você encontrou um " + encontro + ", Prepare-se para o combate"
        display_text(dialogo)
        
        while luta == True:
            if turno == 1:
                dialogo = "O que você vai fazer:"
                display_text(dialogo)
                escolha = input("Atacar ou Fugir?")

                if escolha.lower() == "atacar":
                    vidaMonstro = vidaMonstro - dano
                    display_text("Você deu "+ str(dano) +" de dano no " + encontro)
                    display_text("Ele tem " + str(vidaMonstro) + ' de vida sobrando')
                    if vidaMonstro <= 0:
                        luta = False
                        cur.execute('DELETE FROM instancia_npc WHERE id_instancia_npc = (%s)', [id_instancia])
                        cur.execute(f'UPDATE instancia_mundo SET {sala} = NULL WHERE id_pc = {ID_PC}')
                        if encontro == 'zumbi':
                            if random.random() < 0.5:
                                cur.execute("""SELECT COUNT(*) FROM contem WHERE (%s) = id_instancia_pc AND (%s) = item_nome""", (ID_PC, "Braco de zumbi"))
                                tem_braco = cur.fetchone()[0]
                                if tem_braco == 0:
                                    cur.execute("INSERT INTO contem (item_nome, id_instancia_pc, quantidade)VALUES (%s, %s, %s)", ("Braco de zumbi", ID_PC, 1))
                                else:
                                    cur.execute("""UPDATE contem SET quantidade = quantidade + 1 WHERE item_nome = (%s) AND id_instancia_pc = (%s)""", ("Braco de zumbi", ID_PC))

                                display_text("Braço de zumbi dropou")
                        if encontro == 'slime':
                            if random.random() < 1:
                                cur.execute("""SELECT COUNT(*) FROM contem WHERE (%s) = id_instancia_pc AND (%s) = item_nome""", (ID_PC, "Gel"))
                                tem_braco = cur.fetchone()[0]
                                if tem_braco == 0:
                                    cur.execute("INSERT INTO contem (item_nome, id_instancia_pc, quantidade)VALUES (%s, %s, %s)", ("Gel", ID_PC, 1))
                                else:
                                    cur.execute("""UPDATE contem SET quantidade = quantidade + 1 WHERE item_nome = (%s) AND id_instancia_pc = (%s)""", ("Gel", ID_PC))

                                display_text("Gel dropou")
                    else:
                        cur.execute('UPDATE instancia_npc SET vidaatual = (%s) WHERE id_instancia_npc = (%s)',(vidaMonstro, id_instancia))
                        turno = 0
                    
                if escolha.lower() == 'fugir':
                    luta = False
                    ammount = random.choice([1, -1])
                    side = random.choice(["x", "y"])
                    cur.execute('DELETE FROM instancia_npc WHERE id_instancia_npc = (%s)', [id_instancia])
                    movement_handler(ammount, side)
                connection.commit()
                
                
            else:
                display_text("O "+ encontro + " Te ataca ")
                if encontro == "zumbi":
                    display_text("Você sofreu 14 de dano!!!")
                    vidaPlayer = vidaPlayer - 14
                    display_text("Sua vida é: " + str(vidaPlayer))
                    if vidaPlayer <= 0:
                        luta = False
                        cur.execute('DELETE FROM instancia_pc WHERE id_pc = (%s)', [ID_PC])
                        cur.execute('DELETE FROM pc WHERE id_pc = (%s)', [ID_PC])
                        cur.execute("""
                            SELECT id_p FROM personagem
                            JOIN pc ON id_p = id_personagem
                            WHERE id_pc = (%s)
                        """, (ID_PC,))
                        id_personagem = cur.fetchone()[0]
                        cur.execute('DELETE FROM personagem WHERE id_p = (%s)', [id_personagem])
                        display_text('Você perdeu o jogo, Comece de novo.')
                        sys.exit()
                    else:
                        cur.execute('UPDATE instancia_pc SET vidaatual = (%s) WHERE id_pc = (%s)',(vidaPlayer, ID_PC))
                        turno = 1
                    if encontro == "slime":
                        display_text("Você sofreu 7 de dano!!!")
                        vidaPlayer = vidaPlayer - 7
                        display_text("Sua vida é: " + str(vidaPlayer))
                        if vidaPlayer <= 0:
                            luta = False
                            cur.execute('DELETE FROM instancia_pc WHERE id_pc = (%s)', [ID_PC])
                            cur.execute('DELETE FROM pc WHERE id_pc = (%s)', [ID_PC])
                            cur.execute("""
                                SELECT id_p FROM personagem
                                JOIN pc ON id_p = id_personagem
                                WHERE id_pc = (%s)
                            """, (ID_PC,))
                            id_personagem = cur.fetchone()[0]
                            cur.execute('DELETE FROM personagem WHERE id_p = (%s)', [id_personagem])
                            display_text('Você perdeu o jogo, Comece de novo.')
                            sys.exit()
                        else:
                            cur.execute('UPDATE instancia_pc SET vidaatual = (%s) WHERE id_pc = (%s)',(vidaPlayer, ID_PC))
                            turno = 1
                connection.commit()

    # elif encontro == 'item':
    #     global Lista_itens
    #     cur.execute("SELECT nome FROM item")
    #     lista_item = cur.fetchall()
    #     for item in Lista_itens:
    #         if item[0] == sala:
    #             #mostra o item
    #             break
    #         else:
    #             Lista_itens.append([sala, random.choice(lista_item)])



def display_text(texto):
    texto = texto + "\n"
    for character in texto:
        sys.stdout.write(character)
        sys.stdout.flush()
        time.sleep(0.05)


def start_game():
    return


def main_game_loop():
    while True:
        prompt()
# here handle if puzzles have been solved, boss defeated, explored everything, etc.
def setup_game():
    personagem_handler()
        
    #os.system('clear')
    print("")
    print("# Vamos Começar!! #")
    print("")

    main_game_loop()


def personagem_handler():
    global ID_PC
    # Verifica se a tabela pc está vazia
    cur.execute("SELECT COUNT(*) FROM pc;")
    pc_count = cur.fetchone()[0]

    if pc_count == 0:
        print("Não há personagens jogáveis criados. Por favor, crie um novo personagem.")
        nome_personagem = input('Qual o nome do seu personagem?')
        nome_escolhido,vida_atual_escolhida,mana_atual_escolhida, ID_PC = criar_personagem_jogavel(connection,nome_personagem)
        mundo_handler()
        set_posicao_personagem_criado(connection,ID_PC,ID_M)
    else:
        print("Já existem alguns personagens, deseja escolher algum?")
        # Recupera os personagens existentes e suas respectivas vidas e manas atuais
        cur.execute("""
            SELECT personagem.nome, instancia_pc.vidaAtual, instancia_pc.manaAtual, pc.id_pc
            FROM personagem
            JOIN pc ON personagem.id_p = pc.id_personagem
            JOIN instancia_pc ON pc.id_pc = instancia_pc.id_pc;
        """)
        personagens = cur.fetchall()

        print("Personagens disponíveis:")
        for idx, (nome, vida_atual, mana_atual, id_pc) in enumerate(personagens, start=1):
            print(f"{idx}. Nome: {nome}, Vida Atual: {vida_atual}, Mana Atual: {mana_atual}, ID_PC: {id_pc}")

        # Pergunta ao jogador qual personagem ele deseja usar
        escolha = input("Digite o número do personagem que você deseja utilizar ou '0' para criar um novo personagem: ")

        if escolha == '0':
            print("Criando um novo personagem...")
            nome_personagem = input('Qual o nome do seu personagem?')
            nome_escolhido,vida_atual_escolhida,mana_atual_escolhida, ID_PC = criar_personagem_jogavel(connection,nome_personagem)
            mundo_handler()
            set_posicao_personagem_criado(connection,ID_PC,ID_M)
        else:
            try:
                escolha = int(escolha)
                if 1 <= escolha <= len(personagens):
                    personagem_escolhido = personagens[escolha-1]
                    nome_escolhido, vida_atual_escolhida, mana_atual_escolhida, ID_PC = personagem_escolhido
                    
                else:
                    print("Escolha inválida. Tente novamente.")
            except ValueError:
                print("Entrada inválida. Por favor, insira um número.")



def mundo_handler():
    global ID_M

    print("Para que exista um novo personagem, é necessario um novo mundo, portanto é necessario criar um!")
    nome_mundo = input("Digite o nome do mundo: ")
    tamanho_mundo = input("Escolha o tamanho do mundo (Pequeno, Medio, Grande): ")
    while tamanho_mundo not in ["Pequeno", "Medio", "Grande"]:
        print("Tamanho inválido.")
        tamanho_mundo = input("Escolha o tamanho do mundo (Pequeno, Medio, Grande): ")
    
    dificuldade_mundo = input("Escolha a dificuldade (Jornada, Normal, Expert, Master): ")
    while dificuldade_mundo not in ['Jornada', 'Normal', 'Expert', 'Master']:
        print("Dificuldade inválida.")
        dificuldade_mundo = input("Escolha a dificuldade (Jornada, Normal, Expert, Master): ")
    
    # Criar um novo mundo com os valores fornecidos
    ID_M = criar_mundo(connection, nome_mundo, tamanho_mundo, dificuldade_mundo)
    #mundo_criado = criar_mundo(connection, nome_mundo, tamanho_mundo, dificuldade_mundo)
    #print(f"Mundo criado: {mundo_criado}")

# Função para listar todas as receitas
def listar_receitas():
    with connection.cursor() as cur:
        cur.execute("""
            SELECT ID_Receita, Item_Final, Item_1, Item_2, Item_3 
            FROM Receita;
        """)
        receitas = cur.fetchall()

        if not receitas:
            print("Nenhuma receita encontrada.")
            return None

        # Listar receitas por índice
        print("Receitas disponíveis:")
        for index, receita in enumerate(receitas):
            id_receita, item_final, item_1, item_2, item_3 = receita
            itens = f"{item_1}"
            if item_2:
                itens += f", {item_2}"
            if item_3:
                itens += f", {item_3}"
            print(f"{index + 1}. {item_final} (Ingredientes: {itens})")

        return receitas

# Função para permitir que o usuário escolha uma receita
def escolher_receita():
    receitas = listar_receitas()
    if not receitas:
        return

    # Solicitar que o usuário escolha um índice
    escolha = int(input("Escolha o número da receita que deseja fabricar: ")) - 1

    if escolha < 0 or escolha >= len(receitas):
        print("Índice inválido.")
        return

    # Recuperar a receita escolhida
    id_receita = receitas[escolha][0]
    print("id da receita escolhida: " + str(id_receita))

    adicionar_itens_para_receita(connection,ID_PC,id_receita)

    # Chamar a função de fabricar item
    fabricar_item(connection, ID_PC, id_receita)


title_screen()